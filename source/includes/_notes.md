# Notes

Allows you to leave notes attached to other resources.

## Endpoints
`GET /api/boomerang/notes/{id}`

`DELETE /api/boomerang/notes/{id}`

`GET /api/boomerang/notes`

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


## Fetching a note



> How to fetch a note:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/notes/f51b8fe9-93cd-4192-9e67-8b4af0ea3a35' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "f51b8fe9-93cd-4192-9e67-8b4af0ea3a35",
    "type": "notes",
    "attributes": {
      "created_at": "2024-05-27T09:25:49.133339+00:00",
      "updated_at": "2024-05-27T09:25:49.133339+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "5aa45331-57a3-4a2e-b463-067278a3297b",
      "owner_type": "customers",
      "employee_id": "6b80397f-d384-4f88-9179-0144e2ba9ad7"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/5aa45331-57a3-4a2e-b463-067278a3297b"
        }
      },
      "employee": {
        "links": {
          "related": "api/boomerang/employees/6b80397f-d384-4f88-9179-0144e2ba9ad7"
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






## Deleting a note



> How to delete a note:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/notes/d05a2ed9-d17d-4791-abbf-d863d159869d' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "d05a2ed9-d17d-4791-abbf-d863d159869d",
    "type": "notes",
    "attributes": {
      "created_at": "2024-05-27T09:25:50.087906+00:00",
      "updated_at": "2024-05-27T09:25:50.087906+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "5b5a9ce7-7823-40cb-8008-54e979177811",
      "owner_type": "customers",
      "employee_id": "91044887-4b33-4b3b-bf2d-81ef9e6a2e2d"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/5b5a9ce7-7823-40cb-8008-54e979177811"
        }
      },
      "employee": {
        "links": {
          "related": "api/boomerang/employees/91044887-4b33-4b3b-bf2d-81ef9e6a2e2d"
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
      "id": "122d18bf-39a7-48d7-b9ea-1d9b41c55db1",
      "type": "notes",
      "attributes": {
        "created_at": "2024-05-27T09:25:51.305912+00:00",
        "updated_at": "2024-05-27T09:25:51.305912+00:00",
        "body": "Agreed to give this customer a 20% discount on the next order",
        "owner_id": "695e8686-84b5-4b60-8ab3-6d6c2c227679",
        "owner_type": "customers",
        "employee_id": "4bf1dfba-614e-48d1-8842-44c9c1b92822"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/695e8686-84b5-4b60-8ab3-6d6c2c227679"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/4bf1dfba-614e-48d1-8842-44c9c1b92822"
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
          "owner_id": "dd8a0e39-f2c2-43e8-8b27-bca4565d16c2",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "e7d14925-d547-4757-80ca-698a510183d4",
    "type": "notes",
    "attributes": {
      "created_at": "2024-05-27T09:25:52.453880+00:00",
      "updated_at": "2024-05-27T09:25:52.453880+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "dd8a0e39-f2c2-43e8-8b27-bca4565d16c2",
      "owner_type": "customers",
      "employee_id": "6d4d540c-8a21-4a3d-829e-821c2b2f978c"
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





