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
    "id": "7b597ed0-0f55-5237-b8c2-776b213f4288",
    "type": "bulk_upserts",
    "relationships": {
      "results": {
        "data": [
          {
            "type": "operating_rules",
            "id": "114e2df1-ea6b-4ad9-9983-fc52186f7d15"
          },
          {
            "type": "operating_rules",
            "id": "e1afe9c4-5421-4370-a6ed-dca3fd6f0c64"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "114e2df1-ea6b-4ad9-9983-fc52186f7d15",
      "type": "operating_rules",
      "attributes": {
        "created_at": "2024-11-18T09:26:44.188572+00:00",
        "updated_at": "2024-11-18T09:26:44.188572+00:00",
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
      "id": "e1afe9c4-5421-4370-a6ed-dca3fd6f0c64",
      "type": "operating_rules",
      "attributes": {
        "created_at": "2024-11-18T09:26:44.188572+00:00",
        "updated_at": "2024-11-18T09:26:44.188572+00:00",
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
    "id": "8aeaf49e-6a7e-5e89-a989-bca59ae3746e",
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





