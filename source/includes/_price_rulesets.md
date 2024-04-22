# Price rulesets

Price rulesets are used to create elaborate pricing adjustments using the advanced pricing feature.

<aside class="notice">
  Note: You must have the advanced pricing feature in your plan to use price rulesets and rules.
</aside>

## Endpoints
`GET /api/boomerang/price_rulesets/{id}`

`POST /api/boomerang/price_rulesets`

`GET /api/boomerang/price_rulesets`

`DELETE /api/boomerang/price_rulesets/{id}`

`PUT /api/boomerang/price_rulesets/{id}`

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


## Fetching a price ruleset



> How to fetch a single price ruleset with related price rules:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/price_rulesets/6e12df76-3983-4a3f-8c17-528f67ccca20?include=price_rules' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "6e12df76-3983-4a3f-8c17-528f67ccca20",
    "type": "price_rulesets",
    "attributes": {
      "created_at": "2024-04-22T09:25:28+00:00",
      "updated_at": "2024-04-22T09:25:28+00:00",
      "archived": false,
      "archived_at": null,
      "name": "Ruleset",
      "description": null
    },
    "relationships": {
      "price_rules": {
        "links": {
          "related": "api/boomerang/price_rules?filter[price_ruleset_id]=6e12df76-3983-4a3f-8c17-528f67ccca20"
        },
        "data": [
          {
            "type": "price_rules",
            "id": "a36ac29c-5ed5-44cb-87bf-50959adcaa2b"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "a36ac29c-5ed5-44cb-87bf-50959adcaa2b",
      "type": "price_rules",
      "attributes": {
        "created_at": "2024-04-22T09:25:28+00:00",
        "updated_at": "2024-04-22T09:25:28+00:00",
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
        "price_ruleset_id": "6e12df76-3983-4a3f-8c17-528f67ccca20"
      },
      "relationships": {
        "price_ruleset": {
          "links": {
            "related": "api/boomerang/price_rulesets/6e12df76-3983-4a3f-8c17-528f67ccca20"
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
              "from": "2024-03-22T09:25:28.645Z",
              "till": "2024-05-22T09:25:28.645Z"
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
    "id": "e26a3068-402b-4887-9691-f85ff75cda72",
    "type": "price_rulesets",
    "attributes": {
      "created_at": "2024-04-22T09:25:28+00:00",
      "updated_at": "2024-04-22T09:25:28+00:00",
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
            "id": "960928cf-c52e-43cd-8cce-c0d2c6aeafea"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "960928cf-c52e-43cd-8cce-c0d2c6aeafea",
      "type": "price_rules",
      "attributes": {
        "created_at": "2024-04-22T09:25:28+00:00",
        "updated_at": "2024-04-22T09:25:28+00:00",
        "name": "Off season",
        "rule_type": "range_of_dates",
        "match_strategy": "span",
        "adjustment_strategy": "percentage",
        "value": 25.0,
        "from": "2024-03-22T09:25:28+00:00",
        "till": "2024-05-22T09:25:28+00:00",
        "from_day": null,
        "till_day": null,
        "from_time": null,
        "till_time": null,
        "charge": null,
        "stacked": false,
        "time": null,
        "min_duration": null,
        "max_duration": null,
        "price_ruleset_id": "e26a3068-402b-4887-9691-f85ff75cda72"
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
      "id": "80daece8-e8fb-4e66-adfb-3b66c4067bd5",
      "type": "price_rulesets",
      "attributes": {
        "created_at": "2024-04-22T09:25:29+00:00",
        "updated_at": "2024-04-22T09:25:29+00:00",
        "archived": false,
        "archived_at": null,
        "name": "Ruleset",
        "description": null
      },
      "relationships": {
        "price_rules": {
          "links": {
            "related": "api/boomerang/price_rules?filter[price_ruleset_id]=80daece8-e8fb-4e66-adfb-3b66c4067bd5"
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
    --url 'https://example.booqable.com/api/boomerang/price_rulesets/f6be8200-feb3-46b5-b94a-74272e459623' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "f6be8200-feb3-46b5-b94a-74272e459623",
    "type": "price_rulesets",
    "attributes": {
      "created_at": "2024-04-22T09:25:29+00:00",
      "updated_at": "2024-04-22T09:25:29+00:00",
      "archived": true,
      "archived_at": "2024-04-22T09:25:29+00:00",
      "name": "Ruleset",
      "description": null
    },
    "relationships": {
      "price_rules": {
        "links": {
          "related": "api/boomerang/price_rules?filter[price_ruleset_id]=f6be8200-feb3-46b5-b94a-74272e459623"
        }
      }
    }
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
## Updating a price ruleset



> How to update a price ruleset:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/price_rulesets/7519b003-41d6-4b94-a97e-a3ab5252eeb2' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "7519b003-41d6-4b94-a97e-a3ab5252eeb2",
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
    "id": "7519b003-41d6-4b94-a97e-a3ab5252eeb2",
    "type": "price_rulesets",
    "attributes": {
      "created_at": "2024-04-22T09:25:30+00:00",
      "updated_at": "2024-04-22T09:25:30+00:00",
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


> Updating a price ruleset's price rules:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/price_rulesets/f87af2ed-c896-4cef-a097-8fd5d29279f4' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "f87af2ed-c896-4cef-a097-8fd5d29279f4",
        "type": "price_rulesets",
        "attributes": {
          "price_rules_attributes": [
            {
              "id": "0205c0e3-f364-4766-98e8-647805e3861c",
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
    "id": "f87af2ed-c896-4cef-a097-8fd5d29279f4",
    "type": "price_rulesets",
    "attributes": {
      "created_at": "2024-04-22T09:25:31+00:00",
      "updated_at": "2024-04-22T09:25:31+00:00",
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
            "id": "0205c0e3-f364-4766-98e8-647805e3861c"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "0205c0e3-f364-4766-98e8-647805e3861c",
      "type": "price_rules",
      "attributes": {
        "created_at": "2024-04-22T09:25:31+00:00",
        "updated_at": "2024-04-22T09:25:31+00:00",
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
        "price_ruleset_id": "f87af2ed-c896-4cef-a097-8fd5d29279f4"
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





