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
            "33189212-c458-4ba1-8332-d0e348f7d3e5",
            "501c1789-7c71-4c21-8d11-31f6e5f53320",
            "3b7d41fe-359e-416d-b4a1-40b08a229fc0",
            "5d77187b-fc0c-4bda-bf6b-dda48bc6c834",
            "449f372a-6189-4cb3-8c4c-e020fab38e13"
          ]
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "9248de14-0d69-513e-af4f-8399c0205b13",
    "type": "sortings"
  },
  "links": {
    "self": "api/boomerang/sortings?data%5Battributes%5D%5Bids%5D%5B%5D=33189212-c458-4ba1-8332-d0e348f7d3e5&data%5Battributes%5D%5Bids%5D%5B%5D=501c1789-7c71-4c21-8d11-31f6e5f53320&data%5Battributes%5D%5Bids%5D%5B%5D=3b7d41fe-359e-416d-b4a1-40b08a229fc0&data%5Battributes%5D%5Bids%5D%5B%5D=5d77187b-fc0c-4bda-bf6b-dda48bc6c834&data%5Battributes%5D%5Bids%5D%5B%5D=449f372a-6189-4cb3-8c4c-e020fab38e13&data%5Battributes%5D%5Btype%5D=categories&data%5Btype%5D=sorting&page%5Bnumber%5D=1&page%5Bsize%5D=25&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=33189212-c458-4ba1-8332-d0e348f7d3e5&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=501c1789-7c71-4c21-8d11-31f6e5f53320&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=3b7d41fe-359e-416d-b4a1-40b08a229fc0&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=5d77187b-fc0c-4bda-bf6b-dda48bc6c834&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=449f372a-6189-4cb3-8c4c-e020fab38e13&sorting%5Bdata%5D%5Battributes%5D%5Btype%5D=categories&sorting%5Bdata%5D%5Btype%5D=sorting",
    "first": "api/boomerang/sortings?data%5Battributes%5D%5Bids%5D%5B%5D=33189212-c458-4ba1-8332-d0e348f7d3e5&data%5Battributes%5D%5Bids%5D%5B%5D=501c1789-7c71-4c21-8d11-31f6e5f53320&data%5Battributes%5D%5Bids%5D%5B%5D=3b7d41fe-359e-416d-b4a1-40b08a229fc0&data%5Battributes%5D%5Bids%5D%5B%5D=5d77187b-fc0c-4bda-bf6b-dda48bc6c834&data%5Battributes%5D%5Bids%5D%5B%5D=449f372a-6189-4cb3-8c4c-e020fab38e13&data%5Battributes%5D%5Btype%5D=categories&data%5Btype%5D=sorting&page%5Bnumber%5D=1&page%5Bsize%5D=25&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=33189212-c458-4ba1-8332-d0e348f7d3e5&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=501c1789-7c71-4c21-8d11-31f6e5f53320&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=3b7d41fe-359e-416d-b4a1-40b08a229fc0&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=5d77187b-fc0c-4bda-bf6b-dda48bc6c834&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=449f372a-6189-4cb3-8c4c-e020fab38e13&sorting%5Bdata%5D%5Battributes%5D%5Btype%5D=categories&sorting%5Bdata%5D%5Btype%5D=sorting",
    "last": "api/boomerang/sortings?data%5Battributes%5D%5Bids%5D%5B%5D=33189212-c458-4ba1-8332-d0e348f7d3e5&data%5Battributes%5D%5Bids%5D%5B%5D=501c1789-7c71-4c21-8d11-31f6e5f53320&data%5Battributes%5D%5Bids%5D%5B%5D=3b7d41fe-359e-416d-b4a1-40b08a229fc0&data%5Battributes%5D%5Bids%5D%5B%5D=5d77187b-fc0c-4bda-bf6b-dda48bc6c834&data%5Battributes%5D%5Bids%5D%5B%5D=449f372a-6189-4cb3-8c4c-e020fab38e13&data%5Battributes%5D%5Btype%5D=categories&data%5Btype%5D=sorting&page%5Bnumber%5D=&page%5Bsize%5D=25&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=33189212-c458-4ba1-8332-d0e348f7d3e5&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=501c1789-7c71-4c21-8d11-31f6e5f53320&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=3b7d41fe-359e-416d-b4a1-40b08a229fc0&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=5d77187b-fc0c-4bda-bf6b-dda48bc6c834&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=449f372a-6189-4cb3-8c4c-e020fab38e13&sorting%5Bdata%5D%5Battributes%5D%5Btype%5D=categories&sorting%5Bdata%5D%5Btype%5D=sorting",
    "next": "api/boomerang/sortings?data%5Battributes%5D%5Bids%5D%5B%5D=33189212-c458-4ba1-8332-d0e348f7d3e5&data%5Battributes%5D%5Bids%5D%5B%5D=501c1789-7c71-4c21-8d11-31f6e5f53320&data%5Battributes%5D%5Bids%5D%5B%5D=3b7d41fe-359e-416d-b4a1-40b08a229fc0&data%5Battributes%5D%5Bids%5D%5B%5D=5d77187b-fc0c-4bda-bf6b-dda48bc6c834&data%5Battributes%5D%5Bids%5D%5B%5D=449f372a-6189-4cb3-8c4c-e020fab38e13&data%5Battributes%5D%5Btype%5D=categories&data%5Btype%5D=sorting&page%5Bnumber%5D=2&page%5Bsize%5D=25&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=33189212-c458-4ba1-8332-d0e348f7d3e5&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=501c1789-7c71-4c21-8d11-31f6e5f53320&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=3b7d41fe-359e-416d-b4a1-40b08a229fc0&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=5d77187b-fc0c-4bda-bf6b-dda48bc6c834&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=449f372a-6189-4cb3-8c4c-e020fab38e13&sorting%5Bdata%5D%5Battributes%5D%5Btype%5D=categories&sorting%5Bdata%5D%5Btype%5D=sorting"
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