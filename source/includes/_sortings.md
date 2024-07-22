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
            "9b6a4638-e316-48c4-b490-836aeb85c312",
            "b832864d-e9b6-434a-b67e-1ef5cb2dc3f7",
            "bd9fbb90-33a8-438c-85f2-e1f57f4f8ef2",
            "b3209aaf-0e60-4e1f-b29b-d60d709bdd84",
            "740ef9cd-9d27-49e3-b495-8772210a7973"
          ]
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "9a352a4b-0e22-558f-a883-dec348417482",
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