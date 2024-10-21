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
`employee` | **Employees** `readonly`<br>Associated Employee
`owner` | **Customer, Product, Product group, Stock item, Bundle, Order, Document, User** <br>Associated Owner


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
      "id": "4fdd89b0-157c-4c62-a8f7-cf6b6a442267",
      "type": "notes",
      "attributes": {
        "created_at": "2024-10-21T09:22:38.271432+00:00",
        "updated_at": "2024-10-21T09:22:38.271432+00:00",
        "body": "Agreed to give this customer a 20% discount on the next order",
        "owner_id": "d1179eff-3b01-4c76-990b-748e191da928",
        "owner_type": "customers",
        "employee_id": "0c42fbb6-f57a-4b68-afd9-fba2ab7f4965"
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
    --url 'https://example.booqable.com/api/boomerang/notes/01b8e3a0-3849-4857-887c-dc27bce20f46' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "01b8e3a0-3849-4857-887c-dc27bce20f46",
    "type": "notes",
    "attributes": {
      "created_at": "2024-10-21T09:22:39.874720+00:00",
      "updated_at": "2024-10-21T09:22:39.874720+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "5c918585-1106-4580-bae4-51c2951ee376",
      "owner_type": "customers",
      "employee_id": "9cb67102-649a-48df-b2b4-b63471da7557"
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
          "owner_id": "d1f4a484-99d9-4f0b-95e3-ec9f26193127",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "13cdb4be-e7e0-4343-a824-4b5cb052ef71",
    "type": "notes",
    "attributes": {
      "created_at": "2024-10-21T09:22:38.775445+00:00",
      "updated_at": "2024-10-21T09:22:38.775445+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "d1f4a484-99d9-4f0b-95e3-ec9f26193127",
      "owner_type": "customers",
      "employee_id": "2699fb00-a16d-4033-893a-7c9333dbd9e2"
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
    --url 'https://example.booqable.com/api/boomerang/notes/e5df6cf6-a2ea-421d-9fbd-8b6bd3e3131e' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "e5df6cf6-a2ea-421d-9fbd-8b6bd3e3131e",
    "type": "notes",
    "attributes": {
      "created_at": "2024-10-21T09:22:39.338827+00:00",
      "updated_at": "2024-10-21T09:22:39.338827+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "aa2b27d7-b395-4e91-b77b-6bb5666306ca",
      "owner_type": "customers",
      "employee_id": "e1081e89-a7f2-4d2a-bd3e-b8715c6a73df"
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





