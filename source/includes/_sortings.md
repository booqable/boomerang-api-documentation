# Sortings

A convienient way to bulk update positions for supported models.

## Fields
Every sorting has the following fields:

Name | Description
-- | --
`id` | **Uuid** `readonly`<br>Primary key
`type` | **String_enum** `writeonly`<br>Type of model to update. Any of `bundle_items`, `default_properties`, `lines`, `photos`, `properties`, `tax_rates`, `collection_items`, `products`
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
          "type": "default_properties",
          "ids": [
            "214da8f9-ece9-44f0-b34f-7e1345bd135d",
            "43cc6176-6ba4-495c-81c0-1ac73e800f83",
            "a272c56c-bad2-4dc0-baf0-a143d7ed809f",
            "08eecc32-7e68-4b5d-981c-2d7a7fb6a0ea",
            "5651c84a-3273-4cbd-9538-b7a135dabc0f"
          ]
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "ea0e60f4-8ad7-5e71-898f-28b7b9a44df0",
    "type": "sortings"
  },
  "meta": {}
}
```

### HTTP Request

`POST /api/boomerang/sortings`

### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][type]` | **String_enum** <br>Type of model to update. Any of `bundle_items`, `default_properties`, `lines`, `photos`, `properties`, `tax_rates`, `collection_items`, `products`
`data[attributes][ids]` | **Array_of_strings** <br>Array of ids, positions are determined by the order of the array


### Includes

This request does not accept any includes