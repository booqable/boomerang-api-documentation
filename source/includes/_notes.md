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
      "id": "f78808a1-8903-4ef6-a6b0-6557932a8ca8",
      "type": "notes",
      "attributes": {
        "created_at": "2024-06-17T09:25:50.893714+00:00",
        "updated_at": "2024-06-17T09:25:50.893714+00:00",
        "body": "Agreed to give this customer a 20% discount on the next order",
        "owner_id": "8be11c44-c5d0-4fb4-a66f-bea8c06e187f",
        "owner_type": "customers",
        "employee_id": "fa9cac88-98ed-4259-a705-98b959335890"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/8be11c44-c5d0-4fb4-a66f-bea8c06e187f"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/fa9cac88-98ed-4259-a705-98b959335890"
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
    --url 'https://example.booqable.com/api/boomerang/notes/6fb94575-2e0b-4a9c-b21e-b7d6f4ab9ff2' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "6fb94575-2e0b-4a9c-b21e-b7d6f4ab9ff2",
    "type": "notes",
    "attributes": {
      "created_at": "2024-06-17T09:25:51.427634+00:00",
      "updated_at": "2024-06-17T09:25:51.427634+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "fa354928-e13d-45cf-b8a0-ac97bace06ea",
      "owner_type": "customers",
      "employee_id": "8da584d2-80d9-4b1d-849e-b78565c10ed8"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/fa354928-e13d-45cf-b8a0-ac97bace06ea"
        }
      },
      "employee": {
        "links": {
          "related": "api/boomerang/employees/8da584d2-80d9-4b1d-849e-b78565c10ed8"
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
          "owner_id": "e87909d7-ba7d-4fa2-b4e1-fc22bbfb7d39",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "eb0f746c-512d-4e74-a0d9-d9600ca6f7d0",
    "type": "notes",
    "attributes": {
      "created_at": "2024-06-17T09:25:50.267433+00:00",
      "updated_at": "2024-06-17T09:25:50.267433+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "e87909d7-ba7d-4fa2-b4e1-fc22bbfb7d39",
      "owner_type": "customers",
      "employee_id": "264de18b-e3d1-4afd-a45a-47d31c17a14a"
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
    --url 'https://example.booqable.com/api/boomerang/notes/fc88dc6b-0463-474b-9997-e0c1465ac8b6' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "fc88dc6b-0463-474b-9997-e0c1465ac8b6",
    "type": "notes",
    "attributes": {
      "created_at": "2024-06-17T09:25:49.624983+00:00",
      "updated_at": "2024-06-17T09:25:49.624983+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "1e6cd65d-46a0-4241-8cde-c61aff3c8f00",
      "owner_type": "customers",
      "employee_id": "524d7ccb-0a68-40d6-b4d7-a7eca88346ec"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/1e6cd65d-46a0-4241-8cde-c61aff3c8f00"
        }
      },
      "employee": {
        "links": {
          "related": "api/boomerang/employees/524d7ccb-0a68-40d6-b4d7-a7eca88346ec"
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





