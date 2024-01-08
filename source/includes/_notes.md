# Notes

Allows you to leave notes attached to other resources.

## Endpoints
`DELETE /api/boomerang/notes/{id}`

`POST /api/boomerang/notes`

`GET /api/boomerang/notes/{id}`

`GET /api/boomerang/notes`

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
    --url 'https://example.booqable.com/api/boomerang/notes/b2371d31-526e-483d-9022-b112331eaa4a' \
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
          "owner_id": "0b1fb1fb-bc7f-4f9b-b15d-b8ba9e50bc83",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "4fadcb19-16e1-4add-b6a7-f2ab94438fbd",
    "type": "notes",
    "attributes": {
      "created_at": "2024-01-08T09:15:10+00:00",
      "updated_at": "2024-01-08T09:15:10+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "0b1fb1fb-bc7f-4f9b-b15d-b8ba9e50bc83",
      "owner_type": "customers",
      "employee_id": "f13d3342-8503-4d5e-93ec-6fb753faf4a6"
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
    --url 'https://example.booqable.com/api/boomerang/notes/028dca83-feea-48f8-bba2-0e87d41de1a4' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "028dca83-feea-48f8-bba2-0e87d41de1a4",
    "type": "notes",
    "attributes": {
      "created_at": "2024-01-08T09:15:11+00:00",
      "updated_at": "2024-01-08T09:15:11+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "1e4fd183-6edb-4446-88e8-255bf367f9cd",
      "owner_type": "customers",
      "employee_id": "8833cec8-3214-45fa-83ed-40ceb9ad0a2e"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/1e4fd183-6edb-4446-88e8-255bf367f9cd"
        }
      },
      "employee": {
        "links": {
          "related": "api/boomerang/employees/8833cec8-3214-45fa-83ed-40ceb9ad0a2e"
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
      "id": "914fcc6c-78ed-42c5-a35f-d81a0aab7781",
      "type": "notes",
      "attributes": {
        "created_at": "2024-01-08T09:15:11+00:00",
        "updated_at": "2024-01-08T09:15:11+00:00",
        "body": "Agreed to give this customer a 20% discount on the next order",
        "owner_id": "87cd067c-6ee9-4c6b-a7ab-09c97e802002",
        "owner_type": "customers",
        "employee_id": "a030895f-0d6f-4d42-b9d3-05113ffd4ff5"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/87cd067c-6ee9-4c6b-a7ab-09c97e802002"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/a030895f-0d6f-4d42-b9d3-05113ffd4ff5"
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





