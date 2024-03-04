# Sortings

A convienient way to bulk update positions for supported models.

## Fields
Every sorting has the following fields:

Name | Description
-- | --
`id` | **Uuid** `readonly`<br>
`type` | **String_enum** `writeonly`<br>Type of model to update. Any of `checkout_fields`, `bundle_items`, `default_properties`, `lines`, `photos`, `properties`, `tax_rates`, `collection_items`, `products`
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
            "870ced4a-5ec0-4b37-a2d8-7992d13880e6",
            "fab87ffd-99e6-4b69-99b6-476b79b491b9",
            "73c3bccd-f350-4682-bdaf-eb0d905c5f68",
            "693c708a-38f1-4b16-aefd-bc9d20923bb6",
            "2a2731f3-c596-4084-a8b7-715bec44fc55"
          ]
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "2b9bbbba-d1eb-5ae9-8244-d8571a4fff3e",
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
`data[attributes][type]` | **String_enum** <br>Type of model to update. Any of `checkout_fields`, `bundle_items`, `default_properties`, `lines`, `photos`, `properties`, `tax_rates`, `collection_items`, `products`
`data[attributes][ids]` | **Array_of_strings** <br>Array of ids, positions are determined by the order of the array


### Includes

This request does not accept any includes