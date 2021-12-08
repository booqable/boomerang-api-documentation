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
      "id": "7856f3d9-cc48-48a5-98e1-9d11ff632d9b",
      "type": "price_rulesets",
      "attributes": {
        "created_at": "2021-12-08T12:35:17+00:00",
        "updated_at": "2021-12-08T12:35:17+00:00",
        "name": "Ruleset",
        "archived_at": null
      },
      "relationships": {
        "price_rules": {
          "links": {
            "related": "api/boomerang/price_rules?filter[price_ruleset_id]=7856f3d9-cc48-48a5-98e1-9d11ff632d9b"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-12-08T12:33:46Z`
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
    --url 'https://example.booqable.com/api/boomerang/price_rulesets/a4ff9686-3395-425c-8366-3338e32a233e?include=price_rules' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "a4ff9686-3395-425c-8366-3338e32a233e",
    "type": "price_rulesets",
    "attributes": {
      "created_at": "2021-12-08T12:35:17+00:00",
      "updated_at": "2021-12-08T12:35:17+00:00",
      "name": "Ruleset",
      "archived_at": null
    },
    "relationships": {
      "price_rules": {
        "links": {
          "related": "api/boomerang/price_rules?filter[price_ruleset_id]=a4ff9686-3395-425c-8366-3338e32a233e"
        },
        "data": [
          {
            "type": "price_rules",
            "id": "d5c1b199-df50-4822-b880-dcb74bd53b65"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "d5c1b199-df50-4822-b880-dcb74bd53b65",
      "type": "price_rules",
      "attributes": {
        "created_at": "2021-12-08T12:35:17+00:00",
        "updated_at": "2021-12-08T12:35:17+00:00",
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
        "price_ruleset_id": "a4ff9686-3395-425c-8366-3338e32a233e"
      },
      "relationships": {
        "price_ruleset": {
          "links": {
            "related": "api/boomerang/price_rulesets/a4ff9686-3395-425c-8366-3338e32a233e"
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
              "from": "2021-11-08T12:35:18.142Z",
              "till": "2022-01-08T12:35:18.142Z"
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
    "id": "c16ade78-b878-48a5-a3ad-a028dbf6106a",
    "type": "price_rulesets",
    "attributes": {
      "created_at": "2021-12-08T12:35:18+00:00",
      "updated_at": "2021-12-08T12:35:18+00:00",
      "name": "Seasonal ruleset",
      "archived_at": null
    },
    "relationships": {
      "price_rules": {
        "data": [
          {
            "type": "price_rules",
            "id": "696fe8d4-8670-47d6-8f8d-8e3a1bcac29e"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "696fe8d4-8670-47d6-8f8d-8e3a1bcac29e",
      "type": "price_rules",
      "attributes": {
        "created_at": "2021-12-08T12:35:18+00:00",
        "updated_at": "2021-12-08T12:35:18+00:00",
        "name": "Off season",
        "rule_type": "range_of_dates",
        "match_strategy": "span",
        "adjustment_strategy": "percentage",
        "value": 25.0,
        "from": "2021-11-08T12:35:18+00:00",
        "till": "2022-01-08T12:35:18+00:00",
        "from_day": null,
        "till_day": null,
        "from_time": null,
        "till_time": null,
        "charge": null,
        "stacked": false,
        "time": null,
        "price_ruleset_id": "c16ade78-b878-48a5-a3ad-a028dbf6106a"
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
    "self": "api/boomerang/price_rulesets?data%5Battributes%5D%5Bname%5D=Seasonal+ruleset&data%5Battributes%5D%5Bprice_rules_attributes%5D%5B%5D%5Bname%5D=Off+season&data%5Battributes%5D%5Bprice_rules_attributes%5D%5B%5D%5Brule_type%5D=range_of_dates&data%5Battributes%5D%5Bprice_rules_attributes%5D%5B%5D%5Bmatch_strategy%5D=span&data%5Battributes%5D%5Bprice_rules_attributes%5D%5B%5D%5Bvalue%5D=25&data%5Battributes%5D%5Bprice_rules_attributes%5D%5B%5D%5Bfrom%5D=2021-11-08T12%3A35%3A18.142Z&data%5Battributes%5D%5Bprice_rules_attributes%5D%5B%5D%5Btill%5D=2022-01-08T12%3A35%3A18.142Z&data%5Btype%5D=price_rulesets&include=price_rules&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/price_rulesets?data%5Battributes%5D%5Bname%5D=Seasonal+ruleset&data%5Battributes%5D%5Bprice_rules_attributes%5D%5B%5D%5Bname%5D=Off+season&data%5Battributes%5D%5Bprice_rules_attributes%5D%5B%5D%5Brule_type%5D=range_of_dates&data%5Battributes%5D%5Bprice_rules_attributes%5D%5B%5D%5Bmatch_strategy%5D=span&data%5Battributes%5D%5Bprice_rules_attributes%5D%5B%5D%5Bvalue%5D=25&data%5Battributes%5D%5Bprice_rules_attributes%5D%5B%5D%5Bfrom%5D=2021-11-08T12%3A35%3A18.142Z&data%5Battributes%5D%5Bprice_rules_attributes%5D%5B%5D%5Btill%5D=2022-01-08T12%3A35%3A18.142Z&data%5Btype%5D=price_rulesets&include=price_rules&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/price_rulesets?data%5Battributes%5D%5Bname%5D=Seasonal+ruleset&data%5Battributes%5D%5Bprice_rules_attributes%5D%5B%5D%5Bname%5D=Off+season&data%5Battributes%5D%5Bprice_rules_attributes%5D%5B%5D%5Brule_type%5D=range_of_dates&data%5Battributes%5D%5Bprice_rules_attributes%5D%5B%5D%5Bmatch_strategy%5D=span&data%5Battributes%5D%5Bprice_rules_attributes%5D%5B%5D%5Bvalue%5D=25&data%5Battributes%5D%5Bprice_rules_attributes%5D%5B%5D%5Bfrom%5D=2021-11-08T12%3A35%3A18.142Z&data%5Battributes%5D%5Bprice_rules_attributes%5D%5B%5D%5Btill%5D=2022-01-08T12%3A35%3A18.142Z&data%5Btype%5D=price_rulesets&include=price_rules&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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
    --url 'https://example.booqable.com/api/boomerang/price_rulesets/0a4d8fcf-fe2a-4a2a-8b4c-5aeba64ffd9c' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "0a4d8fcf-fe2a-4a2a-8b4c-5aeba64ffd9c",
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
    "id": "0a4d8fcf-fe2a-4a2a-8b4c-5aeba64ffd9c",
    "type": "price_rulesets",
    "attributes": {
      "created_at": "2021-12-08T12:35:18+00:00",
      "updated_at": "2021-12-08T12:35:18+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/price_rulesets/ed8b255f-7f47-46cc-9ebb-601232706909' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "ed8b255f-7f47-46cc-9ebb-601232706909",
        "type": "price_rulesets",
        "attributes": {
          "price_rules_attributes": [
            {
              "id": "4c0a731d-6667-4b04-98bd-b2903ac5a151",
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
    "id": "ed8b255f-7f47-46cc-9ebb-601232706909",
    "type": "price_rulesets",
    "attributes": {
      "created_at": "2021-12-08T12:35:18+00:00",
      "updated_at": "2021-12-08T12:35:18+00:00",
      "name": "Ruleset",
      "archived_at": null
    },
    "relationships": {
      "price_rules": {
        "data": [
          {
            "type": "price_rules",
            "id": "4c0a731d-6667-4b04-98bd-b2903ac5a151"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "4c0a731d-6667-4b04-98bd-b2903ac5a151",
      "type": "price_rules",
      "attributes": {
        "created_at": "2021-12-08T12:35:18+00:00",
        "updated_at": "2021-12-08T12:35:18+00:00",
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
        "price_ruleset_id": "ed8b255f-7f47-46cc-9ebb-601232706909"
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
    --url 'https://example.booqable.com/api/boomerang/price_rulesets/b53a5cbd-c458-4718-942e-609e3efe7c8c' \
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