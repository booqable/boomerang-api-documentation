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
`theme` | **Themes** `readonly`<br>Associated Theme


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
      "id": "a5c3bf32-14e3-4905-b993-44910f1a2034",
      "type": "assets",
      "attributes": {
        "created_at": "2022-03-31T14:14:36+00:00",
        "updated_at": "2022-03-31T14:14:36+00:00",
        "key": "templates/index.json",
        "checksum": "584f28d8181faf694dfc2aef58b542add1c5d99262de7bca9d043c3da82fbadd",
        "content_type": "application/json",
        "value": "{ name: 'index' }",
        "published_at": "2022-03-24T14:14:36+00:00",
        "theme_id": "e42412aa-d144-472d-b9f5-9017b79da88c",
        "file": {
          "url": null
        }
      },
      "relationships": {
        "theme": {
          "links": {
            "related": "api/boomerang/themes/e42412aa-d144-472d-b9f5-9017b79da88c"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-03-31T14:14:33Z`
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
          "theme_id": "cc25f7f7-9db5-460d-bce5-10cca38da293"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "993a69cd-b663-42d7-bcbb-69d061df286c",
    "type": "assets",
    "attributes": {
      "created_at": "2022-03-31T14:14:37+00:00",
      "updated_at": "2022-03-31T14:14:37+00:00",
      "key": "templates/index.json",
      "checksum": "584f28d8181faf694dfc2aef58b542add1c5d99262de7bca9d043c3da82fbadd",
      "content_type": "application/json",
      "value": "{ name: 'index' }",
      "published_at": null,
      "theme_id": "cc25f7f7-9db5-460d-bce5-10cca38da293",
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
    --url 'https://example.booqable.com/api/boomerang/assets/591b696b-54f2-49b9-826c-511ba6afeaf4' \
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





