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
`theme_id` | **Uuid** <br>The ID of the Theme that the Publication belongs to.


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
      "id": "46fa1247-e0f7-405d-ac05-7258994a4bcf",
      "type": "publications",
      "attributes": {
        "created_at": "2024-11-25T09:27:06.278196+00:00",
        "updated_at": "2024-11-25T09:27:06.278196+00:00",
        "published_at": "2024-11-20T09:27:06.270999+00:00",
        "theme_id": "13a4ac4b-1274-4748-a2d4-78df5e285533"
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
          "theme_id": "50395ff4-b024-4813-87d6-9c4421656968"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "44c6cbae-ed66-4fd6-8048-17744f003874",
    "type": "publications",
    "attributes": {
      "created_at": "2024-11-20T09:27:06.899903+00:00",
      "updated_at": "2024-11-20T09:27:06.899903+00:00",
      "published_at": "2024-11-20T09:27:06.899903+00:00",
      "theme_id": "50395ff4-b024-4813-87d6-9c4421656968"
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
`data[attributes][theme_id]` | **Uuid** <br>The ID of the Theme that the Publication belongs to.


### Includes

This request accepts the following includes:

`theme`


`assets`





