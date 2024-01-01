# Notes

Allows you to leave notes attached to other resources.

## Endpoints
`GET /api/boomerang/notes`

`POST /api/boomerang/notes`

`GET /api/boomerang/notes/{id}`

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
      "id": "de9bf85b-7cbe-461a-9558-3724b8cf5fe1",
      "type": "notes",
      "attributes": {
        "created_at": "2024-01-01T09:14:02+00:00",
        "updated_at": "2024-01-01T09:14:02+00:00",
        "body": "Agreed to give this customer a 20% discount on the next order",
        "owner_id": "3737e627-f479-47f0-9f6e-84ea4e3ca5a3",
        "owner_type": "customers",
        "employee_id": "18ea8f21-9228-4258-88a2-a3e955605a34"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/3737e627-f479-47f0-9f6e-84ea4e3ca5a3"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/18ea8f21-9228-4258-88a2-a3e955605a34"
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
          "owner_id": "45e02412-878f-4b4e-9574-18c902b48918",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "cbfda01d-7dc2-48b0-b3cc-a5c917e59b91",
    "type": "notes",
    "attributes": {
      "created_at": "2024-01-01T09:14:03+00:00",
      "updated_at": "2024-01-01T09:14:03+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "45e02412-878f-4b4e-9574-18c902b48918",
      "owner_type": "customers",
      "employee_id": "6bdf2dc1-bd56-4a3c-b6fe-87adbf1cc345"
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
    --url 'https://example.booqable.com/api/boomerang/notes/380dac29-0f70-4293-8870-61ca9f380942' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "380dac29-0f70-4293-8870-61ca9f380942",
    "type": "notes",
    "attributes": {
      "created_at": "2024-01-01T09:14:04+00:00",
      "updated_at": "2024-01-01T09:14:04+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "dfeb6a48-06e8-40d6-86b4-461b8f24cbe7",
      "owner_type": "customers",
      "employee_id": "4fd6c623-14c6-433c-a84f-8f16d6e1cdb1"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/dfeb6a48-06e8-40d6-86b4-461b8f24cbe7"
        }
      },
      "employee": {
        "links": {
          "related": "api/boomerang/employees/4fd6c623-14c6-433c-a84f-8f16d6e1cdb1"
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






## Deleting a note



> How to delete a note:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/notes/f9f94946-8bfe-4e8f-bf50-1060860ecfd2' \
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