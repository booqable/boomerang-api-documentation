# Notes

Allows you to leave notes attached to other resources.

## Endpoints
`GET /api/boomerang/notes`

`GET /api/boomerang/notes/{id}`

`DELETE /api/boomerang/notes/{id}`

`POST /api/boomerang/notes`

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
      "id": "d1c27049-840e-4dfd-bc3b-2dc3269a35f6",
      "type": "notes",
      "attributes": {
        "created_at": "2023-12-07T18:37:22+00:00",
        "updated_at": "2023-12-07T18:37:22+00:00",
        "body": "Agreed to give this customer a 20% discount on the next order",
        "owner_id": "683bfed1-b6d6-498c-8648-5161305265d1",
        "owner_type": "customers",
        "employee_id": "8414cf23-8751-4987-bca9-877a12f9bba4"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/683bfed1-b6d6-498c-8648-5161305265d1"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/8414cf23-8751-4987-bca9-877a12f9bba4"
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






## Fetching a note



> How to fetch a note:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/notes/0c612e99-3e0a-46e2-b63e-1e4e00856c51' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "0c612e99-3e0a-46e2-b63e-1e4e00856c51",
    "type": "notes",
    "attributes": {
      "created_at": "2023-12-07T18:37:22+00:00",
      "updated_at": "2023-12-07T18:37:22+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "d69cbee0-9fc7-4474-9016-c62f5942665c",
      "owner_type": "customers",
      "employee_id": "77411f2a-c244-45dc-b56e-bdeeac9c563d"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/d69cbee0-9fc7-4474-9016-c62f5942665c"
        }
      },
      "employee": {
        "links": {
          "related": "api/boomerang/employees/77411f2a-c244-45dc-b56e-bdeeac9c563d"
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






## Deleting a note



> How to delete a note:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/notes/97803810-d71d-4f6d-acb8-55956bd14a05' \
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
          "owner_id": "7c6e5a98-1577-467b-a743-50d7779706f9",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "798ba14d-1c22-4352-b76f-4c915482a6a1",
    "type": "notes",
    "attributes": {
      "created_at": "2023-12-07T18:37:24+00:00",
      "updated_at": "2023-12-07T18:37:24+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "7c6e5a98-1577-467b-a743-50d7779706f9",
      "owner_type": "customers",
      "employee_id": "9c9571a5-131d-4ced-91fb-f0672e3d1d9f"
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





