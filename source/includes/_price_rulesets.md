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
      "id": "97204271-34b2-48e2-9c01-deaeffe27ba2",
      "type": "price_rulesets",
      "attributes": {
        "created_at": "2022-01-10T13:52:31+00:00",
        "updated_at": "2022-01-10T13:52:31+00:00",
        "name": "Ruleset",
        "archived_at": null
      },
      "relationships": {
        "price_rules": {
          "links": {
            "related": "api/boomerang/price_rules?filter[price_ruleset_id]=97204271-34b2-48e2-9c01-deaeffe27ba2"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-01-10T13:49:51Z`
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
    --url 'https://example.booqable.com/api/boomerang/price_rulesets/a0e151e2-7179-4992-b0dc-5a0c854d0e22?include=price_rules' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "a0e151e2-7179-4992-b0dc-5a0c854d0e22",
    "type": "price_rulesets",
    "attributes": {
      "created_at": "2022-01-10T13:52:31+00:00",
      "updated_at": "2022-01-10T13:52:31+00:00",
      "name": "Ruleset",
      "archived_at": null
    },
    "relationships": {
      "price_rules": {
        "links": {
          "related": "api/boomerang/price_rules?filter[price_ruleset_id]=a0e151e2-7179-4992-b0dc-5a0c854d0e22"
        },
        "data": [
          {
            "type": "price_rules",
            "id": "c78df71c-eaf1-4587-afff-bade7477fc4d"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "c78df71c-eaf1-4587-afff-bade7477fc4d",
      "type": "price_rules",
      "attributes": {
        "created_at": "2022-01-10T13:52:31+00:00",
        "updated_at": "2022-01-10T13:52:31+00:00",
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
        "price_ruleset_id": "a0e151e2-7179-4992-b0dc-5a0c854d0e22"
      },
      "relationships": {
        "price_ruleset": {
          "links": {
            "related": "api/boomerang/price_rulesets/a0e151e2-7179-4992-b0dc-5a0c854d0e22"
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
              "from": "2021-12-10T13:52:32.312Z",
              "till": "2022-02-10T13:52:32.313Z"
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
    "id": "5d3d0c2f-11cf-462a-8cf1-91ee838b4603",
    "type": "price_rulesets",
    "attributes": {
      "created_at": "2022-01-10T13:52:32+00:00",
      "updated_at": "2022-01-10T13:52:32+00:00",
      "name": "Seasonal ruleset",
      "archived_at": null
    },
    "relationships": {
      "price_rules": {
        "data": [
          {
            "type": "price_rules",
            "id": "c9fb6a68-1bc6-4516-9e97-f3d4e7b14264"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "c9fb6a68-1bc6-4516-9e97-f3d4e7b14264",
      "type": "price_rules",
      "attributes": {
        "created_at": "2022-01-10T13:52:32+00:00",
        "updated_at": "2022-01-10T13:52:32+00:00",
        "name": "Off season",
        "rule_type": "range_of_dates",
        "match_strategy": "span",
        "adjustment_strategy": "percentage",
        "value": 25.0,
        "from": "2021-12-10T13:52:32+00:00",
        "till": "2022-02-10T13:52:32+00:00",
        "from_day": null,
        "till_day": null,
        "from_time": null,
        "till_time": null,
        "charge": null,
        "stacked": false,
        "time": null,
        "price_ruleset_id": "5d3d0c2f-11cf-462a-8cf1-91ee838b4603"
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
    "self": "api/boomerang/price_rulesets?data%5Battributes%5D%5Bname%5D=Seasonal+ruleset&data%5Battributes%5D%5Bprice_rules_attributes%5D%5B%5D%5Bname%5D=Off+season&data%5Battributes%5D%5Bprice_rules_attributes%5D%5B%5D%5Brule_type%5D=range_of_dates&data%5Battributes%5D%5Bprice_rules_attributes%5D%5B%5D%5Bmatch_strategy%5D=span&data%5Battributes%5D%5Bprice_rules_attributes%5D%5B%5D%5Bvalue%5D=25&data%5Battributes%5D%5Bprice_rules_attributes%5D%5B%5D%5Bfrom%5D=2021-12-10T13%3A52%3A32.312Z&data%5Battributes%5D%5Bprice_rules_attributes%5D%5B%5D%5Btill%5D=2022-02-10T13%3A52%3A32.313Z&data%5Btype%5D=price_rulesets&include=price_rules&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/price_rulesets?data%5Battributes%5D%5Bname%5D=Seasonal+ruleset&data%5Battributes%5D%5Bprice_rules_attributes%5D%5B%5D%5Bname%5D=Off+season&data%5Battributes%5D%5Bprice_rules_attributes%5D%5B%5D%5Brule_type%5D=range_of_dates&data%5Battributes%5D%5Bprice_rules_attributes%5D%5B%5D%5Bmatch_strategy%5D=span&data%5Battributes%5D%5Bprice_rules_attributes%5D%5B%5D%5Bvalue%5D=25&data%5Battributes%5D%5Bprice_rules_attributes%5D%5B%5D%5Bfrom%5D=2021-12-10T13%3A52%3A32.312Z&data%5Battributes%5D%5Bprice_rules_attributes%5D%5B%5D%5Btill%5D=2022-02-10T13%3A52%3A32.313Z&data%5Btype%5D=price_rulesets&include=price_rules&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/price_rulesets?data%5Battributes%5D%5Bname%5D=Seasonal+ruleset&data%5Battributes%5D%5Bprice_rules_attributes%5D%5B%5D%5Bname%5D=Off+season&data%5Battributes%5D%5Bprice_rules_attributes%5D%5B%5D%5Brule_type%5D=range_of_dates&data%5Battributes%5D%5Bprice_rules_attributes%5D%5B%5D%5Bmatch_strategy%5D=span&data%5Battributes%5D%5Bprice_rules_attributes%5D%5B%5D%5Bvalue%5D=25&data%5Battributes%5D%5Bprice_rules_attributes%5D%5B%5D%5Bfrom%5D=2021-12-10T13%3A52%3A32.312Z&data%5Battributes%5D%5Bprice_rules_attributes%5D%5B%5D%5Btill%5D=2022-02-10T13%3A52%3A32.313Z&data%5Btype%5D=price_rulesets&include=price_rules&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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
    --url 'https://example.booqable.com/api/boomerang/price_rulesets/25b1893a-a22f-4b5b-880e-c0b795f3295d' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "25b1893a-a22f-4b5b-880e-c0b795f3295d",
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
    "id": "25b1893a-a22f-4b5b-880e-c0b795f3295d",
    "type": "price_rulesets",
    "attributes": {
      "created_at": "2022-01-10T13:52:32+00:00",
      "updated_at": "2022-01-10T13:52:32+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/price_rulesets/a6f7840b-7f2d-4dc8-b435-a38e12c6e8b7' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "a6f7840b-7f2d-4dc8-b435-a38e12c6e8b7",
        "type": "price_rulesets",
        "attributes": {
          "price_rules_attributes": [
            {
              "id": "bb0feb20-9687-4fde-a183-9d723631a7e2",
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
    "id": "a6f7840b-7f2d-4dc8-b435-a38e12c6e8b7",
    "type": "price_rulesets",
    "attributes": {
      "created_at": "2022-01-10T13:52:33+00:00",
      "updated_at": "2022-01-10T13:52:33+00:00",
      "name": "Ruleset",
      "archived_at": null
    },
    "relationships": {
      "price_rules": {
        "data": [
          {
            "type": "price_rules",
            "id": "bb0feb20-9687-4fde-a183-9d723631a7e2"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "bb0feb20-9687-4fde-a183-9d723631a7e2",
      "type": "price_rules",
      "attributes": {
        "created_at": "2022-01-10T13:52:33+00:00",
        "updated_at": "2022-01-10T13:52:33+00:00",
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
        "price_ruleset_id": "a6f7840b-7f2d-4dc8-b435-a38e12c6e8b7"
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
    --url 'https://example.booqable.com/api/boomerang/price_rulesets/f1313a47-2e13-4fcd-a277-79e082e4c965' \
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