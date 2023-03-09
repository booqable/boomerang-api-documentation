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
`name` | **String** <br>Name of the ruleset
`price_rules_attributes` | **Array** `writeonly`<br>Allows creating and updating price rules with their ruleset
`make_name_unique` | **Boolean** `writeonly`<br>When `true`, a unique name will be generated when a PriceRuleset with the same name already exists.


## Relationships
Price rulesets have the following relationships:

Name | Description
- | -
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
      "id": "472a006e-59a1-4314-8577-f5da6b53dc32",
      "type": "price_rulesets",
      "attributes": {
        "created_at": "2023-03-09T10:30:05+00:00",
        "updated_at": "2023-03-09T10:30:05+00:00",
        "archived": false,
        "archived_at": null,
        "name": "Ruleset"
      },
      "relationships": {
        "price_rules": {
          "links": {
            "related": "api/boomerang/price_rules?filter[price_ruleset_id]=472a006e-59a1-4314-8577-f5da6b53dc32"
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
- | -
`include` | **String** <br>List of comma seperated relationships `?include=price_rules`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[price_rulesets]=id,created_at,updated_at`
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-03-09T10:26:12Z`
`sort` | **String** <br>How to sort the data `?sort=-created_at`
`meta` | **Hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String** <br>The page to request
`page[size]` | **String** <br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
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
- | -
`total` | **Array** <br>`count`


### Includes

This request does not accept any includes
## Fetching a price ruleset



> How to fetch a single price ruleset with related price rules:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/price_rulesets/f6196340-bb80-462b-86a0-51f66d272af1?include=price_rules' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "f6196340-bb80-462b-86a0-51f66d272af1",
    "type": "price_rulesets",
    "attributes": {
      "created_at": "2023-03-09T10:30:05+00:00",
      "updated_at": "2023-03-09T10:30:05+00:00",
      "archived": false,
      "archived_at": null,
      "name": "Ruleset"
    },
    "relationships": {
      "price_rules": {
        "links": {
          "related": "api/boomerang/price_rules?filter[price_ruleset_id]=f6196340-bb80-462b-86a0-51f66d272af1"
        },
        "data": [
          {
            "type": "price_rules",
            "id": "b645631a-1cb9-4453-9eb8-420104ed5ee5"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "b645631a-1cb9-4453-9eb8-420104ed5ee5",
      "type": "price_rules",
      "attributes": {
        "created_at": "2023-03-09T10:30:05+00:00",
        "updated_at": "2023-03-09T10:30:05+00:00",
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
        "price_ruleset_id": "f6196340-bb80-462b-86a0-51f66d272af1"
      },
      "relationships": {
        "price_ruleset": {
          "links": {
            "related": "api/boomerang/price_rulesets/f6196340-bb80-462b-86a0-51f66d272af1"
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
- | -
`include` | **String** <br>List of comma seperated relationships `?include=price_rules`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[price_rulesets]=id,created_at,updated_at`


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
              "from": "2023-02-09T10:30:06.225Z",
              "till": "2023-04-09T10:30:06.226Z"
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
    "id": "6c9c0324-0aae-4f32-81f5-4cb9c923ee14",
    "type": "price_rulesets",
    "attributes": {
      "created_at": "2023-03-09T10:30:06+00:00",
      "updated_at": "2023-03-09T10:30:06+00:00",
      "archived": false,
      "archived_at": null,
      "name": "Seasonal ruleset"
    },
    "relationships": {
      "price_rules": {
        "data": [
          {
            "type": "price_rules",
            "id": "a46c84a5-66e5-4a7b-b271-3e156aef901b"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "a46c84a5-66e5-4a7b-b271-3e156aef901b",
      "type": "price_rules",
      "attributes": {
        "created_at": "2023-03-09T10:30:06+00:00",
        "updated_at": "2023-03-09T10:30:06+00:00",
        "name": "Off season",
        "rule_type": "range_of_dates",
        "match_strategy": "span",
        "adjustment_strategy": "percentage",
        "value": 25.0,
        "from": "2023-02-09T10:30:06+00:00",
        "till": "2023-04-09T10:30:06+00:00",
        "from_day": null,
        "till_day": null,
        "from_time": null,
        "till_time": null,
        "charge": null,
        "stacked": false,
        "time": null,
        "price_ruleset_id": "6c9c0324-0aae-4f32-81f5-4cb9c923ee14"
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
- | -
`include` | **String** <br>List of comma seperated relationships `?include=price_rules`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[price_rulesets]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
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
    --url 'https://example.booqable.com/api/boomerang/price_rulesets/80f97896-a2ba-4a66-ba08-e1de9ac2172c' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "80f97896-a2ba-4a66-ba08-e1de9ac2172c",
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
    "id": "80f97896-a2ba-4a66-ba08-e1de9ac2172c",
    "type": "price_rulesets",
    "attributes": {
      "created_at": "2023-03-09T10:30:06+00:00",
      "updated_at": "2023-03-09T10:30:06+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/price_rulesets/e7759b25-1a38-4a6a-bfa3-67e3d9fa20a0' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "e7759b25-1a38-4a6a-bfa3-67e3d9fa20a0",
        "type": "price_rulesets",
        "attributes": {
          "price_rules_attributes": [
            {
              "id": "0586b409-8e0d-4d3a-89a5-b863135142c2",
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
    "id": "e7759b25-1a38-4a6a-bfa3-67e3d9fa20a0",
    "type": "price_rulesets",
    "attributes": {
      "created_at": "2023-03-09T10:30:07+00:00",
      "updated_at": "2023-03-09T10:30:07+00:00",
      "archived": false,
      "archived_at": null,
      "name": "Ruleset"
    },
    "relationships": {
      "price_rules": {
        "data": [
          {
            "type": "price_rules",
            "id": "0586b409-8e0d-4d3a-89a5-b863135142c2"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "0586b409-8e0d-4d3a-89a5-b863135142c2",
      "type": "price_rules",
      "attributes": {
        "created_at": "2023-03-09T10:30:07+00:00",
        "updated_at": "2023-03-09T10:30:07+00:00",
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
        "price_ruleset_id": "e7759b25-1a38-4a6a-bfa3-67e3d9fa20a0"
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
- | -
`include` | **String** <br>List of comma seperated relationships `?include=price_rules`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[price_rulesets]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
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
    --url 'https://example.booqable.com/api/boomerang/price_rulesets/ecdccce3-ebe9-4e8c-98b6-aa07edfcca87' \
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
- | -
`include` | **String** <br>List of comma seperated relationships `?include=price_rules`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[price_rulesets]=id,created_at,updated_at`


### Includes

This request does not accept any includes