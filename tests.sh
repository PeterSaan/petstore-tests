#!/usr/bin/env bash

URL="https://petstore.swagger.io/v2"
API_KEY="rand0m455keyImad3"

AddPet() {
	curl -v -o AddPet.json -X POST \
		"$URL/pet" \
		-H 'Content-Type: application/json' \
		-H "api_key: $API_KEY" \
		-d '
		{
			"name": "Petsi dawg",
			"photoUrls": ["string"]
		}
			 '
}

AddPet | jq
