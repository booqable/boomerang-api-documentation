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
`theme_id` | **Uuid** `readonly-after-create`<br>The ID of the Theme that the Publication belongs to.


## Relationships
Publications have the following relationships:

Name | Description
-- | --
`theme` | **[Theme](#themes)** <br>Associated Theme


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
      "id": "8bf8bbc9-ad55-4a2c-843f-44d5210a81c9",
      "type": "publications",
      "attributes": {
        "created_at": "2024-12-02T13:04:49.508295+00:00",
        "updated_at": "2024-12-02T13:04:49.508295+00:00",
        "published_at": "2024-11-27T13:04:49.504269+00:00",
        "theme_id": "b9541a14-58ae-4fba-989b-3b2f1771a803"
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
          "theme_id": "96f64c48-32de-4d70-9e57-cc94c3fb9fe7"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "42a3503a-a562-45d4-9185-9beb7ef091fd",
    "type": "publications",
    "attributes": {
      "created_at": "2024-11-27T13:04:49.000959+00:00",
      "updated_at": "2024-11-27T13:04:49.000959+00:00",
      "published_at": "2024-11-27T13:04:49.000959+00:00",
      "theme_id": "96f64c48-32de-4d70-9e57-cc94c3fb9fe7"
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





