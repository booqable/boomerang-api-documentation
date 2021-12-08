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
            "4530053a-06a9-4dd9-a261-63eaf9c0fc18",
            "c53af80b-10a0-47da-bcba-b835b24cd217",
            "989ce26f-c400-4469-b450-b87c15d33058",
            "023f85da-ae7b-4ef7-8b65-2b29e1e81971",
            "1b2081f6-b4b7-4b8d-9a71-fe806fd67132"
          ]
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "b19f30f0-ab5f-53eb-9281-d5c7ff057a7b",
    "type": "sortings"
  },
  "links": {
    "self": "api/boomerang/sortings?data%5Battributes%5D%5Bids%5D%5B%5D=4530053a-06a9-4dd9-a261-63eaf9c0fc18&data%5Battributes%5D%5Bids%5D%5B%5D=c53af80b-10a0-47da-bcba-b835b24cd217&data%5Battributes%5D%5Bids%5D%5B%5D=989ce26f-c400-4469-b450-b87c15d33058&data%5Battributes%5D%5Bids%5D%5B%5D=023f85da-ae7b-4ef7-8b65-2b29e1e81971&data%5Battributes%5D%5Bids%5D%5B%5D=1b2081f6-b4b7-4b8d-9a71-fe806fd67132&data%5Battributes%5D%5Btype%5D=categories&data%5Btype%5D=sorting&page%5Bnumber%5D=1&page%5Bsize%5D=25&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=4530053a-06a9-4dd9-a261-63eaf9c0fc18&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=c53af80b-10a0-47da-bcba-b835b24cd217&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=989ce26f-c400-4469-b450-b87c15d33058&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=023f85da-ae7b-4ef7-8b65-2b29e1e81971&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=1b2081f6-b4b7-4b8d-9a71-fe806fd67132&sorting%5Bdata%5D%5Battributes%5D%5Btype%5D=categories&sorting%5Bdata%5D%5Btype%5D=sorting",
    "first": "api/boomerang/sortings?data%5Battributes%5D%5Bids%5D%5B%5D=4530053a-06a9-4dd9-a261-63eaf9c0fc18&data%5Battributes%5D%5Bids%5D%5B%5D=c53af80b-10a0-47da-bcba-b835b24cd217&data%5Battributes%5D%5Bids%5D%5B%5D=989ce26f-c400-4469-b450-b87c15d33058&data%5Battributes%5D%5Bids%5D%5B%5D=023f85da-ae7b-4ef7-8b65-2b29e1e81971&data%5Battributes%5D%5Bids%5D%5B%5D=1b2081f6-b4b7-4b8d-9a71-fe806fd67132&data%5Battributes%5D%5Btype%5D=categories&data%5Btype%5D=sorting&page%5Bnumber%5D=1&page%5Bsize%5D=25&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=4530053a-06a9-4dd9-a261-63eaf9c0fc18&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=c53af80b-10a0-47da-bcba-b835b24cd217&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=989ce26f-c400-4469-b450-b87c15d33058&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=023f85da-ae7b-4ef7-8b65-2b29e1e81971&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=1b2081f6-b4b7-4b8d-9a71-fe806fd67132&sorting%5Bdata%5D%5Battributes%5D%5Btype%5D=categories&sorting%5Bdata%5D%5Btype%5D=sorting",
    "last": "api/boomerang/sortings?data%5Battributes%5D%5Bids%5D%5B%5D=4530053a-06a9-4dd9-a261-63eaf9c0fc18&data%5Battributes%5D%5Bids%5D%5B%5D=c53af80b-10a0-47da-bcba-b835b24cd217&data%5Battributes%5D%5Bids%5D%5B%5D=989ce26f-c400-4469-b450-b87c15d33058&data%5Battributes%5D%5Bids%5D%5B%5D=023f85da-ae7b-4ef7-8b65-2b29e1e81971&data%5Battributes%5D%5Bids%5D%5B%5D=1b2081f6-b4b7-4b8d-9a71-fe806fd67132&data%5Battributes%5D%5Btype%5D=categories&data%5Btype%5D=sorting&page%5Bnumber%5D=&page%5Bsize%5D=25&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=4530053a-06a9-4dd9-a261-63eaf9c0fc18&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=c53af80b-10a0-47da-bcba-b835b24cd217&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=989ce26f-c400-4469-b450-b87c15d33058&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=023f85da-ae7b-4ef7-8b65-2b29e1e81971&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=1b2081f6-b4b7-4b8d-9a71-fe806fd67132&sorting%5Bdata%5D%5Battributes%5D%5Btype%5D=categories&sorting%5Bdata%5D%5Btype%5D=sorting",
    "next": "api/boomerang/sortings?data%5Battributes%5D%5Bids%5D%5B%5D=4530053a-06a9-4dd9-a261-63eaf9c0fc18&data%5Battributes%5D%5Bids%5D%5B%5D=c53af80b-10a0-47da-bcba-b835b24cd217&data%5Battributes%5D%5Bids%5D%5B%5D=989ce26f-c400-4469-b450-b87c15d33058&data%5Battributes%5D%5Bids%5D%5B%5D=023f85da-ae7b-4ef7-8b65-2b29e1e81971&data%5Battributes%5D%5Bids%5D%5B%5D=1b2081f6-b4b7-4b8d-9a71-fe806fd67132&data%5Battributes%5D%5Btype%5D=categories&data%5Btype%5D=sorting&page%5Bnumber%5D=2&page%5Bsize%5D=25&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=4530053a-06a9-4dd9-a261-63eaf9c0fc18&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=c53af80b-10a0-47da-bcba-b835b24cd217&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=989ce26f-c400-4469-b450-b87c15d33058&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=023f85da-ae7b-4ef7-8b65-2b29e1e81971&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=1b2081f6-b4b7-4b8d-9a71-fe806fd67132&sorting%5Bdata%5D%5Battributes%5D%5Btype%5D=categories&sorting%5Bdata%5D%5Btype%5D=sorting"
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