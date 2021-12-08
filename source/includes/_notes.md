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
`owner` | **Customer, Product, Product group, Stock item, Bundle, Order**<br>Associated Owner
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
      "id": "9d8b331e-1094-485e-8145-809b66fcc78d",
      "type": "notes",
      "attributes": {
        "created_at": "2021-12-08T12:34:50+00:00",
        "updated_at": "2021-12-08T12:34:50+00:00",
        "body": "Agreed to give this customer a 20% discount on the next order",
        "owner_id": "c9f65909-fe04-433b-9eb8-df3253c2c9a6",
        "owner_type": "customers",
        "employee_id": "f8a00905-ea37-4589-8a80-11580450aa00"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/c9f65909-fe04-433b-9eb8-df3253c2c9a6"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/f8a00905-ea37-4589-8a80-11580450aa00"
          }
        }
      }
    }
  ],
  "links": {
    "self": "api/boomerang/notes?page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/notes?page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/notes?page%5Bnumber%5D=1&page%5Bsize%5D=25"
  },
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-12-08T12:33:46Z`
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

`notable`






## Fetching a note



> How to fetch a note:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/notes/5d214c6e-fa8c-4180-99d4-02cf81cab18c' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "5d214c6e-fa8c-4180-99d4-02cf81cab18c",
    "type": "notes",
    "attributes": {
      "created_at": "2021-12-08T12:34:50+00:00",
      "updated_at": "2021-12-08T12:34:50+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "96fc104c-646b-4ad8-8c13-20de9dfaf04a",
      "owner_type": "customers",
      "employee_id": "42ad2a30-ade2-4563-acb5-33233caa99aa"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/96fc104c-646b-4ad8-8c13-20de9dfaf04a"
        }
      },
      "employee": {
        "links": {
          "related": "api/boomerang/employees/42ad2a30-ade2-4563-acb5-33233caa99aa"
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

`notable`






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
          "owner_id": "39ea2fd0-82e3-4bed-b2c2-410a05d9a77b",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "4f653c70-3d15-4eda-afdc-a95779aead4e",
    "type": "notes",
    "attributes": {
      "created_at": "2021-12-08T12:34:50+00:00",
      "updated_at": "2021-12-08T12:34:50+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "39ea2fd0-82e3-4bed-b2c2-410a05d9a77b",
      "owner_type": "customers",
      "employee_id": "3077b17b-056b-4dba-8ee7-1e08065342f2"
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
  "links": {
    "self": "api/boomerang/notes?data%5Battributes%5D%5Bbody%5D=Agreed+to+give+this+customer+a+20%25+discount+on+the+next+order&data%5Battributes%5D%5Bowner_id%5D=39ea2fd0-82e3-4bed-b2c2-410a05d9a77b&data%5Battributes%5D%5Bowner_type%5D=customers&data%5Btype%5D=notes&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/notes?data%5Battributes%5D%5Bbody%5D=Agreed+to+give+this+customer+a+20%25+discount+on+the+next+order&data%5Battributes%5D%5Bowner_id%5D=39ea2fd0-82e3-4bed-b2c2-410a05d9a77b&data%5Battributes%5D%5Bowner_type%5D=customers&data%5Btype%5D=notes&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/notes?data%5Battributes%5D%5Bbody%5D=Agreed+to+give+this+customer+a+20%25+discount+on+the+next+order&data%5Battributes%5D%5Bowner_id%5D=39ea2fd0-82e3-4bed-b2c2-410a05d9a77b&data%5Battributes%5D%5Bowner_type%5D=customers&data%5Btype%5D=notes&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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

`notable`






## Deleting a note



> How to delete a note:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/notes/4eb35b47-f972-494b-bc8a-6ee3392e7c1a' \
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