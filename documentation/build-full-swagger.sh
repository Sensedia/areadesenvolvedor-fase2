#!/usr/bin/env bash

chmod + source/scripts/dictionary_generator
BUND_PATH=source/dictionary/bundles
DICT_PATH=source/dictionary/fullswagger
mkdir -p $BUND_PATH

APIS=(
  # "loans_apis"
  # "financings_apis"
  # "unarranged_accounts_overdraft_apis"
  # "invoice_financings_apis"
  # "resources_apis"
  # "consents_apis"
  "payments_apis"
)

APIS_CONDITIONAL=(

)

function generate() {
  LIST=$1
  OPTIONS=$2

  for API in "${APIS[@]}"
  do
    # swagger-cli bundle \
    #   -r "source/swagger/parts/_${API}_part.yml" \
    #   --outfile "${BUND_PATH}/swagger_${API}.yaml" --type=yaml

    ./source/scripts/full_swagger_generator ${OPTIONS- } \
      -f "source/swagger/parts/_${API}_part.yml" \
      -o $DICT_PATH
  done
}

generate $APIS
generate $APIS_CONDITIONAL '-c'

#rm -rf $BUND_PATH

sed -i '1s/^\(\xef\xbb\xbf\)\?/\xef\xbb\xbf/' source/dictionary/*.csv
sed -i '1s/^\(\xef\xbb\xbf\)\?/\xef\xbb\xbf/' source/dictionary/example/*.csv
sed -i '1s/^\(\xef\xbb\xbf\)\?/\xef\xbb\xbf/' source/dictionary/fullswagger/*.yaml
