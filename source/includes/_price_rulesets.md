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
      "id": "dac39cb6-ff73-408a-a749-241732fa7403",
      "type": "price_rulesets",
      "attributes": {
        "created_at": "2022-03-11T12:50:23+00:00",
        "updated_at": "2022-03-11T12:50:23+00:00",
        "archived": false,
        "archived_at": null,
        "name": "Ruleset"
      },
      "relationships": {
        "price_rules": {
          "links": {
            "related": "api/boomerang/price_rules?filter[price_ruleset_id]=dac39cb6-ff73-408a-a749-241732fa7403"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-03-11T12:48:34Z`
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
    --url 'https://example.booqable.com/api/boomerang/price_rulesets/275b5e8b-394e-4e92-84f6-72e36ac9ae23?include=price_rules' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "275b5e8b-394e-4e92-84f6-72e36ac9ae23",
    "type": "price_rulesets",
    "attributes": {
      "created_at": "2022-03-11T12:50:23+00:00",
      "updated_at": "2022-03-11T12:50:23+00:00",
      "archived": false,
      "archived_at": null,
      "name": "Ruleset"
    },
    "relationships": {
      "price_rules": {
        "links": {
          "related": "api/boomerang/price_rules?filter[price_ruleset_id]=275b5e8b-394e-4e92-84f6-72e36ac9ae23"
        },
        "data": [
          {
            "type": "price_rules",
            "id": "e1700c25-15b9-467a-b0af-15acb4ed6d77"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "e1700c25-15b9-467a-b0af-15acb4ed6d77",
      "type": "price_rules",
      "attributes": {
        "created_at": "2022-03-11T12:50:23+00:00",
        "updated_at": "2022-03-11T12:50:23+00:00",
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
        "price_ruleset_id": "275b5e8b-394e-4e92-84f6-72e36ac9ae23"
      },
      "relationships": {
        "price_ruleset": {
          "links": {
            "related": "api/boomerang/price_rulesets/275b5e8b-394e-4e92-84f6-72e36ac9ae23"
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
              "from": "2022-02-11T12:50:24.214Z",
              "till": "2022-04-11T12:50:24.215Z"
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
    "id": "9a2a0537-63c6-4ca9-9f78-53afa90c24fb",
    "type": "price_rulesets",
    "attributes": {
      "created_at": "2022-03-11T12:50:24+00:00",
      "updated_at": "2022-03-11T12:50:24+00:00",
      "archived": false,
      "archived_at": null,
      "name": "Seasonal ruleset"
    },
    "relationships": {
      "price_rules": {
        "data": [
          {
            "type": "price_rules",
            "id": "a2952a42-6f41-4a5e-9901-60dcbadddd52"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "a2952a42-6f41-4a5e-9901-60dcbadddd52",
      "type": "price_rules",
      "attributes": {
        "created_at": "2022-03-11T12:50:24+00:00",
        "updated_at": "2022-03-11T12:50:24+00:00",
        "name": "Off season",
        "rule_type": "range_of_dates",
        "match_strategy": "span",
        "adjustment_strategy": "percentage",
        "value": 25.0,
        "from": "2022-02-11T12:50:24+00:00",
        "till": "2022-04-11T12:50:24+00:00",
        "from_day": null,
        "till_day": null,
        "from_time": null,
        "till_time": null,
        "charge": null,
        "stacked": false,
        "time": null,
        "price_ruleset_id": "9a2a0537-63c6-4ca9-9f78-53afa90c24fb"
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
    --url 'https://example.booqable.com/api/boomerang/price_rulesets/f3b09d19-7605-4c3f-b652-bbe0a52c5614' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "f3b09d19-7605-4c3f-b652-bbe0a52c5614",
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
    "id": "f3b09d19-7605-4c3f-b652-bbe0a52c5614",
    "type": "price_rulesets",
    "attributes": {
      "created_at": "2022-03-11T12:50:24+00:00",
      "updated_at": "2022-03-11T12:50:24+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/price_rulesets/5d4e88a0-0e51-4f8e-b0ff-91e0a2eb5bfc' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "5d4e88a0-0e51-4f8e-b0ff-91e0a2eb5bfc",
        "type": "price_rulesets",
        "attributes": {
          "price_rules_attributes": [
            {
              "id": "720184b5-8dde-4ac6-ad30-bc9a993c86aa",
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
    "id": "5d4e88a0-0e51-4f8e-b0ff-91e0a2eb5bfc",
    "type": "price_rulesets",
    "attributes": {
      "created_at": "2022-03-11T12:50:24+00:00",
      "updated_at": "2022-03-11T12:50:24+00:00",
      "archived": false,
      "archived_at": null,
      "name": "Ruleset"
    },
    "relationships": {
      "price_rules": {
        "data": [
          {
            "type": "price_rules",
            "id": "720184b5-8dde-4ac6-ad30-bc9a993c86aa"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "720184b5-8dde-4ac6-ad30-bc9a993c86aa",
      "type": "price_rules",
      "attributes": {
        "created_at": "2022-03-11T12:50:24+00:00",
        "updated_at": "2022-03-11T12:50:24+00:00",
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
        "price_ruleset_id": "5d4e88a0-0e51-4f8e-b0ff-91e0a2eb5bfc"
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
    --url 'https://example.booqable.com/api/boomerang/price_rulesets/9f838275-4120-4644-8701-a154c927d7f8' \
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