# Bulk upserts

Bulk upserts are for creating one or more entries of a model with one request, supports these types: `coupons`, `operating_rules`, `checkout_fields`

## Fields
Every bulk upsert has the following fields:

Name | Description
- | -
`id` | **Uuid** `readonly`<br>
`type` | **String** `writeonly`<br>Type of data being submitted. One of `coupons`, `operating_rules`, `checkout_fields`
`data` | **Array** `writeonly`<br>Array of objects, all objects must contain valid data for the specified type, see documentation for relevant type endpoint for more details.


## Relationships
Bulk upserts have the following relationships:

Name | Description
- | -
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
    "id": "dbe53a97-2732-5db7-8b69-3a15a66db553",
    "type": "bulk_upserts",
    "relationships": {
      "results": {
        "data": [
          {
            "type": "operating_rules",
            "id": "47b9094d-f734-4eca-bab8-3e1fbbd35be9"
          },
          {
            "type": "operating_rules",
            "id": "af99db6f-e806-437c-950e-442604b7d78b"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "47b9094d-f734-4eca-bab8-3e1fbbd35be9",
      "type": "operating_rules",
      "attributes": {
        "created_at": "2023-02-09T10:10:16+00:00",
        "updated_at": "2023-02-09T10:10:16+00:00",
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
      "id": "af99db6f-e806-437c-950e-442604b7d78b",
      "type": "operating_rules",
      "attributes": {
        "created_at": "2023-02-09T10:10:16+00:00",
        "updated_at": "2023-02-09T10:10:16+00:00",
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


> How to create checkout fields in bulk:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/bulk_upserts' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "bulk_upserts",
        "attributes": {
          "type": "checkout_fields",
          "data": [
            {
              "default_property_id": "0e7bde5d-eb7e-4d5a-bb72-b93cf639f10b"
            },
            {
              "name": "Delivery address",
              "default_property_id": "83755d4f-329f-4f52-9462-37a275dc9438"
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
    "id": "dbe53a97-2732-5db7-8b69-3a15a66db553",
    "type": "bulk_upserts",
    "relationships": {
      "results": {
        "meta": {
          "included": false
        }
      }
    }
  },
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
    "id": "a646e416-9a4f-52d0-9619-aea13a350719",
    "type": "bulk_upserts",
    "relationships": {
      "results": {
        "meta": {
          "included": false
        }
      }
    }
  },
  "meta": {}
}
```

### HTTP Request

`POST /api/boomerang/bulk_upserts`

### Request params

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=results`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[bulk_upserts]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][type]` | **String** <br>Type of data being submitted. One of `coupons`, `operating_rules`, `checkout_fields`
`data[attributes][data][]` | **Array** <br>Array of objects, all objects must contain valid data for the specified type, see documentation for relevant type endpoint for more details.


### Includes

This request accepts the following includes:

`results`





