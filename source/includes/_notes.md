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
- | -
`id` | **Uuid** `readonly`<br>Primary key
`created_at` | **Datetime** `readonly`<br>When the resource was created
`updated_at` | **Datetime** `readonly`<br>When the resource was last updated
`body` | **String**<br>The content of the note
`owner_id` | **Uuid**<br>ID of the resource the note is attached to
`owner_type` | **String**<br>The resource type of the owner. One of `orders`, `documents`, `product_groups`, `bundles`, `products`, `customers`, `stock_items`
`employee_id` | **Uuid** `readonly`<br>The associated Employee


## Relationships
Notes have the following relationships:

Name | Description
- | -
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
      "id": "a191d736-af43-454e-9bf3-147025c8a135",
      "type": "notes",
      "attributes": {
        "created_at": "2022-02-08T09:13:52+00:00",
        "updated_at": "2022-02-08T09:13:52+00:00",
        "body": "Agreed to give this customer a 20% discount on the next order",
        "owner_id": "596e7c80-234a-48ca-9a07-61a6a4f54ff0",
        "owner_type": "customers",
        "employee_id": "a8601082-5796-41ba-a97d-eb3fda6dc806"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/596e7c80-234a-48ca-9a07-61a6a4f54ff0"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/a8601082-5796-41ba-a97d-eb3fda6dc806"
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=owner,employee`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[notes]=id,created_at,updated_at`
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-02-08T09:12:26Z`
`sort` | **String**<br>How to sort the data `?sort=-created_at`
`meta` | **Hash**<br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String**<br>The page to request
`page[size]` | **String**<br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
`id` | **Uuid**<br>`eq`, `not_eq`
`created_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`owner_id` | **Uuid**<br>`eq`, `not_eq`
`owner_type` | **String**<br>`eq`, `not_eq`
`employee_id` | **Uuid**<br>`eq`, `not_eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array**<br>`count`


### Includes

This request accepts the following includes:

`owner`


`employee`






## Fetching a note



> How to fetch a note:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/notes/b03db731-ab36-4e23-9fdf-a3ee65f9091d' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "b03db731-ab36-4e23-9fdf-a3ee65f9091d",
    "type": "notes",
    "attributes": {
      "created_at": "2022-02-08T09:13:52+00:00",
      "updated_at": "2022-02-08T09:13:52+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "30a307bb-fbef-4046-94fe-555b46784232",
      "owner_type": "customers",
      "employee_id": "b2364ac5-0e67-4d01-b8a8-ca9b764fb66c"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/30a307bb-fbef-4046-94fe-555b46784232"
        }
      },
      "employee": {
        "links": {
          "related": "api/boomerang/employees/b2364ac5-0e67-4d01-b8a8-ca9b764fb66c"
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=owner,employee`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[notes]=id,created_at,updated_at`


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
          "owner_id": "57c25bac-63a4-4731-9ced-b2b33c4f1cd4",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "2427e72e-39e9-48fe-b7df-4ede9e9813f0",
    "type": "notes",
    "attributes": {
      "created_at": "2022-02-08T09:13:52+00:00",
      "updated_at": "2022-02-08T09:13:52+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "57c25bac-63a4-4731-9ced-b2b33c4f1cd4",
      "owner_type": "customers",
      "employee_id": "9fe9c83a-e6ee-416c-b662-e125bacba5d8"
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=owner,employee`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[notes]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][body]` | **String**<br>The content of the note
`data[attributes][owner_id]` | **Uuid**<br>ID of the resource the note is attached to
`data[attributes][owner_type]` | **String**<br>The resource type of the owner. One of `orders`, `documents`, `product_groups`, `bundles`, `products`, `customers`, `stock_items`


### Includes

This request accepts the following includes:

`owner`






## Deleting a note



> How to delete a note:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/notes/bf79f030-13c2-46c1-8da4-6b522cb79dcc' \
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=owner,employee`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[notes]=id,created_at,updated_at`


### Includes

This request does not accept any includes