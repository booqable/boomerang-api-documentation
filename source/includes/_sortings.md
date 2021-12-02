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
            "cd2c46b2-3546-47b2-81be-d2deae2a216e",
            "9eced8c9-6cf9-4826-ab0e-a7e3cbc40413",
            "08588a38-575a-4ed2-9e1b-4a092a6dfbc7",
            "bd208643-3770-4f9e-b72f-c70916f766e6",
            "f42b67c7-42e5-4775-891d-5189ddea065a"
          ]
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "948bb0d5-cd34-54a7-92aa-2ca2805c6593",
    "type": "sortings"
  },
  "links": {
    "self": "api/boomerang/sortings?data%5Battributes%5D%5Bids%5D%5B%5D=cd2c46b2-3546-47b2-81be-d2deae2a216e&data%5Battributes%5D%5Bids%5D%5B%5D=9eced8c9-6cf9-4826-ab0e-a7e3cbc40413&data%5Battributes%5D%5Bids%5D%5B%5D=08588a38-575a-4ed2-9e1b-4a092a6dfbc7&data%5Battributes%5D%5Bids%5D%5B%5D=bd208643-3770-4f9e-b72f-c70916f766e6&data%5Battributes%5D%5Bids%5D%5B%5D=f42b67c7-42e5-4775-891d-5189ddea065a&data%5Battributes%5D%5Btype%5D=categories&data%5Btype%5D=sorting&page%5Bnumber%5D=1&page%5Bsize%5D=25&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=cd2c46b2-3546-47b2-81be-d2deae2a216e&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=9eced8c9-6cf9-4826-ab0e-a7e3cbc40413&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=08588a38-575a-4ed2-9e1b-4a092a6dfbc7&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=bd208643-3770-4f9e-b72f-c70916f766e6&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=f42b67c7-42e5-4775-891d-5189ddea065a&sorting%5Bdata%5D%5Battributes%5D%5Btype%5D=categories&sorting%5Bdata%5D%5Btype%5D=sorting",
    "first": "api/boomerang/sortings?data%5Battributes%5D%5Bids%5D%5B%5D=cd2c46b2-3546-47b2-81be-d2deae2a216e&data%5Battributes%5D%5Bids%5D%5B%5D=9eced8c9-6cf9-4826-ab0e-a7e3cbc40413&data%5Battributes%5D%5Bids%5D%5B%5D=08588a38-575a-4ed2-9e1b-4a092a6dfbc7&data%5Battributes%5D%5Bids%5D%5B%5D=bd208643-3770-4f9e-b72f-c70916f766e6&data%5Battributes%5D%5Bids%5D%5B%5D=f42b67c7-42e5-4775-891d-5189ddea065a&data%5Battributes%5D%5Btype%5D=categories&data%5Btype%5D=sorting&page%5Bnumber%5D=1&page%5Bsize%5D=25&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=cd2c46b2-3546-47b2-81be-d2deae2a216e&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=9eced8c9-6cf9-4826-ab0e-a7e3cbc40413&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=08588a38-575a-4ed2-9e1b-4a092a6dfbc7&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=bd208643-3770-4f9e-b72f-c70916f766e6&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=f42b67c7-42e5-4775-891d-5189ddea065a&sorting%5Bdata%5D%5Battributes%5D%5Btype%5D=categories&sorting%5Bdata%5D%5Btype%5D=sorting",
    "last": "api/boomerang/sortings?data%5Battributes%5D%5Bids%5D%5B%5D=cd2c46b2-3546-47b2-81be-d2deae2a216e&data%5Battributes%5D%5Bids%5D%5B%5D=9eced8c9-6cf9-4826-ab0e-a7e3cbc40413&data%5Battributes%5D%5Bids%5D%5B%5D=08588a38-575a-4ed2-9e1b-4a092a6dfbc7&data%5Battributes%5D%5Bids%5D%5B%5D=bd208643-3770-4f9e-b72f-c70916f766e6&data%5Battributes%5D%5Bids%5D%5B%5D=f42b67c7-42e5-4775-891d-5189ddea065a&data%5Battributes%5D%5Btype%5D=categories&data%5Btype%5D=sorting&page%5Bnumber%5D=&page%5Bsize%5D=25&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=cd2c46b2-3546-47b2-81be-d2deae2a216e&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=9eced8c9-6cf9-4826-ab0e-a7e3cbc40413&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=08588a38-575a-4ed2-9e1b-4a092a6dfbc7&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=bd208643-3770-4f9e-b72f-c70916f766e6&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=f42b67c7-42e5-4775-891d-5189ddea065a&sorting%5Bdata%5D%5Battributes%5D%5Btype%5D=categories&sorting%5Bdata%5D%5Btype%5D=sorting",
    "next": "api/boomerang/sortings?data%5Battributes%5D%5Bids%5D%5B%5D=cd2c46b2-3546-47b2-81be-d2deae2a216e&data%5Battributes%5D%5Bids%5D%5B%5D=9eced8c9-6cf9-4826-ab0e-a7e3cbc40413&data%5Battributes%5D%5Bids%5D%5B%5D=08588a38-575a-4ed2-9e1b-4a092a6dfbc7&data%5Battributes%5D%5Bids%5D%5B%5D=bd208643-3770-4f9e-b72f-c70916f766e6&data%5Battributes%5D%5Bids%5D%5B%5D=f42b67c7-42e5-4775-891d-5189ddea065a&data%5Battributes%5D%5Btype%5D=categories&data%5Btype%5D=sorting&page%5Bnumber%5D=2&page%5Bsize%5D=25&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=cd2c46b2-3546-47b2-81be-d2deae2a216e&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=9eced8c9-6cf9-4826-ab0e-a7e3cbc40413&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=08588a38-575a-4ed2-9e1b-4a092a6dfbc7&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=bd208643-3770-4f9e-b72f-c70916f766e6&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=f42b67c7-42e5-4775-891d-5189ddea065a&sorting%5Bdata%5D%5Battributes%5D%5Btype%5D=categories&sorting%5Bdata%5D%5Btype%5D=sorting"
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