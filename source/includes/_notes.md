# Notes

Allows you to leave notes attached to other resources.

## Endpoints
`GET /api/boomerang/notes/{id}`

`POST /api/boomerang/notes`

`DELETE /api/boomerang/notes/{id}`

`GET /api/boomerang/notes`

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


## Fetching a note



> How to fetch a note:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/notes/2c97b5a0-2248-4ac8-9e92-03428b90c5f1' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "2c97b5a0-2248-4ac8-9e92-03428b90c5f1",
    "type": "notes",
    "attributes": {
      "created_at": "2024-02-19T09:14:40+00:00",
      "updated_at": "2024-02-19T09:14:40+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "db1f564f-82ae-4d25-a435-fba0c725f43c",
      "owner_type": "customers",
      "employee_id": "93c08a51-8862-4df9-b052-6eaa227aead4"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/db1f564f-82ae-4d25-a435-fba0c725f43c"
        }
      },
      "employee": {
        "links": {
          "related": "api/boomerang/employees/93c08a51-8862-4df9-b052-6eaa227aead4"
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
          "owner_id": "c65de0e4-80ca-4119-96ec-ce0d06af5552",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "108d5e62-b0b8-4dcb-90a3-a98b75a3b7a2",
    "type": "notes",
    "attributes": {
      "created_at": "2024-02-19T09:14:41+00:00",
      "updated_at": "2024-02-19T09:14:41+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "c65de0e4-80ca-4119-96ec-ce0d06af5552",
      "owner_type": "customers",
      "employee_id": "95b5c749-a62a-4c55-8377-0830025365e7"
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
    --url 'https://example.booqable.com/api/boomerang/notes/40ddfd90-22bc-4fec-8ead-e438432b8835' \
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
      "id": "342e674c-accf-4ded-8e3e-e6320fdc87fd",
      "type": "notes",
      "attributes": {
        "created_at": "2024-02-19T09:14:44+00:00",
        "updated_at": "2024-02-19T09:14:44+00:00",
        "body": "Agreed to give this customer a 20% discount on the next order",
        "owner_id": "4d2109df-fdba-401e-8f9f-6058dcd2ba70",
        "owner_type": "customers",
        "employee_id": "63544c23-1835-4273-9542-818a04c22728"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/4d2109df-fdba-401e-8f9f-6058dcd2ba70"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/63544c23-1835-4273-9542-818a04c22728"
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





