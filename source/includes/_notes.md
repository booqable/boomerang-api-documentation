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
      "id": "95e5390b-b320-41e8-a9f4-37e916158fcd",
      "type": "notes",
      "attributes": {
        "created_at": "2021-11-18T14:42:47+00:00",
        "updated_at": "2021-11-18T14:42:47+00:00",
        "body": "Agreed to give this customer a 20% discount on the next order",
        "owner_id": "75ca78ec-1b98-48c7-b1cd-b357f365c989",
        "owner_type": "customers",
        "employee_id": "a7e7ee4b-3dd4-4d71-bfae-dffdfbbfd2f6"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/75ca78ec-1b98-48c7-b1cd-b357f365c989"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/a7e7ee4b-3dd4-4d71-bfae-dffdfbbfd2f6"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-11-18T14:41:21Z`
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
    --url 'https://example.booqable.com/api/boomerang/notes/2cacc194-4480-404c-bff0-2a46ce65ae73' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "2cacc194-4480-404c-bff0-2a46ce65ae73",
    "type": "notes",
    "attributes": {
      "created_at": "2021-11-18T14:42:48+00:00",
      "updated_at": "2021-11-18T14:42:48+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "b9f5f5fd-10de-412d-9a81-d656964c83a0",
      "owner_type": "customers",
      "employee_id": "b8134896-1aa9-4abf-aef0-ed0662cbb432"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/b9f5f5fd-10de-412d-9a81-d656964c83a0"
        }
      },
      "employee": {
        "links": {
          "related": "api/boomerang/employees/b8134896-1aa9-4abf-aef0-ed0662cbb432"
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
          "owner_id": "f311bc78-f29b-4ef2-8c11-7063d5386521",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "4486e207-c7ec-499a-94c5-45cf1d1d837a",
    "type": "notes",
    "attributes": {
      "created_at": "2021-11-18T14:42:48+00:00",
      "updated_at": "2021-11-18T14:42:48+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "f311bc78-f29b-4ef2-8c11-7063d5386521",
      "owner_type": "customers",
      "employee_id": "91dd0414-a213-430c-b2e4-f7dda1d6ace4"
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
    "self": "api/boomerang/notes?data%5Battributes%5D%5Bbody%5D=Agreed+to+give+this+customer+a+20%25+discount+on+the+next+order&data%5Battributes%5D%5Bowner_id%5D=f311bc78-f29b-4ef2-8c11-7063d5386521&data%5Battributes%5D%5Bowner_type%5D=customers&data%5Btype%5D=notes&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/notes?data%5Battributes%5D%5Bbody%5D=Agreed+to+give+this+customer+a+20%25+discount+on+the+next+order&data%5Battributes%5D%5Bowner_id%5D=f311bc78-f29b-4ef2-8c11-7063d5386521&data%5Battributes%5D%5Bowner_type%5D=customers&data%5Btype%5D=notes&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/notes?data%5Battributes%5D%5Bbody%5D=Agreed+to+give+this+customer+a+20%25+discount+on+the+next+order&data%5Battributes%5D%5Bowner_id%5D=f311bc78-f29b-4ef2-8c11-7063d5386521&data%5Battributes%5D%5Bowner_type%5D=customers&data%5Btype%5D=notes&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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
    --url 'https://example.booqable.com/api/boomerang/notes/16f4cf80-6195-4822-bc57-681bb6ea9c2b' \
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