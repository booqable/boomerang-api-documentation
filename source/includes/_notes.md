# Notes

Allows you to leave notes attached to other resources.

## Endpoints
`DELETE /api/boomerang/notes/{id}`

`POST /api/boomerang/notes`

`GET /api/boomerang/notes/{id}`

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


## Deleting a note



> How to delete a note:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/notes/ad9952b7-b4e0-47fe-846b-382f335bbeb1' \
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
          "owner_id": "5b233ff4-61eb-4bf3-a702-1da923c023c0",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "72611038-e08b-437d-9ed2-d170034aa4ab",
    "type": "notes",
    "attributes": {
      "created_at": "2023-12-25T09:19:40+00:00",
      "updated_at": "2023-12-25T09:19:40+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "5b233ff4-61eb-4bf3-a702-1da923c023c0",
      "owner_type": "customers",
      "employee_id": "9057f0b9-ac89-47c8-8f3d-a0479d85f28f"
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






## Fetching a note



> How to fetch a note:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/notes/986f34b5-d2ba-4323-87fc-94c7059f3203' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "986f34b5-d2ba-4323-87fc-94c7059f3203",
    "type": "notes",
    "attributes": {
      "created_at": "2023-12-25T09:19:41+00:00",
      "updated_at": "2023-12-25T09:19:41+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "385b022b-a927-4032-86a1-eec4cdc65adc",
      "owner_type": "customers",
      "employee_id": "347d9b4e-9118-4608-9084-f375e6a49d45"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/385b022b-a927-4032-86a1-eec4cdc65adc"
        }
      },
      "employee": {
        "links": {
          "related": "api/boomerang/employees/347d9b4e-9118-4608-9084-f375e6a49d45"
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
      "id": "e6b60417-c247-4791-b402-707409bc77e3",
      "type": "notes",
      "attributes": {
        "created_at": "2023-12-25T09:19:42+00:00",
        "updated_at": "2023-12-25T09:19:42+00:00",
        "body": "Agreed to give this customer a 20% discount on the next order",
        "owner_id": "f177d3d9-f586-44d9-bffa-09bb04d4607f",
        "owner_type": "customers",
        "employee_id": "fd0f0d6b-451c-4ca3-a2b6-c63cc15a83f0"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/f177d3d9-f586-44d9-bffa-09bb04d4607f"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/fd0f0d6b-451c-4ca3-a2b6-c63cc15a83f0"
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





