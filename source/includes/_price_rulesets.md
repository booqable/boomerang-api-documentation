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
      "id": "1fc5a22b-f07e-410d-9f4b-dbe8d690d3d6",
      "type": "price_rulesets",
      "attributes": {
        "created_at": "2021-12-08T11:26:11+00:00",
        "updated_at": "2021-12-08T11:26:11+00:00",
        "name": "Ruleset",
        "archived_at": null
      },
      "relationships": {
        "price_rules": {
          "links": {
            "related": "api/boomerang/price_rules?filter[price_ruleset_id]=1fc5a22b-f07e-410d-9f4b-dbe8d690d3d6"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-12-08T11:24:18Z`
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
    --url 'https://example.booqable.com/api/boomerang/price_rulesets/2ef66c56-d3bd-485f-99b8-e611fd03c0b0?include=price_rules' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "2ef66c56-d3bd-485f-99b8-e611fd03c0b0",
    "type": "price_rulesets",
    "attributes": {
      "created_at": "2021-12-08T11:26:11+00:00",
      "updated_at": "2021-12-08T11:26:11+00:00",
      "name": "Ruleset",
      "archived_at": null
    },
    "relationships": {
      "price_rules": {
        "links": {
          "related": "api/boomerang/price_rules?filter[price_ruleset_id]=2ef66c56-d3bd-485f-99b8-e611fd03c0b0"
        },
        "data": [
          {
            "type": "price_rules",
            "id": "8694a3e4-e8fa-43b8-997d-82f0c06f6fd8"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "8694a3e4-e8fa-43b8-997d-82f0c06f6fd8",
      "type": "price_rules",
      "attributes": {
        "created_at": "2021-12-08T11:26:11+00:00",
        "updated_at": "2021-12-08T11:26:11+00:00",
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
        "price_ruleset_id": "2ef66c56-d3bd-485f-99b8-e611fd03c0b0"
      },
      "relationships": {
        "price_ruleset": {
          "links": {
            "related": "api/boomerang/price_rulesets/2ef66c56-d3bd-485f-99b8-e611fd03c0b0"
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
              "from": "2021-11-08T11:26:11.638Z",
              "till": "2022-01-08T11:26:11.638Z"
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
    "id": "8e37c122-1bfc-4ce7-a87d-92d302ce1bb2",
    "type": "price_rulesets",
    "attributes": {
      "created_at": "2021-12-08T11:26:11+00:00",
      "updated_at": "2021-12-08T11:26:11+00:00",
      "name": "Seasonal ruleset",
      "archived_at": null
    },
    "relationships": {
      "price_rules": {
        "data": [
          {
            "type": "price_rules",
            "id": "dcdf7522-e11a-4f67-9675-0460248428b0"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "dcdf7522-e11a-4f67-9675-0460248428b0",
      "type": "price_rules",
      "attributes": {
        "created_at": "2021-12-08T11:26:11+00:00",
        "updated_at": "2021-12-08T11:26:11+00:00",
        "name": "Off season",
        "rule_type": "range_of_dates",
        "match_strategy": "span",
        "adjustment_strategy": "percentage",
        "value": 25.0,
        "from": "2021-11-08T11:26:11+00:00",
        "till": "2022-01-08T11:26:11+00:00",
        "from_day": null,
        "till_day": null,
        "from_time": null,
        "till_time": null,
        "charge": null,
        "stacked": false,
        "time": null,
        "price_ruleset_id": "8e37c122-1bfc-4ce7-a87d-92d302ce1bb2"
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
    "self": "api/boomerang/price_rulesets?data%5Battributes%5D%5Bname%5D=Seasonal+ruleset&data%5Battributes%5D%5Bprice_rules_attributes%5D%5B%5D%5Bname%5D=Off+season&data%5Battributes%5D%5Bprice_rules_attributes%5D%5B%5D%5Brule_type%5D=range_of_dates&data%5Battributes%5D%5Bprice_rules_attributes%5D%5B%5D%5Bmatch_strategy%5D=span&data%5Battributes%5D%5Bprice_rules_attributes%5D%5B%5D%5Bvalue%5D=25&data%5Battributes%5D%5Bprice_rules_attributes%5D%5B%5D%5Bfrom%5D=2021-11-08T11%3A26%3A11.638Z&data%5Battributes%5D%5Bprice_rules_attributes%5D%5B%5D%5Btill%5D=2022-01-08T11%3A26%3A11.638Z&data%5Btype%5D=price_rulesets&include=price_rules&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/price_rulesets?data%5Battributes%5D%5Bname%5D=Seasonal+ruleset&data%5Battributes%5D%5Bprice_rules_attributes%5D%5B%5D%5Bname%5D=Off+season&data%5Battributes%5D%5Bprice_rules_attributes%5D%5B%5D%5Brule_type%5D=range_of_dates&data%5Battributes%5D%5Bprice_rules_attributes%5D%5B%5D%5Bmatch_strategy%5D=span&data%5Battributes%5D%5Bprice_rules_attributes%5D%5B%5D%5Bvalue%5D=25&data%5Battributes%5D%5Bprice_rules_attributes%5D%5B%5D%5Bfrom%5D=2021-11-08T11%3A26%3A11.638Z&data%5Battributes%5D%5Bprice_rules_attributes%5D%5B%5D%5Btill%5D=2022-01-08T11%3A26%3A11.638Z&data%5Btype%5D=price_rulesets&include=price_rules&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/price_rulesets?data%5Battributes%5D%5Bname%5D=Seasonal+ruleset&data%5Battributes%5D%5Bprice_rules_attributes%5D%5B%5D%5Bname%5D=Off+season&data%5Battributes%5D%5Bprice_rules_attributes%5D%5B%5D%5Brule_type%5D=range_of_dates&data%5Battributes%5D%5Bprice_rules_attributes%5D%5B%5D%5Bmatch_strategy%5D=span&data%5Battributes%5D%5Bprice_rules_attributes%5D%5B%5D%5Bvalue%5D=25&data%5Battributes%5D%5Bprice_rules_attributes%5D%5B%5D%5Bfrom%5D=2021-11-08T11%3A26%3A11.638Z&data%5Battributes%5D%5Bprice_rules_attributes%5D%5B%5D%5Btill%5D=2022-01-08T11%3A26%3A11.638Z&data%5Btype%5D=price_rulesets&include=price_rules&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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
    --url 'https://example.booqable.com/api/boomerang/price_rulesets/b4d441d6-80f7-4502-9d13-b74e1537b4f7' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "b4d441d6-80f7-4502-9d13-b74e1537b4f7",
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
    "id": "b4d441d6-80f7-4502-9d13-b74e1537b4f7",
    "type": "price_rulesets",
    "attributes": {
      "created_at": "2021-12-08T11:26:11+00:00",
      "updated_at": "2021-12-08T11:26:11+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/price_rulesets/6029335b-3cd3-4330-be00-a733de9ee320' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "6029335b-3cd3-4330-be00-a733de9ee320",
        "type": "price_rulesets",
        "attributes": {
          "price_rules_attributes": [
            {
              "id": "36065697-aaf2-4f3f-8964-137293c2f786",
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
    "id": "6029335b-3cd3-4330-be00-a733de9ee320",
    "type": "price_rulesets",
    "attributes": {
      "created_at": "2021-12-08T11:26:12+00:00",
      "updated_at": "2021-12-08T11:26:12+00:00",
      "name": "Ruleset",
      "archived_at": null
    },
    "relationships": {
      "price_rules": {
        "data": [
          {
            "type": "price_rules",
            "id": "36065697-aaf2-4f3f-8964-137293c2f786"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "36065697-aaf2-4f3f-8964-137293c2f786",
      "type": "price_rules",
      "attributes": {
        "created_at": "2021-12-08T11:26:12+00:00",
        "updated_at": "2021-12-08T11:26:12+00:00",
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
        "price_ruleset_id": "6029335b-3cd3-4330-be00-a733de9ee320"
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
    --url 'https://example.booqable.com/api/boomerang/price_rulesets/673a6ed9-5b37-425c-860b-fe762d37995d' \
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