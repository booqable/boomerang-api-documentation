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
`owner` | **Customer, Product, Product group, Stock item, Bundle, Order, Document** <br>Associated Owner


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
      "id": "0d84f895-266c-444d-bdc1-d143d43791ab",
      "type": "notes",
      "attributes": {
        "created_at": "2024-09-09T09:23:00.072179+00:00",
        "updated_at": "2024-09-09T09:23:00.072179+00:00",
        "body": "Agreed to give this customer a 20% discount on the next order",
        "owner_id": "8061a747-8eb8-4f28-8f2a-498eec6ffb9f",
        "owner_type": "customers",
        "employee_id": "67ddde7b-a18f-4863-bad7-81901d2487d2"
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
    --url 'https://example.booqable.com/api/boomerang/notes/ca0bf275-3162-4f95-944e-2d92c253e02c' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "ca0bf275-3162-4f95-944e-2d92c253e02c",
    "type": "notes",
    "attributes": {
      "created_at": "2024-09-09T09:23:00.558280+00:00",
      "updated_at": "2024-09-09T09:23:00.558280+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "3c8261f7-fdbd-4413-a29c-dff06cfb22ad",
      "owner_type": "customers",
      "employee_id": "28125e3a-3c8f-44a0-b23c-660c6c40dac5"
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
          "owner_id": "e70c9e41-ad62-45f6-8f9b-6ad22b391039",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "e9123ea7-91ec-42ff-851f-6d7f3bdb6d6c",
    "type": "notes",
    "attributes": {
      "created_at": "2024-09-09T09:22:59.567022+00:00",
      "updated_at": "2024-09-09T09:22:59.567022+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "e70c9e41-ad62-45f6-8f9b-6ad22b391039",
      "owner_type": "customers",
      "employee_id": "c4514752-0f32-4125-a0a3-04d2cdf38c48"
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
    --url 'https://example.booqable.com/api/boomerang/notes/8d574713-b69a-4968-9bd5-5e8158671923' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "8d574713-b69a-4968-9bd5-5e8158671923",
    "type": "notes",
    "attributes": {
      "created_at": "2024-09-09T09:23:01.046528+00:00",
      "updated_at": "2024-09-09T09:23:01.046528+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "3615e82e-ac18-4f4c-9671-7db52a174a5d",
      "owner_type": "customers",
      "employee_id": "d41d8335-5b4d-4ca0-8234-bd34c203952d"
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





