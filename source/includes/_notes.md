# Notes

Allows you to leave notes attached to other resources.

## Endpoints
`DELETE /api/boomerang/notes/{id}`

`GET /api/boomerang/notes`

`GET /api/boomerang/notes/{id}`

`POST /api/boomerang/notes`

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
    --url 'https://example.booqable.com/api/boomerang/notes/56df2d39-f7d2-4696-a697-ec7e5a9e5b20' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "56df2d39-f7d2-4696-a697-ec7e5a9e5b20",
    "type": "notes",
    "attributes": {
      "created_at": "2024-05-13T09:25:25+00:00",
      "updated_at": "2024-05-13T09:25:25+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "b3b217b6-8904-41ad-8f7e-f550b824a456",
      "owner_type": "customers",
      "employee_id": "d40b7ede-77b7-4db3-9d4d-a134dcfe6cc3"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/b3b217b6-8904-41ad-8f7e-f550b824a456"
        }
      },
      "employee": {
        "links": {
          "related": "api/boomerang/employees/d40b7ede-77b7-4db3-9d4d-a134dcfe6cc3"
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
      "id": "4e64fa2e-315e-4ab5-b1ba-36f4eb20bdca",
      "type": "notes",
      "attributes": {
        "created_at": "2024-05-13T09:25:26+00:00",
        "updated_at": "2024-05-13T09:25:26+00:00",
        "body": "Agreed to give this customer a 20% discount on the next order",
        "owner_id": "02fbba77-75fe-4896-a57a-652f493e095f",
        "owner_type": "customers",
        "employee_id": "9d9b04fe-bc93-488e-9725-5e07456214b7"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/02fbba77-75fe-4896-a57a-652f493e095f"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/9d9b04fe-bc93-488e-9725-5e07456214b7"
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
    --url 'https://example.booqable.com/api/boomerang/notes/fea93d61-0510-49e3-a0a1-b2ed4a0e968c' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "fea93d61-0510-49e3-a0a1-b2ed4a0e968c",
    "type": "notes",
    "attributes": {
      "created_at": "2024-05-13T09:25:27+00:00",
      "updated_at": "2024-05-13T09:25:27+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "107b30a6-d43a-4144-a43d-d113ee17654c",
      "owner_type": "customers",
      "employee_id": "6f57d964-60d8-4d83-b06e-bbd370fcf991"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/107b30a6-d43a-4144-a43d-d113ee17654c"
        }
      },
      "employee": {
        "links": {
          "related": "api/boomerang/employees/6f57d964-60d8-4d83-b06e-bbd370fcf991"
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
          "owner_id": "592d822a-1b82-49a9-b08f-592142d41c13",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "bb83d95d-88c3-45e0-a712-e98456867575",
    "type": "notes",
    "attributes": {
      "created_at": "2024-05-13T09:25:27+00:00",
      "updated_at": "2024-05-13T09:25:27+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "592d822a-1b82-49a9-b08f-592142d41c13",
      "owner_type": "customers",
      "employee_id": "89e41856-2e0e-45e8-a981-986442fe929f"
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





