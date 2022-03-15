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
`content_type` | **String** `readonly`<br>The MIME representation of the content, consisting of the type and subtype of the asset. One of `image/jpeg`, `image/gif`, `image/png`, `text/css`, `text/javascript`, `application/liquid`, `application/json`
`value` | **String**<br>The text content of the asset, such as the HTML and Liquid markup of a template file.
`published_at` | **Datetime** `readonly`<br>The date and time (ISO 8601 format) when the asset was published.
`file_url` | **String** `readonly`<br>The link to the binary file belonging to the asset.
`theme_id` | **String**<br>The ID of the theme that an asset belongs to.


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
      "id": "ce83eb4a-5b96-42f6-9066-5ad07cfb4907",
      "type": "assets",
      "attributes": {
        "created_at": "2022-03-15T16:23:03+00:00",
        "updated_at": "2022-03-15T16:23:03+00:00",
        "key": "templates/index.json",
        "checksum": "584f28d8181faf694dfc2aef58b542add1c5d99262de7bca9d043c3da82fbadd",
        "content_type": "application/json",
        "value": "{ name: 'index' }",
        "published_at": "2022-03-08T16:23:03+00:00",
        "file_url": null,
        "theme_id": "1a75418d-6592-4f01-92f5-02ef6d4b6a0c"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-03-15T16:22:59Z`
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
`file_url` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
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
          "theme_id": "7d328c6f-360b-4ad3-a2be-9e865f2b6b3b"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "41d32e90-8825-45f0-91ff-8ad97782c880",
    "type": "assets",
    "attributes": {
      "created_at": "2022-03-15T16:23:04+00:00",
      "updated_at": "2022-03-15T16:23:04+00:00",
      "key": "templates/index.json",
      "checksum": "584f28d8181faf694dfc2aef58b542add1c5d99262de7bca9d043c3da82fbadd",
      "content_type": "application/json",
      "value": "{ name: 'index' }",
      "published_at": null,
      "file_url": null,
      "theme_id": "7d328c6f-360b-4ad3-a2be-9e865f2b6b3b"
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


### Includes

This request accepts the following includes:

`theme`






## Deleting an asset



> How to delete an asset:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/assets/19021910-d82a-4d6c-b06c-cabfdb0db3c6' \
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





