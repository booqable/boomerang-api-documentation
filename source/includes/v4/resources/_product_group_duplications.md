# Product group duplications

Duplicates a ProductGroup with a selectable subset of fields and associations.

## Relationships
Name | Description
-- | --
`new_product_group` | **[Product group](#product-groups)** `required`<br>The newly created [ProductGroup](#product-groups).
`original_product_group` | **[Product group](#product-groups)** `required`<br>The [ProductGroup](#product-groups) to be duplicated.


Check matching attributes under [Fields](#product-group-duplications-fields) to see which relations can be written.
<br/ >
Check each individual operation to see which relations can be included as a sideload.
## Fields

 Name | Description
-- | --
`buffer_times` | **boolean** <br>Indicates if buffer_time_before and buffer_time_after settings should be copied from the original ProductGroup.
`collections` | **boolean** <br>Indicates if collections should be copied from the original ProductGroup.
`custom_fields` | **boolean** <br>Indicates if custom fields should be copied from the original ProductGroup.
`description` | **string** <br>Description used in the online store.
`id` | **uuid** `readonly`<br>Primary key.
`name` | **string** <br>Name of the newly created [ProductGroup](#product-groups).
`new_product_group_id` | **uuid** `readonly`<br>The newly created [ProductGroup](#product-groups).
`original_product_group_id` | **uuid** <br>The [ProductGroup](#product-groups) to be duplicated.
`photo_base64` | **string** <br>Base64 encoded photo, use this field to store a main photo.
`price_settings` | **boolean** <br>Indicates if price settings should be copied from the original ProductGroup.
`remote_photo_url` | **string** <br>URL to an image on the web.
`shortage_settings` | **boolean** <br>Indicates if shortage settings should be copied from the original ProductGroup.
`show_in_store` | **boolean** <br>Indicates if the copied product should be visible in the online store.
`tags` | **boolean** <br>Indicates if tags should be copied from the original ProductGroup.
`tax_settings` | **boolean** <br>Indicates if tax settings should be copied from the original ProductGroup.


## Duplicate


> Duplicate a Product Group:

```shell
  curl --request POST
       --url 'https://example.booqable.com/api/4/product_group_duplications'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "type": "order_duplications",
           "attributes": {
             "original_product_group_id": "714d0e66-adcf-473c-8f70-ab89377a3fe5",
             "name": "New name",
             "description": "New description",
             "collections": true,
             "custom_fields": true,
             "buffer_times": true,
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
      "id": "ae67647c-e51c-4c12-8a82-b38fc5f1138d",
      "type": "product_group_duplications",
      "attributes": {
        "name": "New name",
        "description": "New description",
        "collections": true,
        "custom_fields": true,
        "buffer_times": true,
        "price_settings": true,
        "shortage_settings": true,
        "tags": true,
        "tax_settings": true,
        "show_in_store": true,
        "photo_base64": null,
        "remote_photo_url": null,
        "original_product_group_id": "714d0e66-adcf-473c-8f70-ab89377a3fe5",
        "new_product_group_id": "11cd1364-cfe1-4622-8cd5-c2110a4a1751"
      },
      "relationships": {}
    },
    "meta": {}
  }
```

### HTTP Request

`POST /api/4/product_group_duplications`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[product_group_duplications]=name,description,collections`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=barcode,inventory_levels,photo`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][buffer_times]` | **boolean** <br>Indicates if buffer_time_before and buffer_time_after settings should be copied from the original ProductGroup.
`data[attributes][collections]` | **boolean** <br>Indicates if collections should be copied from the original ProductGroup.
`data[attributes][custom_fields]` | **boolean** <br>Indicates if custom fields should be copied from the original ProductGroup.
`data[attributes][name]` | **string** <br>Name of the newly created [ProductGroup](#product-groups).
`data[attributes][original_product_group_id]` | **uuid** <br>The [ProductGroup](#product-groups) to be duplicated.
`data[attributes][photo_base64]` | **string** <br>Base64 encoded photo, use this field to store a main photo.
`data[attributes][price_settings]` | **boolean** <br>Indicates if price settings should be copied from the original ProductGroup.
`data[attributes][remote_photo_url]` | **string** <br>URL to an image on the web.
`data[attributes][shortage_settings]` | **boolean** <br>Indicates if shortage settings should be copied from the original ProductGroup.
`data[attributes][show_in_store]` | **boolean** <br>Indicates if the copied product should be visible in the online store.
`data[attributes][tags]` | **boolean** <br>Indicates if tags should be copied from the original ProductGroup.
`data[attributes][tax_settings]` | **boolean** <br>Indicates if tax settings should be copied from the original ProductGroup.


### Includes

This request accepts the following includes:

<ul>
  <li><code>barcode</code></li>
  <li><code>inventory_levels</code></li>
  <li><code>new_product_group</code></li>
  <li><code>original_product_group</code></li>
  <li><code>photo</code></li>
  <li>
    <code>price_structure</code>
    <ul>
      <li><code>price_tiles</code></li>
    </ul>
  </li>
  <li><code>properties</code></li>
  <li><code>tax_category</code></li>
</ul>

