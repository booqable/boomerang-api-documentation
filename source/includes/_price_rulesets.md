# Price rulesets

Price rulesets are used to create elaborate pricing adjustments using the advanced pricing feature.

<aside class="notice">
  Note: You must have the advanced pricing feature in your plan to use price rulesets and rules.
</aside>

## Endpoints
`GET /api/boomerang/price_rulesets`

`DELETE /api/boomerang/price_rulesets/{id}`

`PUT /api/boomerang/price_rulesets/{id}`

`POST /api/boomerang/price_rulesets`

`GET /api/boomerang/price_rulesets/{id}`

## Fields
Every price ruleset has the following fields:

Name | Description
-- | --
`id` | **Uuid** `readonly`<br>Primary key
`created_at` | **Datetime** `readonly`<br>When the resource was created
`updated_at` | **Datetime** `readonly`<br>When the resource was last updated
`archived` | **Boolean** `readonly`<br>Whether price ruleset is archived
`archived_at` | **Datetime** `readonly`<br>When the price ruleset was archived
`name` | **String** <br>Name of the ruleset
`description` | **String** <br>Description of the ruleset
`price_rules_attributes` | **Array** `writeonly`<br>Allows creating and updating price rules with their ruleset
`make_name_unique` | **Boolean** `writeonly`<br>When `true`, a unique name will be generated when a PriceRuleset with the same name already exists.


## Relationships
Price rulesets have the following relationships:

Name | Description
-- | --
`price_rules` | **Price rules** `readonly`<br>Associated Price rules


## Listing price rulesets



> How to fetch price rulesets:

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
      "id": "495a84b2-cf9a-4720-8841-a13435d85906",
      "type": "price_rulesets",
      "attributes": {
        "created_at": "2024-03-04T09:19:50+00:00",
        "updated_at": "2024-03-04T09:19:50+00:00",
        "archived": false,
        "archived_at": null,
        "name": "Ruleset",
        "description": null
      },
      "relationships": {
        "price_rules": {
          "links": {
            "related": "api/boomerang/price_rules?filter[price_ruleset_id]=495a84b2-cf9a-4720-8841-a13435d85906"
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

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[price_rulesets]=created_at,updated_at,archived`
`filter` | **Hash** <br>The filters to apply `?filter[attribute][eq]=value`
`sort` | **String** <br>How to sort the data `?sort=attribute1,-attribute2`
`meta` | **Hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String** <br>The page to request
`page[size]` | **String** <br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
-- | --
`id` | **Uuid** <br>`eq`, `not_eq`
`created_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`archived` | **Boolean** <br>`eq`
`archived_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`name` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`price_rules_attributes` | **Array** <br>`eq`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **Array** <br>`count`


### Includes

This request does not accept any includes
## Archiving a price ruleset



> How to archive a price ruleset:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/price_rulesets/95e1507e-29d9-4398-ae09-cb9864dad83e' \
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

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[price_rulesets]=created_at,updated_at,archived`


### Includes

This request does not accept any includes
## Updating a price ruleset



> Updating a price ruleset's price rules:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/price_rulesets/e43d1af7-3975-4fbe-99a6-b776b6596e81' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "e43d1af7-3975-4fbe-99a6-b776b6596e81",
        "type": "price_rulesets",
        "attributes": {
          "price_rules_attributes": [
            {
              "id": "78e06d46-2997-4bb9-8a29-2e7cae1c1aa2",
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
    "id": "e43d1af7-3975-4fbe-99a6-b776b6596e81",
    "type": "price_rulesets",
    "attributes": {
      "created_at": "2024-03-04T09:19:52+00:00",
      "updated_at": "2024-03-04T09:19:52+00:00",
      "archived": false,
      "archived_at": null,
      "name": "Ruleset",
      "description": null
    },
    "relationships": {
      "price_rules": {
        "data": [
          {
            "type": "price_rules",
            "id": "78e06d46-2997-4bb9-8a29-2e7cae1c1aa2"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "78e06d46-2997-4bb9-8a29-2e7cae1c1aa2",
      "type": "price_rules",
      "attributes": {
        "created_at": "2024-03-04T09:19:52+00:00",
        "updated_at": "2024-03-04T09:19:52+00:00",
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
        "min_duration": null,
        "max_duration": null,
        "price_ruleset_id": "e43d1af7-3975-4fbe-99a6-b776b6596e81"
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


> How to update a price ruleset:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/price_rulesets/91b9418a-88c5-46f2-8095-1f660f50fb4d' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "91b9418a-88c5-46f2-8095-1f660f50fb4d",
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
    "id": "91b9418a-88c5-46f2-8095-1f660f50fb4d",
    "type": "price_rulesets",
    "attributes": {
      "created_at": "2024-03-04T09:19:53+00:00",
      "updated_at": "2024-03-04T09:19:53+00:00",
      "archived": false,
      "archived_at": null,
      "name": "Seasonal ruleset (old)",
      "description": null
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

### HTTP Request

`PUT /api/boomerang/price_rulesets/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=price_rules`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[price_rulesets]=created_at,updated_at,archived`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][name]` | **String** <br>Name of the ruleset
`data[attributes][price_rules_attributes][]` | **Array** <br>Allows creating and updating price rules with their ruleset
`data[attributes][make_name_unique]` | **Boolean** <br>When `true`, a unique name will be generated when a PriceRuleset with the same name already exists.


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
              "from": "2024-02-04T09:19:54.379Z",
              "till": "2024-04-04T09:19:54.379Z"
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
    "id": "6ab2ec06-359d-409a-b741-2e92bd0d0f36",
    "type": "price_rulesets",
    "attributes": {
      "created_at": "2024-03-04T09:19:54+00:00",
      "updated_at": "2024-03-04T09:19:54+00:00",
      "archived": false,
      "archived_at": null,
      "name": "Seasonal ruleset",
      "description": null
    },
    "relationships": {
      "price_rules": {
        "data": [
          {
            "type": "price_rules",
            "id": "d80857d5-2c4e-4f75-87c1-f4e77bb6ac5b"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "d80857d5-2c4e-4f75-87c1-f4e77bb6ac5b",
      "type": "price_rules",
      "attributes": {
        "created_at": "2024-03-04T09:19:54+00:00",
        "updated_at": "2024-03-04T09:19:54+00:00",
        "name": "Off season",
        "rule_type": "range_of_dates",
        "match_strategy": "span",
        "adjustment_strategy": "percentage",
        "value": 25.0,
        "from": "2024-02-04T09:19:54+00:00",
        "till": "2024-04-04T09:19:54+00:00",
        "from_day": null,
        "till_day": null,
        "from_time": null,
        "till_time": null,
        "charge": null,
        "stacked": false,
        "time": null,
        "min_duration": null,
        "max_duration": null,
        "price_ruleset_id": "6ab2ec06-359d-409a-b741-2e92bd0d0f36"
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

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=price_rules`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[price_rulesets]=created_at,updated_at,archived`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][name]` | **String** <br>Name of the ruleset
`data[attributes][price_rules_attributes][]` | **Array** <br>Allows creating and updating price rules with their ruleset
`data[attributes][make_name_unique]` | **Boolean** <br>When `true`, a unique name will be generated when a PriceRuleset with the same name already exists.


### Includes

This request accepts the following includes:

`price_rules`






## Fetching a price ruleset



> How to fetch a single price ruleset with related price rules:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/price_rulesets/85d55dea-044f-4126-8d72-64d467b7ee8a?include=price_rules' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "85d55dea-044f-4126-8d72-64d467b7ee8a",
    "type": "price_rulesets",
    "attributes": {
      "created_at": "2024-03-04T09:19:54+00:00",
      "updated_at": "2024-03-04T09:19:54+00:00",
      "archived": false,
      "archived_at": null,
      "name": "Ruleset",
      "description": null
    },
    "relationships": {
      "price_rules": {
        "links": {
          "related": "api/boomerang/price_rules?filter[price_ruleset_id]=85d55dea-044f-4126-8d72-64d467b7ee8a"
        },
        "data": [
          {
            "type": "price_rules",
            "id": "6fb21a7a-7e2c-4ad7-b847-af0469d20752"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "6fb21a7a-7e2c-4ad7-b847-af0469d20752",
      "type": "price_rules",
      "attributes": {
        "created_at": "2024-03-04T09:19:54+00:00",
        "updated_at": "2024-03-04T09:19:54+00:00",
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
        "min_duration": null,
        "max_duration": null,
        "price_ruleset_id": "85d55dea-044f-4126-8d72-64d467b7ee8a"
      },
      "relationships": {
        "price_ruleset": {
          "links": {
            "related": "api/boomerang/price_rulesets/85d55dea-044f-4126-8d72-64d467b7ee8a"
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

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=price_rules`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[price_rulesets]=created_at,updated_at,archived`


### Includes

This request accepts the following includes:

`price_rules`





