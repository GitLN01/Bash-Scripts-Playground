#!/bin/bash

# 7. Create a script that prompts the user for their name and greets them with a message like: Hello, [Name]! Welcome to Bash scripting.

read -p "Enter your name: " name

echo "Hello, "$name"!"

echo "Current user is $(hostname), and location $(pwd)"