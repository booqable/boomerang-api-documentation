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
      "id": "6c59d231-ae4b-4b37-8cbf-9f2a2c2815ec",
      "type": "notes",
      "attributes": {
        "created_at": "2024-06-24T09:22:49.333210+00:00",
        "updated_at": "2024-06-24T09:22:49.333210+00:00",
        "body": "Agreed to give this customer a 20% discount on the next order",
        "owner_id": "4f9bcc54-17f0-46c2-b549-68477a42a326",
        "owner_type": "customers",
        "employee_id": "109ef81e-d903-4510-ac6d-666f5f252fd9"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/4f9bcc54-17f0-46c2-b549-68477a42a326"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/109ef81e-d903-4510-ac6d-666f5f252fd9"
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
    --url 'https://example.booqable.com/api/boomerang/notes/83d541a7-c88f-47dc-90fb-a525fb8329a3' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "83d541a7-c88f-47dc-90fb-a525fb8329a3",
    "type": "notes",
    "attributes": {
      "created_at": "2024-06-24T09:22:50.211731+00:00",
      "updated_at": "2024-06-24T09:22:50.211731+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "adcf4ee6-7ac6-41fc-b496-052c22a69fac",
      "owner_type": "customers",
      "employee_id": "b7e6235e-6aa0-44d1-b549-ae2cc9d98295"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/adcf4ee6-7ac6-41fc-b496-052c22a69fac"
        }
      },
      "employee": {
        "links": {
          "related": "api/boomerang/employees/b7e6235e-6aa0-44d1-b549-ae2cc9d98295"
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
          "owner_id": "797903bb-9049-4454-9357-7f361a2693cd",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "c7d281a4-2ae7-414b-a87f-2c383cdf563b",
    "type": "notes",
    "attributes": {
      "created_at": "2024-06-24T09:22:48.308943+00:00",
      "updated_at": "2024-06-24T09:22:48.308943+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "797903bb-9049-4454-9357-7f361a2693cd",
      "owner_type": "customers",
      "employee_id": "1af1d766-1e3e-4662-b87c-df2920914d0c"
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
    --url 'https://example.booqable.com/api/boomerang/notes/970a7cb5-ad5c-47e7-b0b1-a1f1778ea999' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "970a7cb5-ad5c-47e7-b0b1-a1f1778ea999",
    "type": "notes",
    "attributes": {
      "created_at": "2024-06-24T09:22:46.326130+00:00",
      "updated_at": "2024-06-24T09:22:46.326130+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "f1d2a282-5739-4f22-aa79-3e0877c23b5c",
      "owner_type": "customers",
      "employee_id": "a8bcf8aa-5e22-44db-b5e2-b570b1b54e68"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/f1d2a282-5739-4f22-aa79-3e0877c23b5c"
        }
      },
      "employee": {
        "links": {
          "related": "api/boomerang/employees/a8bcf8aa-5e22-44db-b5e2-b570b1b54e68"
        }
      }
    }
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





