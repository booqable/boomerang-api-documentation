# Notes

Allows you to leave notes attached to other resources.

## Endpoints
`DELETE /api/boomerang/notes/{id}`

`GET /api/boomerang/notes`

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


## Deleting a note



> How to delete a note:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/notes/facca448-8dea-44c8-9289-67f72d7fa332' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "facca448-8dea-44c8-9289-67f72d7fa332",
    "type": "notes",
    "attributes": {
      "created_at": "2024-06-03T09:26:05.191208+00:00",
      "updated_at": "2024-06-03T09:26:05.191208+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "7b3a31c2-2f0e-47c9-867d-f034626e7ab2",
      "owner_type": "customers",
      "employee_id": "ea589611-7ca8-4c22-93e5-5e97a1267007"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/7b3a31c2-2f0e-47c9-867d-f034626e7ab2"
        }
      },
      "employee": {
        "links": {
          "related": "api/boomerang/employees/ea589611-7ca8-4c22-93e5-5e97a1267007"
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
      "id": "0385d1e3-1a10-4136-a49d-4073c194de7b",
      "type": "notes",
      "attributes": {
        "created_at": "2024-06-03T09:26:05.890754+00:00",
        "updated_at": "2024-06-03T09:26:05.890754+00:00",
        "body": "Agreed to give this customer a 20% discount on the next order",
        "owner_id": "e5c29312-aabb-47cd-8e38-9eb994337869",
        "owner_type": "customers",
        "employee_id": "7c6c84df-f178-4d53-8c5e-4145103d58f1"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/e5c29312-aabb-47cd-8e38-9eb994337869"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/7c6c84df-f178-4d53-8c5e-4145103d58f1"
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
          "owner_id": "1f956a28-c8da-4061-93e8-331c06d113ef",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "9a4f1320-08cd-493c-81bf-21958e34d746",
    "type": "notes",
    "attributes": {
      "created_at": "2024-06-03T09:26:06.593301+00:00",
      "updated_at": "2024-06-03T09:26:06.593301+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "1f956a28-c8da-4061-93e8-331c06d113ef",
      "owner_type": "customers",
      "employee_id": "945ce3b0-4415-4c2d-9131-f54d29f0ed08"
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
    --url 'https://example.booqable.com/api/boomerang/notes/f9e144c6-599a-444b-9d1a-a085066e9906' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "f9e144c6-599a-444b-9d1a-a085066e9906",
    "type": "notes",
    "attributes": {
      "created_at": "2024-06-03T09:26:07.322423+00:00",
      "updated_at": "2024-06-03T09:26:07.322423+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "e3853085-3c50-47f1-b28b-355f8120ec6d",
      "owner_type": "customers",
      "employee_id": "20bebef8-3374-4b7c-b76c-8789cc6d8db3"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/e3853085-3c50-47f1-b28b-355f8120ec6d"
        }
      },
      "employee": {
        "links": {
          "related": "api/boomerang/employees/20bebef8-3374-4b7c-b76c-8789cc6d8db3"
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





