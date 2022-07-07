# Sortings

A convienient way to bulk update positions for supported models.

## Fields
Every sorting has the following fields:

Name | Description
- | -
`id` | **Uuid** `readonly`<br>
`type` | **String_enum** `writeonly`<br>Type of model to update. Any of `checkout_fields`, `bundle_items`, `categories`, `category_items`, `default_properties`, `lines`, `photos`, `properties`, `tax_rates`, `collection_items`
`ids` | **Array_of_strings** `writeonly`<br>Array of ids, positions are determined by the order of the array


## Sorting a resource



> How to update positions:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/sortings' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "sorting",
        "attributes": {
          "type": "categories",
          "ids": [
            "e0cee611-b759-4577-a842-120792bdcaeb",
            "8e643307-9699-4bcb-a197-461360b65bd9",
            "a26bd714-d0ec-418d-b55c-0f52bd29b3a3",
            "758b45c8-e38e-4bc4-b2cf-e3a8e761d467",
            "d94bd581-2b09-4a91-94fc-c481eea509dc"
          ]
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "9e65d0b1-4213-5f9b-93da-c0c82b8c2d7c",
    "type": "sortings"
  },
  "meta": {}
}
```

### HTTP Request

`POST /api/boomerang/sortings`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[sortings]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][type]` | **String_enum**<br>Type of model to update. Any of `checkout_fields`, `bundle_items`, `categories`, `category_items`, `default_properties`, `lines`, `photos`, `properties`, `tax_rates`, `collection_items`
`data[attributes][ids]` | **Array_of_strings**<br>Array of ids, positions are determined by the order of the array


### Includes

This request does not accept any includes