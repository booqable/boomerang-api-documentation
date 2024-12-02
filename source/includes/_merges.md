# Merges

Merging enables you to merge the data of two records. The following types are supported: `customers`.

## Fields
Every merge has the following fields:

Name | Description
-- | --
`id` | **Uuid** `readonly`<br>Primary key
`type` | **Uuid** <br>Type of resource to merge. One of `customers`
`source_id` | **Uuid** <br>Resource from which data is taken, this resource gets archived or destroyed
`target_id` | **Uuid** <br>Resource to which data is saved, this resource is returned if `target` is specified in includes


## Relationships
Merges have the following relationships:

Name | Description
-- | --
`target` | **[Customer](#customers)** <br>Associated Target


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
          "source_id": "8de2c892-46b2-4e9b-aa2b-1717f03ca0fd",
          "target_id": "81faa265-4a4e-4137-aa6b-3e5b54ffd793"
        }
      },
      "include": "target"
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "d46aa511-f71a-521d-85ff-73a4b68966fc",
    "type": "merges",
    "attributes": {
      "type": "customers",
      "source_id": "8de2c892-46b2-4e9b-aa2b-1717f03ca0fd",
      "target_id": "81faa265-4a4e-4137-aa6b-3e5b54ffd793"
    },
    "relationships": {
      "target": {
        "data": {
          "type": "customers",
          "id": "81faa265-4a4e-4137-aa6b-3e5b54ffd793"
        }
      }
    }
  },
  "included": [
    {
      "id": "81faa265-4a4e-4137-aa6b-3e5b54ffd793",
      "type": "customers",
      "attributes": {
        "created_at": "2024-12-02T13:02:23.515452+00:00",
        "updated_at": "2024-12-02T13:02:23.647906+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "John Doe",
        "email": "johndoe@company.test",
        "deposit_type": "default",
        "deposit_value": 0.0,
        "discount_percentage": 0.0,
        "legal_type": "person",
        "email_marketing_consented": false,
        "email_marketing_consent_updated_at": null,
        "properties": {},
        "tag_list": [],
        "merge_suggestion_customer_id": null,
        "tax_region_id": null
      },
      "relationships": {}
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
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=target`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[merges]=type,source_id,target_id`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][type]` | **Uuid** <br>Type of resource to merge. One of `customers`
`data[attributes][source_id]` | **Uuid** <br>Resource from which data is taken, this resource gets archived or destroyed
`data[attributes][target_id]` | **Uuid** <br>Resource to which data is saved, this resource is returned if `target` is specified in includes


### Includes

This request accepts the following includes:

`target`





