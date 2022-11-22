# Merges

Merging enables you to merge the data of two records. The following types are supported: `customers`.

## Fields
Every merge has the following fields:

Name | Description
- | -
`id` | **Uuid** `readonly`<br>
`type` | **Uuid** <br>Type of resource to merge. One of `customers`
`source_id` | **Uuid** <br>Resource from which data is taken, this resource gets archived or destroyed
`target_id` | **Uuid** <br>Resource to which data is saved, this resource is returned if `target` is specified in includes


## Relationships
Merges have the following relationships:

Name | Description
- | -
`target` | **Customers**<br>Associated Target


## Merging resources



> How to merge one customer's data into another customer:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/merges' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "merges",
        "attributes": {
          "type": "customers",
          "source_id": "4a44bd18-db3e-42e1-bc66-cdcc3f4acfd9",
          "target_id": "0406ce69-ada1-4c4d-b4d0-d8e5a0a92044"
        }
      },
      "include": "target"
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "6bcac904-8e1c-5759-8fbc-9fb3037f5498",
    "type": "merges",
    "attributes": {
      "type": "customers",
      "source_id": "4a44bd18-db3e-42e1-bc66-cdcc3f4acfd9",
      "target_id": "0406ce69-ada1-4c4d-b4d0-d8e5a0a92044"
    },
    "relationships": {
      "target": {
        "data": {
          "type": "customers",
          "id": "0406ce69-ada1-4c4d-b4d0-d8e5a0a92044"
        }
      }
    }
  },
  "included": [
    {
      "id": "0406ce69-ada1-4c4d-b4d0-d8e5a0a92044",
      "type": "customers",
      "attributes": {
        "created_at": "2022-11-22T14:34:03+00:00",
        "updated_at": "2022-11-22T14:34:03+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "John Doe",
        "email": "johndoe@company.test",
        "deposit_type": "default",
        "deposit_value": 0.0,
        "discount_percentage": 0.0,
        "legal_type": "person",
        "properties": {},
        "tag_list": [],
        "merge_suggestion_customer_id": null,
        "tax_region_id": null
      },
      "relationships": {
        "merge_suggestion_customer": {
          "meta": {
            "included": false
          }
        },
        "tax_region": {
          "meta": {
            "included": false
          }
        },
        "properties": {
          "meta": {
            "included": false
          }
        },
        "barcode": {
          "meta": {
            "included": false
          }
        },
        "notes": {
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

`POST /api/boomerang/merges`

### Request params

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=target`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[merges]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][type]` | **Uuid** <br>Type of resource to merge. One of `customers`
`data[attributes][source_id]` | **Uuid** <br>Resource from which data is taken, this resource gets archived or destroyed
`data[attributes][target_id]` | **Uuid** <br>Resource to which data is saved, this resource is returned if `target` is specified in includes


### Includes

This request accepts the following includes:

`target`





