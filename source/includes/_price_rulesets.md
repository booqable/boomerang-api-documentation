# Price rulesets

Price rulesets are used to create elaborate pricing adjustments using the advanced pricing feature.

<aside class="notice">
  Note: You must have the advanced pricing feature in your plan to use price rulesets and rules.
</aside>

## Endpoints
`GET /api/boomerang/price_rulesets`

`GET /api/boomerang/price_rulesets/{id}`

`POST /api/boomerang/price_rulesets`

`PUT /api/boomerang/price_rulesets/{id}`

`DELETE /api/boomerang/price_rulesets/{id}`

## Fields
Every price ruleset has the following fields:

Name | Description
- | -
`id` | **Uuid** `readonly`<br>Primary key
`created_at` | **Datetime** `readonly`<br>When the resource was created
`updated_at` | **Datetime** `readonly`<br>When the resource was last updated
`name` | **String**<br>Name of the ruleset
`archived_at` | **Datetime** `readonly`<br>Date the ruleset was archived, otherwise null
`price_rules_attributes` | **Array** `writeonly`<br>Allows creating and updating price rules with their ruleset


## Relationships
Price rulesets have the following relationships:

Name | Description
- | -
`price_rules` | **Price rules** `readonly`<br>Associated Price rules


## Listing price rulesets



> How to fetch price rulesets

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/price_rulesets' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "89433fdc-614a-430c-a918-a1eab5f8fcd6",
      "type": "price_rulesets",
      "attributes": {
        "created_at": "2021-12-15T11:45:19+00:00",
        "updated_at": "2021-12-15T11:45:19+00:00",
        "name": "Ruleset",
        "archived_at": null
      },
      "relationships": {
        "price_rules": {
          "links": {
            "related": "api/boomerang/price_rules?filter[price_ruleset_id]=89433fdc-614a-430c-a918-a1eab5f8fcd6"
          }
        }
      }
    }
  ],
  "links": {
    "self": "api/boomerang/price_rulesets?page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/price_rulesets?page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/price_rulesets?page%5Bnumber%5D=1&page%5Bsize%5D=25"
  },
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/price_rulesets`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=price_rules`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[price_rulesets]=id,created_at,updated_at`
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-12-15T11:43:16Z`
`sort` | **String**<br>How to sort the data `?sort=-created_at`
`meta` | **Hash**<br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String**<br>The page to request
`page[size]` | **String**<br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
`id` | **Uuid**<br>`eq`, `not_eq`
`created_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`name` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`archived_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`price_rules_attributes` | **Array**<br>`eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array**<br>`count`


### Includes

This request does not accept any includes
## Fetching a price ruleset



> How to fetch a single price ruleset with related price rules:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/price_rulesets/56e4ebc3-7eee-4429-aff6-7d3655904bde?include=price_rules' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "56e4ebc3-7eee-4429-aff6-7d3655904bde",
    "type": "price_rulesets",
    "attributes": {
      "created_at": "2021-12-15T11:45:19+00:00",
      "updated_at": "2021-12-15T11:45:19+00:00",
      "name": "Ruleset",
      "archived_at": null
    },
    "relationships": {
      "price_rules": {
        "links": {
          "related": "api/boomerang/price_rules?filter[price_ruleset_id]=56e4ebc3-7eee-4429-aff6-7d3655904bde"
        },
        "data": [
          {
            "type": "price_rules",
            "id": "14c544e0-85ec-49c9-ba64-fd5045927faa"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "14c544e0-85ec-49c9-ba64-fd5045927faa",
      "type": "price_rules",
      "attributes": {
        "created_at": "2021-12-15T11:45:19+00:00",
        "updated_at": "2021-12-15T11:45:19+00:00",
        "name": "Price rule",
        "rule_type": "range_of_dates",
        "match_strategy": "span",
        "adjustment_strategy": "percentage",
        "value": 30.0,
        "from": "2030-07-01T00:00:00+00:00",
        "till": "2030-08-31T00:00:00+00:00",
        "from_day": null,
        "till_day": null,
        "from_time": null,
        "till_time": null,
        "charge": null,
        "stacked": false,
        "time": null,
        "price_ruleset_id": "56e4ebc3-7eee-4429-aff6-7d3655904bde"
      },
      "relationships": {
        "price_ruleset": {
          "links": {
            "related": "api/boomerang/price_rulesets/56e4ebc3-7eee-4429-aff6-7d3655904bde"
          }
        }
      }
    }
  ],
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/price_rulesets/{id}`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=price_rules`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[price_rulesets]=id,created_at,updated_at`


### Includes

This request accepts the following includes:

`price_rules`






## Creating a price ruleset



> How to create a price ruleset with price rules:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/price_rulesets' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "price_rulesets",
        "attributes": {
          "name": "Seasonal ruleset",
          "price_rules_attributes": [
            {
              "name": "Off season",
              "rule_type": "range_of_dates",
              "match_strategy": "span",
              "value": 25,
              "from": "2021-11-15T11:45:19.673Z",
              "till": "2022-01-15T11:45:19.673Z"
            }
          ]
        }
      },
      "include": "price_rules"
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "bfc26522-753e-49d5-8aaf-6a332a1c8c9c",
    "type": "price_rulesets",
    "attributes": {
      "created_at": "2021-12-15T11:45:19+00:00",
      "updated_at": "2021-12-15T11:45:19+00:00",
      "name": "Seasonal ruleset",
      "archived_at": null
    },
    "relationships": {
      "price_rules": {
        "data": [
          {
            "type": "price_rules",
            "id": "197d0397-7a74-4ae7-99c7-49625e1db565"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "197d0397-7a74-4ae7-99c7-49625e1db565",
      "type": "price_rules",
      "attributes": {
        "created_at": "2021-12-15T11:45:19+00:00",
        "updated_at": "2021-12-15T11:45:19+00:00",
        "name": "Off season",
        "rule_type": "range_of_dates",
        "match_strategy": "span",
        "adjustment_strategy": "percentage",
        "value": 25.0,
        "from": "2021-11-15T11:45:19+00:00",
        "till": "2022-01-15T11:45:19+00:00",
        "from_day": null,
        "till_day": null,
        "from_time": null,
        "till_time": null,
        "charge": null,
        "stacked": false,
        "time": null,
        "price_ruleset_id": "bfc26522-753e-49d5-8aaf-6a332a1c8c9c"
      },
      "relationships": {
        "price_ruleset": {
          "meta": {
            "included": false
          }
        }
      }
    }
  ],
  "links": {
    "self": "api/boomerang/price_rulesets?data%5Battributes%5D%5Bname%5D=Seasonal+ruleset&data%5Battributes%5D%5Bprice_rules_attributes%5D%5B%5D%5Bname%5D=Off+season&data%5Battributes%5D%5Bprice_rules_attributes%5D%5B%5D%5Brule_type%5D=range_of_dates&data%5Battributes%5D%5Bprice_rules_attributes%5D%5B%5D%5Bmatch_strategy%5D=span&data%5Battributes%5D%5Bprice_rules_attributes%5D%5B%5D%5Bvalue%5D=25&data%5Battributes%5D%5Bprice_rules_attributes%5D%5B%5D%5Bfrom%5D=2021-11-15T11%3A45%3A19.673Z&data%5Battributes%5D%5Bprice_rules_attributes%5D%5B%5D%5Btill%5D=2022-01-15T11%3A45%3A19.673Z&data%5Btype%5D=price_rulesets&include=price_rules&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/price_rulesets?data%5Battributes%5D%5Bname%5D=Seasonal+ruleset&data%5Battributes%5D%5Bprice_rules_attributes%5D%5B%5D%5Bname%5D=Off+season&data%5Battributes%5D%5Bprice_rules_attributes%5D%5B%5D%5Brule_type%5D=range_of_dates&data%5Battributes%5D%5Bprice_rules_attributes%5D%5B%5D%5Bmatch_strategy%5D=span&data%5Battributes%5D%5Bprice_rules_attributes%5D%5B%5D%5Bvalue%5D=25&data%5Battributes%5D%5Bprice_rules_attributes%5D%5B%5D%5Bfrom%5D=2021-11-15T11%3A45%3A19.673Z&data%5Battributes%5D%5Bprice_rules_attributes%5D%5B%5D%5Btill%5D=2022-01-15T11%3A45%3A19.673Z&data%5Btype%5D=price_rulesets&include=price_rules&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/price_rulesets?data%5Battributes%5D%5Bname%5D=Seasonal+ruleset&data%5Battributes%5D%5Bprice_rules_attributes%5D%5B%5D%5Bname%5D=Off+season&data%5Battributes%5D%5Bprice_rules_attributes%5D%5B%5D%5Brule_type%5D=range_of_dates&data%5Battributes%5D%5Bprice_rules_attributes%5D%5B%5D%5Bmatch_strategy%5D=span&data%5Battributes%5D%5Bprice_rules_attributes%5D%5B%5D%5Bvalue%5D=25&data%5Battributes%5D%5Bprice_rules_attributes%5D%5B%5D%5Bfrom%5D=2021-11-15T11%3A45%3A19.673Z&data%5Battributes%5D%5Bprice_rules_attributes%5D%5B%5D%5Btill%5D=2022-01-15T11%3A45%3A19.673Z&data%5Btype%5D=price_rulesets&include=price_rules&page%5Bnumber%5D=1&page%5Bsize%5D=25"
  },
  "meta": {}
}
```

### HTTP Request

`POST /api/boomerang/price_rulesets`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=price_rules`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[price_rulesets]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][name]` | **String**<br>Name of the ruleset
`data[attributes][price_rules_attributes][]` | **Array**<br>Allows creating and updating price rules with their ruleset


### Includes

This request accepts the following includes:

`price_rules`






## Updating a price ruleset



> How to update a price ruleset:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/price_rulesets/92e15c1e-4f1d-40a6-afb7-24b9c872bd32' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "92e15c1e-4f1d-40a6-afb7-24b9c872bd32",
        "type": "price_rulesets",
        "attributes": {
          "name": "Seasonal ruleset (old)"
        }
      }
    }'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "92e15c1e-4f1d-40a6-afb7-24b9c872bd32",
    "type": "price_rulesets",
    "attributes": {
      "created_at": "2021-12-15T11:45:19+00:00",
      "updated_at": "2021-12-15T11:45:19+00:00",
      "name": "Seasonal ruleset (old)",
      "archived_at": null
    },
    "relationships": {
      "price_rules": {
        "meta": {
          "included": false
        }
      }
    }
  },
  "meta": {}
}
```


> Updating a price ruleset's price rules:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/price_rulesets/03fa15d6-f359-4331-8fb1-7ede6997d0b8' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "03fa15d6-f359-4331-8fb1-7ede6997d0b8",
        "type": "price_rulesets",
        "attributes": {
          "price_rules_attributes": [
            {
              "id": "a41372c9-5d67-4f3c-aa53-ba8ed0062f7d",
              "name": "Off season"
            }
          ]
        }
      },
      "include": "price_rules"
    }'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "03fa15d6-f359-4331-8fb1-7ede6997d0b8",
    "type": "price_rulesets",
    "attributes": {
      "created_at": "2021-12-15T11:45:20+00:00",
      "updated_at": "2021-12-15T11:45:20+00:00",
      "name": "Ruleset",
      "archived_at": null
    },
    "relationships": {
      "price_rules": {
        "data": [
          {
            "type": "price_rules",
            "id": "a41372c9-5d67-4f3c-aa53-ba8ed0062f7d"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "a41372c9-5d67-4f3c-aa53-ba8ed0062f7d",
      "type": "price_rules",
      "attributes": {
        "created_at": "2021-12-15T11:45:20+00:00",
        "updated_at": "2021-12-15T11:45:20+00:00",
        "name": "Off season",
        "rule_type": "range_of_dates",
        "match_strategy": "span",
        "adjustment_strategy": "percentage",
        "value": 30.0,
        "from": "2030-07-01T00:00:00+00:00",
        "till": "2030-08-31T00:00:00+00:00",
        "from_day": null,
        "till_day": null,
        "from_time": null,
        "till_time": null,
        "charge": null,
        "stacked": false,
        "time": null,
        "price_ruleset_id": "03fa15d6-f359-4331-8fb1-7ede6997d0b8"
      },
      "relationships": {
        "price_ruleset": {
          "meta": {
            "included": false
          }
        }
      }
    }
  ],
  "meta": {}
}
```

### HTTP Request

`PUT /api/boomerang/price_rulesets/{id}`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=price_rules`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[price_rulesets]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][name]` | **String**<br>Name of the ruleset
`data[attributes][price_rules_attributes][]` | **Array**<br>Allows creating and updating price rules with their ruleset


### Includes

This request accepts the following includes:

`price_rules`






## Archiving a price ruleset



> How to archive a price ruleset:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/price_rulesets/89baac28-d6fd-4445-90ae-962f2f8d7f8f' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "meta": {}
}
```

### HTTP Request

`DELETE /api/boomerang/price_rulesets/{id}`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=price_rules`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[price_rulesets]=id,created_at,updated_at`


### Includes

This request does not accept any includes