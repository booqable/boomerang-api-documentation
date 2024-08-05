# Notes

Allows you to leave notes attached to other resources.

## Endpoints
`GET /api/boomerang/notes`

`GET /api/boomerang/notes/{id}`

`POST /api/boomerang/notes`

`DELETE /api/boomerang/notes/{id}`

## Fields
Every note has the following fields:

Name | Description
-- | --
`id` | **Uuid** `readonly`<br>Primary key
`created_at` | **Datetime** `readonly`<br>When the resource was created
`updated_at` | **Datetime** `readonly`<br>When the resource was last updated
`body` | **String** <br>The content of the note
`owner_id` | **Uuid** <br>ID of the resource the note is attached to
`owner_type` | **String** <br>The resource type of the owner. One of `orders`, `documents`, `product_groups`, `bundles`, `products`, `customers`, `stock_items`, `users`
`employee_id` | **Uuid** `readonly`<br>The associated Employee


## Relationships
Notes have the following relationships:

Name | Description
-- | --
`owner` | **Customer, Product, Product group, Stock item, Bundle, Order, Document**<br>Associated Owner
`employee` | **Employees** `readonly`<br>Associated Employee


## Listing notes



> How to fetch a list of notes:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/notes' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "cd1656e4-0ae4-4584-bc9d-5256b04d68b0",
      "type": "notes",
      "attributes": {
        "created_at": "2024-08-05T09:25:26.191154+00:00",
        "updated_at": "2024-08-05T09:25:26.191154+00:00",
        "body": "Agreed to give this customer a 20% discount on the next order",
        "owner_id": "30b14257-c2d6-462b-b9ae-08b6d06ee23e",
        "owner_type": "customers",
        "employee_id": "c45fdab5-2b62-4c8b-aff6-20ec75a40b00"
      },
      "relationships": {}
    }
  ],
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/notes`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=employee,owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[notes]=created_at,updated_at,body`
`filter` | **Hash** <br>The filters to apply `?filter[attribute][eq]=value`
`sort` | **String** <br>How to sort the data `?sort=attribute1,-attribute2`
`meta` | **Hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String** <br>The page to request
`page[size]` | **String** <br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
-- | --
`id` | **Uuid** <br>`eq`, `not_eq`
`created_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`owner_id` | **Uuid** <br>`eq`, `not_eq`
`owner_type` | **String** <br>`eq`, `not_eq`
`employee_id` | **Uuid** <br>`eq`, `not_eq`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **Array** <br>`count`


### Includes

This request accepts the following includes:

`employee`


`owner`






## Fetching a note



> How to fetch a note:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/notes/bea85c83-5609-42f4-95d6-68dda35b0977' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "bea85c83-5609-42f4-95d6-68dda35b0977",
    "type": "notes",
    "attributes": {
      "created_at": "2024-08-05T09:25:25.235786+00:00",
      "updated_at": "2024-08-05T09:25:25.235786+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "37ffe054-69a6-4dd8-ae9c-03c04bd97c47",
      "owner_type": "customers",
      "employee_id": "fa2dcc2b-60d7-4d6a-b506-4b95138675b1"
    },
    "relationships": {}
  },
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/notes/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=employee,owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[notes]=created_at,updated_at,body`


### Includes

This request accepts the following includes:

`employee`


`owner`






## Creating a note



> How to create a note:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/notes' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "notes",
        "attributes": {
          "body": "Agreed to give this customer a 20% discount on the next order",
          "owner_id": "fac478c6-c3b2-4c26-b213-3c8a7d55f19a",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "94415458-2936-47f3-bfe3-acd174df2f26",
    "type": "notes",
    "attributes": {
      "created_at": "2024-08-05T09:25:24.398425+00:00",
      "updated_at": "2024-08-05T09:25:24.398425+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "fac478c6-c3b2-4c26-b213-3c8a7d55f19a",
      "owner_type": "customers",
      "employee_id": "28335878-5ba5-45cc-9350-b0c7219f3792"
    },
    "relationships": {}
  },
  "meta": {}
}
```

### HTTP Request

`POST /api/boomerang/notes`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=employee,owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[notes]=created_at,updated_at,body`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][body]` | **String** <br>The content of the note
`data[attributes][owner_id]` | **Uuid** <br>ID of the resource the note is attached to
`data[attributes][owner_type]` | **String** <br>The resource type of the owner. One of `orders`, `documents`, `product_groups`, `bundles`, `products`, `customers`, `stock_items`, `users`


### Includes

This request accepts the following includes:

`employee`


`owner`






## Deleting a note



> How to delete a note:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/notes/ae098e45-ed37-4094-80aa-4a5a0d15da07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "ae098e45-ed37-4094-80aa-4a5a0d15da07",
    "type": "notes",
    "attributes": {
      "created_at": "2024-08-05T09:25:23.703484+00:00",
      "updated_at": "2024-08-05T09:25:23.703484+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "7284ee36-8cdd-448c-b14b-08f72c0554a0",
      "owner_type": "customers",
      "employee_id": "9bd0a5ec-85fd-44c4-82fa-4caaf695f25d"
    },
    "relationships": {}
  },
  "meta": {}
}
```

### HTTP Request

`DELETE /api/boomerang/notes/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=employee,owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[notes]=created_at,updated_at,body`


### Includes

This request accepts the following includes:

`employee`


`owner`





