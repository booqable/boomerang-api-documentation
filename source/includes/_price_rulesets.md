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
      "id": "9036c5be-b90a-43e4-abeb-d33f20dd067d",
      "type": "price_rulesets",
      "attributes": {
        "created_at": "2024-09-23T09:24:01.933770+00:00",
        "updated_at": "2024-09-23T09:24:01.933770+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/price_rulesets/26165ee5-6c4b-4ee4-a19a-d448da2b5264?include=price_rules' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "26165ee5-6c4b-4ee4-a19a-d448da2b5264",
    "type": "price_rulesets",
    "attributes": {
      "created_at": "2024-09-23T09:24:01.489743+00:00",
      "updated_at": "2024-09-23T09:24:01.489743+00:00",
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
            "id": "507b8afd-6a9d-4e4d-ab2c-a5bb28b0ebd8"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "507b8afd-6a9d-4e4d-ab2c-a5bb28b0ebd8",
      "type": "price_rules",
      "attributes": {
        "created_at": "2024-09-23T09:24:01.491745+00:00",
        "updated_at": "2024-09-23T09:24:01.491745+00:00",
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
        "price_ruleset_id": "26165ee5-6c4b-4ee4-a19a-d448da2b5264"
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
              "from": "2024-08-23T09:24:00.188Z",
              "till": "2024-10-23T09:24:00.188Z"
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
    "id": "bc5cdaa3-26d7-49b8-969f-51a562e246b0",
    "type": "price_rulesets",
    "attributes": {
      "created_at": "2024-09-23T09:24:00.211732+00:00",
      "updated_at": "2024-09-23T09:24:00.211732+00:00",
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
            "id": "6c935c3d-9b0e-4fa2-841b-0f86f3fe3531"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "6c935c3d-9b0e-4fa2-841b-0f86f3fe3531",
      "type": "price_rules",
      "attributes": {
        "created_at": "2024-09-23T09:24:00.213304+00:00",
        "updated_at": "2024-09-23T09:24:00.213304+00:00",
        "name": "Off season",
        "rule_type": "range_of_dates",
        "match_strategy": "span",
        "adjustment_strategy": "percentage",
        "value": 25.0,
        "from": "2024-08-23T09:24:00.188000+00:00",
        "till": "2024-10-23T09:24:00.188000+00:00",
        "from_day": null,
        "till_day": null,
        "from_time": null,
        "till_time": null,
        "charge": null,
        "stacked": false,
        "time": null,
        "min_duration": null,
        "max_duration": null,
        "price_ruleset_id": "bc5cdaa3-26d7-49b8-969f-51a562e246b0"
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
    --url 'https://example.booqable.com/api/boomerang/price_rulesets/3eae0ee4-ebc1-43a7-9ef9-4a0ef1fa24d1' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "3eae0ee4-ebc1-43a7-9ef9-4a0ef1fa24d1",
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
    "id": "3eae0ee4-ebc1-43a7-9ef9-4a0ef1fa24d1",
    "type": "price_rulesets",
    "attributes": {
      "created_at": "2024-09-23T09:24:02.935365+00:00",
      "updated_at": "2024-09-23T09:24:02.953551+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/price_rulesets/50e11be6-3960-4129-b966-713288a9c1bf' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "50e11be6-3960-4129-b966-713288a9c1bf",
        "type": "price_rulesets",
        "attributes": {
          "price_rules_attributes": [
            {
              "id": "5d66a0c6-007d-4d94-8caa-4912f66b8a43",
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
    "id": "50e11be6-3960-4129-b966-713288a9c1bf",
    "type": "price_rulesets",
    "attributes": {
      "created_at": "2024-09-23T09:24:02.501455+00:00",
      "updated_at": "2024-09-23T09:24:02.501455+00:00",
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
            "id": "5d66a0c6-007d-4d94-8caa-4912f66b8a43"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "5d66a0c6-007d-4d94-8caa-4912f66b8a43",
      "type": "price_rules",
      "attributes": {
        "created_at": "2024-09-23T09:24:02.502725+00:00",
        "updated_at": "2024-09-23T09:24:02.526240+00:00",
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
        "price_ruleset_id": "50e11be6-3960-4129-b966-713288a9c1bf"
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
    --url 'https://example.booqable.com/api/boomerang/price_rulesets/356fa0e5-a7f8-4222-8668-b9c347fd602a' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "356fa0e5-a7f8-4222-8668-b9c347fd602a",
    "type": "price_rulesets",
    "attributes": {
      "created_at": "2024-09-23T09:24:00.868696+00:00",
      "updated_at": "2024-09-23T09:24:00.887532+00:00",
      "archived": true,
      "archived_at": "2024-09-23T09:24:00.887532+00:00",
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