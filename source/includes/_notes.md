# Notes

Allows you to leave notes attached to other resources.

## Endpoints
`POST /api/boomerang/notes`

`GET /api/boomerang/notes`

`GET /api/boomerang/notes/{id}`

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
          "owner_id": "2df23986-0cc6-45ab-83d3-2a843b998b14",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "c856e308-590d-4075-acde-72f294f9697a",
    "type": "notes",
    "attributes": {
      "created_at": "2023-12-07T14:00:58+00:00",
      "updated_at": "2023-12-07T14:00:58+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "2df23986-0cc6-45ab-83d3-2a843b998b14",
      "owner_type": "customers",
      "employee_id": "fe791bf6-b932-4707-b128-5e1d397df34d"
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
      "id": "4c46a19d-efba-4114-b8ef-65ea9a4ffb60",
      "type": "notes",
      "attributes": {
        "created_at": "2023-12-07T14:00:59+00:00",
        "updated_at": "2023-12-07T14:00:59+00:00",
        "body": "Agreed to give this customer a 20% discount on the next order",
        "owner_id": "185697ba-cd7f-4fc3-b867-8e9f62d5bebf",
        "owner_type": "customers",
        "employee_id": "651a5fb4-c39c-4366-a76c-1e7d357c7e37"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/185697ba-cd7f-4fc3-b867-8e9f62d5bebf"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/651a5fb4-c39c-4366-a76c-1e7d357c7e37"
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
    --url 'https://example.booqable.com/api/boomerang/notes/357fe5a7-d261-494d-8f32-b575930b8cdf' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "357fe5a7-d261-494d-8f32-b575930b8cdf",
    "type": "notes",
    "attributes": {
      "created_at": "2023-12-07T14:00:59+00:00",
      "updated_at": "2023-12-07T14:00:59+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "8e165179-9c75-4f9c-9777-fe2c8d7f8f78",
      "owner_type": "customers",
      "employee_id": "ea6e6485-4017-4254-ac74-c729cbebb9fc"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/8e165179-9c75-4f9c-9777-fe2c8d7f8f78"
        }
      },
      "employee": {
        "links": {
          "related": "api/boomerang/employees/ea6e6485-4017-4254-ac74-c729cbebb9fc"
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
    --url 'https://example.booqable.com/api/boomerang/notes/71ae1e42-52ec-453b-bc6a-416d6457e1b4' \
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