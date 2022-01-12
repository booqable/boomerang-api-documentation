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
            "6f92a4c3-52d5-4515-98ad-323fc6b80b12",
            "47778d2f-b730-4a1f-8d37-3e7aef362c93",
            "59623382-45de-46b9-8989-3a4c9b2b70c7",
            "8ddb5bf7-24b5-4ac2-8f80-63a462684003",
            "3b79c7f0-d2ca-4640-9ed5-74bdd4eff360"
          ]
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "2415245c-ba03-5ce3-bf08-17ccf336647c",
    "type": "sortings"
  },
  "links": {
    "self": "api/boomerang/sortings?data%5Battributes%5D%5Bids%5D%5B%5D=6f92a4c3-52d5-4515-98ad-323fc6b80b12&data%5Battributes%5D%5Bids%5D%5B%5D=47778d2f-b730-4a1f-8d37-3e7aef362c93&data%5Battributes%5D%5Bids%5D%5B%5D=59623382-45de-46b9-8989-3a4c9b2b70c7&data%5Battributes%5D%5Bids%5D%5B%5D=8ddb5bf7-24b5-4ac2-8f80-63a462684003&data%5Battributes%5D%5Bids%5D%5B%5D=3b79c7f0-d2ca-4640-9ed5-74bdd4eff360&data%5Battributes%5D%5Btype%5D=categories&data%5Btype%5D=sorting&page%5Bnumber%5D=1&page%5Bsize%5D=25&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=6f92a4c3-52d5-4515-98ad-323fc6b80b12&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=47778d2f-b730-4a1f-8d37-3e7aef362c93&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=59623382-45de-46b9-8989-3a4c9b2b70c7&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=8ddb5bf7-24b5-4ac2-8f80-63a462684003&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=3b79c7f0-d2ca-4640-9ed5-74bdd4eff360&sorting%5Bdata%5D%5Battributes%5D%5Btype%5D=categories&sorting%5Bdata%5D%5Btype%5D=sorting",
    "first": "api/boomerang/sortings?data%5Battributes%5D%5Bids%5D%5B%5D=6f92a4c3-52d5-4515-98ad-323fc6b80b12&data%5Battributes%5D%5Bids%5D%5B%5D=47778d2f-b730-4a1f-8d37-3e7aef362c93&data%5Battributes%5D%5Bids%5D%5B%5D=59623382-45de-46b9-8989-3a4c9b2b70c7&data%5Battributes%5D%5Bids%5D%5B%5D=8ddb5bf7-24b5-4ac2-8f80-63a462684003&data%5Battributes%5D%5Bids%5D%5B%5D=3b79c7f0-d2ca-4640-9ed5-74bdd4eff360&data%5Battributes%5D%5Btype%5D=categories&data%5Btype%5D=sorting&page%5Bnumber%5D=1&page%5Bsize%5D=25&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=6f92a4c3-52d5-4515-98ad-323fc6b80b12&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=47778d2f-b730-4a1f-8d37-3e7aef362c93&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=59623382-45de-46b9-8989-3a4c9b2b70c7&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=8ddb5bf7-24b5-4ac2-8f80-63a462684003&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=3b79c7f0-d2ca-4640-9ed5-74bdd4eff360&sorting%5Bdata%5D%5Battributes%5D%5Btype%5D=categories&sorting%5Bdata%5D%5Btype%5D=sorting",
    "last": "api/boomerang/sortings?data%5Battributes%5D%5Bids%5D%5B%5D=6f92a4c3-52d5-4515-98ad-323fc6b80b12&data%5Battributes%5D%5Bids%5D%5B%5D=47778d2f-b730-4a1f-8d37-3e7aef362c93&data%5Battributes%5D%5Bids%5D%5B%5D=59623382-45de-46b9-8989-3a4c9b2b70c7&data%5Battributes%5D%5Bids%5D%5B%5D=8ddb5bf7-24b5-4ac2-8f80-63a462684003&data%5Battributes%5D%5Bids%5D%5B%5D=3b79c7f0-d2ca-4640-9ed5-74bdd4eff360&data%5Battributes%5D%5Btype%5D=categories&data%5Btype%5D=sorting&page%5Bnumber%5D=&page%5Bsize%5D=25&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=6f92a4c3-52d5-4515-98ad-323fc6b80b12&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=47778d2f-b730-4a1f-8d37-3e7aef362c93&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=59623382-45de-46b9-8989-3a4c9b2b70c7&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=8ddb5bf7-24b5-4ac2-8f80-63a462684003&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=3b79c7f0-d2ca-4640-9ed5-74bdd4eff360&sorting%5Bdata%5D%5Battributes%5D%5Btype%5D=categories&sorting%5Bdata%5D%5Btype%5D=sorting",
    "next": "api/boomerang/sortings?data%5Battributes%5D%5Bids%5D%5B%5D=6f92a4c3-52d5-4515-98ad-323fc6b80b12&data%5Battributes%5D%5Bids%5D%5B%5D=47778d2f-b730-4a1f-8d37-3e7aef362c93&data%5Battributes%5D%5Bids%5D%5B%5D=59623382-45de-46b9-8989-3a4c9b2b70c7&data%5Battributes%5D%5Bids%5D%5B%5D=8ddb5bf7-24b5-4ac2-8f80-63a462684003&data%5Battributes%5D%5Bids%5D%5B%5D=3b79c7f0-d2ca-4640-9ed5-74bdd4eff360&data%5Battributes%5D%5Btype%5D=categories&data%5Btype%5D=sorting&page%5Bnumber%5D=2&page%5Bsize%5D=25&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=6f92a4c3-52d5-4515-98ad-323fc6b80b12&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=47778d2f-b730-4a1f-8d37-3e7aef362c93&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=59623382-45de-46b9-8989-3a4c9b2b70c7&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=8ddb5bf7-24b5-4ac2-8f80-63a462684003&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=3b79c7f0-d2ca-4640-9ed5-74bdd4eff360&sorting%5Bdata%5D%5Battributes%5D%5Btype%5D=categories&sorting%5Bdata%5D%5Btype%5D=sorting"
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