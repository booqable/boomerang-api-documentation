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
      "id": "5fe82f4b-6b0d-4cdf-b81b-d12e3bb69f65",
      "type": "notes",
      "attributes": {
        "created_at": "2023-02-20T11:47:40+00:00",
        "updated_at": "2023-02-20T11:47:40+00:00",
        "body": "Agreed to give this customer a 20% discount on the next order",
        "owner_id": "08304ec4-5234-4262-8b98-49c427849ba9",
        "owner_type": "customers",
        "employee_id": "65e1adfc-42f0-4b84-8d55-40aee0c5a16d"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/08304ec4-5234-4262-8b98-49c427849ba9"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/65e1adfc-42f0-4b84-8d55-40aee0c5a16d"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-20T11:45:20Z`
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
    --url 'https://example.booqable.com/api/boomerang/notes/e08bad8d-dd6c-4af9-947c-28479a5f6571' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "e08bad8d-dd6c-4af9-947c-28479a5f6571",
    "type": "notes",
    "attributes": {
      "created_at": "2023-02-20T11:47:40+00:00",
      "updated_at": "2023-02-20T11:47:40+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "3e46ef2f-9cf9-4d42-9038-575c5175ee63",
      "owner_type": "customers",
      "employee_id": "8b3b7f32-7661-4328-8f37-a624717319b4"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/3e46ef2f-9cf9-4d42-9038-575c5175ee63"
        }
      },
      "employee": {
        "links": {
          "related": "api/boomerang/employees/8b3b7f32-7661-4328-8f37-a624717319b4"
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
          "owner_id": "93e3f9ab-e895-4e25-93c9-e57f11b0a35a",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "f57bb6fc-6968-4a48-8cdc-d95540f1a5ee",
    "type": "notes",
    "attributes": {
      "created_at": "2023-02-20T11:47:40+00:00",
      "updated_at": "2023-02-20T11:47:40+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "93e3f9ab-e895-4e25-93c9-e57f11b0a35a",
      "owner_type": "customers",
      "employee_id": "d19c038d-8132-49d7-a554-0d1bcdfd5d36"
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
    --url 'https://example.booqable.com/api/boomerang/notes/a68009ce-0e46-4a93-b5b2-909d12365f2b' \
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