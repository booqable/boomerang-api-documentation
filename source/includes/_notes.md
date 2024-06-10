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
      "id": "1ff1c095-387e-4521-82bc-d52aa5387cf2",
      "type": "notes",
      "attributes": {
        "created_at": "2024-06-10T09:25:23.278747+00:00",
        "updated_at": "2024-06-10T09:25:23.278747+00:00",
        "body": "Agreed to give this customer a 20% discount on the next order",
        "owner_id": "cff54bbb-4f8e-4094-b477-5770286828c0",
        "owner_type": "customers",
        "employee_id": "34f80a59-c48d-429b-8350-a0472ca6c3fe"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/cff54bbb-4f8e-4094-b477-5770286828c0"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/34f80a59-c48d-429b-8350-a0472ca6c3fe"
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






## Fetching a note



> How to fetch a note:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/notes/c0802d16-2322-48f4-85b1-c89672471b5e' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "c0802d16-2322-48f4-85b1-c89672471b5e",
    "type": "notes",
    "attributes": {
      "created_at": "2024-06-10T09:25:21.408297+00:00",
      "updated_at": "2024-06-10T09:25:21.408297+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "57870092-3941-4d26-86d3-05b9e980fdb9",
      "owner_type": "customers",
      "employee_id": "8e08e481-fc6b-4240-9cbf-ec99c2a85458"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/57870092-3941-4d26-86d3-05b9e980fdb9"
        }
      },
      "employee": {
        "links": {
          "related": "api/boomerang/employees/8e08e481-fc6b-4240-9cbf-ec99c2a85458"
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
          "owner_id": "8fc016e2-af1c-4451-b195-803cb8ed11d3",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "f6c7605a-9309-437b-837e-24b485030a94",
    "type": "notes",
    "attributes": {
      "created_at": "2024-06-10T09:25:22.302408+00:00",
      "updated_at": "2024-06-10T09:25:22.302408+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "8fc016e2-af1c-4451-b195-803cb8ed11d3",
      "owner_type": "customers",
      "employee_id": "b0d839aa-8fa9-41b0-89a2-0464c9eca1b7"
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






## Deleting a note



> How to delete a note:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/notes/5e037784-9d2e-4e82-afac-154958bc267f' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "5e037784-9d2e-4e82-afac-154958bc267f",
    "type": "notes",
    "attributes": {
      "created_at": "2024-06-10T09:25:23.906313+00:00",
      "updated_at": "2024-06-10T09:25:23.906313+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "c06293fe-6eab-4de1-9d9c-b11a216ba1e6",
      "owner_type": "customers",
      "employee_id": "4b96a33d-bc71-4d82-81fd-f3ff5ed0589a"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/c06293fe-6eab-4de1-9d9c-b11a216ba1e6"
        }
      },
      "employee": {
        "links": {
          "related": "api/boomerang/employees/4b96a33d-bc71-4d82-81fd-f3ff5ed0589a"
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





