#!/bin/bash
# Create a token for a child cluster with the created policy
vault token create -policy=unseal
