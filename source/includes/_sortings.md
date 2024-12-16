# Sortings

A convienient way to bulk update positions for supported resources.

## Fields

 Name | Description
-- | --
`id` | **uuid** `readonly`<br>Primary key.
`ids` | **array[string]** `writeonly`<br>Array of ids, positions are determined by the order of the array.
`type` | **enum** `writeonly`<br>Type of resource to update.<br>One of: `bundle_items`, `default_properties`, `lines`, `photos`, `properties`, `tax_rates`, `collection_items`, `products`.


## Sorting a resource


> How to update positions:

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
               "92950914-7942-4ac7-83fd-60fcc23ca62c",
               "0a54d6ed-02ea-4119-8d81-e4224c738b6d",
               "7fa7f4d7-2ac5-4a46-8d3c-f38791ce0c37",
               "388cf5f9-972d-43bf-872d-d4a4fdde8388",
               "c25ec89c-dd19-40c8-828b-b5b8e205adf2"
             ]
           }
         }
       }'
```

> A 201 status response looks like this:

```json
  {
    "data": {
      "id": "2ec8d847-5901-422b-8464-aab5bf268709",
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