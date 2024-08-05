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
            "04ffbc9a-0a6f-4045-96ad-9ace3a950339",
            "a1118dc0-4e85-4724-8207-49e2b6b30e58",
            "07712ad0-7d22-43f6-8c59-bc624fbe85fc",
            "6f1eeb0a-3a2d-49e1-823d-013d05cb4c43",
            "002fbdf2-fb55-43f2-8d46-6cc0d98bdd43"
          ]
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "b1071425-c53f-5881-9cfe-23f881f93d1d",
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