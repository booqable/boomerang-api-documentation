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
            "200239d9-e3c1-494a-8472-ec4c6f4c9fac",
            "2553a8c5-68ba-4df0-8cae-956defc09e6c",
            "8fff0f74-2859-413a-9978-838d1abe99fc",
            "8a2a7c03-d6de-47ba-9ddb-5f5ab49d2d76",
            "b3bce2f4-8b97-44b2-bf95-b12356a76b8a"
          ]
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "9413c715-9ab4-5d10-8e8f-696160fc9973",
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