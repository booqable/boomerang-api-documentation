# Notes

Allows you to leave notes attached to other resources.

## Endpoints
`GET /api/boomerang/notes`

`POST /api/boomerang/notes`

`DELETE /api/boomerang/notes/{id}`

`GET /api/boomerang/notes/{id}`

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
      "id": "b29c77a2-05b8-4770-ab6e-4c48509ec5bd",
      "type": "notes",
      "attributes": {
        "created_at": "2024-01-22T09:19:25+00:00",
        "updated_at": "2024-01-22T09:19:25+00:00",
        "body": "Agreed to give this customer a 20% discount on the next order",
        "owner_id": "553b5fde-d380-4a04-8ec6-14ae224d6639",
        "owner_type": "customers",
        "employee_id": "d06d5a5a-8293-4fac-9872-1ea1879dab8d"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/553b5fde-d380-4a04-8ec6-14ae224d6639"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/d06d5a5a-8293-4fac-9872-1ea1879dab8d"
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
`include` | **String** <br>List of comma seperated relationships `?include=owner,employee`
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

`owner`


`employee`






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
          "owner_id": "b938aefa-8947-4a97-b4ef-c5a932a29c90",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "d53632b1-d173-4d5e-afc1-1b291228a4a2",
    "type": "notes",
    "attributes": {
      "created_at": "2024-01-22T09:19:26+00:00",
      "updated_at": "2024-01-22T09:19:26+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "b938aefa-8947-4a97-b4ef-c5a932a29c90",
      "owner_type": "customers",
      "employee_id": "6c8f5b9d-ab2a-46d3-8d3c-8a4f1d5c9534"
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
`include` | **String** <br>List of comma seperated relationships `?include=owner`
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

`owner`






## Deleting a note



> How to delete a note:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/notes/84b55d34-8cd0-4d40-bc82-2d50f838af38' \
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
-- | --
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[notes]=created_at,updated_at,body`


### Includes

This request does not accept any includes
## Fetching a note



> How to fetch a note:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/notes/4cb38bf2-35dd-4de4-a9b7-95a4fe9126a4' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "4cb38bf2-35dd-4de4-a9b7-95a4fe9126a4",
    "type": "notes",
    "attributes": {
      "created_at": "2024-01-22T09:19:27+00:00",
      "updated_at": "2024-01-22T09:19:27+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "19ef214e-0255-48e6-8095-b6e61117a2b8",
      "owner_type": "customers",
      "employee_id": "f35563e1-91a2-46a6-babb-9a234c9aab76"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/19ef214e-0255-48e6-8095-b6e61117a2b8"
        }
      },
      "employee": {
        "links": {
          "related": "api/boomerang/employees/f35563e1-91a2-46a6-babb-9a234c9aab76"
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
`include` | **String** <br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[notes]=created_at,updated_at,body`


### Includes

This request accepts the following includes:

`owner`





