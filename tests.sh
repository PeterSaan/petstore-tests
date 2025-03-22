#!/usr/bin/env bash

URL="https://petstore.swagger.io/v2"
RED='\033[0;31m'
GREEN='\033[0;32m'
NO_COLOR='\033[0m'

AddPet() {
	curl -K .curlrc --fail-with-body -o AddPet.json -X POST \
		"$URL/pet" \
		-d '
		{
			"name": "Petsi dawg",
			"photoUrls": ["string"],
			"tags": [
				{ "name": "big" },
				{ "name": "fast" },
				{ "name": "terrifying" }
			],
			"status": "unavailable"
		}
			 '

		if grep -q "code" AddPet.json; then
			echo -e "${RED}AddPet test failed${NO_COLOR}"
		else
			echo -e "${GREEN}AddPet test successful${NO_COLOR}"
		fi
}

FindPetById() {
	curl -K .curlrc --fail-with-body -o FindPetById.json -X POST \
		"$URL/pet" \
		-d '
		{
			"name": "Petsi test dawg",
			"photoUrls": ["string"]
		}
			 '
}

AddPet
#FindPetById
