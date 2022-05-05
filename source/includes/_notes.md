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
`body` | **String**<br>The content of the note
`owner_id` | **Uuid**<br>ID of the resource the note is attached to
`owner_type` | **String**<br>The resource type of the owner. One of `orders`, `documents`, `product_groups`, `bundles`, `products`, `customers`, `stock_items`
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
      "id": "d30413f0-b740-4e99-95a3-7f338119d683",
      "type": "notes",
      "attributes": {
        "created_at": "2022-05-05T09:13:50+00:00",
        "updated_at": "2022-05-05T09:13:50+00:00",
        "body": "Agreed to give this customer a 20% discount on the next order",
        "owner_id": "8e2da2f8-b92f-4ab4-b17e-83b307b93951",
        "owner_type": "customers",
        "employee_id": "49cc9c31-8a2a-462c-bbbf-7d997f77def3"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/8e2da2f8-b92f-4ab4-b17e-83b307b93951"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/49cc9c31-8a2a-462c-bbbf-7d997f77def3"
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=owner,employee`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[notes]=id,created_at,updated_at`
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-05-05T09:12:14Z`
`sort` | **String**<br>How to sort the data `?sort=-created_at`
`meta` | **Hash**<br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String**<br>The page to request
`page[size]` | **String**<br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
`id` | **Uuid**<br>`eq`, `not_eq`
`created_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`owner_id` | **Uuid**<br>`eq`, `not_eq`
`owner_type` | **String**<br>`eq`, `not_eq`
`employee_id` | **Uuid**<br>`eq`, `not_eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array**<br>`count`


### Includes

This request accepts the following includes:

`owner`


`employee`






## Fetching a note



> How to fetch a note:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/notes/0687312d-6c60-4502-87b1-998f1ba8fa4c' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "0687312d-6c60-4502-87b1-998f1ba8fa4c",
    "type": "notes",
    "attributes": {
      "created_at": "2022-05-05T09:13:51+00:00",
      "updated_at": "2022-05-05T09:13:51+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "3f0e4d3b-8685-481b-951c-8cd44d13b214",
      "owner_type": "customers",
      "employee_id": "6541b8d0-08c6-4158-8be5-f343fad3a82d"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/3f0e4d3b-8685-481b-951c-8cd44d13b214"
        }
      },
      "employee": {
        "links": {
          "related": "api/boomerang/employees/6541b8d0-08c6-4158-8be5-f343fad3a82d"
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=owner,employee`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[notes]=id,created_at,updated_at`


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
          "owner_id": "954dcd9b-59e9-4a1d-af0a-825acffba2cb",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "ba749b94-002e-4ce9-bcdf-ba6fcb2dff8c",
    "type": "notes",
    "attributes": {
      "created_at": "2022-05-05T09:13:51+00:00",
      "updated_at": "2022-05-05T09:13:51+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "954dcd9b-59e9-4a1d-af0a-825acffba2cb",
      "owner_type": "customers",
      "employee_id": "0d7558bf-2ac7-4bea-94ad-843485290df4"
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=owner,employee`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[notes]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][body]` | **String**<br>The content of the note
`data[attributes][owner_id]` | **Uuid**<br>ID of the resource the note is attached to
`data[attributes][owner_type]` | **String**<br>The resource type of the owner. One of `orders`, `documents`, `product_groups`, `bundles`, `products`, `customers`, `stock_items`


### Includes

This request accepts the following includes:

`owner`






## Deleting a note



> How to delete a note:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/notes/22e0bec5-cd10-4ae7-ada9-fbb77e5b872c' \
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=owner,employee`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[notes]=id,created_at,updated_at`


### Includes

This request does not accept any includes