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
          "source_id": "ba90d401-352f-48a1-aa53-8ca16998ae17",
          "target_id": "547348ad-02e5-4529-b709-bc250abb8cc5"
        }
      },
      "include": "target"
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "e0c821bb-bc0f-587d-a00f-603cff26c4ca",
    "type": "merges",
    "attributes": {
      "type": "customers",
      "source_id": "ba90d401-352f-48a1-aa53-8ca16998ae17",
      "target_id": "547348ad-02e5-4529-b709-bc250abb8cc5"
    },
    "relationships": {
      "target": {
        "data": {
          "type": "customers",
          "id": "547348ad-02e5-4529-b709-bc250abb8cc5"
        }
      }
    }
  },
  "included": [
    {
      "id": "547348ad-02e5-4529-b709-bc250abb8cc5",
      "type": "customers",
      "attributes": {
        "created_at": "2024-09-16T09:26:22.124876+00:00",
        "updated_at": "2024-09-16T09:26:22.218100+00:00",
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





