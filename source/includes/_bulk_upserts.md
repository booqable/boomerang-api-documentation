# Bulk upserts

Bulk upserts are for creating one or more entries of a model with one request, supports these types: `coupons`, `operating_rules`

## Fields
Every bulk upsert has the following fields:

Name | Description
-- | --
`id` | **Uuid** `readonly`<br>Primary key
`type` | **String** `writeonly`<br>Type of data being submitted. One of `coupons`, `operating_rules`
`data` | **Array** `writeonly`<br>Array of objects, all objects must contain valid data for the specified type, see documentation for relevant type endpoint for more details.


## Relationships
Bulk upserts have the following relationships:

Name | Description
-- | --
`results` | **Virtuals** `readonly`<br>Associated Results


## Creating a bulk upsert



> How to create operating rules in bulk:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/bulk_upserts' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "bulk_upserts",
        "attributes": {
          "type": "operating_rules",
          "data": [
            {
              "data": {
                "mon": {
                  "from": "09:00",
                  "till": "13:00"
                }
              },
              "data_type": "hours"
            },
            {
              "data": {
                "mon": {
                  "from": "15:00",
                  "till": "17:00"
                }
              },
              "data_type": "hours"
            }
          ]
        }
      },
      "include": "results"
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "07d3c7b7-8ca1-51f0-b6fc-89f43ad76f48",
    "type": "bulk_upserts",
    "relationships": {
      "results": {
        "data": [
          {
            "type": "operating_rules",
            "id": "41d1f980-7fbf-4c64-8da0-b211ed2a80d7"
          },
          {
            "type": "operating_rules",
            "id": "94a4679e-85f5-4690-92bf-2748e3f2f13e"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "41d1f980-7fbf-4c64-8da0-b211ed2a80d7",
      "type": "operating_rules",
      "attributes": {
        "created_at": "2024-11-25T09:26:53.722835+00:00",
        "updated_at": "2024-11-25T09:26:53.722835+00:00",
        "data_type": "hours",
        "data": {
          "mon": {
            "from": "09:00",
            "till": "13:00"
          }
        }
      }
    },
    {
      "id": "94a4679e-85f5-4690-92bf-2748e3f2f13e",
      "type": "operating_rules",
      "attributes": {
        "created_at": "2024-11-25T09:26:53.722835+00:00",
        "updated_at": "2024-11-25T09:26:53.722835+00:00",
        "data_type": "hours",
        "data": {
          "mon": {
            "from": "15:00",
            "till": "17:00"
          }
        }
      }
    }
  ],
  "meta": {}
}
```


> How to create coupons in bulk:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/bulk_upserts' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "bulk_upserts",
        "attributes": {
          "type": "coupons",
          "data": [
            {
              "identifier": "off",
              "coupon_type": "percentage",
              "value": 25,
              "active": true
            },
            {
              "identifier": "summer-22",
              "coupon_type": "cents",
              "value": 2200
            }
          ]
        },
        "include": "results"
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "4fa724bf-01a0-5454-ba9d-1c774f859a8b",
    "type": "bulk_upserts",
    "relationships": {}
  },
  "meta": {}
}
```

### HTTP Request

`POST /api/boomerang/bulk_upserts`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=results`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][type]` | **String** <br>Type of data being submitted. One of `coupons`, `operating_rules`
`data[attributes][data][]` | **Array** <br>Array of objects, all objects must contain valid data for the specified type, see documentation for relevant type endpoint for more details.


### Includes

This request accepts the following includes:

`results`





