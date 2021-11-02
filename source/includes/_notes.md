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
`owner_type` | **String**<br>The resource type of the owner. One of `Order`, `Document`, `ProductGroup`, `Product`, `Customer`, `StockItem`
`employee_id` | **Uuid** `readonly`<br>The associated Employee


## Relationships
Notes have the following relationships:

Name | Description
- | -
`owner` | **Customer**<br>Associated Owner
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
      "id": "7f14931c-1175-4a73-8df1-af8ca2dd246b",
      "type": "notes",
      "attributes": {
        "body": "Agreed to give this customer a 20% discount on the next order",
        "owner_id": "dfad470b-80e5-4638-8aae-b56c0f12adcc",
        "owner_type": "Customer",
        "employee_id": "d9642fa3-3f2f-4bb7-8516-4c2e3bcd9e54"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/dfad470b-80e5-4638-8aae-b56c0f12adcc"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/d9642fa3-3f2f-4bb7-8516-4c2e3bcd9e54"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-11-02T08:22:24Z`
`sort` | **String**<br>How to sort the data `?sort=-created_at`
`meta` | **Hash**<br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String**<br>The page to request
`page[per]` | **String**<br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
`id` | **Uuid**<br>`eq`, `not_eq`
`created_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`owner_id` | **Uuid**<br>`eq`, `not_eq`
`owner_type` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
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
    --url 'https://example.booqable.com/api/boomerang/notes/8b687671-3441-4770-b497-66e4cb9629dc' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "8b687671-3441-4770-b497-66e4cb9629dc",
    "type": "notes",
    "attributes": {
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "85c45d97-1e1a-4782-bfd7-71a37ec672aa",
      "owner_type": "Customer",
      "employee_id": "88753c82-77ab-4dba-a177-d63545066105"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/85c45d97-1e1a-4782-bfd7-71a37ec672aa"
        }
      },
      "employee": {
        "links": {
          "related": "api/boomerang/employees/88753c82-77ab-4dba-a177-d63545066105"
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
          "owner_id": "08dd2e72-92f0-4ca1-b99a-fe27ac4b9bc5",
          "owner_type": "Customer"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "6743983e-7af5-4c5e-8e19-51ecce6cf8e0",
    "type": "notes",
    "attributes": {
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "08dd2e72-92f0-4ca1-b99a-fe27ac4b9bc5",
      "owner_type": "Customer",
      "employee_id": "84d87fe1-36c9-4b68-80ac-98097bad12ef"
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
    "self": "api/boomerang/notes?data%5Battributes%5D%5Bbody%5D=Agreed+to+give+this+customer+a+20%25+discount+on+the+next+order&data%5Battributes%5D%5Bowner_id%5D=08dd2e72-92f0-4ca1-b99a-fe27ac4b9bc5&data%5Battributes%5D%5Bowner_type%5D=Customer&data%5Btype%5D=notes&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/notes?data%5Battributes%5D%5Bbody%5D=Agreed+to+give+this+customer+a+20%25+discount+on+the+next+order&data%5Battributes%5D%5Bowner_id%5D=08dd2e72-92f0-4ca1-b99a-fe27ac4b9bc5&data%5Battributes%5D%5Bowner_type%5D=Customer&data%5Btype%5D=notes&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/notes?data%5Battributes%5D%5Bbody%5D=Agreed+to+give+this+customer+a+20%25+discount+on+the+next+order&data%5Battributes%5D%5Bowner_id%5D=08dd2e72-92f0-4ca1-b99a-fe27ac4b9bc5&data%5Battributes%5D%5Bowner_type%5D=Customer&data%5Btype%5D=notes&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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
`data[attributes][owner_type]` | **String**<br>The resource type of the owner. One of `Order`, `Document`, `ProductGroup`, `Product`, `Customer`, `StockItem`


### Includes

This request accepts the following includes:

`notable`






## Deleting a note



> How to delete a note:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/notes/30cbfae3-7b62-441c-a7ea-122a01122943' \
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