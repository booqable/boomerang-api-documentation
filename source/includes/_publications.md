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
      "id": "45eba10d-e3d4-4192-bf90-3de692a8f413",
      "type": "publications",
      "attributes": {
        "created_at": "2022-04-08T17:53:27+00:00",
        "updated_at": "2022-04-08T17:53:27+00:00",
        "published_at": "2022-04-03T17:53:27+00:00",
        "theme_id": "3e1fa29a-d86f-46e6-b725-aeb201138be8"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-04-08T17:51:17Z`
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
          "theme_id": "93042b6d-e17a-4c72-bdb3-ceedcec709aa"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "00bab204-2fa0-4d7b-8cc6-5c47a1ce01f7",
    "type": "publications",
    "attributes": {
      "created_at": "2022-04-03T17:53:27+00:00",
      "updated_at": "2022-04-03T17:53:27+00:00",
      "published_at": "2022-04-03T17:53:27+00:00",
      "theme_id": "93042b6d-e17a-4c72-bdb3-ceedcec709aa"
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





