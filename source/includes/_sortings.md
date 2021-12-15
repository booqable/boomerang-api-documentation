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
            "e1ea157b-32e7-41af-ba67-3bf115485adb",
            "4164f1d0-00b8-4ae4-a13f-2ce316c21764",
            "8209bc26-9d4b-43ee-9853-e277fa9f868a",
            "90cb8589-43ca-4997-97f0-29e08cecf047",
            "f0f0743e-1b98-45a9-9498-f5c4e1db07e4"
          ]
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "30f598ef-63e3-5205-b580-050cf1dc29fe",
    "type": "sortings"
  },
  "links": {
    "self": "api/boomerang/sortings?data%5Battributes%5D%5Bids%5D%5B%5D=e1ea157b-32e7-41af-ba67-3bf115485adb&data%5Battributes%5D%5Bids%5D%5B%5D=4164f1d0-00b8-4ae4-a13f-2ce316c21764&data%5Battributes%5D%5Bids%5D%5B%5D=8209bc26-9d4b-43ee-9853-e277fa9f868a&data%5Battributes%5D%5Bids%5D%5B%5D=90cb8589-43ca-4997-97f0-29e08cecf047&data%5Battributes%5D%5Bids%5D%5B%5D=f0f0743e-1b98-45a9-9498-f5c4e1db07e4&data%5Battributes%5D%5Btype%5D=categories&data%5Btype%5D=sorting&page%5Bnumber%5D=1&page%5Bsize%5D=25&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=e1ea157b-32e7-41af-ba67-3bf115485adb&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=4164f1d0-00b8-4ae4-a13f-2ce316c21764&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=8209bc26-9d4b-43ee-9853-e277fa9f868a&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=90cb8589-43ca-4997-97f0-29e08cecf047&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=f0f0743e-1b98-45a9-9498-f5c4e1db07e4&sorting%5Bdata%5D%5Battributes%5D%5Btype%5D=categories&sorting%5Bdata%5D%5Btype%5D=sorting",
    "first": "api/boomerang/sortings?data%5Battributes%5D%5Bids%5D%5B%5D=e1ea157b-32e7-41af-ba67-3bf115485adb&data%5Battributes%5D%5Bids%5D%5B%5D=4164f1d0-00b8-4ae4-a13f-2ce316c21764&data%5Battributes%5D%5Bids%5D%5B%5D=8209bc26-9d4b-43ee-9853-e277fa9f868a&data%5Battributes%5D%5Bids%5D%5B%5D=90cb8589-43ca-4997-97f0-29e08cecf047&data%5Battributes%5D%5Bids%5D%5B%5D=f0f0743e-1b98-45a9-9498-f5c4e1db07e4&data%5Battributes%5D%5Btype%5D=categories&data%5Btype%5D=sorting&page%5Bnumber%5D=1&page%5Bsize%5D=25&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=e1ea157b-32e7-41af-ba67-3bf115485adb&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=4164f1d0-00b8-4ae4-a13f-2ce316c21764&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=8209bc26-9d4b-43ee-9853-e277fa9f868a&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=90cb8589-43ca-4997-97f0-29e08cecf047&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=f0f0743e-1b98-45a9-9498-f5c4e1db07e4&sorting%5Bdata%5D%5Battributes%5D%5Btype%5D=categories&sorting%5Bdata%5D%5Btype%5D=sorting",
    "last": "api/boomerang/sortings?data%5Battributes%5D%5Bids%5D%5B%5D=e1ea157b-32e7-41af-ba67-3bf115485adb&data%5Battributes%5D%5Bids%5D%5B%5D=4164f1d0-00b8-4ae4-a13f-2ce316c21764&data%5Battributes%5D%5Bids%5D%5B%5D=8209bc26-9d4b-43ee-9853-e277fa9f868a&data%5Battributes%5D%5Bids%5D%5B%5D=90cb8589-43ca-4997-97f0-29e08cecf047&data%5Battributes%5D%5Bids%5D%5B%5D=f0f0743e-1b98-45a9-9498-f5c4e1db07e4&data%5Battributes%5D%5Btype%5D=categories&data%5Btype%5D=sorting&page%5Bnumber%5D=&page%5Bsize%5D=25&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=e1ea157b-32e7-41af-ba67-3bf115485adb&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=4164f1d0-00b8-4ae4-a13f-2ce316c21764&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=8209bc26-9d4b-43ee-9853-e277fa9f868a&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=90cb8589-43ca-4997-97f0-29e08cecf047&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=f0f0743e-1b98-45a9-9498-f5c4e1db07e4&sorting%5Bdata%5D%5Battributes%5D%5Btype%5D=categories&sorting%5Bdata%5D%5Btype%5D=sorting",
    "next": "api/boomerang/sortings?data%5Battributes%5D%5Bids%5D%5B%5D=e1ea157b-32e7-41af-ba67-3bf115485adb&data%5Battributes%5D%5Bids%5D%5B%5D=4164f1d0-00b8-4ae4-a13f-2ce316c21764&data%5Battributes%5D%5Bids%5D%5B%5D=8209bc26-9d4b-43ee-9853-e277fa9f868a&data%5Battributes%5D%5Bids%5D%5B%5D=90cb8589-43ca-4997-97f0-29e08cecf047&data%5Battributes%5D%5Bids%5D%5B%5D=f0f0743e-1b98-45a9-9498-f5c4e1db07e4&data%5Battributes%5D%5Btype%5D=categories&data%5Btype%5D=sorting&page%5Bnumber%5D=2&page%5Bsize%5D=25&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=e1ea157b-32e7-41af-ba67-3bf115485adb&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=4164f1d0-00b8-4ae4-a13f-2ce316c21764&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=8209bc26-9d4b-43ee-9853-e277fa9f868a&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=90cb8589-43ca-4997-97f0-29e08cecf047&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=f0f0743e-1b98-45a9-9498-f5c4e1db07e4&sorting%5Bdata%5D%5Battributes%5D%5Btype%5D=categories&sorting%5Bdata%5D%5Btype%5D=sorting"
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