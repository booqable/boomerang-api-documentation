# Notes

Allows you to leave notes attached to other resources.

## Endpoints
`GET /api/boomerang/notes`

`DELETE /api/boomerang/notes/{id}`

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
      "id": "9079ea9a-ed52-48a9-b22d-75a732c640e2",
      "type": "notes",
      "attributes": {
        "created_at": "2024-01-29T09:21:27+00:00",
        "updated_at": "2024-01-29T09:21:27+00:00",
        "body": "Agreed to give this customer a 20% discount on the next order",
        "owner_id": "191a495f-be78-4380-9d55-afeb510effed",
        "owner_type": "customers",
        "employee_id": "23c6f640-6b98-4c83-81d6-140c52d38d97"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/191a495f-be78-4380-9d55-afeb510effed"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/23c6f640-6b98-4c83-81d6-140c52d38d97"
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
    --url 'https://example.booqable.com/api/boomerang/notes/de2ff668-e72f-46c1-9b93-e377136c0253' \
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
## Fetching a note



> How to fetch a note:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/notes/72a7efcc-e9aa-4b7b-b15d-25b3ee97707e' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "72a7efcc-e9aa-4b7b-b15d-25b3ee97707e",
    "type": "notes",
    "attributes": {
      "created_at": "2024-01-29T09:21:28+00:00",
      "updated_at": "2024-01-29T09:21:28+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "16b07b1c-a506-4b0f-90b2-be002a5cecb5",
      "owner_type": "customers",
      "employee_id": "976257aa-4fbc-4ef0-a3e8-ec2459731dbd"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/16b07b1c-a506-4b0f-90b2-be002a5cecb5"
        }
      },
      "employee": {
        "links": {
          "related": "api/boomerang/employees/976257aa-4fbc-4ef0-a3e8-ec2459731dbd"
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
          "owner_id": "4c7b7f4b-f007-43fd-aff5-78e8db959b8a",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "f8346a9b-7f93-4de8-a075-1c9026c3051e",
    "type": "notes",
    "attributes": {
      "created_at": "2024-01-29T09:21:28+00:00",
      "updated_at": "2024-01-29T09:21:28+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "4c7b7f4b-f007-43fd-aff5-78e8db959b8a",
      "owner_type": "customers",
      "employee_id": "13d126bd-b14b-4070-b677-be3339c15f04"
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





