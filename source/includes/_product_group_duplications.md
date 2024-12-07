# Product group duplications

Duplicates a `ProductGroup` with a selectable subset of fields and associations.

## Fields
Every product group duplication has the following fields:

Name | Description
-- | --
`id` | **Uuid** `readonly`<br>Primary key
`name` | **String** <br>Name of the newly created Product Group.
`description` | **String** <br>Description used in the online store.
`collections` | **Boolean** <br>Indicates if collections should be copied from the original Product Group.
`custom_fields` | **Boolean** <br>Indicates if custom Lines should be copied from the original Product Group.
`padding_time` | **Boolean** <br>Indicates if lead and lag time settings should be copied from the original Product Group.
`price_settings` | **Boolean** <br>Indicates if price settings should be copied from the original Product Group.
`shortage_settings` | **Boolean** <br>Indicates if shortage settings should be copied from the original Product Group.
`tags` | **Boolean** <br>Indicates if tags should be copied from the original Product Group.
`tax_settings` | **Boolean** <br>Indicates if tax settings should be copied from the original Product Group.
`show_in_store` | **Boolean** <br>Indicates if the copied product should be visible in the online store.
`photo_base64` | **String** <br>Base64 encoded photo, use this field to store a main photo
`remote_photo_url` | **String** <br>Url to an image on the web
`original_product_group_id` | **Uuid** <br>ID of the Product Group to be duplicated.
`new_product_group_id` | **Uuid** `readonly`<br>ID of the newly created Product Group.


## Relationships
Product group duplications have the following relationships:

Name | Description
-- | --
`new_product_group` | **[Product group](#product-groups)** <br>Associated New product group
`original_product_group` | **[Product group](#product-groups)** <br>Associated Original product group


## Duplicate



> Duplicate a Product Group:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/product_group_duplications' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "order_duplications",
        "attributes": {
          "original_product_group_id": "86de5792-a7df-4b52-912c-dd0307650104",
          "name": "New name",
          "description": "New description",
          "collections": true,
          "custom_fields": true,
          "padding_time": true,
          "price_settings": true,
          "shortage_settings": true,
          "tags": true,
          "tax_settings": true,
          "show_in_store": true
        }
      }
    }'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "c050b4ac-5c89-549b-a970-9a9fdbf0d7f2",
    "type": "product_group_duplications",
    "attributes": {
      "name": "New name",
      "description": "New description",
      "collections": true,
      "custom_fields": true,
      "padding_time": true,
      "price_settings": true,
      "shortage_settings": true,
      "tags": true,
      "tax_settings": true,
      "show_in_store": true,
      "photo_base64": null,
      "remote_photo_url": null,
      "original_product_group_id": "86de5792-a7df-4b52-912c-dd0307650104",
      "new_product_group_id": "48fc6df5-cba3-4514-9359-1a32b8e96dfc"
    },
    "relationships": {}
  },
  "meta": {}
}
```

### HTTP Request

`POST /api/boomerang/product_group_duplications`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=barcode,inventory_levels,photo`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[product_group_duplications]=name,description,collections`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][name]` | **String** <br>Name of the newly created Product Group.
`data[attributes][collections]` | **Boolean** <br>Indicates if collections should be copied from the original Product Group.
`data[attributes][custom_fields]` | **Boolean** <br>Indicates if custom Lines should be copied from the original Product Group.
`data[attributes][padding_time]` | **Boolean** <br>Indicates if lead and lag time settings should be copied from the original Product Group.
`data[attributes][price_settings]` | **Boolean** <br>Indicates if price settings should be copied from the original Product Group.
`data[attributes][shortage_settings]` | **Boolean** <br>Indicates if shortage settings should be copied from the original Product Group.
`data[attributes][tags]` | **Boolean** <br>Indicates if tags should be copied from the original Product Group.
`data[attributes][tax_settings]` | **Boolean** <br>Indicates if tax settings should be copied from the original Product Group.
`data[attributes][show_in_store]` | **Boolean** <br>Indicates if the copied product should be visible in the online store.
`data[attributes][photo_base64]` | **String** <br>Base64 encoded photo, use this field to store a main photo
`data[attributes][remote_photo_url]` | **String** <br>Url to an image on the web
`data[attributes][original_product_group_id]` | **Uuid** <br>ID of the Product Group to be duplicated.


### Includes

This request accepts the following includes:

`barcode`


`inventory_levels`


`photo`


`price_structure` => 
`price_tiles`




`original_product_group`


`new_product_group`


`properties`


`tax_category`





