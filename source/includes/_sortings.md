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
            "683497b5-02b6-495d-9d47-38ac281233a1",
            "fcffc237-ecd2-4fc8-9edf-f37b41fe6ec7",
            "93c12e15-b809-4031-a14f-670c873a170f",
            "ac23f856-5bca-4f6d-b78e-3e844044232c",
            "d03cfacb-9a15-4b41-a366-843017007a2e"
          ]
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "99645b8e-6e2e-5e50-8360-530997670af5",
    "type": "sortings"
  },
  "links": {
    "self": "api/boomerang/sortings?data%5Battributes%5D%5Bids%5D%5B%5D=683497b5-02b6-495d-9d47-38ac281233a1&data%5Battributes%5D%5Bids%5D%5B%5D=fcffc237-ecd2-4fc8-9edf-f37b41fe6ec7&data%5Battributes%5D%5Bids%5D%5B%5D=93c12e15-b809-4031-a14f-670c873a170f&data%5Battributes%5D%5Bids%5D%5B%5D=ac23f856-5bca-4f6d-b78e-3e844044232c&data%5Battributes%5D%5Bids%5D%5B%5D=d03cfacb-9a15-4b41-a366-843017007a2e&data%5Battributes%5D%5Btype%5D=categories&data%5Btype%5D=sorting&page%5Bnumber%5D=1&page%5Bsize%5D=25&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=683497b5-02b6-495d-9d47-38ac281233a1&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=fcffc237-ecd2-4fc8-9edf-f37b41fe6ec7&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=93c12e15-b809-4031-a14f-670c873a170f&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=ac23f856-5bca-4f6d-b78e-3e844044232c&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=d03cfacb-9a15-4b41-a366-843017007a2e&sorting%5Bdata%5D%5Battributes%5D%5Btype%5D=categories&sorting%5Bdata%5D%5Btype%5D=sorting",
    "first": "api/boomerang/sortings?data%5Battributes%5D%5Bids%5D%5B%5D=683497b5-02b6-495d-9d47-38ac281233a1&data%5Battributes%5D%5Bids%5D%5B%5D=fcffc237-ecd2-4fc8-9edf-f37b41fe6ec7&data%5Battributes%5D%5Bids%5D%5B%5D=93c12e15-b809-4031-a14f-670c873a170f&data%5Battributes%5D%5Bids%5D%5B%5D=ac23f856-5bca-4f6d-b78e-3e844044232c&data%5Battributes%5D%5Bids%5D%5B%5D=d03cfacb-9a15-4b41-a366-843017007a2e&data%5Battributes%5D%5Btype%5D=categories&data%5Btype%5D=sorting&page%5Bnumber%5D=1&page%5Bsize%5D=25&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=683497b5-02b6-495d-9d47-38ac281233a1&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=fcffc237-ecd2-4fc8-9edf-f37b41fe6ec7&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=93c12e15-b809-4031-a14f-670c873a170f&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=ac23f856-5bca-4f6d-b78e-3e844044232c&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=d03cfacb-9a15-4b41-a366-843017007a2e&sorting%5Bdata%5D%5Battributes%5D%5Btype%5D=categories&sorting%5Bdata%5D%5Btype%5D=sorting",
    "last": "api/boomerang/sortings?data%5Battributes%5D%5Bids%5D%5B%5D=683497b5-02b6-495d-9d47-38ac281233a1&data%5Battributes%5D%5Bids%5D%5B%5D=fcffc237-ecd2-4fc8-9edf-f37b41fe6ec7&data%5Battributes%5D%5Bids%5D%5B%5D=93c12e15-b809-4031-a14f-670c873a170f&data%5Battributes%5D%5Bids%5D%5B%5D=ac23f856-5bca-4f6d-b78e-3e844044232c&data%5Battributes%5D%5Bids%5D%5B%5D=d03cfacb-9a15-4b41-a366-843017007a2e&data%5Battributes%5D%5Btype%5D=categories&data%5Btype%5D=sorting&page%5Bnumber%5D=&page%5Bsize%5D=25&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=683497b5-02b6-495d-9d47-38ac281233a1&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=fcffc237-ecd2-4fc8-9edf-f37b41fe6ec7&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=93c12e15-b809-4031-a14f-670c873a170f&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=ac23f856-5bca-4f6d-b78e-3e844044232c&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=d03cfacb-9a15-4b41-a366-843017007a2e&sorting%5Bdata%5D%5Battributes%5D%5Btype%5D=categories&sorting%5Bdata%5D%5Btype%5D=sorting",
    "next": "api/boomerang/sortings?data%5Battributes%5D%5Bids%5D%5B%5D=683497b5-02b6-495d-9d47-38ac281233a1&data%5Battributes%5D%5Bids%5D%5B%5D=fcffc237-ecd2-4fc8-9edf-f37b41fe6ec7&data%5Battributes%5D%5Bids%5D%5B%5D=93c12e15-b809-4031-a14f-670c873a170f&data%5Battributes%5D%5Bids%5D%5B%5D=ac23f856-5bca-4f6d-b78e-3e844044232c&data%5Battributes%5D%5Bids%5D%5B%5D=d03cfacb-9a15-4b41-a366-843017007a2e&data%5Battributes%5D%5Btype%5D=categories&data%5Btype%5D=sorting&page%5Bnumber%5D=2&page%5Bsize%5D=25&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=683497b5-02b6-495d-9d47-38ac281233a1&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=fcffc237-ecd2-4fc8-9edf-f37b41fe6ec7&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=93c12e15-b809-4031-a14f-670c873a170f&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=ac23f856-5bca-4f6d-b78e-3e844044232c&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=d03cfacb-9a15-4b41-a366-843017007a2e&sorting%5Bdata%5D%5Battributes%5D%5Btype%5D=categories&sorting%5Bdata%5D%5Btype%5D=sorting"
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