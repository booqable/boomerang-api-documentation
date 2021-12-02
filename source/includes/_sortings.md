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
            "ec76d768-fba5-4996-8b56-d349676c0459",
            "687d0b91-c4ce-40a9-9f7b-a7a13154063c",
            "28d3906a-61a4-4adf-8b40-25dca4823bed",
            "803b000f-2461-4950-949b-6ece16c54143",
            "42d7ef45-96dd-4932-8ef0-59f46ca341bd"
          ]
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "b4db16c0-247e-523c-968f-a9fb52d9cf40",
    "type": "sortings"
  },
  "links": {
    "self": "api/boomerang/sortings?data%5Battributes%5D%5Bids%5D%5B%5D=ec76d768-fba5-4996-8b56-d349676c0459&data%5Battributes%5D%5Bids%5D%5B%5D=687d0b91-c4ce-40a9-9f7b-a7a13154063c&data%5Battributes%5D%5Bids%5D%5B%5D=28d3906a-61a4-4adf-8b40-25dca4823bed&data%5Battributes%5D%5Bids%5D%5B%5D=803b000f-2461-4950-949b-6ece16c54143&data%5Battributes%5D%5Bids%5D%5B%5D=42d7ef45-96dd-4932-8ef0-59f46ca341bd&data%5Battributes%5D%5Btype%5D=categories&data%5Btype%5D=sorting&page%5Bnumber%5D=1&page%5Bsize%5D=25&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=ec76d768-fba5-4996-8b56-d349676c0459&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=687d0b91-c4ce-40a9-9f7b-a7a13154063c&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=28d3906a-61a4-4adf-8b40-25dca4823bed&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=803b000f-2461-4950-949b-6ece16c54143&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=42d7ef45-96dd-4932-8ef0-59f46ca341bd&sorting%5Bdata%5D%5Battributes%5D%5Btype%5D=categories&sorting%5Bdata%5D%5Btype%5D=sorting",
    "first": "api/boomerang/sortings?data%5Battributes%5D%5Bids%5D%5B%5D=ec76d768-fba5-4996-8b56-d349676c0459&data%5Battributes%5D%5Bids%5D%5B%5D=687d0b91-c4ce-40a9-9f7b-a7a13154063c&data%5Battributes%5D%5Bids%5D%5B%5D=28d3906a-61a4-4adf-8b40-25dca4823bed&data%5Battributes%5D%5Bids%5D%5B%5D=803b000f-2461-4950-949b-6ece16c54143&data%5Battributes%5D%5Bids%5D%5B%5D=42d7ef45-96dd-4932-8ef0-59f46ca341bd&data%5Battributes%5D%5Btype%5D=categories&data%5Btype%5D=sorting&page%5Bnumber%5D=1&page%5Bsize%5D=25&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=ec76d768-fba5-4996-8b56-d349676c0459&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=687d0b91-c4ce-40a9-9f7b-a7a13154063c&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=28d3906a-61a4-4adf-8b40-25dca4823bed&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=803b000f-2461-4950-949b-6ece16c54143&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=42d7ef45-96dd-4932-8ef0-59f46ca341bd&sorting%5Bdata%5D%5Battributes%5D%5Btype%5D=categories&sorting%5Bdata%5D%5Btype%5D=sorting",
    "last": "api/boomerang/sortings?data%5Battributes%5D%5Bids%5D%5B%5D=ec76d768-fba5-4996-8b56-d349676c0459&data%5Battributes%5D%5Bids%5D%5B%5D=687d0b91-c4ce-40a9-9f7b-a7a13154063c&data%5Battributes%5D%5Bids%5D%5B%5D=28d3906a-61a4-4adf-8b40-25dca4823bed&data%5Battributes%5D%5Bids%5D%5B%5D=803b000f-2461-4950-949b-6ece16c54143&data%5Battributes%5D%5Bids%5D%5B%5D=42d7ef45-96dd-4932-8ef0-59f46ca341bd&data%5Battributes%5D%5Btype%5D=categories&data%5Btype%5D=sorting&page%5Bnumber%5D=&page%5Bsize%5D=25&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=ec76d768-fba5-4996-8b56-d349676c0459&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=687d0b91-c4ce-40a9-9f7b-a7a13154063c&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=28d3906a-61a4-4adf-8b40-25dca4823bed&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=803b000f-2461-4950-949b-6ece16c54143&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=42d7ef45-96dd-4932-8ef0-59f46ca341bd&sorting%5Bdata%5D%5Battributes%5D%5Btype%5D=categories&sorting%5Bdata%5D%5Btype%5D=sorting",
    "next": "api/boomerang/sortings?data%5Battributes%5D%5Bids%5D%5B%5D=ec76d768-fba5-4996-8b56-d349676c0459&data%5Battributes%5D%5Bids%5D%5B%5D=687d0b91-c4ce-40a9-9f7b-a7a13154063c&data%5Battributes%5D%5Bids%5D%5B%5D=28d3906a-61a4-4adf-8b40-25dca4823bed&data%5Battributes%5D%5Bids%5D%5B%5D=803b000f-2461-4950-949b-6ece16c54143&data%5Battributes%5D%5Bids%5D%5B%5D=42d7ef45-96dd-4932-8ef0-59f46ca341bd&data%5Battributes%5D%5Btype%5D=categories&data%5Btype%5D=sorting&page%5Bnumber%5D=2&page%5Bsize%5D=25&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=ec76d768-fba5-4996-8b56-d349676c0459&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=687d0b91-c4ce-40a9-9f7b-a7a13154063c&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=28d3906a-61a4-4adf-8b40-25dca4823bed&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=803b000f-2461-4950-949b-6ece16c54143&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=42d7ef45-96dd-4932-8ef0-59f46ca341bd&sorting%5Bdata%5D%5Battributes%5D%5Btype%5D=categories&sorting%5Bdata%5D%5Btype%5D=sorting"
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