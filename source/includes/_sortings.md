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
            "ef74386a-d665-437e-913e-4a68653bd17b",
            "589c3b82-bf64-4cd4-869e-9e7a5272c083",
            "ade946ce-4b2f-47cd-89a4-50c5956ff1b6",
            "8d0b716b-2d1e-446e-88ff-bfe51eab938f",
            "85c08d69-8946-42eb-ac02-021d6caf59f3"
          ]
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "9c016235-d1ec-5132-aefb-8c17cc2340d5",
    "type": "sortings"
  },
  "links": {
    "self": "api/boomerang/sortings?data%5Battributes%5D%5Bids%5D%5B%5D=ef74386a-d665-437e-913e-4a68653bd17b&data%5Battributes%5D%5Bids%5D%5B%5D=589c3b82-bf64-4cd4-869e-9e7a5272c083&data%5Battributes%5D%5Bids%5D%5B%5D=ade946ce-4b2f-47cd-89a4-50c5956ff1b6&data%5Battributes%5D%5Bids%5D%5B%5D=8d0b716b-2d1e-446e-88ff-bfe51eab938f&data%5Battributes%5D%5Bids%5D%5B%5D=85c08d69-8946-42eb-ac02-021d6caf59f3&data%5Battributes%5D%5Btype%5D=categories&data%5Btype%5D=sorting&page%5Bnumber%5D=1&page%5Bsize%5D=25&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=ef74386a-d665-437e-913e-4a68653bd17b&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=589c3b82-bf64-4cd4-869e-9e7a5272c083&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=ade946ce-4b2f-47cd-89a4-50c5956ff1b6&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=8d0b716b-2d1e-446e-88ff-bfe51eab938f&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=85c08d69-8946-42eb-ac02-021d6caf59f3&sorting%5Bdata%5D%5Battributes%5D%5Btype%5D=categories&sorting%5Bdata%5D%5Btype%5D=sorting",
    "first": "api/boomerang/sortings?data%5Battributes%5D%5Bids%5D%5B%5D=ef74386a-d665-437e-913e-4a68653bd17b&data%5Battributes%5D%5Bids%5D%5B%5D=589c3b82-bf64-4cd4-869e-9e7a5272c083&data%5Battributes%5D%5Bids%5D%5B%5D=ade946ce-4b2f-47cd-89a4-50c5956ff1b6&data%5Battributes%5D%5Bids%5D%5B%5D=8d0b716b-2d1e-446e-88ff-bfe51eab938f&data%5Battributes%5D%5Bids%5D%5B%5D=85c08d69-8946-42eb-ac02-021d6caf59f3&data%5Battributes%5D%5Btype%5D=categories&data%5Btype%5D=sorting&page%5Bnumber%5D=1&page%5Bsize%5D=25&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=ef74386a-d665-437e-913e-4a68653bd17b&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=589c3b82-bf64-4cd4-869e-9e7a5272c083&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=ade946ce-4b2f-47cd-89a4-50c5956ff1b6&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=8d0b716b-2d1e-446e-88ff-bfe51eab938f&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=85c08d69-8946-42eb-ac02-021d6caf59f3&sorting%5Bdata%5D%5Battributes%5D%5Btype%5D=categories&sorting%5Bdata%5D%5Btype%5D=sorting",
    "last": "api/boomerang/sortings?data%5Battributes%5D%5Bids%5D%5B%5D=ef74386a-d665-437e-913e-4a68653bd17b&data%5Battributes%5D%5Bids%5D%5B%5D=589c3b82-bf64-4cd4-869e-9e7a5272c083&data%5Battributes%5D%5Bids%5D%5B%5D=ade946ce-4b2f-47cd-89a4-50c5956ff1b6&data%5Battributes%5D%5Bids%5D%5B%5D=8d0b716b-2d1e-446e-88ff-bfe51eab938f&data%5Battributes%5D%5Bids%5D%5B%5D=85c08d69-8946-42eb-ac02-021d6caf59f3&data%5Battributes%5D%5Btype%5D=categories&data%5Btype%5D=sorting&page%5Bnumber%5D=&page%5Bsize%5D=25&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=ef74386a-d665-437e-913e-4a68653bd17b&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=589c3b82-bf64-4cd4-869e-9e7a5272c083&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=ade946ce-4b2f-47cd-89a4-50c5956ff1b6&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=8d0b716b-2d1e-446e-88ff-bfe51eab938f&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=85c08d69-8946-42eb-ac02-021d6caf59f3&sorting%5Bdata%5D%5Battributes%5D%5Btype%5D=categories&sorting%5Bdata%5D%5Btype%5D=sorting",
    "next": "api/boomerang/sortings?data%5Battributes%5D%5Bids%5D%5B%5D=ef74386a-d665-437e-913e-4a68653bd17b&data%5Battributes%5D%5Bids%5D%5B%5D=589c3b82-bf64-4cd4-869e-9e7a5272c083&data%5Battributes%5D%5Bids%5D%5B%5D=ade946ce-4b2f-47cd-89a4-50c5956ff1b6&data%5Battributes%5D%5Bids%5D%5B%5D=8d0b716b-2d1e-446e-88ff-bfe51eab938f&data%5Battributes%5D%5Bids%5D%5B%5D=85c08d69-8946-42eb-ac02-021d6caf59f3&data%5Battributes%5D%5Btype%5D=categories&data%5Btype%5D=sorting&page%5Bnumber%5D=2&page%5Bsize%5D=25&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=ef74386a-d665-437e-913e-4a68653bd17b&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=589c3b82-bf64-4cd4-869e-9e7a5272c083&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=ade946ce-4b2f-47cd-89a4-50c5956ff1b6&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=8d0b716b-2d1e-446e-88ff-bfe51eab938f&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=85c08d69-8946-42eb-ac02-021d6caf59f3&sorting%5Bdata%5D%5Battributes%5D%5Btype%5D=categories&sorting%5Bdata%5D%5Btype%5D=sorting"
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