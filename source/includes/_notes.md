# Notes

Notes allow you to leave notes about a resource.

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
`body` | **String**<br>The body of the note
`notable_id` | **Uuid**<br>ID if the resource that the note was left for
`notable_type` | **String**<br>The resource type of the resource that the note was left for. One of `Order`, `Document`, `ProductGroup`, `Product`, `Customer`, `StockItem`
`employee_id` | **Uuid**<br>The associated Employee


## Relationships
A notes has the following relationships:

Name | Description
- | -
`notable` | **Customer**<br>Associated Notable
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
      "id": "b1fd2eef-3307-43e3-b89b-7fc0a7a6b3f6",
      "type": "notes",
      "attributes": {
        "created_at": "2021-10-07T13:04:27+00:00",
        "updated_at": "2021-10-07T13:04:27+00:00",
        "body": "Agreed to give this customer a 20% discount on the next order",
        "notable_id": "4a247273-b20b-46cd-9a31-212c9d90d491",
        "notable_type": "Customer",
        "employee_id": "f78a5a16-9978-4dfa-8463-72aa74c264e8"
      },
      "relationships": {
        "notable": {
          "links": {
            "related": "api/boomerang/customers/4a247273-b20b-46cd-9a31-212c9d90d491"
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/f78a5a16-9978-4dfa-8463-72aa74c264e8"
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
`include` | **String**<br>List of comma seperated relationships `?include=notable,employee`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[notes]=id,created_at,updated_at`
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-10-07T13:04:25Z`
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
`notable_id` | **Uuid**<br>`eq`, `not_eq`
`notable_type` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
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
    --url 'https://example.booqable.com/api/boomerang/notes/dfaf4c92-979c-4725-b6ed-5cc44739e922' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "dfaf4c92-979c-4725-b6ed-5cc44739e922",
    "type": "notes",
    "attributes": {
      "created_at": "2021-10-07T13:04:28+00:00",
      "updated_at": "2021-10-07T13:04:28+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "notable_id": "f1648990-a78d-4d58-831b-7e624fa3837e",
      "notable_type": "Customer",
      "employee_id": "c721c534-9b3c-4882-a5dd-c72735b6766e"
    },
    "relationships": {
      "notable": {
        "links": {
          "related": "api/boomerang/customers/f1648990-a78d-4d58-831b-7e624fa3837e"
        }
      },
      "employee": {
        "links": {
          "related": "api/boomerang/employees/c721c534-9b3c-4882-a5dd-c72735b6766e"
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
`include` | **String**<br>List of comma seperated relationships `?include=notable,employee`
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
          "notable_id": "27f824e5-f54e-4161-a6db-5e552eb5825c",
          "notable_type": "Customer"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "09710f16-14ed-4a5c-af81-5751eb9cea38",
    "type": "notes",
    "attributes": {
      "created_at": "2021-10-07T13:04:29+00:00",
      "updated_at": "2021-10-07T13:04:29+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "notable_id": "27f824e5-f54e-4161-a6db-5e552eb5825c",
      "notable_type": "Customer",
      "employee_id": "97479af2-7d8a-44cd-8df9-c13dec3dabb9"
    },
    "relationships": {
      "notable": {
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
`include` | **String**<br>List of comma seperated relationships `?include=notable,employee`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[notes]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][body]` | **String**<br>The body of the note
`data[attributes][notable_id]` | **Uuid**<br>ID if the resource that the note was left for
`data[attributes][notable_type]` | **String**<br>The resource type of the resource that the note was left for. One of `Order`, `Document`, `ProductGroup`, `Product`, `Customer`, `StockItem`
`data[attributes][employee_id]` | **Uuid**<br>The associated Employee


### Includes

This request accepts the following includes:

`notable`






## Deleting a note

> How to delete a note:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/notes/d8d79a81-d999-4ff1-af29-d44f20a7873f' \
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
`include` | **String**<br>List of comma seperated relationships `?include=notable,employee`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[notes]=id,created_at,updated_at`


### Includes

This request does not accept any includes