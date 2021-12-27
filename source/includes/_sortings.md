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
            "59b70939-deb7-4620-ae39-f9dcb1497f16",
            "a5769ee9-901b-439a-ac31-9588e31d8d39",
            "a19d546a-900e-4a98-b0cf-e065fca04086",
            "ed1dc644-fd80-4cca-bd25-84321d0e234b",
            "2d8278db-037a-451a-b697-b750c502e132"
          ]
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "d04e556e-c6f8-574a-b7c5-e39f4bbd4bf8",
    "type": "sortings"
  },
  "links": {
    "self": "api/boomerang/sortings?data%5Battributes%5D%5Bids%5D%5B%5D=59b70939-deb7-4620-ae39-f9dcb1497f16&data%5Battributes%5D%5Bids%5D%5B%5D=a5769ee9-901b-439a-ac31-9588e31d8d39&data%5Battributes%5D%5Bids%5D%5B%5D=a19d546a-900e-4a98-b0cf-e065fca04086&data%5Battributes%5D%5Bids%5D%5B%5D=ed1dc644-fd80-4cca-bd25-84321d0e234b&data%5Battributes%5D%5Bids%5D%5B%5D=2d8278db-037a-451a-b697-b750c502e132&data%5Battributes%5D%5Btype%5D=categories&data%5Btype%5D=sorting&page%5Bnumber%5D=1&page%5Bsize%5D=25&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=59b70939-deb7-4620-ae39-f9dcb1497f16&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=a5769ee9-901b-439a-ac31-9588e31d8d39&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=a19d546a-900e-4a98-b0cf-e065fca04086&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=ed1dc644-fd80-4cca-bd25-84321d0e234b&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=2d8278db-037a-451a-b697-b750c502e132&sorting%5Bdata%5D%5Battributes%5D%5Btype%5D=categories&sorting%5Bdata%5D%5Btype%5D=sorting",
    "first": "api/boomerang/sortings?data%5Battributes%5D%5Bids%5D%5B%5D=59b70939-deb7-4620-ae39-f9dcb1497f16&data%5Battributes%5D%5Bids%5D%5B%5D=a5769ee9-901b-439a-ac31-9588e31d8d39&data%5Battributes%5D%5Bids%5D%5B%5D=a19d546a-900e-4a98-b0cf-e065fca04086&data%5Battributes%5D%5Bids%5D%5B%5D=ed1dc644-fd80-4cca-bd25-84321d0e234b&data%5Battributes%5D%5Bids%5D%5B%5D=2d8278db-037a-451a-b697-b750c502e132&data%5Battributes%5D%5Btype%5D=categories&data%5Btype%5D=sorting&page%5Bnumber%5D=1&page%5Bsize%5D=25&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=59b70939-deb7-4620-ae39-f9dcb1497f16&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=a5769ee9-901b-439a-ac31-9588e31d8d39&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=a19d546a-900e-4a98-b0cf-e065fca04086&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=ed1dc644-fd80-4cca-bd25-84321d0e234b&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=2d8278db-037a-451a-b697-b750c502e132&sorting%5Bdata%5D%5Battributes%5D%5Btype%5D=categories&sorting%5Bdata%5D%5Btype%5D=sorting",
    "last": "api/boomerang/sortings?data%5Battributes%5D%5Bids%5D%5B%5D=59b70939-deb7-4620-ae39-f9dcb1497f16&data%5Battributes%5D%5Bids%5D%5B%5D=a5769ee9-901b-439a-ac31-9588e31d8d39&data%5Battributes%5D%5Bids%5D%5B%5D=a19d546a-900e-4a98-b0cf-e065fca04086&data%5Battributes%5D%5Bids%5D%5B%5D=ed1dc644-fd80-4cca-bd25-84321d0e234b&data%5Battributes%5D%5Bids%5D%5B%5D=2d8278db-037a-451a-b697-b750c502e132&data%5Battributes%5D%5Btype%5D=categories&data%5Btype%5D=sorting&page%5Bnumber%5D=&page%5Bsize%5D=25&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=59b70939-deb7-4620-ae39-f9dcb1497f16&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=a5769ee9-901b-439a-ac31-9588e31d8d39&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=a19d546a-900e-4a98-b0cf-e065fca04086&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=ed1dc644-fd80-4cca-bd25-84321d0e234b&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=2d8278db-037a-451a-b697-b750c502e132&sorting%5Bdata%5D%5Battributes%5D%5Btype%5D=categories&sorting%5Bdata%5D%5Btype%5D=sorting",
    "next": "api/boomerang/sortings?data%5Battributes%5D%5Bids%5D%5B%5D=59b70939-deb7-4620-ae39-f9dcb1497f16&data%5Battributes%5D%5Bids%5D%5B%5D=a5769ee9-901b-439a-ac31-9588e31d8d39&data%5Battributes%5D%5Bids%5D%5B%5D=a19d546a-900e-4a98-b0cf-e065fca04086&data%5Battributes%5D%5Bids%5D%5B%5D=ed1dc644-fd80-4cca-bd25-84321d0e234b&data%5Battributes%5D%5Bids%5D%5B%5D=2d8278db-037a-451a-b697-b750c502e132&data%5Battributes%5D%5Btype%5D=categories&data%5Btype%5D=sorting&page%5Bnumber%5D=2&page%5Bsize%5D=25&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=59b70939-deb7-4620-ae39-f9dcb1497f16&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=a5769ee9-901b-439a-ac31-9588e31d8d39&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=a19d546a-900e-4a98-b0cf-e065fca04086&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=ed1dc644-fd80-4cca-bd25-84321d0e234b&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=2d8278db-037a-451a-b697-b750c502e132&sorting%5Bdata%5D%5Battributes%5D%5Btype%5D=categories&sorting%5Bdata%5D%5Btype%5D=sorting"
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