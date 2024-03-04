# Notes

Allows you to leave notes attached to other resources.

## Endpoints
`GET /api/boomerang/notes`

`POST /api/boomerang/notes`

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
      "id": "df7b137b-9cd1-437a-9533-889cacfbd17d",
      "type": "notes",
      "attributes": {
        "created_at": "2024-03-04T09:17:14+00:00",
        "updated_at": "2024-03-04T09:17:14+00:00",
        "body": "Agreed to give this customer a 20% discount on the next order",
        "owner_id": "50555f1e-bc15-4059-80b1-d57877ad4827",
        "owner_type": "customers",
        "employee_id": "817f8a76-9e83-4482-b869-1fa34f45dc53"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/50555f1e-bc15-4059-80b1-d57877ad4827"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/817f8a76-9e83-4482-b869-1fa34f45dc53"
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
          "owner_id": "04e858cf-cf77-49a6-8670-d1a2d2e4cff8",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "39e19209-2df9-4c9d-90c7-00ff623ce0fd",
    "type": "notes",
    "attributes": {
      "created_at": "2024-03-04T09:17:15+00:00",
      "updated_at": "2024-03-04T09:17:15+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "04e858cf-cf77-49a6-8670-d1a2d2e4cff8",
      "owner_type": "customers",
      "employee_id": "538735dc-4056-4a4b-a2d2-3c8268340c3c"
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
    --url 'https://example.booqable.com/api/boomerang/notes/e2bae721-b7bc-47dc-89c3-0b6bbc980619' \
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
## Fetching a note



> How to fetch a note:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/notes/85b27f35-7d01-4b15-9528-1329b5ab0aec' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "85b27f35-7d01-4b15-9528-1329b5ab0aec",
    "type": "notes",
    "attributes": {
      "created_at": "2024-03-04T09:17:17+00:00",
      "updated_at": "2024-03-04T09:17:17+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "87ec8235-f6ae-4454-b480-efef1d514b2f",
      "owner_type": "customers",
      "employee_id": "41a894b6-85e7-4d24-b710-75f18c388cb0"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/87ec8235-f6ae-4454-b480-efef1d514b2f"
        }
      },
      "employee": {
        "links": {
          "related": "api/boomerang/employees/41a894b6-85e7-4d24-b710-75f18c388cb0"
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





