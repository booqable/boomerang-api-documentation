# Product group duplications

Duplicates a `ProductGroup` with a selectable subset of fields and associations.

## Fields
Every product group duplication has the following fields:

Name | Description
-- | --
`id` | **Uuid** `readonly`<br>
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
`original_product_group_id` | **Uuid** <br>The associated Original product group
`new_product_group_id` | **Uuid** `readonly`<br>The associated New product group


## Relationships
Product group duplications have the following relationships:

Name | Description
-- | --
`original_product_group` | **Product groups**<br>Associated Original product group
`new_product_group` | **Product groups** `readonly`<br>Associated New product group


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
          "original_product_group_id": "720e20dc-f839-42ce-9931-d7ae1947686a",
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
    "id": "45aebe0e-5c0f-597f-b66a-72a9132c3f9a",
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
      "original_product_group_id": "720e20dc-f839-42ce-9931-d7ae1947686a",
      "new_product_group_id": "9ada1d7a-3094-4a23-8a57-6437fef1f78d"
    },
    "relationships": {
      "original_product_group": {
        "meta": {
          "included": false
        }
      },
      "new_product_group": {
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
`data[attributes][original_product_group_id]` | **Uuid** <br>The associated Original product group


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




