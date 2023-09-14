#!/bin/bash

vault auth enable -path=mypath -description="Lorem ipsum" approle
# vault auth disable mypath

vault write auth/mypath/option/vault-associate
