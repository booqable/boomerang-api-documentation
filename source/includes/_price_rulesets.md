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
`archived` | **Boolean** `readonly`<br>Whether price ruleset is archived
`archived_at` | **Datetime** `readonly`<br>When the price ruleset was archived
`name` | **String**<br>Name of the ruleset
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
      "id": "61f5d631-1868-4620-a581-b2d5c64e9f8f",
      "type": "price_rulesets",
      "attributes": {
        "created_at": "2022-04-08T17:53:10+00:00",
        "updated_at": "2022-04-08T17:53:10+00:00",
        "archived": false,
        "archived_at": null,
        "name": "Ruleset"
      },
      "relationships": {
        "price_rules": {
          "links": {
            "related": "api/boomerang/price_rules?filter[price_ruleset_id]=61f5d631-1868-4620-a581-b2d5c64e9f8f"
          }
        }
      }
    }
  ],
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-04-08T17:51:17Z`
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
`archived` | **Boolean**<br>`eq`
`archived_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`name` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
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
    --url 'https://example.booqable.com/api/boomerang/price_rulesets/30326a01-24d5-4638-aff0-6061591aae28?include=price_rules' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "30326a01-24d5-4638-aff0-6061591aae28",
    "type": "price_rulesets",
    "attributes": {
      "created_at": "2022-04-08T17:53:11+00:00",
      "updated_at": "2022-04-08T17:53:11+00:00",
      "archived": false,
      "archived_at": null,
      "name": "Ruleset"
    },
    "relationships": {
      "price_rules": {
        "links": {
          "related": "api/boomerang/price_rules?filter[price_ruleset_id]=30326a01-24d5-4638-aff0-6061591aae28"
        },
        "data": [
          {
            "type": "price_rules",
            "id": "bc779fda-bd49-4b23-be17-1c8e6e396f12"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "bc779fda-bd49-4b23-be17-1c8e6e396f12",
      "type": "price_rules",
      "attributes": {
        "created_at": "2022-04-08T17:53:11+00:00",
        "updated_at": "2022-04-08T17:53:11+00:00",
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
        "price_ruleset_id": "30326a01-24d5-4638-aff0-6061591aae28"
      },
      "relationships": {
        "price_ruleset": {
          "links": {
            "related": "api/boomerang/price_rulesets/30326a01-24d5-4638-aff0-6061591aae28"
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
              "from": "2022-03-08T17:53:11.621Z",
              "till": "2022-05-08T17:53:11.621Z"
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
    "id": "108e6f45-661a-4741-a8ce-45a8bd0f3f53",
    "type": "price_rulesets",
    "attributes": {
      "created_at": "2022-04-08T17:53:11+00:00",
      "updated_at": "2022-04-08T17:53:11+00:00",
      "archived": false,
      "archived_at": null,
      "name": "Seasonal ruleset"
    },
    "relationships": {
      "price_rules": {
        "data": [
          {
            "type": "price_rules",
            "id": "bf853105-c026-4c1b-88f2-4733f7c1044a"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "bf853105-c026-4c1b-88f2-4733f7c1044a",
      "type": "price_rules",
      "attributes": {
        "created_at": "2022-04-08T17:53:11+00:00",
        "updated_at": "2022-04-08T17:53:11+00:00",
        "name": "Off season",
        "rule_type": "range_of_dates",
        "match_strategy": "span",
        "adjustment_strategy": "percentage",
        "value": 25.0,
        "from": "2022-03-08T17:53:11+00:00",
        "till": "2022-05-08T17:53:11+00:00",
        "from_day": null,
        "till_day": null,
        "from_time": null,
        "till_time": null,
        "charge": null,
        "stacked": false,
        "time": null,
        "price_ruleset_id": "108e6f45-661a-4741-a8ce-45a8bd0f3f53"
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
    --url 'https://example.booqable.com/api/boomerang/price_rulesets/1d810f4d-f691-4168-a9f1-c77f089e7053' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "1d810f4d-f691-4168-a9f1-c77f089e7053",
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
    "id": "1d810f4d-f691-4168-a9f1-c77f089e7053",
    "type": "price_rulesets",
    "attributes": {
      "created_at": "2022-04-08T17:53:11+00:00",
      "updated_at": "2022-04-08T17:53:11+00:00",
      "archived": false,
      "archived_at": null,
      "name": "Seasonal ruleset (old)"
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
    --url 'https://example.booqable.com/api/boomerang/price_rulesets/d1efc840-de9e-4789-a906-33342faf00b7' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "d1efc840-de9e-4789-a906-33342faf00b7",
        "type": "price_rulesets",
        "attributes": {
          "price_rules_attributes": [
            {
              "id": "051dc28b-362e-47d7-bde9-eb624423e282",
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
    "id": "d1efc840-de9e-4789-a906-33342faf00b7",
    "type": "price_rulesets",
    "attributes": {
      "created_at": "2022-04-08T17:53:12+00:00",
      "updated_at": "2022-04-08T17:53:12+00:00",
      "archived": false,
      "archived_at": null,
      "name": "Ruleset"
    },
    "relationships": {
      "price_rules": {
        "data": [
          {
            "type": "price_rules",
            "id": "051dc28b-362e-47d7-bde9-eb624423e282"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "051dc28b-362e-47d7-bde9-eb624423e282",
      "type": "price_rules",
      "attributes": {
        "created_at": "2022-04-08T17:53:12+00:00",
        "updated_at": "2022-04-08T17:53:12+00:00",
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
        "price_ruleset_id": "d1efc840-de9e-4789-a906-33342faf00b7"
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
    --url 'https://example.booqable.com/api/boomerang/price_rulesets/02354727-2e86-4a5c-a70f-3a4950db0676' \
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