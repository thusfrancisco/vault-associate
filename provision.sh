#!/bin/bash
sudo unzip /tmp/vault.zip
sudo mv /tmp/vault /usr/local/bin

vault version

sudo systemctl start vault