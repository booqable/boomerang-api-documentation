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
            "dc7789f8-fccf-4eb6-9853-b4493ce2c86f",
            "408d01ee-e2e4-4428-946f-9d7ae61f0339",
            "83d387a5-667d-4919-a2fe-dda06e356940",
            "2e95fd37-0714-4cb6-9168-36ca24da27d5",
            "f0b97794-1ef2-4940-b4f3-1a94185ef22a"
          ]
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "60f57ae9-53d0-5323-a1d1-7b0af7b3f6c0",
    "type": "sortings"
  },
  "links": {
    "self": "api/boomerang/sortings?data%5Battributes%5D%5Bids%5D%5B%5D=dc7789f8-fccf-4eb6-9853-b4493ce2c86f&data%5Battributes%5D%5Bids%5D%5B%5D=408d01ee-e2e4-4428-946f-9d7ae61f0339&data%5Battributes%5D%5Bids%5D%5B%5D=83d387a5-667d-4919-a2fe-dda06e356940&data%5Battributes%5D%5Bids%5D%5B%5D=2e95fd37-0714-4cb6-9168-36ca24da27d5&data%5Battributes%5D%5Bids%5D%5B%5D=f0b97794-1ef2-4940-b4f3-1a94185ef22a&data%5Battributes%5D%5Btype%5D=categories&data%5Btype%5D=sorting&page%5Bnumber%5D=1&page%5Bsize%5D=25&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=dc7789f8-fccf-4eb6-9853-b4493ce2c86f&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=408d01ee-e2e4-4428-946f-9d7ae61f0339&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=83d387a5-667d-4919-a2fe-dda06e356940&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=2e95fd37-0714-4cb6-9168-36ca24da27d5&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=f0b97794-1ef2-4940-b4f3-1a94185ef22a&sorting%5Bdata%5D%5Battributes%5D%5Btype%5D=categories&sorting%5Bdata%5D%5Btype%5D=sorting",
    "first": "api/boomerang/sortings?data%5Battributes%5D%5Bids%5D%5B%5D=dc7789f8-fccf-4eb6-9853-b4493ce2c86f&data%5Battributes%5D%5Bids%5D%5B%5D=408d01ee-e2e4-4428-946f-9d7ae61f0339&data%5Battributes%5D%5Bids%5D%5B%5D=83d387a5-667d-4919-a2fe-dda06e356940&data%5Battributes%5D%5Bids%5D%5B%5D=2e95fd37-0714-4cb6-9168-36ca24da27d5&data%5Battributes%5D%5Bids%5D%5B%5D=f0b97794-1ef2-4940-b4f3-1a94185ef22a&data%5Battributes%5D%5Btype%5D=categories&data%5Btype%5D=sorting&page%5Bnumber%5D=1&page%5Bsize%5D=25&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=dc7789f8-fccf-4eb6-9853-b4493ce2c86f&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=408d01ee-e2e4-4428-946f-9d7ae61f0339&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=83d387a5-667d-4919-a2fe-dda06e356940&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=2e95fd37-0714-4cb6-9168-36ca24da27d5&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=f0b97794-1ef2-4940-b4f3-1a94185ef22a&sorting%5Bdata%5D%5Battributes%5D%5Btype%5D=categories&sorting%5Bdata%5D%5Btype%5D=sorting",
    "last": "api/boomerang/sortings?data%5Battributes%5D%5Bids%5D%5B%5D=dc7789f8-fccf-4eb6-9853-b4493ce2c86f&data%5Battributes%5D%5Bids%5D%5B%5D=408d01ee-e2e4-4428-946f-9d7ae61f0339&data%5Battributes%5D%5Bids%5D%5B%5D=83d387a5-667d-4919-a2fe-dda06e356940&data%5Battributes%5D%5Bids%5D%5B%5D=2e95fd37-0714-4cb6-9168-36ca24da27d5&data%5Battributes%5D%5Bids%5D%5B%5D=f0b97794-1ef2-4940-b4f3-1a94185ef22a&data%5Battributes%5D%5Btype%5D=categories&data%5Btype%5D=sorting&page%5Bnumber%5D=&page%5Bsize%5D=25&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=dc7789f8-fccf-4eb6-9853-b4493ce2c86f&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=408d01ee-e2e4-4428-946f-9d7ae61f0339&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=83d387a5-667d-4919-a2fe-dda06e356940&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=2e95fd37-0714-4cb6-9168-36ca24da27d5&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=f0b97794-1ef2-4940-b4f3-1a94185ef22a&sorting%5Bdata%5D%5Battributes%5D%5Btype%5D=categories&sorting%5Bdata%5D%5Btype%5D=sorting",
    "next": "api/boomerang/sortings?data%5Battributes%5D%5Bids%5D%5B%5D=dc7789f8-fccf-4eb6-9853-b4493ce2c86f&data%5Battributes%5D%5Bids%5D%5B%5D=408d01ee-e2e4-4428-946f-9d7ae61f0339&data%5Battributes%5D%5Bids%5D%5B%5D=83d387a5-667d-4919-a2fe-dda06e356940&data%5Battributes%5D%5Bids%5D%5B%5D=2e95fd37-0714-4cb6-9168-36ca24da27d5&data%5Battributes%5D%5Bids%5D%5B%5D=f0b97794-1ef2-4940-b4f3-1a94185ef22a&data%5Battributes%5D%5Btype%5D=categories&data%5Btype%5D=sorting&page%5Bnumber%5D=2&page%5Bsize%5D=25&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=dc7789f8-fccf-4eb6-9853-b4493ce2c86f&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=408d01ee-e2e4-4428-946f-9d7ae61f0339&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=83d387a5-667d-4919-a2fe-dda06e356940&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=2e95fd37-0714-4cb6-9168-36ca24da27d5&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=f0b97794-1ef2-4940-b4f3-1a94185ef22a&sorting%5Bdata%5D%5Battributes%5D%5Btype%5D=categories&sorting%5Bdata%5D%5Btype%5D=sorting"
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