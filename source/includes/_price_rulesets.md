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
      "id": "4c7900f4-bb14-4914-a62a-f407020933db",
      "type": "price_rulesets",
      "attributes": {
        "created_at": "2024-06-10T09:22:59.465076+00:00",
        "updated_at": "2024-06-10T09:22:59.465076+00:00",
        "archived": false,
        "archived_at": null,
        "name": "Ruleset",
        "description": null
      },
      "relationships": {
        "price_rules": {
          "links": {
            "related": "api/boomerang/price_rules?filter[price_ruleset_id]=4c7900f4-bb14-4914-a62a-f407020933db"
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
## Fetching a price ruleset



> How to fetch a single price ruleset with related price rules:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/price_rulesets/4d96729e-5eb9-49fd-952d-71ade13dcbdc?include=price_rules' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "4d96729e-5eb9-49fd-952d-71ade13dcbdc",
    "type": "price_rulesets",
    "attributes": {
      "created_at": "2024-06-10T09:22:56.788854+00:00",
      "updated_at": "2024-06-10T09:22:56.788854+00:00",
      "archived": false,
      "archived_at": null,
      "name": "Ruleset",
      "description": null
    },
    "relationships": {
      "price_rules": {
        "links": {
          "related": "api/boomerang/price_rules?filter[price_ruleset_id]=4d96729e-5eb9-49fd-952d-71ade13dcbdc"
        },
        "data": [
          {
            "type": "price_rules",
            "id": "259d5bcc-8175-469d-89a7-792cbf69694c"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "259d5bcc-8175-469d-89a7-792cbf69694c",
      "type": "price_rules",
      "attributes": {
        "created_at": "2024-06-10T09:22:56.791812+00:00",
        "updated_at": "2024-06-10T09:22:56.791812+00:00",
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
        "price_ruleset_id": "4d96729e-5eb9-49fd-952d-71ade13dcbdc"
      },
      "relationships": {
        "price_ruleset": {
          "links": {
            "related": "api/boomerang/price_rulesets/4d96729e-5eb9-49fd-952d-71ade13dcbdc"
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
              "from": "2024-05-10T09:22:57.411Z",
              "till": "2024-07-10T09:22:57.411Z"
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
    "id": "1d674d2b-9212-4c56-8ffe-400d82441f9d",
    "type": "price_rulesets",
    "attributes": {
      "created_at": "2024-06-10T09:22:57.459690+00:00",
      "updated_at": "2024-06-10T09:22:57.459690+00:00",
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
            "id": "967453a1-663d-4b75-b661-2f23e6b2c810"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "967453a1-663d-4b75-b661-2f23e6b2c810",
      "type": "price_rules",
      "attributes": {
        "created_at": "2024-06-10T09:22:57.465051+00:00",
        "updated_at": "2024-06-10T09:22:57.465051+00:00",
        "name": "Off season",
        "rule_type": "range_of_dates",
        "match_strategy": "span",
        "adjustment_strategy": "percentage",
        "value": 25.0,
        "from": "2024-05-10T09:22:57.411000+00:00",
        "till": "2024-07-10T09:22:57.411000+00:00",
        "from_day": null,
        "till_day": null,
        "from_time": null,
        "till_time": null,
        "charge": null,
        "stacked": false,
        "time": null,
        "min_duration": null,
        "max_duration": null,
        "price_ruleset_id": "1d674d2b-9212-4c56-8ffe-400d82441f9d"
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






## Updating a price ruleset



> How to update a price ruleset:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/price_rulesets/8f938483-0bfb-4c99-87be-a6c1d81e65da' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "8f938483-0bfb-4c99-87be-a6c1d81e65da",
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
    "id": "8f938483-0bfb-4c99-87be-a6c1d81e65da",
    "type": "price_rulesets",
    "attributes": {
      "created_at": "2024-06-10T09:22:58.110497+00:00",
      "updated_at": "2024-06-10T09:22:58.154204+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/price_rulesets/58379745-bf0c-4f68-8f4b-87e4042226b8' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "58379745-bf0c-4f68-8f4b-87e4042226b8",
        "type": "price_rulesets",
        "attributes": {
          "price_rules_attributes": [
            {
              "id": "c92451bd-3c62-4ad5-b579-aebd295472e9",
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
    "id": "58379745-bf0c-4f68-8f4b-87e4042226b8",
    "type": "price_rulesets",
    "attributes": {
      "created_at": "2024-06-10T09:22:58.850981+00:00",
      "updated_at": "2024-06-10T09:22:58.850981+00:00",
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
            "id": "c92451bd-3c62-4ad5-b579-aebd295472e9"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "c92451bd-3c62-4ad5-b579-aebd295472e9",
      "type": "price_rules",
      "attributes": {
        "created_at": "2024-06-10T09:22:58.864385+00:00",
        "updated_at": "2024-06-10T09:22:58.924372+00:00",
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
        "price_ruleset_id": "58379745-bf0c-4f68-8f4b-87e4042226b8"
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






## Archiving a price ruleset



> How to archive a price ruleset:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/price_rulesets/5c3eebb6-7bf9-47c5-8558-2cc967c594b6' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "5c3eebb6-7bf9-47c5-8558-2cc967c594b6",
    "type": "price_rulesets",
    "attributes": {
      "created_at": "2024-06-10T09:23:00.090732+00:00",
      "updated_at": "2024-06-10T09:23:00.130567+00:00",
      "archived": true,
      "archived_at": "2024-06-10T09:23:00.130567+00:00",
      "name": "Ruleset",
      "description": null
    },
    "relationships": {
      "price_rules": {
        "links": {
          "related": "api/boomerang/price_rules?filter[price_ruleset_id]=5c3eebb6-7bf9-47c5-8558-2cc967c594b6"
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