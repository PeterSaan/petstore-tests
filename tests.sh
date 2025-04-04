#!/usr/bin/env bash

URL="https://petstore.swagger.io/v2"
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NO_COLOR='\033[0m'

DeletePetReturnsDeletedIdAndOkStatus() {
	local response
	local deletedId

	response=$(curl -K .curlrc --fail-with-body -o DeletePetReturnsDeletedIdAndOkStatus.json -X GET \
		"$URL/pet/1")
	
	deletedId=$(cat < DeletePetReturnsDeletedIdAndOkStatus.json | jq -r '.message')

	if [[ ! "$response" == "200" && ! "$deletedId" == "1" ]]; then
		echo -e "${RED}DeletePetReturnsDeletedIdAndOkStatus test failed${NO_COLOR}"
		return 1
	fi

	echo -e "${GREEN}DeletePetReturnsDeletedIdAndOkStatus test successful${NO_COLOR}"
	return 0
}

FindPetByIdReturnsNotFoundStatusAndMessage() {
	local response
	local responseMessage

	response=$(curl -K .curlrc --fail-with-body -o FindPetByIdReturnsNotFoundStatusAndMessage.json -X GET \
		"$URL/pet/0")

	responseMessage=$(cat < FindPetByIdReturnsNotFoundStatusAndMessage.json | jq -r '.message')

	if [[ ! "$response" == "404" && ! "$responseMessage" == "Pet not found" ]]; then
		echo -e "${RED}FindPetByIdReturnsNotFoundStatusAndMessage test failed${NO_COLOR}"
		return 1
	fi

	echo -e "${GREEN}FindPetByIdReturnsNotFoundStatusAndMessage test successful${NO_COLOR}"
	return 0
}

AddPetReturnsPetObjectAndOkStatus() {
	local response
	local petName

	response=$(curl -K .curlrc --fail-with-body -o AddPetReturnsPetObjectAndOkStatus.json -X POST \
		"$URL/pet" \
		-d '
		{
			"id": 1,
			"name": "Petsi dawg",
			"photoUrls": ["string"],
			"tags": [
				{ "name": "big" },
				{ "name": "fast" },
				{ "name": "terrifying" }
			],
			"status": "unavailable"
		}
			')

	petName=$(cat < AddPetReturnsPetObjectAndOkStatus.json | jq -r '.name')

	if [[ ! "$response" == "200" && ! "$petName" == "Petsi dawg" ]]; then
		echo -e "${RED}AddPetReturnsPetObjectAndOkStatus test failed${NO_COLOR}"
		return 1
	fi

	echo -e "${GREEN}AddPetReturnsPetObjectAndOkStatus test successful${NO_COLOR}"
	return 0
}

AddPetReturnsInternalServerErrorOnWrongInput() {
	local response

	response=$(curl -K .curlrc --fail-with-body -o AddPetReturnsInternalServerErrorOnWrongInput.json -X POST \
		"$URL/pet" \
		-d '
		{
			"id": "wrong"
		}
			')

		if [ ! "$response" == "500" ]; then
			echo -e "${RED}AddPetReturnsInternalServerErrorOnWrongInput test failed${NO_COLOR}"
			return 1
		fi

		echo -e "${GREEN}AddPetReturnsInternalServerErrorOnWrongInput test successful${NO_COLOR}"
		return 0
}

FindPetByIdReturnsPetObjectAndOkStatus() {
	local response
	local petId

	response=$(curl -K .curlrc --fail-with-body -o FindPetByIdReturnsPetObjectAndOkStatus.json -X GET \
		"$URL/pet/1")

	petId=$(cat < FindPetByIdReturnsPetObjectAndOkStatus.json | jq -r '.id')

	if [[ ! "$response" == "200" && ! "$petId" == "1" ]]; then
		echo -e "${RED}FindPetByIdReturnsPetObjectAndOkStatus test failed${NO_COLOR}"
		return 1
	fi

	echo -e "${GREEN}FindPetByIdReturnsPetObjectAndOkStatus test successful${NO_COLOR}"
	return 0
}

echo "Running DeletePetReturnsDeletedIdAndOkStatus..."
DeletePetReturnsDeletedIdAndOkStatus

echo "Running FindPetByIdReturnsNotFoundStatusAndMessage..."
FindPetByIdReturnsNotFoundStatusAndMessage

echo "Running AddPetReturnsPetObjectAndOkStatus..."
AddPetReturnsPetObjectAndOkStatus

echo "Running AddPetReturnsInternalServerErrorOnWrongInput..."
AddPetReturnsInternalServerErrorOnWrongInput

echo "Running FindPetByIdReturnsPetObjectAndOkStatus..."
FindPetByIdReturnsPetObjectAndOkStatus
