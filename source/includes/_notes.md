# Notes

Allows you to leave notes attached to other resources.

## Endpoints
`DELETE /api/boomerang/notes/{id}`

`POST /api/boomerang/notes`

`GET /api/boomerang/notes`

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


## Deleting a note



> How to delete a note:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/notes/d06d8ea9-526b-4b40-b2cf-fe5f94007800' \
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
          "owner_id": "474534ec-0fae-4043-953d-60aa71b9f38a",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "e1baba83-0c54-4b42-b749-e8af837f5651",
    "type": "notes",
    "attributes": {
      "created_at": "2024-02-26T09:18:46+00:00",
      "updated_at": "2024-02-26T09:18:46+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "474534ec-0fae-4043-953d-60aa71b9f38a",
      "owner_type": "customers",
      "employee_id": "ecd5bb89-f094-4a5e-bfc7-69d19de8780a"
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
      "id": "2f632029-06d7-4eff-80e8-f2070c42e3d3",
      "type": "notes",
      "attributes": {
        "created_at": "2024-02-26T09:18:47+00:00",
        "updated_at": "2024-02-26T09:18:47+00:00",
        "body": "Agreed to give this customer a 20% discount on the next order",
        "owner_id": "3619e4ab-6c90-40af-8c14-2a21c0a5ac04",
        "owner_type": "customers",
        "employee_id": "bee15d69-7f00-4f5e-b39a-07b9e6e0ce66"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/3619e4ab-6c90-40af-8c14-2a21c0a5ac04"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/bee15d69-7f00-4f5e-b39a-07b9e6e0ce66"
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
    --url 'https://example.booqable.com/api/boomerang/notes/869eeadd-0b6e-407b-bb8c-c0d02ef33ed3' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "869eeadd-0b6e-407b-bb8c-c0d02ef33ed3",
    "type": "notes",
    "attributes": {
      "created_at": "2024-02-26T09:18:47+00:00",
      "updated_at": "2024-02-26T09:18:47+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "6d28ab78-2d72-4103-b648-ecd73b697077",
      "owner_type": "customers",
      "employee_id": "e9ff56d9-e600-4be2-9c60-668db044d981"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/6d28ab78-2d72-4103-b648-ecd73b697077"
        }
      },
      "employee": {
        "links": {
          "related": "api/boomerang/employees/e9ff56d9-e600-4be2-9c60-668db044d981"
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





