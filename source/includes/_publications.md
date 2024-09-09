# Publications

A publication marks a moment from which all previously persisted Asstes in a Theme are released.

## Endpoints
`GET /api/boomerang/publications`

`POST /api/boomerang/publications`

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
      "id": "40cf70a1-323f-4b9b-9c70-e612f4c352bb",
      "type": "publications",
      "attributes": {
        "created_at": "2024-09-09T09:23:59.080145+00:00",
        "updated_at": "2024-09-09T09:23:59.080145+00:00",
        "published_at": "2024-09-04T09:23:59.076393+00:00",
        "theme_id": "70bc93f6-975f-4fd3-b9aa-4165ca17eee5"
      },
      "relationships": {}
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
          "theme_id": "b53a0bf5-bed1-454a-ade7-a224424ac57b"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "af2273a5-1c16-4e2f-b22e-8834b59181fa",
    "type": "publications",
    "attributes": {
      "created_at": "2024-09-04T09:23:58.649555+00:00",
      "updated_at": "2024-09-04T09:23:58.649555+00:00",
      "published_at": "2024-09-04T09:23:58.649555+00:00",
      "theme_id": "b53a0bf5-bed1-454a-ade7-a224424ac57b"
    },
    "relationships": {}
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





