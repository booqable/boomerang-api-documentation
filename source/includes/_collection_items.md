# Collection items

An item in a [Collection](#collections).

CollectionItems cannot be changed directly, but their position can be updated
through the [Sortings](#sortings) resource.

## Relationships
Name | Description
-- | --
`collection` | **[Collection](#collections)** `required`<br>The [Collection](#collections) this CollectionItem is part of. 
`item` | **[Item](#items)** `required`<br>The item. Can be a [ProductGroup](#product-groups) or a [Bundle](#bundles). 


Check matching attributes under [Fields](#collection-items-fields) to see which relations can be written.
<br/ >
Check each individual operation to see which relations can be included as a sideload.
## Fields

 Name | Description
-- | --
`collection_id` | **uuid** `readonly-after-create`<br>The [Collection](#collections) this CollectionItem is part of. 
`created_at` | **datetime** `readonly`<br>When the resource was created.
`id` | **uuid** `readonly`<br>Primary key.
`implicit` | **boolean** `readonly`<br>A value of `true` indicates that this item was not added explicitly, but instead is included in one of the child Collections. 
`item_id` | **uuid** `readonly-after-create`<br>The item. Can be a [ProductGroup](#product-groups) or a [Bundle](#bundles). 
`position` | **integer** `readonly`<br>Position of this item within the Collection. I.e sorting relative to other CollectionItems. 
`source_collections` | **array** `readonly` `extra`<br>The child [Collection](#collections)(s) which explicitly include the [ProductGroup](#product-groups)/[Bundle](#bundles), and are the source(s) for this CollectionItem. 


## List collection items


> How to fetch collection items:

```shell
  curl --get 'https://example.booqable.com/api/4/collection_items'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": [
      {
        "id": "c1cd76e1-4623-455e-8573-566ce1ce6c28",
        "type": "collection_items",
        "attributes": {
          "created_at": "2023-01-20T16:48:01.000000+00:00",
          "updated_at": "2023-01-20T16:48:01.000000+00:00",
          "item_id": "33763613-da95-4e0a-89fd-1394814769da",
          "collection_id": "80277708-d325-42a0-87a1-7e45bb3167ec",
          "position": null,
          "implicit": false
        },
        "relationships": {}
      }
    ],
    "meta": {}
  }
```

### HTTP Request

`GET /api/boomerang/collection_items`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`extra_fields[]` | **array** <br>List of comma separated fields to include in addition to the default fields. `?extra_fields[collection_items]=source_collections`
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[collection_items]=created_at,item_id,collection_id`
`filter` | **hash** <br>The filters to apply `?filter[attribute][eq]=value`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=item,collection`
`meta` | **hash** <br>Metadata to send along. `?meta[total][]=count`
`page[number]` | **string** <br>The page to request.
`page[size]` | **string** <br>The amount of items per page.
`sort` | **string** <br>How to sort the data. `?sort=attribute1,-attribute2`


### Filters

This request can be filtered on:

Name | Description
-- | --
`collection_id` | **uuid** <br>`eq`, `not_eq`
`created_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`exclude_system_collections` | **boolean** <br>`eq`
`id` | **uuid** <br>`eq`, `not_eq`
`implicit` | **boolean** <br>`eq`
`item_id` | **uuid** <br>`eq`, `not_eq`
`position` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **array** <br>`count`


### Includes

This request accepts the following includes:

`item` => 
`photo`




`collection`






## Create a collection item


> How to create a collection item:

```shell
  curl --request POST
       --url 'https://example.booqable.com/api/4/collection_items'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "type": "collection_items",
           "attributes": {
             "item_id": "facd8ef7-5f11-4dae-8318-f3a59f73560e",
             "collection_id": "d9c4b730-729f-4e5d-8809-1be451f56dac"
           }
         }
       }'
```

> A 201 status response looks like this:

```json
  {
    "data": {
      "id": "2f9668f0-65ed-4b5c-865d-f8e91d0b51cd",
      "type": "collection_items",
      "attributes": {
        "created_at": "2025-05-23T01:55:00.000000+00:00",
        "updated_at": "2025-05-23T01:55:00.000000+00:00",
        "item_id": "facd8ef7-5f11-4dae-8318-f3a59f73560e",
        "collection_id": "d9c4b730-729f-4e5d-8809-1be451f56dac",
        "position": null,
        "implicit": false
      },
      "relationships": {}
    },
    "meta": {}
  }
```

### HTTP Request

`POST /api/boomerang/collection_items`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`extra_fields[]` | **array** <br>List of comma separated fields to include in addition to the default fields. `?extra_fields[collection_items]=source_collections`
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[collection_items]=created_at,item_id,collection_id`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][collection_id]` | **uuid** <br>The [Collection](#collections) this CollectionItem is part of. 
`data[attributes][item_id]` | **uuid** <br>The item. Can be a [ProductGroup](#product-groups) or a [Bundle](#bundles). 


### Includes

This request does not accept any includes
## Delete a collection item


> How to delete a collection item:

```shell
  curl --request DELETE
       --url 'https://example.booqable.com/api/4/collection_items/ec034cc0-89e0-42f0-8a00-b2a59de8c98a'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "ec034cc0-89e0-42f0-8a00-b2a59de8c98a",
      "type": "collection_items",
      "attributes": {
        "created_at": "2018-01-04T10:28:00.000000+00:00",
        "updated_at": "2018-01-04T10:28:00.000000+00:00",
        "item_id": "cdb92bdf-3a07-413f-8f82-69cb2d3ea2b1",
        "collection_id": "fc597631-ca5b-4fcb-83eb-2b59c0f54073",
        "position": null,
        "implicit": false
      },
      "relationships": {}
    },
    "meta": {}
  }
```

### HTTP Request

`DELETE /api/boomerang/collection_items/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`extra_fields[]` | **array** <br>List of comma separated fields to include in addition to the default fields. `?extra_fields[collection_items]=source_collections`
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[collection_items]=created_at,item_id,collection_id`


### Includes

This request does not accept any includes