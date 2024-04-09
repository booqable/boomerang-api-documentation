# Notes

Allows you to leave notes attached to other resources.

## Endpoints
`GET /api/boomerang/notes`

`POST /api/boomerang/notes`

`GET /api/boomerang/notes/{id}`

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
      "id": "0bf56b51-f254-4376-9c1b-ef8772d5dbd5",
      "type": "notes",
      "attributes": {
        "created_at": "2024-04-09T07:36:42+00:00",
        "updated_at": "2024-04-09T07:36:42+00:00",
        "body": "Agreed to give this customer a 20% discount on the next order",
        "owner_id": "9d6ca6d6-5dff-41b9-9b67-cb9030df19bc",
        "owner_type": "customers",
        "employee_id": "6c4b4553-b31f-4bea-b74b-a1434c84f871"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/9d6ca6d6-5dff-41b9-9b67-cb9030df19bc"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/6c4b4553-b31f-4bea-b74b-a1434c84f871"
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
          "owner_id": "5144d6d8-cd16-4b31-bc15-285825c87747",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "25cec03a-14ad-4c2b-a555-553f8a8430ef",
    "type": "notes",
    "attributes": {
      "created_at": "2024-04-09T07:36:42+00:00",
      "updated_at": "2024-04-09T07:36:42+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "5144d6d8-cd16-4b31-bc15-285825c87747",
      "owner_type": "customers",
      "employee_id": "9b6a09ce-87cc-4a3b-9468-11da82f15c64"
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






## Fetching a note



> How to fetch a note:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/notes/8defdddf-194a-4ed4-9374-c2d49af25cba' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "8defdddf-194a-4ed4-9374-c2d49af25cba",
    "type": "notes",
    "attributes": {
      "created_at": "2024-04-09T07:36:44+00:00",
      "updated_at": "2024-04-09T07:36:44+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "03c1f15c-3787-489f-bf54-3468e08a94fe",
      "owner_type": "customers",
      "employee_id": "1d3a32fb-3bfa-468b-822f-58c7db47b1b0"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/03c1f15c-3787-489f-bf54-3468e08a94fe"
        }
      },
      "employee": {
        "links": {
          "related": "api/boomerang/employees/1d3a32fb-3bfa-468b-822f-58c7db47b1b0"
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






## Deleting a note



> How to delete a note:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/notes/4b0f609b-cd93-47e6-9163-89a997f5cad6' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "4b0f609b-cd93-47e6-9163-89a997f5cad6",
    "type": "notes",
    "attributes": {
      "created_at": "2024-04-09T07:36:46+00:00",
      "updated_at": "2024-04-09T07:36:46+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "3b7e9c26-ee93-4a61-bcc0-7a0163df0bbc",
      "owner_type": "customers",
      "employee_id": "029721f1-8f56-4541-9ae2-201b510c9b9e"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/3b7e9c26-ee93-4a61-bcc0-7a0163df0bbc"
        }
      },
      "employee": {
        "links": {
          "related": "api/boomerang/employees/029721f1-8f56-4541-9ae2-201b510c9b9e"
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





