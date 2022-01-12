# Sortings

A convienient way to bulk update positions for supported models.

## Fields
Every sorting has the following fields:

Name | Description
- | -
`id` | **Uuid** `readonly`<br>
`type` | **String_enum** `writeonly`<br>Type of model to update. Any of `checkout_fields`, `bundle_items`, `categories`, `category_items`, `default_properties`, `lines`, `photos`, `properties`, `tax_rates`
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
            "20916e5d-edd9-4879-9812-764551376b6f",
            "311f04d4-fcf1-429f-8afa-b99228afc9e3",
            "5072407b-5b37-4ec0-a5e7-8c2303361875",
            "d9c8b667-5a99-47e2-97ae-c4affda83f0a",
            "4b409d1a-402e-4bc1-903f-7953645e80d6"
          ]
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "5fc77c45-2472-5248-b1ae-6e6c4c543fe6",
    "type": "sortings"
  },
  "links": {
    "self": "api/boomerang/sortings?data%5Battributes%5D%5Bids%5D%5B%5D=20916e5d-edd9-4879-9812-764551376b6f&data%5Battributes%5D%5Bids%5D%5B%5D=311f04d4-fcf1-429f-8afa-b99228afc9e3&data%5Battributes%5D%5Bids%5D%5B%5D=5072407b-5b37-4ec0-a5e7-8c2303361875&data%5Battributes%5D%5Bids%5D%5B%5D=d9c8b667-5a99-47e2-97ae-c4affda83f0a&data%5Battributes%5D%5Bids%5D%5B%5D=4b409d1a-402e-4bc1-903f-7953645e80d6&data%5Battributes%5D%5Btype%5D=categories&data%5Btype%5D=sorting&page%5Bnumber%5D=1&page%5Bsize%5D=25&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=20916e5d-edd9-4879-9812-764551376b6f&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=311f04d4-fcf1-429f-8afa-b99228afc9e3&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=5072407b-5b37-4ec0-a5e7-8c2303361875&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=d9c8b667-5a99-47e2-97ae-c4affda83f0a&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=4b409d1a-402e-4bc1-903f-7953645e80d6&sorting%5Bdata%5D%5Battributes%5D%5Btype%5D=categories&sorting%5Bdata%5D%5Btype%5D=sorting",
    "first": "api/boomerang/sortings?data%5Battributes%5D%5Bids%5D%5B%5D=20916e5d-edd9-4879-9812-764551376b6f&data%5Battributes%5D%5Bids%5D%5B%5D=311f04d4-fcf1-429f-8afa-b99228afc9e3&data%5Battributes%5D%5Bids%5D%5B%5D=5072407b-5b37-4ec0-a5e7-8c2303361875&data%5Battributes%5D%5Bids%5D%5B%5D=d9c8b667-5a99-47e2-97ae-c4affda83f0a&data%5Battributes%5D%5Bids%5D%5B%5D=4b409d1a-402e-4bc1-903f-7953645e80d6&data%5Battributes%5D%5Btype%5D=categories&data%5Btype%5D=sorting&page%5Bnumber%5D=1&page%5Bsize%5D=25&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=20916e5d-edd9-4879-9812-764551376b6f&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=311f04d4-fcf1-429f-8afa-b99228afc9e3&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=5072407b-5b37-4ec0-a5e7-8c2303361875&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=d9c8b667-5a99-47e2-97ae-c4affda83f0a&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=4b409d1a-402e-4bc1-903f-7953645e80d6&sorting%5Bdata%5D%5Battributes%5D%5Btype%5D=categories&sorting%5Bdata%5D%5Btype%5D=sorting",
    "last": "api/boomerang/sortings?data%5Battributes%5D%5Bids%5D%5B%5D=20916e5d-edd9-4879-9812-764551376b6f&data%5Battributes%5D%5Bids%5D%5B%5D=311f04d4-fcf1-429f-8afa-b99228afc9e3&data%5Battributes%5D%5Bids%5D%5B%5D=5072407b-5b37-4ec0-a5e7-8c2303361875&data%5Battributes%5D%5Bids%5D%5B%5D=d9c8b667-5a99-47e2-97ae-c4affda83f0a&data%5Battributes%5D%5Bids%5D%5B%5D=4b409d1a-402e-4bc1-903f-7953645e80d6&data%5Battributes%5D%5Btype%5D=categories&data%5Btype%5D=sorting&page%5Bnumber%5D=&page%5Bsize%5D=25&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=20916e5d-edd9-4879-9812-764551376b6f&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=311f04d4-fcf1-429f-8afa-b99228afc9e3&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=5072407b-5b37-4ec0-a5e7-8c2303361875&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=d9c8b667-5a99-47e2-97ae-c4affda83f0a&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=4b409d1a-402e-4bc1-903f-7953645e80d6&sorting%5Bdata%5D%5Battributes%5D%5Btype%5D=categories&sorting%5Bdata%5D%5Btype%5D=sorting",
    "next": "api/boomerang/sortings?data%5Battributes%5D%5Bids%5D%5B%5D=20916e5d-edd9-4879-9812-764551376b6f&data%5Battributes%5D%5Bids%5D%5B%5D=311f04d4-fcf1-429f-8afa-b99228afc9e3&data%5Battributes%5D%5Bids%5D%5B%5D=5072407b-5b37-4ec0-a5e7-8c2303361875&data%5Battributes%5D%5Bids%5D%5B%5D=d9c8b667-5a99-47e2-97ae-c4affda83f0a&data%5Battributes%5D%5Bids%5D%5B%5D=4b409d1a-402e-4bc1-903f-7953645e80d6&data%5Battributes%5D%5Btype%5D=categories&data%5Btype%5D=sorting&page%5Bnumber%5D=2&page%5Bsize%5D=25&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=20916e5d-edd9-4879-9812-764551376b6f&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=311f04d4-fcf1-429f-8afa-b99228afc9e3&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=5072407b-5b37-4ec0-a5e7-8c2303361875&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=d9c8b667-5a99-47e2-97ae-c4affda83f0a&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=4b409d1a-402e-4bc1-903f-7953645e80d6&sorting%5Bdata%5D%5Battributes%5D%5Btype%5D=categories&sorting%5Bdata%5D%5Btype%5D=sorting"
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
`data[attributes][type]` | **String_enum**<br>Type of model to update. Any of `checkout_fields`, `bundle_items`, `categories`, `category_items`, `default_properties`, `lines`, `photos`, `properties`, `tax_rates`
`data[attributes][ids]` | **Array_of_strings**<br>Array of ids, positions are determined by the order of the array


### Includes

This request does not accept any includes