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
      "id": "e8a8fff4-4765-43c7-a79d-1254c66b2d12",
      "type": "notes",
      "attributes": {
        "created_at": "2022-04-08T17:52:32+00:00",
        "updated_at": "2022-04-08T17:52:32+00:00",
        "body": "Agreed to give this customer a 20% discount on the next order",
        "owner_id": "db50cc65-f41b-4c83-9ac6-662c4dd79ba3",
        "owner_type": "customers",
        "employee_id": "194638b3-7abe-441a-a291-deb95ae974ba"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/db50cc65-f41b-4c83-9ac6-662c4dd79ba3"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/194638b3-7abe-441a-a291-deb95ae974ba"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-04-08T17:51:17Z`
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
    --url 'https://example.booqable.com/api/boomerang/notes/96d118c0-5819-4083-b2fa-330c70c5504f' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "96d118c0-5819-4083-b2fa-330c70c5504f",
    "type": "notes",
    "attributes": {
      "created_at": "2022-04-08T17:52:32+00:00",
      "updated_at": "2022-04-08T17:52:32+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "07f7808f-1773-4fec-ae09-948299f0bca3",
      "owner_type": "customers",
      "employee_id": "b0b99ba5-3bad-4e0a-ac80-7bf1159ffbd5"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/07f7808f-1773-4fec-ae09-948299f0bca3"
        }
      },
      "employee": {
        "links": {
          "related": "api/boomerang/employees/b0b99ba5-3bad-4e0a-ac80-7bf1159ffbd5"
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
          "owner_id": "6033b0cd-34a1-416b-9c87-78fbaf6c1946",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "67d23da1-f14a-4877-ae6e-1f2996d045c8",
    "type": "notes",
    "attributes": {
      "created_at": "2022-04-08T17:52:32+00:00",
      "updated_at": "2022-04-08T17:52:32+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "6033b0cd-34a1-416b-9c87-78fbaf6c1946",
      "owner_type": "customers",
      "employee_id": "e3b655e5-3678-431e-abf7-9e091103b514"
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
    --url 'https://example.booqable.com/api/boomerang/notes/c9716f4b-78c4-43ae-8875-6b66ad8e3070' \
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