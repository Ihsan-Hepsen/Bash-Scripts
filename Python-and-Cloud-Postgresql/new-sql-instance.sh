#!/bin/bash

if [ $# -eq 0 ]
then
	echo "Please provide a sql-instance name"
	exit 1
fi

gcloud sql instances create "${1}" --tier=db-g1-small --region=europe-west1 --authorized-networks=109.128.102.10/32 --database-version=POSTGRES_14
