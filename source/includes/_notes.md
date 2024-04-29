# Notes

Allows you to leave notes attached to other resources.

## Endpoints
`POST /api/boomerang/notes`

`GET /api/boomerang/notes`

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
          "owner_id": "ad34e77a-8f0c-4133-bd6c-adb8158415f5",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "7984793f-6451-4d55-96c3-eb7244786275",
    "type": "notes",
    "attributes": {
      "created_at": "2024-04-29T09:29:50+00:00",
      "updated_at": "2024-04-29T09:29:50+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "ad34e77a-8f0c-4133-bd6c-adb8158415f5",
      "owner_type": "customers",
      "employee_id": "3258f348-7a82-42e1-8537-f39fd6eac750"
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
      "id": "a6e45491-5837-460a-a3f2-6e269be5bbfb",
      "type": "notes",
      "attributes": {
        "created_at": "2024-04-29T09:29:51+00:00",
        "updated_at": "2024-04-29T09:29:51+00:00",
        "body": "Agreed to give this customer a 20% discount on the next order",
        "owner_id": "0a86cc50-462d-427e-83a4-0be9164c80d7",
        "owner_type": "customers",
        "employee_id": "efe06596-998a-4201-b75c-91efdd181d36"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/0a86cc50-462d-427e-83a4-0be9164c80d7"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/efe06596-998a-4201-b75c-91efdd181d36"
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
    --url 'https://example.booqable.com/api/boomerang/notes/06c55be2-0b0b-49e4-a533-a40839164e5b' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "06c55be2-0b0b-49e4-a533-a40839164e5b",
    "type": "notes",
    "attributes": {
      "created_at": "2024-04-29T09:29:52+00:00",
      "updated_at": "2024-04-29T09:29:52+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "142fd9e0-140d-428a-9ce6-95badba1b58d",
      "owner_type": "customers",
      "employee_id": "c2bb3b05-18e8-4b36-9bc0-4895f1c3ae9e"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/142fd9e0-140d-428a-9ce6-95badba1b58d"
        }
      },
      "employee": {
        "links": {
          "related": "api/boomerang/employees/c2bb3b05-18e8-4b36-9bc0-4895f1c3ae9e"
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
    --url 'https://example.booqable.com/api/boomerang/notes/6a130d8b-4027-442a-a2a4-0d1ee7ef986e' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "6a130d8b-4027-442a-a2a4-0d1ee7ef986e",
    "type": "notes",
    "attributes": {
      "created_at": "2024-04-29T09:29:53+00:00",
      "updated_at": "2024-04-29T09:29:53+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "5a5e2b19-7f22-4621-9a87-a1cc8960d375",
      "owner_type": "customers",
      "employee_id": "39f2bfd1-f118-4917-9401-b906510e8c8f"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/5a5e2b19-7f22-4621-9a87-a1cc8960d375"
        }
      },
      "employee": {
        "links": {
          "related": "api/boomerang/employees/39f2bfd1-f118-4917-9401-b906510e8c8f"
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





