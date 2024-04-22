# Notes

Allows you to leave notes attached to other resources.

## Endpoints
`POST /api/boomerang/notes`

`GET /api/boomerang/notes`

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
          "owner_id": "0eb6ba22-43bd-449a-a772-cd2065a1e2da",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "a78200f8-743b-4075-aa5c-f208ef0bf24b",
    "type": "notes",
    "attributes": {
      "created_at": "2024-04-22T09:27:59+00:00",
      "updated_at": "2024-04-22T09:27:59+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "0eb6ba22-43bd-449a-a772-cd2065a1e2da",
      "owner_type": "customers",
      "employee_id": "0aebfe65-c132-4b95-a2c8-b091e6ff4a43"
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
      "id": "af406d95-4da2-4108-9acb-4019b51d4465",
      "type": "notes",
      "attributes": {
        "created_at": "2024-04-22T09:28:00+00:00",
        "updated_at": "2024-04-22T09:28:00+00:00",
        "body": "Agreed to give this customer a 20% discount on the next order",
        "owner_id": "c11d3b3e-24e7-4ef3-ba38-a5e055a785de",
        "owner_type": "customers",
        "employee_id": "4e29c386-4c27-42ff-a56a-6886e8b8c130"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/c11d3b3e-24e7-4ef3-ba38-a5e055a785de"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/4e29c386-4c27-42ff-a56a-6886e8b8c130"
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






## Deleting a note



> How to delete a note:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/notes/39ab2a1c-fba3-4712-b0c4-041c81084367' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "39ab2a1c-fba3-4712-b0c4-041c81084367",
    "type": "notes",
    "attributes": {
      "created_at": "2024-04-22T09:28:00+00:00",
      "updated_at": "2024-04-22T09:28:00+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "f95871e5-9b2d-47f5-8389-bd7fdf10795b",
      "owner_type": "customers",
      "employee_id": "012aa71e-11bc-4419-bf3d-c19afca612f6"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/f95871e5-9b2d-47f5-8389-bd7fdf10795b"
        }
      },
      "employee": {
        "links": {
          "related": "api/boomerang/employees/012aa71e-11bc-4419-bf3d-c19afca612f6"
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






## Fetching a note



> How to fetch a note:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/notes/4f7060e3-0d63-4afd-9406-5d94f9ac4fce' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "4f7060e3-0d63-4afd-9406-5d94f9ac4fce",
    "type": "notes",
    "attributes": {
      "created_at": "2024-04-22T09:28:01+00:00",
      "updated_at": "2024-04-22T09:28:01+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "26d7d133-26d1-455d-8aca-3184a6a8194c",
      "owner_type": "customers",
      "employee_id": "cdcb6b8a-a90b-4ea4-afee-46e1d728ca24"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/26d7d133-26d1-455d-8aca-3184a6a8194c"
        }
      },
      "employee": {
        "links": {
          "related": "api/boomerang/employees/cdcb6b8a-a90b-4ea4-afee-46e1d728ca24"
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





