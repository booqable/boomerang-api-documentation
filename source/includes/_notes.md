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
      "id": "9383aaf0-b9e8-47c5-a119-efe21fc65940",
      "type": "notes",
      "attributes": {
        "created_at": "2023-02-21T10:49:36+00:00",
        "updated_at": "2023-02-21T10:49:36+00:00",
        "body": "Agreed to give this customer a 20% discount on the next order",
        "owner_id": "abc533bb-5f57-408a-b78f-ab066f85bd8b",
        "owner_type": "customers",
        "employee_id": "5f2d4ed6-20b1-4b06-bb9c-1705ff7f27b1"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/abc533bb-5f57-408a-b78f-ab066f85bd8b"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/5f2d4ed6-20b1-4b06-bb9c-1705ff7f27b1"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-21T10:47:38Z`
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
    --url 'https://example.booqable.com/api/boomerang/notes/f5ef18fe-7c01-4b4f-a757-4f9129f91ceb' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "f5ef18fe-7c01-4b4f-a757-4f9129f91ceb",
    "type": "notes",
    "attributes": {
      "created_at": "2023-02-21T10:49:36+00:00",
      "updated_at": "2023-02-21T10:49:36+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "8f369aa7-e26c-4085-b6e0-ec52eefbbc44",
      "owner_type": "customers",
      "employee_id": "80840a70-189b-48f1-a473-db5aea7fd365"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/8f369aa7-e26c-4085-b6e0-ec52eefbbc44"
        }
      },
      "employee": {
        "links": {
          "related": "api/boomerang/employees/80840a70-189b-48f1-a473-db5aea7fd365"
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
          "owner_id": "c8dd54a2-105d-4ad8-8faf-a205bcbd97d6",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "fd4b66d2-a40d-48a0-9599-3ac4793d0982",
    "type": "notes",
    "attributes": {
      "created_at": "2023-02-21T10:49:36+00:00",
      "updated_at": "2023-02-21T10:49:36+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "c8dd54a2-105d-4ad8-8faf-a205bcbd97d6",
      "owner_type": "customers",
      "employee_id": "ba80c42f-762b-4ceb-bae4-4ad368b9640b"
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
    --url 'https://example.booqable.com/api/boomerang/notes/554609a3-7208-4748-9fee-ec8681c73f2b' \
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