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
      "id": "1bf23e21-7a48-4c22-a70f-8aa37403ecee",
      "type": "notes",
      "attributes": {
        "created_at": "2023-07-10T09:17:43+00:00",
        "updated_at": "2023-07-10T09:17:43+00:00",
        "body": "Agreed to give this customer a 20% discount on the next order",
        "owner_id": "c794c87c-50ae-452c-aa4e-aedbef9ed68c",
        "owner_type": "customers",
        "employee_id": "c1160eff-bccd-4af5-bca0-6e9f4a70b77e"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/c794c87c-50ae-452c-aa4e-aedbef9ed68c"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/c1160eff-bccd-4af5-bca0-6e9f4a70b77e"
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






## Fetching a note



> How to fetch a note:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/notes/5415d194-c5dd-4f91-87d0-615ee572f2dc' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "5415d194-c5dd-4f91-87d0-615ee572f2dc",
    "type": "notes",
    "attributes": {
      "created_at": "2023-07-10T09:17:44+00:00",
      "updated_at": "2023-07-10T09:17:44+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "5ec605d2-8925-496e-b9f7-25fd09a53b99",
      "owner_type": "customers",
      "employee_id": "0a896f27-2078-4b6b-9e4a-55671265c0d0"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/5ec605d2-8925-496e-b9f7-25fd09a53b99"
        }
      },
      "employee": {
        "links": {
          "related": "api/boomerang/employees/0a896f27-2078-4b6b-9e4a-55671265c0d0"
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
          "owner_id": "038154a3-641f-4ef1-b123-744befb34645",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "9b41da1e-bafc-4725-bd83-daf36ea0ca10",
    "type": "notes",
    "attributes": {
      "created_at": "2023-07-10T09:17:45+00:00",
      "updated_at": "2023-07-10T09:17:45+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "038154a3-641f-4ef1-b123-744befb34645",
      "owner_type": "customers",
      "employee_id": "0b5f36ff-8403-439e-8125-1381541f9be4"
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






## Deleting a note



> How to delete a note:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/notes/c689c58d-d143-43a4-b211-0be03c1f77e0' \
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