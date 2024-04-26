#!/bin/env bash

set -euo pipefail

select_profile() {
	profile_name=$1
    if aws configure list-profiles | grep -q "^$profile_name$"; then
        echo "export AWS_PROFILE=\"$profile_name\""
        echo "Switched to AWS profile: $profile_name" >&2
    else
        echo "Profile '$profile_name' does not exist." >&2
        exit 1
    fi
}

profile_json() {
	readarray -t lines < <(aws configure list-profiles)
	json_array='['
	first=1
	for line in "${lines[@]}"; do
		if [ "$first" -eq "1" ]; then
			first=0
		else
			json_array+=','
		fi
		json_array+="{\"label\":\"$line\",\"value\":\"$line\"}"
	done
	json_array+=']'
	echo "$json_array"
}

ui_select() {
	val=$(SELEKTOR_OPTIONS="$(profile_json)" SELEKTOR_PROMPT="Select Profile" selektor)
	if [ "$val" == "" ]; then
		echo "No option selected." >&2
		exit 1
	fi
	echo "$val"
}

help() {
	echo "Usage: aws-profile <list|select|login> [profile-name]" >&2
}

case "$1" in
    list)
        echo "Available AWS Profiles:" >&2
        aws configure list-profiles >&2
        ;;
    select)
        if [ $# -lt 2 ]; then
			result=$(ui_select)
			select_profile "$result"
        else
			select_profile "$2"
        fi
        ;;
    login)
        if [ $# -lt 2 ]; then
			result=$(ui_select)
			select_profile "$result"
			aws sso login --profile "$result" >&2
        else
			select_profile "$2"
			aws sso login --profile "$2" >&2
        fi
        ;;
    *)
        help
        ;;
esac
