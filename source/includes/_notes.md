# Notes

Allows you to leave notes attached to other resources.

## Endpoints
`GET /api/boomerang/notes`

`DELETE /api/boomerang/notes/{id}`

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
      "id": "00b448ff-d3ce-44b2-9a79-bbf0f8c41442",
      "type": "notes",
      "attributes": {
        "created_at": "2024-03-11T09:19:12+00:00",
        "updated_at": "2024-03-11T09:19:12+00:00",
        "body": "Agreed to give this customer a 20% discount on the next order",
        "owner_id": "ecc86072-d5e4-4a8a-b0b8-2318b22c9ab9",
        "owner_type": "customers",
        "employee_id": "b114e395-647e-49af-bb4c-7cb4adf3269e"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/ecc86072-d5e4-4a8a-b0b8-2318b22c9ab9"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/b114e395-647e-49af-bb4c-7cb4adf3269e"
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
    --url 'https://example.booqable.com/api/boomerang/notes/beefa1af-e491-4a10-8605-74759f6a958d' \
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
          "owner_id": "d2234254-00ca-4644-bb40-eff9b67d656a",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "ad977476-0cfb-4bd2-88fc-4492c5ee7cf0",
    "type": "notes",
    "attributes": {
      "created_at": "2024-03-11T09:19:14+00:00",
      "updated_at": "2024-03-11T09:19:14+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "d2234254-00ca-4644-bb40-eff9b67d656a",
      "owner_type": "customers",
      "employee_id": "361cbcad-5748-4810-989e-ef504e094eb0"
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
    --url 'https://example.booqable.com/api/boomerang/notes/56d9d90d-cc5e-4569-9ca8-1ed00a5585ea' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "56d9d90d-cc5e-4569-9ca8-1ed00a5585ea",
    "type": "notes",
    "attributes": {
      "created_at": "2024-03-11T09:19:15+00:00",
      "updated_at": "2024-03-11T09:19:15+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "166aecd8-2d26-4beb-8eaa-5da9147980c7",
      "owner_type": "customers",
      "employee_id": "10b59038-2ae2-405a-a351-747b0bc8951a"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/166aecd8-2d26-4beb-8eaa-5da9147980c7"
        }
      },
      "employee": {
        "links": {
          "related": "api/boomerang/employees/10b59038-2ae2-405a-a351-747b0bc8951a"
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





