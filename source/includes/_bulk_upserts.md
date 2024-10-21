# Bulk upserts

Bulk upserts are for creating one or more entries of a model with one request, supports these types: `coupons`, `operating_rules`

## Fields
Every bulk upsert has the following fields:

Name | Description
-- | --
`id` | **Uuid** `readonly`<br>
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
    "id": "fc03d4fc-0d41-52d0-a0a9-8c8a572cdc24",
    "type": "bulk_upserts",
    "relationships": {
      "results": {
        "data": [
          {
            "type": "operating_rules",
            "id": "d8f05568-7dc4-4bc7-8617-eacb7aa00d64"
          },
          {
            "type": "operating_rules",
            "id": "09d9358d-7d8d-43d8-9034-3965e2bd008b"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "d8f05568-7dc4-4bc7-8617-eacb7aa00d64",
      "type": "operating_rules",
      "attributes": {
        "created_at": "2024-10-21T09:26:30.579526+00:00",
        "updated_at": "2024-10-21T09:26:30.579526+00:00",
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
      "id": "09d9358d-7d8d-43d8-9034-3965e2bd008b",
      "type": "operating_rules",
      "attributes": {
        "created_at": "2024-10-21T09:26:30.579526+00:00",
        "updated_at": "2024-10-21T09:26:30.579526+00:00",
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
    "id": "ddd7a2f0-b63b-52ad-b7c2-135bcbdbda3c",
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





