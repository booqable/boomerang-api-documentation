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
- | -
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
- | -
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
      "id": "2151efa1-ff4d-402c-88bd-4054d078f274",
      "type": "notes",
      "attributes": {
        "created_at": "2023-01-05T13:44:36+00:00",
        "updated_at": "2023-01-05T13:44:36+00:00",
        "body": "Agreed to give this customer a 20% discount on the next order",
        "owner_id": "81b4ae0c-09a8-4a43-9958-fd9d0b613dd9",
        "owner_type": "customers",
        "employee_id": "1df2fe3d-5f97-40f2-98c1-548053ec79ac"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/81b4ae0c-09a8-4a43-9958-fd9d0b613dd9"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/1df2fe3d-5f97-40f2-98c1-548053ec79ac"
          }
        }
      }
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
- | -
`include` | **String** <br>List of comma seperated relationships `?include=owner,employee`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[notes]=id,created_at,updated_at`
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-01-05T13:42:08Z`
`sort` | **String** <br>How to sort the data `?sort=-created_at`
`meta` | **Hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String** <br>The page to request
`page[size]` | **String** <br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
`id` | **Uuid** <br>`eq`, `not_eq`
`created_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`owner_id` | **Uuid** <br>`eq`, `not_eq`
`owner_type` | **String** <br>`eq`, `not_eq`
`employee_id` | **Uuid** <br>`eq`, `not_eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array** <br>`count`


### Includes

This request accepts the following includes:

`owner`


`employee`






## Fetching a note



> How to fetch a note:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/notes/e7dadeae-de3f-45db-8574-1c00c708e39e' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "e7dadeae-de3f-45db-8574-1c00c708e39e",
    "type": "notes",
    "attributes": {
      "created_at": "2023-01-05T13:44:36+00:00",
      "updated_at": "2023-01-05T13:44:36+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "7baeea52-53d0-4fa4-bbed-9d478e45a7a3",
      "owner_type": "customers",
      "employee_id": "31786cfd-03ae-40e1-8b45-b62b0979e9cc"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/7baeea52-53d0-4fa4-bbed-9d478e45a7a3"
        }
      },
      "employee": {
        "links": {
          "related": "api/boomerang/employees/31786cfd-03ae-40e1-8b45-b62b0979e9cc"
        }
      }
    }
  },
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/notes/{id}`

### Request params

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=owner,employee`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[notes]=id,created_at,updated_at`


### Includes

This request accepts the following includes:

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
          "owner_id": "cb964aa6-736c-4e2d-9c8d-95873477147c",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "8776d5ef-f90a-4eef-b2ca-9f130a898989",
    "type": "notes",
    "attributes": {
      "created_at": "2023-01-05T13:44:37+00:00",
      "updated_at": "2023-01-05T13:44:37+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "cb964aa6-736c-4e2d-9c8d-95873477147c",
      "owner_type": "customers",
      "employee_id": "5ce30dca-f56f-49d1-a9f0-129af0cc2ce0"
    },
    "relationships": {
      "owner": {
        "meta": {
          "included": false
        }
      },
      "employee": {
        "meta": {
          "included": false
        }
      }
    }
  },
  "meta": {}
}
```

### HTTP Request

`POST /api/boomerang/notes`

### Request params

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=owner,employee`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[notes]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][body]` | **String** <br>The content of the note
`data[attributes][owner_id]` | **Uuid** <br>ID of the resource the note is attached to
`data[attributes][owner_type]` | **String** <br>The resource type of the owner. One of `orders`, `documents`, `product_groups`, `bundles`, `products`, `customers`, `stock_items`, `users`


### Includes

This request accepts the following includes:

`owner`






## Deleting a note



> How to delete a note:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/notes/39fce772-5796-4cf4-88cf-5244ec0ea165' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "meta": {}
}
```

### HTTP Request

`DELETE /api/boomerang/notes/{id}`

### Request params

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=owner,employee`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[notes]=id,created_at,updated_at`


### Includes

This request does not accept any includes