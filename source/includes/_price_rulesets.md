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
      "id": "a041640b-83e2-4b82-bdb2-d94f99f477a7",
      "type": "price_rulesets",
      "attributes": {
        "created_at": "2022-01-05T12:40:49+00:00",
        "updated_at": "2022-01-05T12:40:49+00:00",
        "name": "Ruleset",
        "archived_at": null
      },
      "relationships": {
        "price_rules": {
          "links": {
            "related": "api/boomerang/price_rules?filter[price_ruleset_id]=a041640b-83e2-4b82-bdb2-d94f99f477a7"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-01-05T12:38:51Z`
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
    --url 'https://example.booqable.com/api/boomerang/price_rulesets/d5b4ad0f-5a50-48bd-9c39-1f81b6e48eae?include=price_rules' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "d5b4ad0f-5a50-48bd-9c39-1f81b6e48eae",
    "type": "price_rulesets",
    "attributes": {
      "created_at": "2022-01-05T12:40:50+00:00",
      "updated_at": "2022-01-05T12:40:50+00:00",
      "name": "Ruleset",
      "archived_at": null
    },
    "relationships": {
      "price_rules": {
        "links": {
          "related": "api/boomerang/price_rules?filter[price_ruleset_id]=d5b4ad0f-5a50-48bd-9c39-1f81b6e48eae"
        },
        "data": [
          {
            "type": "price_rules",
            "id": "81b6b9c7-025b-405f-ac9f-5e949603965e"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "81b6b9c7-025b-405f-ac9f-5e949603965e",
      "type": "price_rules",
      "attributes": {
        "created_at": "2022-01-05T12:40:50+00:00",
        "updated_at": "2022-01-05T12:40:50+00:00",
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
        "price_ruleset_id": "d5b4ad0f-5a50-48bd-9c39-1f81b6e48eae"
      },
      "relationships": {
        "price_ruleset": {
          "links": {
            "related": "api/boomerang/price_rulesets/d5b4ad0f-5a50-48bd-9c39-1f81b6e48eae"
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
              "from": "2021-12-05T12:40:50.332Z",
              "till": "2022-02-05T12:40:50.332Z"
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
    "id": "76f19ca9-67e6-4f91-a9f3-2b72f9de1b65",
    "type": "price_rulesets",
    "attributes": {
      "created_at": "2022-01-05T12:40:50+00:00",
      "updated_at": "2022-01-05T12:40:50+00:00",
      "name": "Seasonal ruleset",
      "archived_at": null
    },
    "relationships": {
      "price_rules": {
        "data": [
          {
            "type": "price_rules",
            "id": "f0172629-7afd-474a-b34f-529dbfe9b093"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "f0172629-7afd-474a-b34f-529dbfe9b093",
      "type": "price_rules",
      "attributes": {
        "created_at": "2022-01-05T12:40:50+00:00",
        "updated_at": "2022-01-05T12:40:50+00:00",
        "name": "Off season",
        "rule_type": "range_of_dates",
        "match_strategy": "span",
        "adjustment_strategy": "percentage",
        "value": 25.0,
        "from": "2021-12-05T12:40:50+00:00",
        "till": "2022-02-05T12:40:50+00:00",
        "from_day": null,
        "till_day": null,
        "from_time": null,
        "till_time": null,
        "charge": null,
        "stacked": false,
        "time": null,
        "price_ruleset_id": "76f19ca9-67e6-4f91-a9f3-2b72f9de1b65"
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
    "self": "api/boomerang/price_rulesets?data%5Battributes%5D%5Bname%5D=Seasonal+ruleset&data%5Battributes%5D%5Bprice_rules_attributes%5D%5B%5D%5Bname%5D=Off+season&data%5Battributes%5D%5Bprice_rules_attributes%5D%5B%5D%5Brule_type%5D=range_of_dates&data%5Battributes%5D%5Bprice_rules_attributes%5D%5B%5D%5Bmatch_strategy%5D=span&data%5Battributes%5D%5Bprice_rules_attributes%5D%5B%5D%5Bvalue%5D=25&data%5Battributes%5D%5Bprice_rules_attributes%5D%5B%5D%5Bfrom%5D=2021-12-05T12%3A40%3A50.332Z&data%5Battributes%5D%5Bprice_rules_attributes%5D%5B%5D%5Btill%5D=2022-02-05T12%3A40%3A50.332Z&data%5Btype%5D=price_rulesets&include=price_rules&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/price_rulesets?data%5Battributes%5D%5Bname%5D=Seasonal+ruleset&data%5Battributes%5D%5Bprice_rules_attributes%5D%5B%5D%5Bname%5D=Off+season&data%5Battributes%5D%5Bprice_rules_attributes%5D%5B%5D%5Brule_type%5D=range_of_dates&data%5Battributes%5D%5Bprice_rules_attributes%5D%5B%5D%5Bmatch_strategy%5D=span&data%5Battributes%5D%5Bprice_rules_attributes%5D%5B%5D%5Bvalue%5D=25&data%5Battributes%5D%5Bprice_rules_attributes%5D%5B%5D%5Bfrom%5D=2021-12-05T12%3A40%3A50.332Z&data%5Battributes%5D%5Bprice_rules_attributes%5D%5B%5D%5Btill%5D=2022-02-05T12%3A40%3A50.332Z&data%5Btype%5D=price_rulesets&include=price_rules&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/price_rulesets?data%5Battributes%5D%5Bname%5D=Seasonal+ruleset&data%5Battributes%5D%5Bprice_rules_attributes%5D%5B%5D%5Bname%5D=Off+season&data%5Battributes%5D%5Bprice_rules_attributes%5D%5B%5D%5Brule_type%5D=range_of_dates&data%5Battributes%5D%5Bprice_rules_attributes%5D%5B%5D%5Bmatch_strategy%5D=span&data%5Battributes%5D%5Bprice_rules_attributes%5D%5B%5D%5Bvalue%5D=25&data%5Battributes%5D%5Bprice_rules_attributes%5D%5B%5D%5Bfrom%5D=2021-12-05T12%3A40%3A50.332Z&data%5Battributes%5D%5Bprice_rules_attributes%5D%5B%5D%5Btill%5D=2022-02-05T12%3A40%3A50.332Z&data%5Btype%5D=price_rulesets&include=price_rules&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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
    --url 'https://example.booqable.com/api/boomerang/price_rulesets/27c451a3-d0c5-4403-85f2-a5ec5f80c865' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "27c451a3-d0c5-4403-85f2-a5ec5f80c865",
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
    "id": "27c451a3-d0c5-4403-85f2-a5ec5f80c865",
    "type": "price_rulesets",
    "attributes": {
      "created_at": "2022-01-05T12:40:50+00:00",
      "updated_at": "2022-01-05T12:40:50+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/price_rulesets/84dfae5f-95e4-44a1-9c71-cbddea19f767' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "84dfae5f-95e4-44a1-9c71-cbddea19f767",
        "type": "price_rulesets",
        "attributes": {
          "price_rules_attributes": [
            {
              "id": "561ed595-6696-4c85-bf81-24990ebbbd4e",
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
    "id": "84dfae5f-95e4-44a1-9c71-cbddea19f767",
    "type": "price_rulesets",
    "attributes": {
      "created_at": "2022-01-05T12:40:50+00:00",
      "updated_at": "2022-01-05T12:40:50+00:00",
      "name": "Ruleset",
      "archived_at": null
    },
    "relationships": {
      "price_rules": {
        "data": [
          {
            "type": "price_rules",
            "id": "561ed595-6696-4c85-bf81-24990ebbbd4e"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "561ed595-6696-4c85-bf81-24990ebbbd4e",
      "type": "price_rules",
      "attributes": {
        "created_at": "2022-01-05T12:40:50+00:00",
        "updated_at": "2022-01-05T12:40:50+00:00",
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
        "price_ruleset_id": "84dfae5f-95e4-44a1-9c71-cbddea19f767"
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
    --url 'https://example.booqable.com/api/boomerang/price_rulesets/83c71ffb-5a49-4988-8104-4d62d52dda03' \
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