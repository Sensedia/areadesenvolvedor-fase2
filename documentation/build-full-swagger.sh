#!/usr/bin/env bash

chmod + source/scripts/dictionary_generator
BUND_PATH=source/dictionary/bundles
DICT_PATH=source/swagger/parts
mkdir -p $BUND_PATH

APIS=(
  "loans_apis"
  "financings_apis"
  "unarranged_accounts_overdraft_apis"
  "invoice_financings_apis"
  "resources_apis"
  "consents_apis"
  # "payments_apis"
)

function generate() {
  LIST=$1
  OPTIONS=$2

  ruby source/scripts/path_content_cleaner

  for API in "${APIS[@]}"
  do
    ./source/scripts/full_swagger_generator ${OPTIONS- } \
      -f "source/swagger/parts/_${API}_part.yml" \
      -o $DICT_PATH
  done
}

#ruby source\scripts\full_swagger_generator -f "source/swagger/parts/_consents_apis_part.yml" -o source/swagger/parts

generate $APIS
