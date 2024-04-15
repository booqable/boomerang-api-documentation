# Notes

Allows you to leave notes attached to other resources.

## Endpoints
`POST /api/boomerang/notes`

`GET /api/boomerang/notes`

`DELETE /api/boomerang/notes/{id}`

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
          "owner_id": "c1840f0f-c2fa-45ce-b1de-f97e445c5202",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "62f5d85c-d2a7-4ed1-91ed-7fd5dc68413e",
    "type": "notes",
    "attributes": {
      "created_at": "2024-04-15T09:25:29+00:00",
      "updated_at": "2024-04-15T09:25:29+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "c1840f0f-c2fa-45ce-b1de-f97e445c5202",
      "owner_type": "customers",
      "employee_id": "fc0911d1-b234-42b7-8058-ece1b5405f0c"
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
      "id": "489d3015-b7b3-44d9-a002-c62b07c2b764",
      "type": "notes",
      "attributes": {
        "created_at": "2024-04-15T09:25:30+00:00",
        "updated_at": "2024-04-15T09:25:30+00:00",
        "body": "Agreed to give this customer a 20% discount on the next order",
        "owner_id": "7c0197c7-9379-40f4-960a-d85188fde248",
        "owner_type": "customers",
        "employee_id": "047ab890-d812-4cf8-8909-1eab03a745f5"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/7c0197c7-9379-40f4-960a-d85188fde248"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/047ab890-d812-4cf8-8909-1eab03a745f5"
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






## Deleting a note



> How to delete a note:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/notes/c4d294d2-5639-4cd2-b38c-c19d48747f4d' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "c4d294d2-5639-4cd2-b38c-c19d48747f4d",
    "type": "notes",
    "attributes": {
      "created_at": "2024-04-15T09:25:30+00:00",
      "updated_at": "2024-04-15T09:25:30+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "12f4cab1-156f-4091-aed4-a4525062aed2",
      "owner_type": "customers",
      "employee_id": "812351ab-47a8-4d36-92c9-34f958f49ce8"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/12f4cab1-156f-4091-aed4-a4525062aed2"
        }
      },
      "employee": {
        "links": {
          "related": "api/boomerang/employees/812351ab-47a8-4d36-92c9-34f958f49ce8"
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






## Fetching a note



> How to fetch a note:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/notes/c0c3b41f-ee67-4db7-bf10-1be1816b0542' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "c0c3b41f-ee67-4db7-bf10-1be1816b0542",
    "type": "notes",
    "attributes": {
      "created_at": "2024-04-15T09:25:31+00:00",
      "updated_at": "2024-04-15T09:25:31+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "24fbe533-7de2-4d34-9683-5c1a162e85dc",
      "owner_type": "customers",
      "employee_id": "fa314cb3-008f-4ca0-986a-39724d25af10"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/24fbe533-7de2-4d34-9683-5c1a162e85dc"
        }
      },
      "employee": {
        "links": {
          "related": "api/boomerang/employees/fa314cb3-008f-4ca0-986a-39724d25af10"
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





