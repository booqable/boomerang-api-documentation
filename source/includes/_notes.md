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
      "id": "1556d929-8edc-4951-9486-b9b9101c6dfe",
      "type": "notes",
      "attributes": {
        "created_at": "2024-07-22T09:26:16.047792+00:00",
        "updated_at": "2024-07-22T09:26:16.047792+00:00",
        "body": "Agreed to give this customer a 20% discount on the next order",
        "owner_id": "b527d123-ff4f-4a58-9942-f62d860809a4",
        "owner_type": "customers",
        "employee_id": "5c2a5e20-aa69-41e2-a0c2-5bf1eda4e325"
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
    --url 'https://example.booqable.com/api/boomerang/notes/8a8e88a8-26cb-47e5-af9b-e87bc29ce0eb' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "8a8e88a8-26cb-47e5-af9b-e87bc29ce0eb",
    "type": "notes",
    "attributes": {
      "created_at": "2024-07-22T09:26:14.677971+00:00",
      "updated_at": "2024-07-22T09:26:14.677971+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "a6c7cab8-1ed5-44af-92b5-542673a3d316",
      "owner_type": "customers",
      "employee_id": "a8aa6871-647b-41fb-95d0-0f297d768fab"
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
          "owner_id": "33d6f98a-f1ae-4e56-ab5a-f047efcce238",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "7723ed92-22e9-4ec2-94e4-a46896f1e8e5",
    "type": "notes",
    "attributes": {
      "created_at": "2024-07-22T09:26:15.357769+00:00",
      "updated_at": "2024-07-22T09:26:15.357769+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "33d6f98a-f1ae-4e56-ab5a-f047efcce238",
      "owner_type": "customers",
      "employee_id": "42912082-709d-4afd-afd7-137907ab94a2"
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
    --url 'https://example.booqable.com/api/boomerang/notes/6a7c7aea-ea86-4fe7-8b10-3ae5713edeb8' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "6a7c7aea-ea86-4fe7-8b10-3ae5713edeb8",
    "type": "notes",
    "attributes": {
      "created_at": "2024-07-22T09:26:14.003395+00:00",
      "updated_at": "2024-07-22T09:26:14.003395+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "eaabf0ed-cdfb-455f-875b-cc078b59708d",
      "owner_type": "customers",
      "employee_id": "3cc81d48-0afe-456a-a219-4f82d1ea5750"
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





