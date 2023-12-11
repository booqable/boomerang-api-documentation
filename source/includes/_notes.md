# Notes

Allows you to leave notes attached to other resources.

## Endpoints
`GET /api/boomerang/notes/{id}`

`DELETE /api/boomerang/notes/{id}`

`POST /api/boomerang/notes`

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


## Fetching a note



> How to fetch a note:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/notes/ae848d7b-7253-4a36-b382-93a1e1b5861c' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "ae848d7b-7253-4a36-b382-93a1e1b5861c",
    "type": "notes",
    "attributes": {
      "created_at": "2023-12-11T15:33:32+00:00",
      "updated_at": "2023-12-11T15:33:32+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "a0991944-da92-49fb-ad89-5d7e5aca1900",
      "owner_type": "customers",
      "employee_id": "d83cc60a-174e-4e15-83ad-b3064cff06a4"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/a0991944-da92-49fb-ad89-5d7e5aca1900"
        }
      },
      "employee": {
        "links": {
          "related": "api/boomerang/employees/d83cc60a-174e-4e15-83ad-b3064cff06a4"
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
    --url 'https://example.booqable.com/api/boomerang/notes/3fcefb8e-13b2-4bc0-b431-63e2837fc506' \
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
          "owner_id": "823c3330-daa7-4b5e-bc4d-dc2f91df7ebe",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "3177099f-fab6-40e4-ba5a-4081962d0647",
    "type": "notes",
    "attributes": {
      "created_at": "2023-12-11T15:33:34+00:00",
      "updated_at": "2023-12-11T15:33:34+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "823c3330-daa7-4b5e-bc4d-dc2f91df7ebe",
      "owner_type": "customers",
      "employee_id": "a1c1a103-f4ca-47ae-b190-4d9f72fd165d"
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
      "id": "e780b8cf-f618-4cf6-9e66-f767ae94386b",
      "type": "notes",
      "attributes": {
        "created_at": "2023-12-11T15:33:34+00:00",
        "updated_at": "2023-12-11T15:33:34+00:00",
        "body": "Agreed to give this customer a 20% discount on the next order",
        "owner_id": "0945e5d0-f4ce-4a44-a3d8-5def9378b4c5",
        "owner_type": "customers",
        "employee_id": "a4288751-0bd5-4838-8d24-4a88570f5a78"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/0945e5d0-f4ce-4a44-a3d8-5def9378b4c5"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/a4288751-0bd5-4838-8d24-4a88570f5a78"
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





