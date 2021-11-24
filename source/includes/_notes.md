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
      "id": "d385c25f-1a14-4fef-b572-420cf0b90e37",
      "type": "notes",
      "attributes": {
        "created_at": "2021-11-24T18:21:54+00:00",
        "updated_at": "2021-11-24T18:21:54+00:00",
        "body": "Agreed to give this customer a 20% discount on the next order",
        "owner_id": "f18d9024-1b0a-4d28-b0be-8eb07daf38ac",
        "owner_type": "customers",
        "employee_id": "0c8f2abf-5d2f-4788-9ba4-2639890521ed"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/f18d9024-1b0a-4d28-b0be-8eb07daf38ac"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/0c8f2abf-5d2f-4788-9ba4-2639890521ed"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-11-24T18:20:56Z`
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
    --url 'https://example.booqable.com/api/boomerang/notes/26067a39-abff-4e4f-aaa9-af3c32f8978e' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "26067a39-abff-4e4f-aaa9-af3c32f8978e",
    "type": "notes",
    "attributes": {
      "created_at": "2021-11-24T18:21:54+00:00",
      "updated_at": "2021-11-24T18:21:54+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "bbd03f19-cc4e-4471-b160-4dabceca899e",
      "owner_type": "customers",
      "employee_id": "4fe00e57-4f9c-4e54-860d-f58daae3ef58"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/bbd03f19-cc4e-4471-b160-4dabceca899e"
        }
      },
      "employee": {
        "links": {
          "related": "api/boomerang/employees/4fe00e57-4f9c-4e54-860d-f58daae3ef58"
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
          "owner_id": "584cb157-071e-4d02-97b0-3282d1109f12",
          "owner_type": "customers"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "abbd37ed-51f7-46c7-9b81-05aa73d4c2c5",
    "type": "notes",
    "attributes": {
      "created_at": "2021-11-24T18:21:55+00:00",
      "updated_at": "2021-11-24T18:21:55+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "584cb157-071e-4d02-97b0-3282d1109f12",
      "owner_type": "customers",
      "employee_id": "2c480af4-38d1-482c-81cd-9c0514ab7622"
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
    "self": "api/boomerang/notes?data%5Battributes%5D%5Bbody%5D=Agreed+to+give+this+customer+a+20%25+discount+on+the+next+order&data%5Battributes%5D%5Bowner_id%5D=584cb157-071e-4d02-97b0-3282d1109f12&data%5Battributes%5D%5Bowner_type%5D=customers&data%5Btype%5D=notes&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/notes?data%5Battributes%5D%5Bbody%5D=Agreed+to+give+this+customer+a+20%25+discount+on+the+next+order&data%5Battributes%5D%5Bowner_id%5D=584cb157-071e-4d02-97b0-3282d1109f12&data%5Battributes%5D%5Bowner_type%5D=customers&data%5Btype%5D=notes&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/notes?data%5Battributes%5D%5Bbody%5D=Agreed+to+give+this+customer+a+20%25+discount+on+the+next+order&data%5Battributes%5D%5Bowner_id%5D=584cb157-071e-4d02-97b0-3282d1109f12&data%5Battributes%5D%5Bowner_type%5D=customers&data%5Btype%5D=notes&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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
    --url 'https://example.booqable.com/api/boomerang/notes/0083d3c5-ec16-4f81-a821-6a51bc95944f' \
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