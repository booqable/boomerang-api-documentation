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
            "d7c01c89-67b7-45d1-a7b0-943841a3987f",
            "d08e7c41-2fd1-4587-a3c9-9afc26b381a0",
            "8bb21060-847f-43d3-97f6-a1439e578e9d",
            "0fb638b9-7aa0-44ec-af07-4ce1368cb680",
            "3873f61d-6822-4de6-9347-15d1f35c2dd5"
          ]
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "e40483f5-85e2-5150-8f90-b034e2ca801e",
    "type": "sortings"
  },
  "links": {
    "self": "api/boomerang/sortings?data%5Battributes%5D%5Bids%5D%5B%5D=d7c01c89-67b7-45d1-a7b0-943841a3987f&data%5Battributes%5D%5Bids%5D%5B%5D=d08e7c41-2fd1-4587-a3c9-9afc26b381a0&data%5Battributes%5D%5Bids%5D%5B%5D=8bb21060-847f-43d3-97f6-a1439e578e9d&data%5Battributes%5D%5Bids%5D%5B%5D=0fb638b9-7aa0-44ec-af07-4ce1368cb680&data%5Battributes%5D%5Bids%5D%5B%5D=3873f61d-6822-4de6-9347-15d1f35c2dd5&data%5Battributes%5D%5Btype%5D=categories&data%5Btype%5D=sorting&page%5Bnumber%5D=1&page%5Bsize%5D=25&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=d7c01c89-67b7-45d1-a7b0-943841a3987f&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=d08e7c41-2fd1-4587-a3c9-9afc26b381a0&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=8bb21060-847f-43d3-97f6-a1439e578e9d&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=0fb638b9-7aa0-44ec-af07-4ce1368cb680&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=3873f61d-6822-4de6-9347-15d1f35c2dd5&sorting%5Bdata%5D%5Battributes%5D%5Btype%5D=categories&sorting%5Bdata%5D%5Btype%5D=sorting",
    "first": "api/boomerang/sortings?data%5Battributes%5D%5Bids%5D%5B%5D=d7c01c89-67b7-45d1-a7b0-943841a3987f&data%5Battributes%5D%5Bids%5D%5B%5D=d08e7c41-2fd1-4587-a3c9-9afc26b381a0&data%5Battributes%5D%5Bids%5D%5B%5D=8bb21060-847f-43d3-97f6-a1439e578e9d&data%5Battributes%5D%5Bids%5D%5B%5D=0fb638b9-7aa0-44ec-af07-4ce1368cb680&data%5Battributes%5D%5Bids%5D%5B%5D=3873f61d-6822-4de6-9347-15d1f35c2dd5&data%5Battributes%5D%5Btype%5D=categories&data%5Btype%5D=sorting&page%5Bnumber%5D=1&page%5Bsize%5D=25&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=d7c01c89-67b7-45d1-a7b0-943841a3987f&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=d08e7c41-2fd1-4587-a3c9-9afc26b381a0&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=8bb21060-847f-43d3-97f6-a1439e578e9d&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=0fb638b9-7aa0-44ec-af07-4ce1368cb680&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=3873f61d-6822-4de6-9347-15d1f35c2dd5&sorting%5Bdata%5D%5Battributes%5D%5Btype%5D=categories&sorting%5Bdata%5D%5Btype%5D=sorting",
    "last": "api/boomerang/sortings?data%5Battributes%5D%5Bids%5D%5B%5D=d7c01c89-67b7-45d1-a7b0-943841a3987f&data%5Battributes%5D%5Bids%5D%5B%5D=d08e7c41-2fd1-4587-a3c9-9afc26b381a0&data%5Battributes%5D%5Bids%5D%5B%5D=8bb21060-847f-43d3-97f6-a1439e578e9d&data%5Battributes%5D%5Bids%5D%5B%5D=0fb638b9-7aa0-44ec-af07-4ce1368cb680&data%5Battributes%5D%5Bids%5D%5B%5D=3873f61d-6822-4de6-9347-15d1f35c2dd5&data%5Battributes%5D%5Btype%5D=categories&data%5Btype%5D=sorting&page%5Bnumber%5D=&page%5Bsize%5D=25&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=d7c01c89-67b7-45d1-a7b0-943841a3987f&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=d08e7c41-2fd1-4587-a3c9-9afc26b381a0&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=8bb21060-847f-43d3-97f6-a1439e578e9d&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=0fb638b9-7aa0-44ec-af07-4ce1368cb680&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=3873f61d-6822-4de6-9347-15d1f35c2dd5&sorting%5Bdata%5D%5Battributes%5D%5Btype%5D=categories&sorting%5Bdata%5D%5Btype%5D=sorting",
    "next": "api/boomerang/sortings?data%5Battributes%5D%5Bids%5D%5B%5D=d7c01c89-67b7-45d1-a7b0-943841a3987f&data%5Battributes%5D%5Bids%5D%5B%5D=d08e7c41-2fd1-4587-a3c9-9afc26b381a0&data%5Battributes%5D%5Bids%5D%5B%5D=8bb21060-847f-43d3-97f6-a1439e578e9d&data%5Battributes%5D%5Bids%5D%5B%5D=0fb638b9-7aa0-44ec-af07-4ce1368cb680&data%5Battributes%5D%5Bids%5D%5B%5D=3873f61d-6822-4de6-9347-15d1f35c2dd5&data%5Battributes%5D%5Btype%5D=categories&data%5Btype%5D=sorting&page%5Bnumber%5D=2&page%5Bsize%5D=25&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=d7c01c89-67b7-45d1-a7b0-943841a3987f&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=d08e7c41-2fd1-4587-a3c9-9afc26b381a0&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=8bb21060-847f-43d3-97f6-a1439e578e9d&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=0fb638b9-7aa0-44ec-af07-4ce1368cb680&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=3873f61d-6822-4de6-9347-15d1f35c2dd5&sorting%5Bdata%5D%5Battributes%5D%5Btype%5D=categories&sorting%5Bdata%5D%5Btype%5D=sorting"
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