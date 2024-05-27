# Publications

A publication marks a moment from which all previously persisted Asstes in a Theme are released.

## Endpoints
`POST /api/boomerang/publications`

`GET /api/boomerang/publications`

## Fields
Every publication has the following fields:

Name | Description
-- | --
`id` | **Uuid** `readonly`<br>Primary key
`created_at` | **Datetime** `readonly`<br>When the resource was created
`updated_at` | **Datetime** `readonly`<br>When the resource was last updated
`published_at` | **Datetime** `readonly`<br>The date and time (ISO 8601 format) the Publication uses to filter all released Assets by.
`theme_id` | **Uuid** <br>The associated Theme


## Relationships
Publications have the following relationships:

Name | Description
-- | --
`theme` | **Themes** `readonly`<br>Associated Theme


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
          "theme_id": "cac9e39c-4a93-4897-863d-0cc3390444ec"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "4d8ab254-5c22-4604-87f6-d760f9c6852a",
    "type": "publications",
    "attributes": {
      "created_at": "2024-05-22T09:29:35.589011+00:00",
      "updated_at": "2024-05-22T09:29:35.589011+00:00",
      "published_at": "2024-05-22T09:29:35.589011+00:00",
      "theme_id": "cac9e39c-4a93-4897-863d-0cc3390444ec"
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
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=theme,assets`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[publications]=created_at,updated_at,published_at`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][theme_id]` | **Uuid** <br>The associated Theme


### Includes

This request accepts the following includes:

`theme`


`assets`






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
      "id": "b452beb5-ddf6-41f4-8567-f1ea2f65a664",
      "type": "publications",
      "attributes": {
        "created_at": "2024-05-27T09:29:36.284397+00:00",
        "updated_at": "2024-05-27T09:29:36.284397+00:00",
        "published_at": "2024-05-22T09:29:36.277442+00:00",
        "theme_id": "f35ddcf1-1684-45fb-8b38-440b29760cfd"
      },
      "relationships": {
        "theme": {
          "links": {
            "related": "api/boomerang/themes/f35ddcf1-1684-45fb-8b38-440b29760cfd"
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
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=theme`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[publications]=created_at,updated_at,published_at`
`filter` | **Hash** <br>The filters to apply `?filter[attribute][eq]=value`
`sort` | **String** <br>How to sort the data `?sort=attribute1,-attribute2`
`meta` | **Hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String** <br>The page to request
`page[size]` | **String** <br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
-- | --
`id` | **Uuid** <br>`eq`, `not_eq`
`created_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`published_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`theme_id` | **Uuid** <br>`eq`, `not_eq`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **Array** <br>`count`


### Includes

This request accepts the following includes:

`theme`





