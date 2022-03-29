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
`theme_id` | **String**<br>The ID of the theme that an asset belongs to.
`file` | **Carrierwave_file**<br>An object describing the binary file belonging to the asset.


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
      "id": "833b5297-c26e-411c-9e04-50aa52cbf8b7",
      "type": "assets",
      "attributes": {
        "created_at": "2022-03-29T09:19:19+00:00",
        "updated_at": "2022-03-29T09:19:19+00:00",
        "key": "templates/index.json",
        "checksum": "584f28d8181faf694dfc2aef58b542add1c5d99262de7bca9d043c3da82fbadd",
        "content_type": "application/json",
        "value": "{ name: 'index' }",
        "published_at": "2022-03-22T09:19:19+00:00",
        "theme_id": "85f70f6a-d42b-41c3-bcdb-d94a756a8cca",
        "file": {
          "url": null
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
`include` | **String**<br>List of comma seperated relationships `?include=`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[assets]=id,created_at,updated_at`
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-03-29T09:19:15Z`
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
`theme_id` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`


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
          "theme_id": "79a1dc00-8ba2-45fb-a7db-85b3dce7f278"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "8b7ba044-1dac-448a-beae-f4724a87f75c",
    "type": "assets",
    "attributes": {
      "created_at": "2022-03-29T09:19:21+00:00",
      "updated_at": "2022-03-29T09:19:21+00:00",
      "key": "templates/index.json",
      "checksum": "584f28d8181faf694dfc2aef58b542add1c5d99262de7bca9d043c3da82fbadd",
      "content_type": "application/json",
      "value": "{ name: 'index' }",
      "published_at": null,
      "theme_id": "79a1dc00-8ba2-45fb-a7db-85b3dce7f278",
      "file": {
        "url": null
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
`include` | **String**<br>List of comma seperated relationships `?include=`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[assets]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][key]` | **String**<br>The path of the asset within a theme. It consists of the file's directory and filename. For example, the asset `layouts/index.liquid` is in the layouts directory, so its key is `layouts/index.liquid`.
`data[attributes][value]` | **String**<br>The text content of the asset, such as the HTML and Liquid markup of a template file.
`data[attributes][theme_id]` | **String**<br>The ID of the theme that an asset belongs to.
`data[attributes][file]` | **Carrierwave_file**<br>An object describing the binary file belonging to the asset.


### Includes

This request accepts the following includes:

`theme`






## Deleting an asset



> How to delete an asset:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/assets/91f901a6-47d2-418f-873b-e4a4b35c3716' \
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
`include` | **String**<br>List of comma seperated relationships `?include=`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[assets]=id,created_at,updated_at`


### Includes

This request accepts the following includes:

`theme`





