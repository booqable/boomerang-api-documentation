# Notes

Allows you to leave notes attached to other resources.

## Endpoints
`GET /api/boomerang/notes`

`DELETE /api/boomerang/notes/{id}`

`POST /api/boomerang/notes`

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
      "id": "51a784a3-3247-4678-bff3-54aa79fc126a",
      "type": "notes",
      "attributes": {
        "created_at": "2024-05-06T09:22:47+00:00",
        "updated_at": "2024-05-06T09:22:47+00:00",
        "body": "Agreed to give this customer a 20% discount on the next order",
        "owner_id": "06b889f7-df9f-4389-ae19-76a33a9da895",
        "owner_type": "customers",
        "employee_id": "80a07df7-0c14-49be-86a7-ec88777d5edd"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/06b889f7-df9f-4389-ae19-76a33a9da895"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/80a07df7-0c14-49be-86a7-ec88777d5edd"
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
`include` | **String** <br>List of comma seperated relationships `?include=employee,owner`
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

`employee`


`owner`






## Deleting a note



> How to delete a note:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/notes/4f4a61f5-23ae-44d6-b44b-578b91b04c4f' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "4f4a61f5-23ae-44d6-b44b-578b91b04c4f",
    "type": "notes",
    "attributes": {
      "created_at": "2024-05-06T09:22:48+00:00",
      "updated_at": "2024-05-06T09:22:48+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "e28fa29d-75b4-4696-ae24-f2546b04ed2e",
      "owner_type": "customers",
      "employee_id": "f31392f4-ff01-402e-81ad-1167f6387a0b"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/e28fa29d-75b4-4696-ae24-f2546b04ed2e"
        }
      },
      "employee": {
        "links": {
          "related": "api/boomerang/employees/f31392f4-ff01-402e-81ad-1167f6387a0b"
        }
      }
    }
  },
  "meta": {}
}
```

### HTTP Request

`DELETE /api/boomerang/notes/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=employee,owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[notes]=created_at,updated_at,body`


### Includes

This request accepts the following includes:

`employee`


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
          "owner_id": "943f3ad2-4139-4bd3-83fb-d9984f6a77a4",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "9120b656-87f3-4fa5-b179-554ead7e83ca",
    "type": "notes",
    "attributes": {
      "created_at": "2024-05-06T09:22:49+00:00",
      "updated_at": "2024-05-06T09:22:49+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "943f3ad2-4139-4bd3-83fb-d9984f6a77a4",
      "owner_type": "customers",
      "employee_id": "40454649-54ae-46ec-8de6-6a3ee62b1f74"
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
`include` | **String** <br>List of comma seperated relationships `?include=employee,owner`
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

`employee`


`owner`






## Fetching a note



> How to fetch a note:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/notes/e05afb60-6490-4d3f-a911-45c8623030cc' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "e05afb60-6490-4d3f-a911-45c8623030cc",
    "type": "notes",
    "attributes": {
      "created_at": "2024-05-06T09:22:49+00:00",
      "updated_at": "2024-05-06T09:22:49+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "4d3e8795-3347-48d7-a2f6-7ef0cced90f9",
      "owner_type": "customers",
      "employee_id": "38863b75-f4ce-495c-9703-3f8d06f1c1d7"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/4d3e8795-3347-48d7-a2f6-7ef0cced90f9"
        }
      },
      "employee": {
        "links": {
          "related": "api/boomerang/employees/38863b75-f4ce-495c-9703-3f8d06f1c1d7"
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
`include` | **String** <br>List of comma seperated relationships `?include=employee,owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[notes]=created_at,updated_at,body`


### Includes

This request accepts the following includes:

`employee`


`owner`





