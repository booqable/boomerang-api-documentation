# Assets

Theme assets are the individual files that make up a shop's theme.

## Endpoints
`GET /api/boomerang/assets`

`POST /api/boomerang/assets`

`DELETE /api/boomerang/assets/{id}`

## Fields
Every asset has the following fields:

Name | Description
- | -
`id` | **Uuid** `readonly`<br>Primary key
`created_at` | **Datetime** `readonly`<br>When the resource was created
`updated_at` | **Datetime** `readonly`<br>When the resource was last updated
`key` | **String**<br>The path of the asset within a theme. It consists of the file's directory and filename. For example, the asset `layouts/index.liquid` is in the layouts directory, so its key is `layouts/index.liquid`.
`checksum` | **String** `readonly`<br>The checksum of the content value or file in SHA256.
`content_type` | **String** `readonly`<br>The MIME representation of the content, consisting of the type and subtype of the asset. One of `image/jpeg`, `image/gif`, `image/png`, `text/css`, `application/javascript`, `application/liquid`, `application/json`
`value` | **String**<br>The text content of the asset, such as the HTML and Liquid markup of a template file.
`published_at` | **Datetime** `readonly`<br>The date and time (ISO 8601 format) when the asset was published.
`theme_id` | **Uuid**<br>The associated Theme
`file` | **Carrierwave_file**<br>An object describing the binary file belonging to the asset.


## Relationships
Assets have the following relationships:

Name | Description
- | -
`theme` | **Themes**<br>Associated Theme


## Listing assets



> How to fetch a list of assets:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/assets' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "8e1a8678-0377-4f0c-a66f-8c0647575d9a",
      "type": "assets",
      "attributes": {
        "created_at": "2022-05-04T10:04:07+00:00",
        "updated_at": "2022-05-04T10:04:07+00:00",
        "key": "templates/index.json",
        "checksum": "584f28d8181faf694dfc2aef58b542add1c5d99262de7bca9d043c3da82fbadd",
        "content_type": "application/json",
        "value": "{ name: 'index' }",
        "published_at": "2022-04-27T10:04:07+00:00",
        "theme_id": "529d8860-68c3-409a-a6db-9775950089e2",
        "file": {
          "url": null
        }
      },
      "relationships": {
        "theme": {
          "links": {
            "related": "api/boomerang/themes/529d8860-68c3-409a-a6db-9775950089e2"
          }
        }
      }
    }
  ],
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/assets`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=theme`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[assets]=id,created_at,updated_at`
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-05-04T10:04:04Z`
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
`key` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`checksum` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`content_type` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`published_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`theme_id` | **Uuid**<br>`eq`, `not_eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array**<br>`count`
`published` | **Array**<br>`count`
`unpublished` | **Array**<br>`count`


### Includes

This request accepts the following includes:

`theme`






## Creating an asset



> How to create a new asset:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/assets' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "assets",
        "attributes": {
          "key": "templates/index.json",
          "value": "{ name: 'index' }",
          "theme_id": "3f4a1766-fe63-42b0-95d9-31c878a5c1cf"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "d8f27e36-3f81-4b57-a0e4-04bd71e2795f",
    "type": "assets",
    "attributes": {
      "created_at": "2022-05-04T10:04:07+00:00",
      "updated_at": "2022-05-04T10:04:07+00:00",
      "key": "templates/index.json",
      "checksum": "584f28d8181faf694dfc2aef58b542add1c5d99262de7bca9d043c3da82fbadd",
      "content_type": "application/json",
      "value": "{ name: 'index' }",
      "published_at": null,
      "theme_id": "3f4a1766-fe63-42b0-95d9-31c878a5c1cf",
      "file": {
        "url": null
      }
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

`POST /api/boomerang/assets`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=theme`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[assets]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][key]` | **String**<br>The path of the asset within a theme. It consists of the file's directory and filename. For example, the asset `layouts/index.liquid` is in the layouts directory, so its key is `layouts/index.liquid`.
`data[attributes][value]` | **String**<br>The text content of the asset, such as the HTML and Liquid markup of a template file.
`data[attributes][theme_id]` | **Uuid**<br>The associated Theme
`data[attributes][file]` | **Carrierwave_file**<br>An object describing the binary file belonging to the asset.


### Includes

This request accepts the following includes:

`theme`






## Deleting an asset



> How to delete an asset:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/assets/82747ee8-8762-41af-b706-ce6c1c119c48' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "meta": {}
}
```

### HTTP Request

`DELETE /api/boomerang/assets/{id}`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=theme`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[assets]=id,created_at,updated_at`


### Includes

This request accepts the following includes:

`theme`





