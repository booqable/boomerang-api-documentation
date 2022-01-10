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
            "356d677d-44f1-4382-a773-b8ad562da7c2",
            "b38f3bda-09f2-4128-877c-2768d71a29ad",
            "4d51e8a0-d813-4e5d-a9eb-9fb47bb0590c",
            "908658fa-e05f-4fde-9ffa-ff7de86b9d3b",
            "e4317b53-643b-450e-a40e-383f9c280f43"
          ]
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "7c01b5e6-a164-5c10-b52f-f18aa35d79da",
    "type": "sortings"
  },
  "links": {
    "self": "api/boomerang/sortings?data%5Battributes%5D%5Bids%5D%5B%5D=356d677d-44f1-4382-a773-b8ad562da7c2&data%5Battributes%5D%5Bids%5D%5B%5D=b38f3bda-09f2-4128-877c-2768d71a29ad&data%5Battributes%5D%5Bids%5D%5B%5D=4d51e8a0-d813-4e5d-a9eb-9fb47bb0590c&data%5Battributes%5D%5Bids%5D%5B%5D=908658fa-e05f-4fde-9ffa-ff7de86b9d3b&data%5Battributes%5D%5Bids%5D%5B%5D=e4317b53-643b-450e-a40e-383f9c280f43&data%5Battributes%5D%5Btype%5D=categories&data%5Btype%5D=sorting&page%5Bnumber%5D=1&page%5Bsize%5D=25&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=356d677d-44f1-4382-a773-b8ad562da7c2&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=b38f3bda-09f2-4128-877c-2768d71a29ad&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=4d51e8a0-d813-4e5d-a9eb-9fb47bb0590c&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=908658fa-e05f-4fde-9ffa-ff7de86b9d3b&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=e4317b53-643b-450e-a40e-383f9c280f43&sorting%5Bdata%5D%5Battributes%5D%5Btype%5D=categories&sorting%5Bdata%5D%5Btype%5D=sorting",
    "first": "api/boomerang/sortings?data%5Battributes%5D%5Bids%5D%5B%5D=356d677d-44f1-4382-a773-b8ad562da7c2&data%5Battributes%5D%5Bids%5D%5B%5D=b38f3bda-09f2-4128-877c-2768d71a29ad&data%5Battributes%5D%5Bids%5D%5B%5D=4d51e8a0-d813-4e5d-a9eb-9fb47bb0590c&data%5Battributes%5D%5Bids%5D%5B%5D=908658fa-e05f-4fde-9ffa-ff7de86b9d3b&data%5Battributes%5D%5Bids%5D%5B%5D=e4317b53-643b-450e-a40e-383f9c280f43&data%5Battributes%5D%5Btype%5D=categories&data%5Btype%5D=sorting&page%5Bnumber%5D=1&page%5Bsize%5D=25&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=356d677d-44f1-4382-a773-b8ad562da7c2&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=b38f3bda-09f2-4128-877c-2768d71a29ad&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=4d51e8a0-d813-4e5d-a9eb-9fb47bb0590c&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=908658fa-e05f-4fde-9ffa-ff7de86b9d3b&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=e4317b53-643b-450e-a40e-383f9c280f43&sorting%5Bdata%5D%5Battributes%5D%5Btype%5D=categories&sorting%5Bdata%5D%5Btype%5D=sorting",
    "last": "api/boomerang/sortings?data%5Battributes%5D%5Bids%5D%5B%5D=356d677d-44f1-4382-a773-b8ad562da7c2&data%5Battributes%5D%5Bids%5D%5B%5D=b38f3bda-09f2-4128-877c-2768d71a29ad&data%5Battributes%5D%5Bids%5D%5B%5D=4d51e8a0-d813-4e5d-a9eb-9fb47bb0590c&data%5Battributes%5D%5Bids%5D%5B%5D=908658fa-e05f-4fde-9ffa-ff7de86b9d3b&data%5Battributes%5D%5Bids%5D%5B%5D=e4317b53-643b-450e-a40e-383f9c280f43&data%5Battributes%5D%5Btype%5D=categories&data%5Btype%5D=sorting&page%5Bnumber%5D=&page%5Bsize%5D=25&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=356d677d-44f1-4382-a773-b8ad562da7c2&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=b38f3bda-09f2-4128-877c-2768d71a29ad&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=4d51e8a0-d813-4e5d-a9eb-9fb47bb0590c&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=908658fa-e05f-4fde-9ffa-ff7de86b9d3b&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=e4317b53-643b-450e-a40e-383f9c280f43&sorting%5Bdata%5D%5Battributes%5D%5Btype%5D=categories&sorting%5Bdata%5D%5Btype%5D=sorting",
    "next": "api/boomerang/sortings?data%5Battributes%5D%5Bids%5D%5B%5D=356d677d-44f1-4382-a773-b8ad562da7c2&data%5Battributes%5D%5Bids%5D%5B%5D=b38f3bda-09f2-4128-877c-2768d71a29ad&data%5Battributes%5D%5Bids%5D%5B%5D=4d51e8a0-d813-4e5d-a9eb-9fb47bb0590c&data%5Battributes%5D%5Bids%5D%5B%5D=908658fa-e05f-4fde-9ffa-ff7de86b9d3b&data%5Battributes%5D%5Bids%5D%5B%5D=e4317b53-643b-450e-a40e-383f9c280f43&data%5Battributes%5D%5Btype%5D=categories&data%5Btype%5D=sorting&page%5Bnumber%5D=2&page%5Bsize%5D=25&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=356d677d-44f1-4382-a773-b8ad562da7c2&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=b38f3bda-09f2-4128-877c-2768d71a29ad&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=4d51e8a0-d813-4e5d-a9eb-9fb47bb0590c&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=908658fa-e05f-4fde-9ffa-ff7de86b9d3b&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=e4317b53-643b-450e-a40e-383f9c280f43&sorting%5Bdata%5D%5Battributes%5D%5Btype%5D=categories&sorting%5Bdata%5D%5Btype%5D=sorting"
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