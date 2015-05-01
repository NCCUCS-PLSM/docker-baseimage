#!/bin/bash
set -e
if [[ ! -e /etc/ssh/ssh_host_rsa_key ]]; then
	echo "No SSH host key available. Generating one..."
	export LC_ALL=C
	echo "Creating SSH1 key; this may take some time ..."
	ssh-keygen -q -f "/etc/ssh/ssh_host_key" -N '' -t rsa1
	echo "Creating SSH2 RSA key; this may take some time ..."
	ssh-keygen -q -f "/etc/ssh/ssh_host_rsa_key" -N '' -t rsa
	echo "Creating SSH2 DSA key; this may take some time ..."
	ssh-keygen -q -f "/etc/ssh/ssh_host_dsa_key" -N '' -t dsa
	echo "Creating SSH2 ECDSA key; this may take some time ..."
	ssh-keygen -q -f "/etc/ssh/ssh_host_ecdsa_key" -N '' -t ecdsa
fi
