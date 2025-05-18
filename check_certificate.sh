#!/bin/bash

URLS=(
acme.delsystems.net
acme-vault.delsystems.net
akounting.delsystems.net
artifactory.delsystems.net
as-medusa.delsystems.net
assets.delsystems.net
bw.delsystems.net
ceph.delsystems.net
clients-grafana.delsystems.net
coinis-grafana.delsystems.net
coinis-jenkins.delsystems.net
confluence.delsystems.net
ddb.delsystems.net
dev0.delsystems.net
dev-bitwarden.delsystems.net
dev-confluence.delsystems.net
dev.delsystems.net
dev-erp.delsystems.net
dev-grafana.delsystems.net
dev-grimoire.delsystems.net
dev-haproxy.delsystems.net
dev-jenkins.delsystems.net
dev-jira.delsystems.net
dev-medusa.delsystems.net
dev-o2.delsystems.net
dev-ocmdb.delsystems.net
dev-osign.delsystems.net
dev-pns.delsystems.net
dev-ringzz.delsystems.net
dev-sonar.delsystems.net
dev-vault.delsystems.net
dev-www.delsystems.net
dnsa.delsystems.net
docu.delsystems.net
eaglelab-wga.delsystems.net
echo.delsystems.net
eu-medusa.delsystems.net
g4i-wga.delsystems.net
ggr.delsystems.net
grafana.delsystems.net
ha-proxy.delsystems.net
jenkins.delsystems.net
jira2.delsystems.net
jira.delsystems.net
ldap.delsystems.net
live-www.delsystems.net
maven.delsystems.net
mcm.delsystems.net
medusa.delsystems.net
mk.delsystems.net
monad-grafana.delsystems.net
munki.delsystems.net
mx.delsystems.net
npm.delsystems.net
ocamba.delsystems.net
ocmdb.delsystems.net
old-grafana.delsystems.net
orbs-grafana.delsystems.net
orbs-wga.delsystems.net
osign.delsystems.net
packages.delsystems.net
royalada-grafana.delsystems.net
royalada-wga.delsystems.net
rs-medusa.delsystems.net
s3.delsystems.net
snipe-it.delsystems.net
sonar.delsystems.net
stage-ocmdb.delsystems.net
stage-pns.delsystems.net
taboola-grafana.delsystems.net
us-medusa.delsystems.net
vault.delsystems.net
vertigo-wga.delsystems.net
vpngw.delsystems.net
webmail.delsystems.net
wga.delsystems.net
wiki.delsystems.net
)

FAILED_DOMAINS="failed_domains.txt"
VALID_CERTS="valid_certificates.txt"

> "$FAILED_DOMAINS"
> "$VALID_CERTS"

PORT="${1:-443}"

TODAY_TS=$(date +%s)

echo -e "\nChecking SSL certificates...\n"

for domain in "${URLS[@]}"; do
  echo "🔗 $domain"

  cert_data=$(echo | openssl s_client -connect "$domain:$PORT" -servername "$domain" 2>/dev/null | openssl x509 -noout -dates)

  if [[ -z "$cert_data" ]]; then
    echo "❌ Cannot fetch certificate!"
    subdomain=$(echo "$domain" | sed 's/\.delsystems\.net//')
    echo "$subdomain" >> "$FAILED_DOMAINS"
    echo
    continue
  fi

  not_before=$(echo "$cert_data" | grep 'notBefore=' | cut -d= -f2)
  not_after=$(echo "$cert_data" | grep 'notAfter=' | cut -d= -f2)

  echo "    Issued On : $not_before"
  echo "    Expires On: $not_after"

  not_before_ts=$(gdate -d "$not_before" +%s 2>/dev/null)
  not_after_ts=$(gdate -d "$not_after" +%s 2>/dev/null)

  if [[ "$TODAY_TS" -ge "$not_before_ts" && "$TODAY_TS" -le "$not_after_ts" ]]; then
    subdomain=$(echo "$domain" | sed 's/\.delsystems\.net//')
    {
      echo "$subdomain"
      echo "  Issued On : $not_before"
      echo "  Expires On: $not_after"
      echo
    } >> "$VALID_CERTS"
  else
    subdomain=$(echo "$domain" | sed 's/\.delsystems\.net//')
    {
      echo "$subdomain -> Expired On: $not_after"
    } >> "$FAILED_DOMAINS"
  fi

  echo
done

echo "Done!"
echo "Expired domains and domains with SSL fetch errors are saved to: $FAILED_DOMAINS"
echo "Domains with currently valid certificates are saved to: $VALID_CERTS"
