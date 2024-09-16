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
      "id": "723093fa-2943-4b6d-9765-ad3f84b0ef06",
      "type": "price_rulesets",
      "attributes": {
        "created_at": "2024-09-16T09:22:33.206660+00:00",
        "updated_at": "2024-09-16T09:22:33.206660+00:00",
        "archived": false,
        "archived_at": null,
        "name": "Ruleset",
        "description": null
      },
      "relationships": {}
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
## Fetching a price ruleset



> How to fetch a single price ruleset with related price rules:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/price_rulesets/f3895c61-6023-49d1-8b2f-63898e5441a7?include=price_rules' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "f3895c61-6023-49d1-8b2f-63898e5441a7",
    "type": "price_rulesets",
    "attributes": {
      "created_at": "2024-09-16T09:22:30.543384+00:00",
      "updated_at": "2024-09-16T09:22:30.543384+00:00",
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
            "id": "94853cf1-aff0-4889-8b13-80778c351969"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "94853cf1-aff0-4889-8b13-80778c351969",
      "type": "price_rules",
      "attributes": {
        "created_at": "2024-09-16T09:22:30.545718+00:00",
        "updated_at": "2024-09-16T09:22:30.545718+00:00",
        "name": "Price rule",
        "rule_type": "range_of_dates",
        "match_strategy": "span",
        "adjustment_strategy": "percentage",
        "value": 30.0,
        "from": "2030-07-01T00:00:00.000000+00:00",
        "till": "2030-08-31T00:00:00.000000+00:00",
        "from_day": null,
        "till_day": null,
        "from_time": null,
        "till_time": null,
        "charge": null,
        "stacked": false,
        "time": null,
        "min_duration": null,
        "max_duration": null,
        "price_ruleset_id": "f3895c61-6023-49d1-8b2f-63898e5441a7"
      },
      "relationships": {}
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
              "from": "2024-08-16T09:22:33.870Z",
              "till": "2024-10-16T09:22:33.871Z"
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
    "id": "1f4fd5b0-c8dc-45d9-b3d1-4791a142f7ab",
    "type": "price_rulesets",
    "attributes": {
      "created_at": "2024-09-16T09:22:33.906454+00:00",
      "updated_at": "2024-09-16T09:22:33.906454+00:00",
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
            "id": "4969b34e-b722-4278-b49d-1bf49aab4071"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "4969b34e-b722-4278-b49d-1bf49aab4071",
      "type": "price_rules",
      "attributes": {
        "created_at": "2024-09-16T09:22:33.908686+00:00",
        "updated_at": "2024-09-16T09:22:33.908686+00:00",
        "name": "Off season",
        "rule_type": "range_of_dates",
        "match_strategy": "span",
        "adjustment_strategy": "percentage",
        "value": 25.0,
        "from": "2024-08-16T09:22:33.870000+00:00",
        "till": "2024-10-16T09:22:33.871000+00:00",
        "from_day": null,
        "till_day": null,
        "from_time": null,
        "till_time": null,
        "charge": null,
        "stacked": false,
        "time": null,
        "min_duration": null,
        "max_duration": null,
        "price_ruleset_id": "1f4fd5b0-c8dc-45d9-b3d1-4791a142f7ab"
      },
      "relationships": {}
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






## Updating a price ruleset



> How to update a price ruleset:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/price_rulesets/da2282e3-7ec3-483a-9bac-3ae9790425a7' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "da2282e3-7ec3-483a-9bac-3ae9790425a7",
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
    "id": "da2282e3-7ec3-483a-9bac-3ae9790425a7",
    "type": "price_rulesets",
    "attributes": {
      "created_at": "2024-09-16T09:22:31.166993+00:00",
      "updated_at": "2024-09-16T09:22:31.202224+00:00",
      "archived": false,
      "archived_at": null,
      "name": "Seasonal ruleset (old)",
      "description": null
    },
    "relationships": {}
  },
  "meta": {}
}
```


> Updating a price ruleset's price rules:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/price_rulesets/f0ba8c69-c2ad-4c57-b5df-6747a435dece' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "f0ba8c69-c2ad-4c57-b5df-6747a435dece",
        "type": "price_rulesets",
        "attributes": {
          "price_rules_attributes": [
            {
              "id": "dd5f367b-12d3-453b-8f9d-32fb8aa59e00",
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
    "id": "f0ba8c69-c2ad-4c57-b5df-6747a435dece",
    "type": "price_rulesets",
    "attributes": {
      "created_at": "2024-09-16T09:22:31.844118+00:00",
      "updated_at": "2024-09-16T09:22:31.844118+00:00",
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
            "id": "dd5f367b-12d3-453b-8f9d-32fb8aa59e00"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "dd5f367b-12d3-453b-8f9d-32fb8aa59e00",
      "type": "price_rules",
      "attributes": {
        "created_at": "2024-09-16T09:22:31.846037+00:00",
        "updated_at": "2024-09-16T09:22:31.893831+00:00",
        "name": "Off season",
        "rule_type": "range_of_dates",
        "match_strategy": "span",
        "adjustment_strategy": "percentage",
        "value": 30.0,
        "from": "2030-07-01T00:00:00.000000+00:00",
        "till": "2030-08-31T00:00:00.000000+00:00",
        "from_day": null,
        "till_day": null,
        "from_time": null,
        "till_time": null,
        "charge": null,
        "stacked": false,
        "time": null,
        "min_duration": null,
        "max_duration": null,
        "price_ruleset_id": "f0ba8c69-c2ad-4c57-b5df-6747a435dece"
      },
      "relationships": {}
    }
  ],
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






## Archiving a price ruleset



> How to archive a price ruleset:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/price_rulesets/7b29e3c6-1ed2-48a7-8453-e89990b9dddb' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "7b29e3c6-1ed2-48a7-8453-e89990b9dddb",
    "type": "price_rulesets",
    "attributes": {
      "created_at": "2024-09-16T09:22:32.532507+00:00",
      "updated_at": "2024-09-16T09:22:32.560284+00:00",
      "archived": true,
      "archived_at": "2024-09-16T09:22:32.560284+00:00",
      "name": "Ruleset",
      "description": null
    },
    "relationships": {}
  },
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