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
`body` | **String** <br>The content of the note
`owner_id` | **Uuid** <br>ID of the resource the note is attached to
`owner_type` | **String** <br>The resource type of the owner. One of `orders`, `documents`, `product_groups`, `bundles`, `products`, `customers`, `stock_items`, `users`
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
      "id": "005c1fd6-1279-4668-92f0-726c0b947026",
      "type": "notes",
      "attributes": {
        "created_at": "2022-11-04T15:24:32+00:00",
        "updated_at": "2022-11-04T15:24:32+00:00",
        "body": "Agreed to give this customer a 20% discount on the next order",
        "owner_id": "40cd0836-e843-4255-a055-99d0fe01e0ac",
        "owner_type": "customers",
        "employee_id": "fb809a44-abc6-4142-bedd-c262f8d69873"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/40cd0836-e843-4255-a055-99d0fe01e0ac"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/fb809a44-abc6-4142-bedd-c262f8d69873"
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
- | -
`include` | **String** <br>List of comma seperated relationships `?include=owner,employee`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[notes]=id,created_at,updated_at`
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-11-04T15:22:44Z`
`sort` | **String** <br>How to sort the data `?sort=-created_at`
`meta` | **Hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String** <br>The page to request
`page[size]` | **String** <br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
`id` | **Uuid** <br>`eq`, `not_eq`
`created_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`owner_id` | **Uuid** <br>`eq`, `not_eq`
`owner_type` | **String** <br>`eq`, `not_eq`
`employee_id` | **Uuid** <br>`eq`, `not_eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array** <br>`count`


### Includes

This request accepts the following includes:

`owner`


`employee`






## Fetching a note



> How to fetch a note:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/notes/d372cca8-839b-435b-a50a-e15da070d5b7' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "d372cca8-839b-435b-a50a-e15da070d5b7",
    "type": "notes",
    "attributes": {
      "created_at": "2022-11-04T15:24:32+00:00",
      "updated_at": "2022-11-04T15:24:32+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "362fac00-bf68-41fc-a678-55067e22bc7e",
      "owner_type": "customers",
      "employee_id": "6f074374-aaeb-452a-8b36-6ae79f7ecb22"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/362fac00-bf68-41fc-a678-55067e22bc7e"
        }
      },
      "employee": {
        "links": {
          "related": "api/boomerang/employees/6f074374-aaeb-452a-8b36-6ae79f7ecb22"
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
- | -
`include` | **String** <br>List of comma seperated relationships `?include=owner,employee`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[notes]=id,created_at,updated_at`


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
          "owner_id": "f8948a39-fd37-420c-b227-f914378e2dce",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "b56000e0-3582-42f2-82f3-9bcfc59504e0",
    "type": "notes",
    "attributes": {
      "created_at": "2022-11-04T15:24:32+00:00",
      "updated_at": "2022-11-04T15:24:32+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "f8948a39-fd37-420c-b227-f914378e2dce",
      "owner_type": "customers",
      "employee_id": "2c596194-07f1-4dd4-a0f2-9664abdf9b51"
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
- | -
`include` | **String** <br>List of comma seperated relationships `?include=owner,employee`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[notes]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
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
    --url 'https://example.booqable.com/api/boomerang/notes/acb49448-edb1-475f-a6f5-e10151251b5c' \
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
- | -
`include` | **String** <br>List of comma seperated relationships `?include=owner,employee`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[notes]=id,created_at,updated_at`


### Includes

This request does not accept any includes