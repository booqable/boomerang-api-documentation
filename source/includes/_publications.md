# Publications

A publication marks a moment from which all previously persisted Asstes in a Theme are released.

## Endpoints
`GET /api/boomerang/publications`

`POST /api/boomerang/publications`

## Fields
Every publication has the following fields:

Name | Description
- | -
`id` | **Uuid** `readonly`<br>Primary key
`created_at` | **Datetime** `readonly`<br>When the resource was created
`updated_at` | **Datetime** `readonly`<br>When the resource was last updated
`published_at` | **Datetime** `readonly`<br>The date and time (ISO 8601 format) the Publication uses to filter all released Assets by.
`theme_id` | **Uuid** <br>The associated Theme


## Relationships
Publications have the following relationships:

Name | Description
- | -
`theme` | **Themes** `readonly`<br>Associated Theme


## Listing publications



> How to fetch a list of publications:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/publications' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "f25c5d51-9f68-40a4-bb82-adfc061deb6a",
      "type": "publications",
      "attributes": {
        "created_at": "2023-02-09T10:13:05+00:00",
        "updated_at": "2023-02-09T10:13:05+00:00",
        "published_at": "2023-02-04T10:13:05+00:00",
        "theme_id": "dc3a9bec-2b72-46fa-942e-a7fbb7fcf705"
      },
      "relationships": {
        "theme": {
          "links": {
            "related": "api/boomerang/themes/dc3a9bec-2b72-46fa-942e-a7fbb7fcf705"
          }
        }
      }
    }
  ],
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/publications`

### Request params

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=theme`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[publications]=id,created_at,updated_at`
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-09T10:09:54Z`
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
`published_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`theme_id` | **Uuid** <br>`eq`, `not_eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array** <br>`count`


### Includes

This request accepts the following includes:

`theme`






## Creating a publication



> How to create a new publication:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/publications' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "publications",
        "attributes": {
          "theme_id": "1f21f15f-541a-4ab6-a3be-2d143b1efac0"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "c51ab69d-0b22-4c9e-b52b-ae0b252472d0",
    "type": "publications",
    "attributes": {
      "created_at": "2023-02-04T10:13:05+00:00",
      "updated_at": "2023-02-04T10:13:05+00:00",
      "published_at": "2023-02-04T10:13:05+00:00",
      "theme_id": "1f21f15f-541a-4ab6-a3be-2d143b1efac0"
    },
    "relationships": {
      "theme": {
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

`POST /api/boomerang/publications`

### Request params

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=theme`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[publications]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][theme_id]` | **Uuid** <br>The associated Theme


### Includes

This request accepts the following includes:

`theme`


`assets`





