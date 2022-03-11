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
    "id": "5e1f0e58-1f6d-503d-9b27-ea60fa23e7a8",
    "type": "bulk_upserts",
    "relationships": {
      "results": {
        "data": [
          {
            "type": "operating_rules",
            "id": "762ce63d-f6bd-4a8d-8a18-3a6cf36ca523"
          },
          {
            "type": "operating_rules",
            "id": "00a07775-237f-42c7-a7e0-eac465b5eb73"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "762ce63d-f6bd-4a8d-8a18-3a6cf36ca523",
      "type": "operating_rules",
      "attributes": {
        "created_at": "2022-03-11T12:48:48+00:00",
        "updated_at": "2022-03-11T12:48:48+00:00",
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
      "id": "00a07775-237f-42c7-a7e0-eac465b5eb73",
      "type": "operating_rules",
      "attributes": {
        "created_at": "2022-03-11T12:48:48+00:00",
        "updated_at": "2022-03-11T12:48:48+00:00",
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
              "default_property_id": "d3684b6a-33c7-4079-8b02-b4a233d373b7"
            },
            {
              "name": "Delivery address",
              "default_property_id": "7ea1a6bd-e10e-4fb3-8976-406330090546"
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
    "id": "5e1f0e58-1f6d-503d-9b27-ea60fa23e7a8",
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
    "id": "5e1f0e58-1f6d-503d-9b27-ea60fa23e7a8",
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=results`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[bulk_upserts]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][type]` | **String**<br>Type of data being submitted. One of `coupons`, `operating_rules`, `checkout_fields`
`data[attributes][data][]` | **Array**<br>Array of objects, all objects must contain valid data for the specified type, see documentation for relevant type endpoint for more details.


### Includes

This request accepts the following includes:

`results`





