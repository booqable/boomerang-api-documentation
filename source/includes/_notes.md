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
      "id": "83aabf30-02ec-494d-a119-a9bb291ad707",
      "type": "notes",
      "attributes": {
        "created_at": "2022-06-23T19:02:24+00:00",
        "updated_at": "2022-06-23T19:02:24+00:00",
        "body": "Agreed to give this customer a 20% discount on the next order",
        "owner_id": "fd9d1e05-622e-4720-904a-d853b37b30d1",
        "owner_type": "customers",
        "employee_id": "89b38488-9c9d-475a-86df-eca31fd7068c"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/fd9d1e05-622e-4720-904a-d853b37b30d1"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/89b38488-9c9d-475a-86df-eca31fd7068c"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-06-23T19:00:38Z`
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
    --url 'https://example.booqable.com/api/boomerang/notes/68012e00-c66b-4bc9-9da8-5fb2445b8282' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "68012e00-c66b-4bc9-9da8-5fb2445b8282",
    "type": "notes",
    "attributes": {
      "created_at": "2022-06-23T19:02:25+00:00",
      "updated_at": "2022-06-23T19:02:25+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "6fa0df39-c058-4229-a677-cae307545602",
      "owner_type": "customers",
      "employee_id": "94cd7407-605e-48f9-9c41-c5b6785353f8"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/6fa0df39-c058-4229-a677-cae307545602"
        }
      },
      "employee": {
        "links": {
          "related": "api/boomerang/employees/94cd7407-605e-48f9-9c41-c5b6785353f8"
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
          "owner_id": "93ecd38b-7f58-4e38-8c2e-9a64c614c104",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "5b4caf75-d873-4746-aa8f-ff129054e861",
    "type": "notes",
    "attributes": {
      "created_at": "2022-06-23T19:02:25+00:00",
      "updated_at": "2022-06-23T19:02:25+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "93ecd38b-7f58-4e38-8c2e-9a64c614c104",
      "owner_type": "customers",
      "employee_id": "068f8a80-d0dd-424b-851b-f094efb4176d"
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
    --url 'https://example.booqable.com/api/boomerang/notes/717fc829-91cd-45a2-8cfb-c633be867732' \
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