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
`employee_id` | **Uuid** `readonly`<br>The associated Employee


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
      "id": "4ef38996-17c9-4a7f-81ff-e140a7c5d95b",
      "type": "notes",
      "attributes": {
        "created_at": "2021-10-14T14:20:18+00:00",
        "updated_at": "2021-10-14T14:20:18+00:00",
        "body": "Agreed to give this customer a 20% discount on the next order",
        "notable_id": null,
        "notable_type": null,
        "employee_id": "96e76827-8b71-4de9-9b37-c3eef01e10bf"
      },
      "relationships": {
        "notable": {
          "links": {
            "related": null
          }
        },
        "employee": {
          "links": {
            "related": "api/boomerang/employees/96e76827-8b71-4de9-9b37-c3eef01e10bf"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-10-14T14:20:15Z`
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
    --url 'https://example.booqable.com/api/boomerang/notes/bddc64d7-0480-46dd-ad4c-b99fb35b7eac' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "bddc64d7-0480-46dd-ad4c-b99fb35b7eac",
    "type": "notes",
    "attributes": {
      "created_at": "2021-10-14T14:20:19+00:00",
      "updated_at": "2021-10-14T14:20:19+00:00",
      "body": "Agreed to give this customer a 20% discount on the next order",
      "notable_id": null,
      "notable_type": null,
      "employee_id": "1c4ab166-63b4-4e78-9556-84752435a2d6"
    },
    "relationships": {
      "notable": {
        "links": {
          "related": null
        }
      },
      "employee": {
        "links": {
          "related": "api/boomerang/employees/1c4ab166-63b4-4e78-9556-84752435a2d6"
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


### Includes

This request accepts the following includes:

`notable`






## Deleting a note

> How to delete a note:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/notes/f53a1962-2d1a-42e7-a539-9023f5d2be21' \
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