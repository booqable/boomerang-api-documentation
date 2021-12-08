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
            "2a3d41ba-755e-4b02-ae17-0d8dbafbbdc7",
            "4e3bf812-ca3a-43d6-bc01-02eb47c454cc",
            "06cf13f7-9418-42ee-af63-9133767a36cd",
            "0829d848-f3c8-4d13-b7a0-ae2ddf7fe645",
            "9d51d74e-3dba-4951-923a-063e9f919315"
          ]
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "e8c4683c-714a-5719-8ce0-0c9f35710640",
    "type": "sortings"
  },
  "links": {
    "self": "api/boomerang/sortings?data%5Battributes%5D%5Bids%5D%5B%5D=2a3d41ba-755e-4b02-ae17-0d8dbafbbdc7&data%5Battributes%5D%5Bids%5D%5B%5D=4e3bf812-ca3a-43d6-bc01-02eb47c454cc&data%5Battributes%5D%5Bids%5D%5B%5D=06cf13f7-9418-42ee-af63-9133767a36cd&data%5Battributes%5D%5Bids%5D%5B%5D=0829d848-f3c8-4d13-b7a0-ae2ddf7fe645&data%5Battributes%5D%5Bids%5D%5B%5D=9d51d74e-3dba-4951-923a-063e9f919315&data%5Battributes%5D%5Btype%5D=categories&data%5Btype%5D=sorting&page%5Bnumber%5D=1&page%5Bsize%5D=25&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=2a3d41ba-755e-4b02-ae17-0d8dbafbbdc7&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=4e3bf812-ca3a-43d6-bc01-02eb47c454cc&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=06cf13f7-9418-42ee-af63-9133767a36cd&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=0829d848-f3c8-4d13-b7a0-ae2ddf7fe645&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=9d51d74e-3dba-4951-923a-063e9f919315&sorting%5Bdata%5D%5Battributes%5D%5Btype%5D=categories&sorting%5Bdata%5D%5Btype%5D=sorting",
    "first": "api/boomerang/sortings?data%5Battributes%5D%5Bids%5D%5B%5D=2a3d41ba-755e-4b02-ae17-0d8dbafbbdc7&data%5Battributes%5D%5Bids%5D%5B%5D=4e3bf812-ca3a-43d6-bc01-02eb47c454cc&data%5Battributes%5D%5Bids%5D%5B%5D=06cf13f7-9418-42ee-af63-9133767a36cd&data%5Battributes%5D%5Bids%5D%5B%5D=0829d848-f3c8-4d13-b7a0-ae2ddf7fe645&data%5Battributes%5D%5Bids%5D%5B%5D=9d51d74e-3dba-4951-923a-063e9f919315&data%5Battributes%5D%5Btype%5D=categories&data%5Btype%5D=sorting&page%5Bnumber%5D=1&page%5Bsize%5D=25&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=2a3d41ba-755e-4b02-ae17-0d8dbafbbdc7&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=4e3bf812-ca3a-43d6-bc01-02eb47c454cc&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=06cf13f7-9418-42ee-af63-9133767a36cd&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=0829d848-f3c8-4d13-b7a0-ae2ddf7fe645&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=9d51d74e-3dba-4951-923a-063e9f919315&sorting%5Bdata%5D%5Battributes%5D%5Btype%5D=categories&sorting%5Bdata%5D%5Btype%5D=sorting",
    "last": "api/boomerang/sortings?data%5Battributes%5D%5Bids%5D%5B%5D=2a3d41ba-755e-4b02-ae17-0d8dbafbbdc7&data%5Battributes%5D%5Bids%5D%5B%5D=4e3bf812-ca3a-43d6-bc01-02eb47c454cc&data%5Battributes%5D%5Bids%5D%5B%5D=06cf13f7-9418-42ee-af63-9133767a36cd&data%5Battributes%5D%5Bids%5D%5B%5D=0829d848-f3c8-4d13-b7a0-ae2ddf7fe645&data%5Battributes%5D%5Bids%5D%5B%5D=9d51d74e-3dba-4951-923a-063e9f919315&data%5Battributes%5D%5Btype%5D=categories&data%5Btype%5D=sorting&page%5Bnumber%5D=&page%5Bsize%5D=25&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=2a3d41ba-755e-4b02-ae17-0d8dbafbbdc7&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=4e3bf812-ca3a-43d6-bc01-02eb47c454cc&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=06cf13f7-9418-42ee-af63-9133767a36cd&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=0829d848-f3c8-4d13-b7a0-ae2ddf7fe645&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=9d51d74e-3dba-4951-923a-063e9f919315&sorting%5Bdata%5D%5Battributes%5D%5Btype%5D=categories&sorting%5Bdata%5D%5Btype%5D=sorting",
    "next": "api/boomerang/sortings?data%5Battributes%5D%5Bids%5D%5B%5D=2a3d41ba-755e-4b02-ae17-0d8dbafbbdc7&data%5Battributes%5D%5Bids%5D%5B%5D=4e3bf812-ca3a-43d6-bc01-02eb47c454cc&data%5Battributes%5D%5Bids%5D%5B%5D=06cf13f7-9418-42ee-af63-9133767a36cd&data%5Battributes%5D%5Bids%5D%5B%5D=0829d848-f3c8-4d13-b7a0-ae2ddf7fe645&data%5Battributes%5D%5Bids%5D%5B%5D=9d51d74e-3dba-4951-923a-063e9f919315&data%5Battributes%5D%5Btype%5D=categories&data%5Btype%5D=sorting&page%5Bnumber%5D=2&page%5Bsize%5D=25&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=2a3d41ba-755e-4b02-ae17-0d8dbafbbdc7&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=4e3bf812-ca3a-43d6-bc01-02eb47c454cc&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=06cf13f7-9418-42ee-af63-9133767a36cd&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=0829d848-f3c8-4d13-b7a0-ae2ddf7fe645&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=9d51d74e-3dba-4951-923a-063e9f919315&sorting%5Bdata%5D%5Battributes%5D%5Btype%5D=categories&sorting%5Bdata%5D%5Btype%5D=sorting"
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