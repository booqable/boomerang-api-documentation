# Publications

A publication marks a moment from which all previously persisted Assets in a Theme are released.

## Relationships
Name | Description
-- | --
`theme` | **[Theme](#themes)** `required`<br>The Theme that the Publication belongs to.


Check matching attributes under [Fields](#publications-fields) to see which relations can be written.
<br/ >
Check each individual operation to see which relations can be included as a sideload.
## Fields

 Name | Description
-- | --
`created_at` | **datetime** `readonly`<br>When the resource was created.
`id` | **uuid** `readonly`<br>Primary key.
`published_at` | **datetime** `readonly`<br>The date and time (ISO 8601 format) the Publication uses to filter all released Assets by.
`theme_id` | **uuid** `readonly-after-create`<br>The Theme that the Publication belongs to.
`updated_at` | **datetime** `readonly`<br>When the resource was last updated.


## Listing publications


> How to fetch a list of publications:

```shell
  curl --get 'https://example.booqable.com/api/boomerang/publications'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": [
      {
        "id": "bb352822-78d2-4736-86da-98b9dda712e5",
        "type": "publications",
        "attributes": {
          "created_at": "2028-06-17T00:07:00.000000+00:00",
          "updated_at": "2028-06-17T00:07:00.000000+00:00",
          "published_at": "2028-06-12T00:07:00.000000+00:00",
          "theme_id": "563b52b6-8650-4a3f-8c5e-74b5c90cac4b"
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
`fields[]` | **array** <br>List of comma seperated fields to include `?fields[publications]=created_at,updated_at,published_at`
`filter` | **hash** <br>The filters to apply `?filter[attribute][eq]=value`
`include` | **string** <br>List of comma seperated relationships `?include=theme`
`meta` | **hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **string** <br>The page to request
`page[size]` | **string** <br>The amount of items per page (max 100)
`sort` | **string** <br>How to sort the data `?sort=attribute1,-attribute2`


### Filters

This request can be filtered on:

Name | Description
-- | --
`created_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`id` | **uuid** <br>`eq`, `not_eq`
`published_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`theme_id` | **uuid** <br>`eq`, `not_eq`
`updated_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **array** <br>`count`


### Includes

This request accepts the following includes:

`theme`






## Creating a publication


> How to create a new publication:

```shell
  curl --request POST \
       --url 'https://example.booqable.com/api/boomerang/publications'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "type": "publications",
           "attributes": {
             "theme_id": "1f46931b-6746-466c-8eb5-304a2becea54"
           }
         }
       }'
```

> A 201 status response looks like this:

```json
  {
    "data": {
      "id": "404928d1-a65b-40a1-80e4-bff95ae6b9b2",
      "type": "publications",
      "attributes": {
        "created_at": "2023-10-09T13:36:02.000000+00:00",
        "updated_at": "2023-10-09T13:36:02.000000+00:00",
        "published_at": "2023-10-09T13:36:02.000000+00:00",
        "theme_id": "1f46931b-6746-466c-8eb5-304a2becea54"
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
`fields[]` | **array** <br>List of comma seperated fields to include `?fields[publications]=created_at,updated_at,published_at`
`include` | **string** <br>List of comma seperated relationships `?include=theme,assets`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][theme_id]` | **uuid** <br>The Theme that the Publication belongs to.


### Includes

This request accepts the following includes:

`theme`


`assets`





