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
          "source_id": "c2619247-d7af-4783-8998-7f7fb24c58b1",
          "target_id": "064b71d1-29b7-4df8-b7e8-d7c1bc98aecf"
        }
      },
      "include": "target"
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "99108476-7d69-554a-b6ff-41bf9c627f92",
    "type": "merges",
    "attributes": {
      "type": "customers",
      "source_id": "c2619247-d7af-4783-8998-7f7fb24c58b1",
      "target_id": "064b71d1-29b7-4df8-b7e8-d7c1bc98aecf"
    },
    "relationships": {
      "target": {
        "data": {
          "type": "customers",
          "id": "064b71d1-29b7-4df8-b7e8-d7c1bc98aecf"
        }
      }
    }
  },
  "included": [
    {
      "id": "064b71d1-29b7-4df8-b7e8-d7c1bc98aecf",
      "type": "customers",
      "attributes": {
        "created_at": "2024-07-01T09:26:00.291889+00:00",
        "updated_at": "2024-07-01T09:26:00.501685+00:00",
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





