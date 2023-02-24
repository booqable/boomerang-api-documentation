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
      "id": "926455fe-59d0-4d16-8293-f5e2c12015a5",
      "type": "notes",
      "attributes": {
        "created_at": "2023-02-24T09:48:28+00:00",
        "updated_at": "2023-02-24T09:48:28+00:00",
        "body": "Agreed to give this customer a 20% discount on the next order",
        "owner_id": "70434ca8-029d-40be-b89d-7f0ff4155f6f",
        "owner_type": "customers",
        "employee_id": "0479c197-f446-4464-8583-1e1aafeec00c"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/70434ca8-029d-40be-b89d-7f0ff4155f6f"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/0479c197-f446-4464-8583-1e1aafeec00c"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-24T09:46:21Z`
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
    --url 'https://example.booqable.com/api/boomerang/notes/faabb046-584c-4fb6-88b8-194408ed84a8' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "faabb046-584c-4fb6-88b8-194408ed84a8",
    "type": "notes",
    "attributes": {
      "created_at": "2023-02-24T09:48:28+00:00",
      "updated_at": "2023-02-24T09:48:28+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "78773b28-9b0a-41dd-bc91-dd6823ca8e80",
      "owner_type": "customers",
      "employee_id": "77eb8117-c306-4b7f-83c7-f26684ccdd1a"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/78773b28-9b0a-41dd-bc91-dd6823ca8e80"
        }
      },
      "employee": {
        "links": {
          "related": "api/boomerang/employees/77eb8117-c306-4b7f-83c7-f26684ccdd1a"
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
          "owner_id": "63d6ce27-98ab-40b8-8d3a-006b64142dcb",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "7f05b623-3438-4bc3-a50c-8e923ffc87f1",
    "type": "notes",
    "attributes": {
      "created_at": "2023-02-24T09:48:29+00:00",
      "updated_at": "2023-02-24T09:48:29+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "63d6ce27-98ab-40b8-8d3a-006b64142dcb",
      "owner_type": "customers",
      "employee_id": "7dc0cadd-a235-404d-b40b-d2bbaf946ba8"
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
    --url 'https://example.booqable.com/api/boomerang/notes/d667e89f-1a6f-4555-a1d7-3e603427c6f2' \
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