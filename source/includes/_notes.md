# Notes

Allows you to leave notes attached to other resources.

## Endpoints
`GET /api/boomerang/notes/{id}`

`DELETE /api/boomerang/notes/{id}`

`POST /api/boomerang/notes`

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
    --url 'https://example.booqable.com/api/boomerang/notes/2e0c90fe-d181-4081-8f4c-74b65480c427' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "2e0c90fe-d181-4081-8f4c-74b65480c427",
    "type": "notes",
    "attributes": {
      "created_at": "2023-12-18T09:19:51+00:00",
      "updated_at": "2023-12-18T09:19:51+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "ecbe9250-62d3-4bc2-8760-bc06b9259d69",
      "owner_type": "customers",
      "employee_id": "cef88b5a-deae-49c6-bd02-f029337909d9"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/ecbe9250-62d3-4bc2-8760-bc06b9259d69"
        }
      },
      "employee": {
        "links": {
          "related": "api/boomerang/employees/cef88b5a-deae-49c6-bd02-f029337909d9"
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
    --url 'https://example.booqable.com/api/boomerang/notes/6eb9b03d-2487-46a6-b2b5-2edc7c53c28c' \
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
          "owner_id": "6c396520-8cf9-42f8-a821-ce6ec2d82c9f",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "4e4afab6-0789-481d-bff0-572f55a2079e",
    "type": "notes",
    "attributes": {
      "created_at": "2023-12-18T09:19:53+00:00",
      "updated_at": "2023-12-18T09:19:53+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "6c396520-8cf9-42f8-a821-ce6ec2d82c9f",
      "owner_type": "customers",
      "employee_id": "aa72082b-f874-43f5-b407-cd64ec96fbcd"
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
      "id": "46810d48-da54-439d-8dad-d3a288f8fda0",
      "type": "notes",
      "attributes": {
        "created_at": "2023-12-18T09:19:54+00:00",
        "updated_at": "2023-12-18T09:19:54+00:00",
        "body": "Agreed to give this customer a 20% discount on the next order",
        "owner_id": "dbe9a458-6f6a-41a8-a3be-7f5152119eda",
        "owner_type": "customers",
        "employee_id": "e1de6400-b798-4e5d-b29a-0b070d773127"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/dbe9a458-6f6a-41a8-a3be-7f5152119eda"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/e1de6400-b798-4e5d-b29a-0b070d773127"
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





