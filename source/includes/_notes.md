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
      "id": "5042129a-3020-4de0-97a3-909b8f803d8a",
      "type": "notes",
      "attributes": {
        "body": "Agreed to give this customer a 20% discount on the next order",
        "owner_id": "e5bf2c38-1557-448d-8231-e1b516282902",
        "owner_type": "Customer",
        "employee_id": "88232916-7258-4c59-8d30-82b191f36b54"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/e5bf2c38-1557-448d-8231-e1b516282902"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/88232916-7258-4c59-8d30-82b191f36b54"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-10-28T15:48:52Z`
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
    --url 'https://example.booqable.com/api/boomerang/notes/41048f9d-b4ca-4616-bcbc-d48c3745afb2' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "41048f9d-b4ca-4616-bcbc-d48c3745afb2",
    "type": "notes",
    "attributes": {
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "8f38ce60-b203-428d-bca0-bab4ef6c7cf3",
      "owner_type": "Customer",
      "employee_id": "d7e8deac-c52f-46b0-9b59-ff89c694495c"
    },
    "relationships": {
      "owner": {
        "links": {
          "related": "api/boomerang/customers/8f38ce60-b203-428d-bca0-bab4ef6c7cf3"
        }
      },
      "employee": {
        "links": {
          "related": "api/boomerang/employees/d7e8deac-c52f-46b0-9b59-ff89c694495c"
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
          "owner_id": "4178091f-3c8f-44cc-ae71-7eb8c6b102cd",
          "owner_type": "Customer"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "a31d6474-1be5-40b0-8395-0e6f54754743",
    "type": "notes",
    "attributes": {
      "body": "Agreed to give this customer a 20% discount on the next order",
      "owner_id": "4178091f-3c8f-44cc-ae71-7eb8c6b102cd",
      "owner_type": "Customer",
      "employee_id": "b912352f-dd73-4563-b65d-1c80ee0b4712"
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
    "self": "api/boomerang/notes?data%5Battributes%5D%5Bbody%5D=Agreed+to+give+this+customer+a+20%25+discount+on+the+next+order&data%5Battributes%5D%5Bowner_id%5D=4178091f-3c8f-44cc-ae71-7eb8c6b102cd&data%5Battributes%5D%5Bowner_type%5D=Customer&data%5Btype%5D=notes&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/notes?data%5Battributes%5D%5Bbody%5D=Agreed+to+give+this+customer+a+20%25+discount+on+the+next+order&data%5Battributes%5D%5Bowner_id%5D=4178091f-3c8f-44cc-ae71-7eb8c6b102cd&data%5Battributes%5D%5Bowner_type%5D=Customer&data%5Btype%5D=notes&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/notes?data%5Battributes%5D%5Bbody%5D=Agreed+to+give+this+customer+a+20%25+discount+on+the+next+order&data%5Battributes%5D%5Bowner_id%5D=4178091f-3c8f-44cc-ae71-7eb8c6b102cd&data%5Battributes%5D%5Bowner_type%5D=Customer&data%5Btype%5D=notes&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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
    --url 'https://example.booqable.com/api/boomerang/notes/df2732be-35ff-4cbb-ac8a-eb82b79584ff' \
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