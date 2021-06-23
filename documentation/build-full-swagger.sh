#!/usr/bin/env bash

chmod + source/scripts/dictionary_generator
BUND_PATH=source/dictionary/bundles
DICT_PATH=source/swagger/parts
mkdir -p $BUND_PATH

function generate() {
  VERSION=$1

  if [ $VERSION == '2' ]; then
    LIST=(
      "loans_apis"
      "financings_apis"
      "unarranged_accounts_overdraft_apis"
      "invoice_financings_apis"
      "resources_apis"
      "consents_apis"
      "customers_apis"
      "credit_cards_apis"
      "accounts_apis"
      # "payments_apis"
    )
  elif [ $VERSION == '3' ]; then
    LIST=(
      # "loans_apis"
      # "financings_apis"
      # "unarranged_accounts_overdraft_apis"
      # "invoice_financings_apis"
      # "resources_apis"
      # "consents_apis"
      "payments_apis"
    )
  fi

  ruby source/scripts/path_content_cleaner -v $VERSION

  for API in "${LIST[@]}"
  do
    ./source/scripts/full_swagger_generator ${OPTIONS- } \
      -f "source/swagger/parts/_${API}_part.yml" \
      -o $DICT_PATH \
      -v $VERSION
  done
}

generate '2'
generate '3'