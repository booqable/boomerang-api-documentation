# Merges

Merging enables you to merge the data of two records. The following types are supported: `customers`.

## Fields
Every merge has the following fields:

Name | Description
-- | --
`id` | **Uuid** `readonly`<br>
`type` | **Uuid** <br>Type of resource to merge. One of `customers`
`source_id` | **Uuid** <br>Resource from which data is taken, this resource gets archived or destroyed
`target_id` | **Uuid** <br>Resource to which data is saved, this resource is returned if `target` is specified in includes


## Relationships
Merges have the following relationships:

Name | Description
-- | --
`target` | **Customers** <br>Associated Target


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
          "source_id": "bf1ddcc9-50f9-40fe-b481-d173c74fe314",
          "target_id": "aed5e38e-cb6f-4ff2-8a7b-24f4ca70386b"
        }
      },
      "include": "target"
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "281c3879-06a9-5f74-92cc-c84663056bec",
    "type": "merges",
    "attributes": {
      "type": "customers",
      "source_id": "bf1ddcc9-50f9-40fe-b481-d173c74fe314",
      "target_id": "aed5e38e-cb6f-4ff2-8a7b-24f4ca70386b"
    },
    "relationships": {
      "target": {
        "data": {
          "type": "customers",
          "id": "aed5e38e-cb6f-4ff2-8a7b-24f4ca70386b"
        }
      }
    }
  },
  "included": [
    {
      "id": "aed5e38e-cb6f-4ff2-8a7b-24f4ca70386b",
      "type": "customers",
      "attributes": {
        "created_at": "2024-10-21T09:23:10.577143+00:00",
        "updated_at": "2024-10-21T09:23:10.680226+00:00",
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





