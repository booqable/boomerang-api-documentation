# Sortings

A convenient way to bulk update positions for supported resources.

## Fields

 Name | Description
-- | --
`id` | **uuid** `readonly`<br>Primary key.
`ids` | **array[string]** `writeonly`<br>Array of ids, positions are determined by the order of the array.
`type` | **enum** `writeonly`<br>Type of resource to update.<br>One of: `bundle_items`, `default_properties`, `lines`, `photos`, `properties`, `tax_rates`, `collection_items`, `products`.


## Sort resources


> How to update ordering of lines on an order:

```shell
  curl --request POST
       --url 'https://example.booqable.com/api/boomerang/sortings'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "type": "sorting",
           "attributes": {
             "type": "lines",
             "ids": [
               "dd7704d6-92af-433f-8307-1580c222b45b",
               "f07a772a-99b8-42a9-80cf-ae5f022c3a88",
               "0b8285b3-8cc6-4091-8484-0ae26045348e"
             ]
           }
         }
       }'
```

> A 201 status response looks like this:

```json
  {
    "data": {
      "id": "c9141d6a-4138-42f9-8b9b-ec969ca14eb7",
      "type": "sortings"
    },
    "meta": {}
  }
```

> How to update the order in which default properties are displayed:

```shell
  curl --request POST
       --url 'https://example.booqable.com/api/boomerang/sortings'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "type": "sorting",
           "attributes": {
             "type": "default_properties",
             "ids": [
               "b4bc1f68-037d-4910-8c66-87497dd24491",
               "0bd669a0-51bf-4493-8ce1-22c9ca11fce7",
               "e54e6ae1-8288-4ffd-8e7a-f3450abfc7ba",
               "41c3e709-3062-4040-8862-3f5c87890671",
               "2033f2d9-8300-4554-8070-08271971674b"
             ]
           }
         }
       }'
```

> A 201 status response looks like this:

```json
  {
    "data": {
      "id": "09ef6bf7-74e3-4276-8064-c916d9e88fac",
      "type": "sortings"
    },
    "meta": {}
  }
```

### HTTP Request

`POST /api/boomerang/sortings`

### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][ids]` | **array[string]** <br>Array of ids, positions are determined by the order of the array.
`data[attributes][type]` | **enum** <br>Type of resource to update.<br>One of: `bundle_items`, `default_properties`, `lines`, `photos`, `properties`, `tax_rates`, `collection_items`, `products`.


### Includes

This request does not accept any includes