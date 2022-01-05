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
            "27f2ae09-54bb-49f5-a15c-8f4b9c9b8f78",
            "217624c6-6e46-429b-95fd-e632eede05a0",
            "00295240-6fbb-445a-a115-e01b07755c57",
            "c390b03b-a0c2-4439-b9d1-363558a5bd4a",
            "6dba8526-a8aa-46a9-8efb-63ab8dabb86b"
          ]
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "86e97bdf-74bf-52f4-9a40-c94e8ec19aec",
    "type": "sortings"
  },
  "links": {
    "self": "api/boomerang/sortings?data%5Battributes%5D%5Bids%5D%5B%5D=27f2ae09-54bb-49f5-a15c-8f4b9c9b8f78&data%5Battributes%5D%5Bids%5D%5B%5D=217624c6-6e46-429b-95fd-e632eede05a0&data%5Battributes%5D%5Bids%5D%5B%5D=00295240-6fbb-445a-a115-e01b07755c57&data%5Battributes%5D%5Bids%5D%5B%5D=c390b03b-a0c2-4439-b9d1-363558a5bd4a&data%5Battributes%5D%5Bids%5D%5B%5D=6dba8526-a8aa-46a9-8efb-63ab8dabb86b&data%5Battributes%5D%5Btype%5D=categories&data%5Btype%5D=sorting&page%5Bnumber%5D=1&page%5Bsize%5D=25&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=27f2ae09-54bb-49f5-a15c-8f4b9c9b8f78&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=217624c6-6e46-429b-95fd-e632eede05a0&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=00295240-6fbb-445a-a115-e01b07755c57&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=c390b03b-a0c2-4439-b9d1-363558a5bd4a&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=6dba8526-a8aa-46a9-8efb-63ab8dabb86b&sorting%5Bdata%5D%5Battributes%5D%5Btype%5D=categories&sorting%5Bdata%5D%5Btype%5D=sorting",
    "first": "api/boomerang/sortings?data%5Battributes%5D%5Bids%5D%5B%5D=27f2ae09-54bb-49f5-a15c-8f4b9c9b8f78&data%5Battributes%5D%5Bids%5D%5B%5D=217624c6-6e46-429b-95fd-e632eede05a0&data%5Battributes%5D%5Bids%5D%5B%5D=00295240-6fbb-445a-a115-e01b07755c57&data%5Battributes%5D%5Bids%5D%5B%5D=c390b03b-a0c2-4439-b9d1-363558a5bd4a&data%5Battributes%5D%5Bids%5D%5B%5D=6dba8526-a8aa-46a9-8efb-63ab8dabb86b&data%5Battributes%5D%5Btype%5D=categories&data%5Btype%5D=sorting&page%5Bnumber%5D=1&page%5Bsize%5D=25&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=27f2ae09-54bb-49f5-a15c-8f4b9c9b8f78&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=217624c6-6e46-429b-95fd-e632eede05a0&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=00295240-6fbb-445a-a115-e01b07755c57&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=c390b03b-a0c2-4439-b9d1-363558a5bd4a&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=6dba8526-a8aa-46a9-8efb-63ab8dabb86b&sorting%5Bdata%5D%5Battributes%5D%5Btype%5D=categories&sorting%5Bdata%5D%5Btype%5D=sorting",
    "last": "api/boomerang/sortings?data%5Battributes%5D%5Bids%5D%5B%5D=27f2ae09-54bb-49f5-a15c-8f4b9c9b8f78&data%5Battributes%5D%5Bids%5D%5B%5D=217624c6-6e46-429b-95fd-e632eede05a0&data%5Battributes%5D%5Bids%5D%5B%5D=00295240-6fbb-445a-a115-e01b07755c57&data%5Battributes%5D%5Bids%5D%5B%5D=c390b03b-a0c2-4439-b9d1-363558a5bd4a&data%5Battributes%5D%5Bids%5D%5B%5D=6dba8526-a8aa-46a9-8efb-63ab8dabb86b&data%5Battributes%5D%5Btype%5D=categories&data%5Btype%5D=sorting&page%5Bnumber%5D=&page%5Bsize%5D=25&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=27f2ae09-54bb-49f5-a15c-8f4b9c9b8f78&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=217624c6-6e46-429b-95fd-e632eede05a0&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=00295240-6fbb-445a-a115-e01b07755c57&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=c390b03b-a0c2-4439-b9d1-363558a5bd4a&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=6dba8526-a8aa-46a9-8efb-63ab8dabb86b&sorting%5Bdata%5D%5Battributes%5D%5Btype%5D=categories&sorting%5Bdata%5D%5Btype%5D=sorting",
    "next": "api/boomerang/sortings?data%5Battributes%5D%5Bids%5D%5B%5D=27f2ae09-54bb-49f5-a15c-8f4b9c9b8f78&data%5Battributes%5D%5Bids%5D%5B%5D=217624c6-6e46-429b-95fd-e632eede05a0&data%5Battributes%5D%5Bids%5D%5B%5D=00295240-6fbb-445a-a115-e01b07755c57&data%5Battributes%5D%5Bids%5D%5B%5D=c390b03b-a0c2-4439-b9d1-363558a5bd4a&data%5Battributes%5D%5Bids%5D%5B%5D=6dba8526-a8aa-46a9-8efb-63ab8dabb86b&data%5Battributes%5D%5Btype%5D=categories&data%5Btype%5D=sorting&page%5Bnumber%5D=2&page%5Bsize%5D=25&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=27f2ae09-54bb-49f5-a15c-8f4b9c9b8f78&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=217624c6-6e46-429b-95fd-e632eede05a0&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=00295240-6fbb-445a-a115-e01b07755c57&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=c390b03b-a0c2-4439-b9d1-363558a5bd4a&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=6dba8526-a8aa-46a9-8efb-63ab8dabb86b&sorting%5Bdata%5D%5Battributes%5D%5Btype%5D=categories&sorting%5Bdata%5D%5Btype%5D=sorting"
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