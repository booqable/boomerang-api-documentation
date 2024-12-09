# Merges

Merging enables you to merge the data of two records.

## Relationships
Name | Description
-- | --
`source` | **[Customer](#customers)** `required`<br>Resource from which data is taken, this resource gets archived or destroyed.
`target` | **[Customer](#customers)** `required`<br>Resource to which data is saved.


Check matching attributes under [Fields](#merges-fields) to see which relations can be written.
<br/ >
Check each individual operation to see which relations can be included as a sideload.
## Fields

 Name | Description
-- | --
`id` | **uuid** `readonly`<br>Primary key.
`source_id` | **uuid** <br>Resource from which data is taken, this resource gets archived or destroyed.
`target_id` | **uuid** <br>Resource to which data is saved.
`type` | **enum** <br>Type of resource to merge. Only merging `customers` is supported.


## Merge customers


> How to merge one customer's data into another customer:

```shell
  curl --request POST \
       --url 'https://example.booqable.com/api/boomerang/merges'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "type": "merges",
           "attributes": {
             "type": "customers",
             "source_id": "0786baf4-bec1-461b-8991-2d8a800a02d8",
             "target_id": "be3b0b9e-2a43-4287-85b2-82e638a8d783"
           }
         },
         "include": "target"
       }'
```

> A 201 status response looks like this:

```json
  {
    "data": {
      "id": "f56645b5-f7d5-4d4c-86d5-52c24d06de70",
      "type": "merges",
      "attributes": {
        "type": "customers",
        "source_id": "0786baf4-bec1-461b-8991-2d8a800a02d8",
        "target_id": "be3b0b9e-2a43-4287-85b2-82e638a8d783"
      },
      "relationships": {
        "target": {
          "data": {
            "type": "customers",
            "id": "be3b0b9e-2a43-4287-85b2-82e638a8d783"
          }
        }
      }
    },
    "included": [
      {
        "id": "be3b0b9e-2a43-4287-85b2-82e638a8d783",
        "type": "customers",
        "attributes": {
          "created_at": "2023-02-01T00:39:00.000000+00:00",
          "updated_at": "2023-02-01T00:39:00.000000+00:00",
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
`fields[]` | **array** <br>List of comma seperated fields to include `?fields[merges]=type,source_id,target_id`
`include` | **string** <br>List of comma seperated relationships `?include=target`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][source_id]` | **uuid** <br>Resource from which data is taken, this resource gets archived or destroyed.
`data[attributes][target_id]` | **uuid** <br>Resource to which data is saved.
`data[attributes][type]` | **enum** <br>Type of resource to merge. Only merging `customers` is supported.


### Includes

This request accepts the following includes:

`target`





