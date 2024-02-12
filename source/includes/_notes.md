# Notes

Allows you to leave notes attached to other resources.

## Endpoints
`POST /api/boomerang/notes`

`GET /api/boomerang/notes/{id}`

`GET /api/boomerang/notes`

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
          "owner_id": "e34dee80-6de6-4abe-826c-bfebb1c313d4",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "5eb5fb4d-0cf5-40fa-ba78-7773166acb1c",
    "type": "notes",
    "attributes": {
      "created_at": "2024-02-12T09:15:51+00:00",
      "updated_at": "2024-02-12T09:15:51+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "e34dee80-6de6-4abe-826c-bfebb1c313d4",
      "owner_type": "customers",
      "employee_id": "76a55d67-4c95-406b-89f6-7a4c033cfa42"
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
    --url 'https://example.booqable.com/api/boomerang/notes/3d377c6b-cfd9-4036-a3cc-d5a029e2c726' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "3d377c6b-cfd9-4036-a3cc-d5a029e2c726",
    "type": "notes",
    "attributes": {
      "created_at": "2024-02-12T09:15:52+00:00",
      "updated_at": "2024-02-12T09:15:52+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "482a6d5d-dbee-4639-a675-36cb4f685bc8",
      "owner_type": "customers",
      "employee_id": "f511aa43-d5b5-4e17-9e09-4d301f5c23ce"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/482a6d5d-dbee-4639-a675-36cb4f685bc8"
        }
      },
      "employee": {
        "links": {
          "related": "api/boomerang/employees/f511aa43-d5b5-4e17-9e09-4d301f5c23ce"
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
      "id": "598cabd3-a65e-457e-b8db-678f74f2438f",
      "type": "notes",
      "attributes": {
        "created_at": "2024-02-12T09:15:53+00:00",
        "updated_at": "2024-02-12T09:15:53+00:00",
        "body": "Agreed to give this customer a 20% discount on the next order",
        "owner_id": "018afbd3-e5c1-49ce-abdc-5414bfd71f63",
        "owner_type": "customers",
        "employee_id": "3f4e1cb9-f87f-425e-a88a-6a997eba13fa"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/018afbd3-e5c1-49ce-abdc-5414bfd71f63"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/3f4e1cb9-f87f-425e-a88a-6a997eba13fa"
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






## Deleting a note



> How to delete a note:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/notes/5f076298-8180-4c75-bb41-1ba06a8b2930' \
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