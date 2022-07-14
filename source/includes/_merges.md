# Merges

Merging enables you to merge the data of two records. The following types are supported: `customers`.

## Fields
Every merge has the following fields:

Name | Description
- | -
`id` | **Uuid** `readonly`<br>
`type` | **Uuid**<br>Type of resource to merge. One of `customers`
`source_id` | **Uuid**<br>Resource from which data is taken, this resource gets archived or destroyed
`target_id` | **Uuid**<br>Resource to which data is saved, this resource is returned if `target` is specified in includes


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
          "source_id": "d4385d81-ab83-4192-b78e-6d9e5dec6b10",
          "target_id": "f6aa252e-bd00-4216-b1c1-6eb73c771d1d"
        }
      },
      "include": "target"
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "ee76c4fc-ebd1-55b6-b2f1-ae609cb76eab",
    "type": "merges",
    "attributes": {
      "type": "customers",
      "source_id": "d4385d81-ab83-4192-b78e-6d9e5dec6b10",
      "target_id": "f6aa252e-bd00-4216-b1c1-6eb73c771d1d"
    },
    "relationships": {
      "target": {
        "data": {
          "type": "customers",
          "id": "f6aa252e-bd00-4216-b1c1-6eb73c771d1d"
        }
      }
    }
  },
  "included": [
    {
      "id": "f6aa252e-bd00-4216-b1c1-6eb73c771d1d",
      "type": "customers",
      "attributes": {
        "created_at": "2022-07-14T13:04:45+00:00",
        "updated_at": "2022-07-14T13:04:45+00:00",
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=target`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[merges]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][type]` | **Uuid**<br>Type of resource to merge. One of `customers`
`data[attributes][source_id]` | **Uuid**<br>Resource from which data is taken, this resource gets archived or destroyed
`data[attributes][target_id]` | **Uuid**<br>Resource to which data is saved, this resource is returned if `target` is specified in includes


### Includes

This request accepts the following includes:

`target`





