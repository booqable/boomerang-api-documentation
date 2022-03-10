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
`theme_id` | **String**<br>The ID of the Theme that the Publication belongs to.


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
      "id": "b4d82c98-11cf-492f-9c21-0a0021a55658",
      "type": "publications",
      "attributes": {
        "created_at": "2022-03-09T10:03:59+00:00",
        "updated_at": "2022-03-09T10:03:59+00:00",
        "published_at": "2022-03-04T10:03:59+00:00",
        "theme_id": "14c3ed0d-fc0e-490e-a054-e75ff3310391"
      }
    }
  ],
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/publications`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[publications]=id,created_at,updated_at`
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-03-09T10:01:28Z`
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
`published_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`theme_id` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array**<br>`count`


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
          "theme_id": "5c3a2967-0493-4519-b1b9-e106caaa2159"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "54ba2b38-b9bf-45f0-8773-56e8156bbe5b",
    "type": "publications",
    "attributes": {
      "created_at": "2022-03-04T10:04:00+00:00",
      "updated_at": "2022-03-04T10:04:00+00:00",
      "published_at": "2022-03-04T10:04:00+00:00",
      "theme_id": "5c3a2967-0493-4519-b1b9-e106caaa2159"
    }
  },
  "meta": {}
}
```

### HTTP Request

`POST /api/boomerang/publications`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[publications]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][theme_id]` | **String**<br>The ID of the Theme that the Publication belongs to.


### Includes

This request accepts the following includes:

`theme`


`assets`





