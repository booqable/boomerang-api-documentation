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
      "id": "7a637efd-5517-4299-9ac4-38d9ca5fa5fb",
      "type": "notes",
      "attributes": {
        "created_at": "2024-06-24T09:55:16.107956+00:00",
        "updated_at": "2024-06-24T09:55:16.107956+00:00",
        "body": "Agreed to give this customer a 20% discount on the next order",
        "owner_id": "4273621a-5a4f-46d0-9ae7-8ab814909685",
        "owner_type": "customers",
        "employee_id": "4a35d82f-4e65-495b-a2e9-2ab36d664707"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/4273621a-5a4f-46d0-9ae7-8ab814909685"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/4a35d82f-4e65-495b-a2e9-2ab36d664707"
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
    --url 'https://example.booqable.com/api/boomerang/notes/62550b73-1e8c-4ea7-b127-81a31a88ac52' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "62550b73-1e8c-4ea7-b127-81a31a88ac52",
    "type": "notes",
    "attributes": {
      "created_at": "2024-06-24T09:55:16.855848+00:00",
      "updated_at": "2024-06-24T09:55:16.855848+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "382423bb-7d55-4b76-8b6d-c68093213423",
      "owner_type": "customers",
      "employee_id": "f1bf60b2-5fc7-48bc-b6ec-1a96b5f1d509"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/382423bb-7d55-4b76-8b6d-c68093213423"
        }
      },
      "employee": {
        "links": {
          "related": "api/boomerang/employees/f1bf60b2-5fc7-48bc-b6ec-1a96b5f1d509"
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
          "owner_id": "1ba97db2-e4aa-4327-b1d5-45277eca0e95",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "c38c92a5-4fdd-42a0-9ba4-4bde7df4ed07",
    "type": "notes",
    "attributes": {
      "created_at": "2024-06-24T09:55:15.309641+00:00",
      "updated_at": "2024-06-24T09:55:15.309641+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "1ba97db2-e4aa-4327-b1d5-45277eca0e95",
      "owner_type": "customers",
      "employee_id": "9db57304-0fa9-4e85-9b4b-214ea77e5b37"
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
    --url 'https://example.booqable.com/api/boomerang/notes/6ff5aa4e-647b-441e-a408-452bb2f44f17' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "6ff5aa4e-647b-441e-a408-452bb2f44f17",
    "type": "notes",
    "attributes": {
      "created_at": "2024-06-24T09:55:17.586339+00:00",
      "updated_at": "2024-06-24T09:55:17.586339+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "8cd3a916-4651-4769-a316-a97ad086508a",
      "owner_type": "customers",
      "employee_id": "59bd735a-87a1-40ef-9702-d13acf9a3563"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/8cd3a916-4651-4769-a316-a97ad086508a"
        }
      },
      "employee": {
        "links": {
          "related": "api/boomerang/employees/59bd735a-87a1-40ef-9702-d13acf9a3563"
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





