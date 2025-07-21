# Price rulesets

Price rulesets are used to create elaborate pricing adjustments using the advanced pricing feature.

<aside class="notice">
  Note: You must have the advanced pricing feature in your plan to use price rulesets and rules.
</aside>

## Relationships
Name | Description
-- | --
`price_rules` | **[Price rules](#price-rules)** `hasmany`<br>The rules included in this ruleset.


Check matching attributes under [Fields](#price-rulesets-fields) to see which relations can be written.
<br/ >
Check each individual operation to see which relations can be included as a sideload.
## Fields

 Name | Description
-- | --
`archived` | **boolean** `readonly`<br>Whether the price ruleset is archived.
`archived_at` | **datetime** `readonly` `nullable`<br>When the price ruleset was archived.
`created_at` | **datetime** `readonly`<br>When the resource was created.
`description` | **string** <br>Description of the ruleset.
`id` | **uuid** `readonly`<br>Primary key.
`make_name_unique` | **boolean** `writeonly`<br>When `true`, a unique name will be generated when a PriceRuleset with the same name already exists.
`name` | **string** <br>Name of the ruleset.
`price_rules_attributes` | **array** `writeonly`<br>Allows creating and updating price rules with their ruleset.
`updated_at` | **datetime** `readonly`<br>When the resource was last updated.


## List price rulesets


> How to fetch price rulesets:

```shell
  curl --get 'https://example.booqable.com/api/4/price_rulesets'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": [
      {
        "id": "c218f45f-5f3f-4800-8f10-4d3ad173bd93",
        "type": "price_rulesets",
        "attributes": {
          "created_at": "2023-11-03T10:09:00.000000+00:00",
          "updated_at": "2023-11-03T10:09:00.000000+00:00",
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

`GET /api/4/price_rulesets`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[price_rulesets]=created_at,updated_at,archived`
`filter` | **hash** <br>The filters to apply `?filter[attribute][eq]=value`
`meta` | **hash** <br>Metadata to send along. `?meta[total][]=count`
`page[number]` | **string** <br>The page to request.
`page[size]` | **string** <br>The amount of items per page.
`sort` | **string** <br>How to sort the data. `?sort=attribute1,-attribute2`


### Filters

This request can be filtered on:

Name | Description
-- | --
`archived` | **boolean** <br>`eq`
`archived_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`created_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`id` | **uuid** <br>`eq`, `not_eq`
`name` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`price_rules_attributes` | **array** <br>`eq`
`updated_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **array** <br>`count`


### Includes

This request does not accept any includes
## Fetch a price ruleset


> How to fetch a single price ruleset with related price rules:

```shell
  curl --get 'https://example.booqable.com/api/4/price_rulesets/ca85320f-4ffc-496c-855e-77a3d0f4a40a'
       --header 'content-type: application/json'
       --data-urlencode 'include=price_rules'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "ca85320f-4ffc-496c-855e-77a3d0f4a40a",
      "type": "price_rulesets",
      "attributes": {
        "created_at": "2027-04-22T08:54:05.000000+00:00",
        "updated_at": "2027-04-22T08:54:05.000000+00:00",
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
              "id": "e80760ba-0d09-4a88-878f-b2f2dfd3ad73"
            }
          ]
        }
      }
    },
    "included": [
      {
        "id": "e80760ba-0d09-4a88-878f-b2f2dfd3ad73",
        "type": "price_rules",
        "attributes": {
          "created_at": "2027-04-22T08:54:05.000000+00:00",
          "updated_at": "2027-04-22T08:54:05.000000+00:00",
          "name": "Price rule",
          "rule_type": "range_of_dates",
          "match_strategy": "span",
          "adjustment_strategy": "percentage",
          "value": 30.0,
          "from": "2032-03-31T23:26:05.000000+00:00",
          "till": "2032-05-31T23:26:05.000000+00:00",
          "from_day": null,
          "till_day": null,
          "from_time": null,
          "till_time": null,
          "charge": null,
          "stacked": false,
          "time": null,
          "min_duration": null,
          "max_duration": null,
          "price_ruleset_id": "ca85320f-4ffc-496c-855e-77a3d0f4a40a"
        },
        "relationships": {}
      }
    ],
    "meta": {}
  }
```

### HTTP Request

`GET /api/4/price_rulesets/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[price_rulesets]=created_at,updated_at,archived`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=price_rules`


### Includes

This request accepts the following includes:

<ul>
  <li><code>price_rules</code></li>
</ul>


## Create a price ruleset


> How to create a price ruleset with price rules:

```shell
  curl --request POST
       --url 'https://example.booqable.com/api/4/price_rulesets'
       --header 'content-type: application/json'
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
                 "from": "2014-09-24T15:02:01.000000+00:00",
                 "till": "2014-11-24T15:02:01.000000+00:00"
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
      "id": "e4fe0b61-208f-4525-8281-39ceec698804",
      "type": "price_rulesets",
      "attributes": {
        "created_at": "2014-10-24T15:02:01.000000+00:00",
        "updated_at": "2014-10-24T15:02:01.000000+00:00",
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
              "id": "fe521f82-f68d-479c-843d-7420dbcf18ae"
            }
          ]
        }
      }
    },
    "included": [
      {
        "id": "fe521f82-f68d-479c-843d-7420dbcf18ae",
        "type": "price_rules",
        "attributes": {
          "created_at": "2014-10-24T15:02:01.000000+00:00",
          "updated_at": "2014-10-24T15:02:01.000000+00:00",
          "name": "Off season",
          "rule_type": "range_of_dates",
          "match_strategy": "span",
          "adjustment_strategy": "percentage",
          "value": 25.0,
          "from": "2014-09-24T15:02:01.000000+00:00",
          "till": "2014-11-24T15:02:01.000000+00:00",
          "from_day": null,
          "till_day": null,
          "from_time": null,
          "till_time": null,
          "charge": null,
          "stacked": false,
          "time": null,
          "min_duration": null,
          "max_duration": null,
          "price_ruleset_id": "e4fe0b61-208f-4525-8281-39ceec698804"
        },
        "relationships": {}
      }
    ],
    "meta": {}
  }
```

### HTTP Request

`POST /api/4/price_rulesets`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[price_rulesets]=created_at,updated_at,archived`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=price_rules`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][make_name_unique]` | **boolean** <br>When `true`, a unique name will be generated when a PriceRuleset with the same name already exists.
`data[attributes][name]` | **string** <br>Name of the ruleset.
`data[attributes][price_rules_attributes][]` | **array** <br>Allows creating and updating price rules with their ruleset.


### Includes

This request accepts the following includes:

<ul>
  <li><code>price_rules</code></li>
</ul>


## Update a price ruleset


> How to update a price ruleset:

```shell
  curl --request PUT
       --url 'https://example.booqable.com/api/4/price_rulesets/f45fa6ef-5ccc-4a37-89b6-5701c9c8f77b'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "id": "f45fa6ef-5ccc-4a37-89b6-5701c9c8f77b",
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
      "id": "f45fa6ef-5ccc-4a37-89b6-5701c9c8f77b",
      "type": "price_rulesets",
      "attributes": {
        "created_at": "2016-01-18T12:44:00.000000+00:00",
        "updated_at": "2016-01-18T12:44:00.000000+00:00",
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
  curl --request PUT
       --url 'https://example.booqable.com/api/4/price_rulesets/8fdd2e80-1ce2-4bf8-8e01-df9e6925b595'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "id": "8fdd2e80-1ce2-4bf8-8e01-df9e6925b595",
           "type": "price_rulesets",
           "attributes": {
             "price_rules_attributes": [
               {
                 "id": "ab3f8794-7809-432e-8619-556bc2224ad3",
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
      "id": "8fdd2e80-1ce2-4bf8-8e01-df9e6925b595",
      "type": "price_rulesets",
      "attributes": {
        "created_at": "2023-09-01T22:07:00.000000+00:00",
        "updated_at": "2023-09-01T22:07:00.000000+00:00",
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
              "id": "ab3f8794-7809-432e-8619-556bc2224ad3"
            }
          ]
        }
      }
    },
    "included": [
      {
        "id": "ab3f8794-7809-432e-8619-556bc2224ad3",
        "type": "price_rules",
        "attributes": {
          "created_at": "2023-09-01T22:07:00.000000+00:00",
          "updated_at": "2023-09-01T22:07:00.000000+00:00",
          "name": "Off season",
          "rule_type": "range_of_dates",
          "match_strategy": "span",
          "adjustment_strategy": "percentage",
          "value": 30.0,
          "from": "2028-08-11T12:39:00.000000+00:00",
          "till": "2028-10-11T12:39:00.000000+00:00",
          "from_day": null,
          "till_day": null,
          "from_time": null,
          "till_time": null,
          "charge": null,
          "stacked": false,
          "time": null,
          "min_duration": null,
          "max_duration": null,
          "price_ruleset_id": "8fdd2e80-1ce2-4bf8-8e01-df9e6925b595"
        },
        "relationships": {}
      }
    ],
    "meta": {}
  }
```

### HTTP Request

`PUT /api/4/price_rulesets/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[price_rulesets]=created_at,updated_at,archived`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=price_rules`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][make_name_unique]` | **boolean** <br>When `true`, a unique name will be generated when a PriceRuleset with the same name already exists.
`data[attributes][name]` | **string** <br>Name of the ruleset.
`data[attributes][price_rules_attributes][]` | **array** <br>Allows creating and updating price rules with their ruleset.


### Includes

This request accepts the following includes:

<ul>
  <li><code>price_rules</code></li>
</ul>


## Archive a price ruleset


> How to archive a price ruleset:

```shell
  curl --request DELETE
       --url 'https://example.booqable.com/api/4/price_rulesets/dcba05ea-7016-4ed4-8034-a823d01f4d26'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "dcba05ea-7016-4ed4-8034-a823d01f4d26",
      "type": "price_rulesets",
      "attributes": {
        "created_at": "2020-12-18T05:52:07.000000+00:00",
        "updated_at": "2020-12-18T05:52:07.000000+00:00",
        "archived": true,
        "archived_at": "2020-12-18T05:52:07.000000+00:00",
        "name": "Ruleset",
        "description": null
      },
      "relationships": {}
    },
    "meta": {}
  }
```

### HTTP Request

`DELETE /api/4/price_rulesets/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[price_rulesets]=created_at,updated_at,archived`


### Includes

This request does not accept any includes