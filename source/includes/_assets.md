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
`key` | **String** <br>The path of the asset within a theme. It consists of the file's directory and filename. For example, the asset `layout/index.liquid` is in the layout directory, so its key is `layout/index.liquid`.
`custom` | **Boolean** `readonly`<br>Whether the asset is part of the theme or created by the user
`checksum` | **String** `readonly`<br>The checksum of the content value or file in SHA256.
`content_type` | **String** `readonly`<br>The MIME representation of the content, consisting of the type and subtype of the asset. One of `image/jpeg`, `image/gif`, `image/png`, `image/svg+xml`, `image/webp`, `text/css`, `text/plain`, `application/javascript`, `application/liquid`, `application/json`
`value` | **String** <br>The text content of the asset, such as the HTML and Liquid markup of a template file.
`published_at` | **Datetime** `readonly`<br>The date and time (ISO 8601 format) when the asset was published.
`theme_id` | **Uuid** <br>The associated Theme
`remote_file_url` | **String** `writeonly`<br>The URL of the remote file, for upload only
`file` | **Carrierwave_file** <br>An object describing the binary file belonging to the asset.
`file_base64` | **String** `writeonly`<br>File in base 64, for upload only


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
      "id": "cb212643-3c4a-44bd-9c57-81a1ff957350",
      "type": "assets",
      "attributes": {
        "created_at": "2023-02-21T10:55:32+00:00",
        "updated_at": "2023-02-21T10:55:32+00:00",
        "key": "templates/index.json",
        "custom": false,
        "checksum": "74b5b91c79f3099a43573f152554e8d82d55efe4039fe9c2d67246950750f61e",
        "content_type": "application/json",
        "value": "{ \"name\": \"index\" }",
        "published_at": "2023-02-14T10:55:32+00:00",
        "theme_id": "97708e28-6252-4ff6-b14a-bc2b22a223ea",
        "file": {
          "url": null
        }
      },
      "relationships": {
        "theme": {
          "links": {
            "related": "api/boomerang/themes/97708e28-6252-4ff6-b14a-bc2b22a223ea"
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

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=theme`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[assets]=id,created_at,updated_at`
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-21T10:55:23Z`
`sort` | **String** <br>How to sort the data `?sort=-created_at`
`meta` | **Hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String** <br>The page to request
`page[size]` | **String** <br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
`id` | **Uuid** <br>`eq`, `not_eq`
`created_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`key` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`custom` | **Boolean** <br>`eq`
`checksum` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`content_type` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`published_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`theme_id` | **Uuid** <br>`eq`, `not_eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array** <br>`count`
`published` | **Array** <br>`count`
`unpublished` | **Array** <br>`count`


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
          "value": "{ \"name\": \"index\" }",
          "theme_id": "a519c341-0687-4ee9-9836-0ddd2612f2fd"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "ddcb204b-0282-4783-bd63-e2f18ea29d2b",
    "type": "assets",
    "attributes": {
      "created_at": "2023-02-21T10:55:33+00:00",
      "updated_at": "2023-02-21T10:55:33+00:00",
      "key": "templates/index.json",
      "custom": false,
      "checksum": "74b5b91c79f3099a43573f152554e8d82d55efe4039fe9c2d67246950750f61e",
      "content_type": "application/json",
      "value": "{ \"name\": \"index\" }",
      "published_at": null,
      "theme_id": "a519c341-0687-4ee9-9836-0ddd2612f2fd",
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

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=theme`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[assets]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][key]` | **String** <br>The path of the asset within a theme. It consists of the file's directory and filename. For example, the asset `layout/index.liquid` is in the layout directory, so its key is `layout/index.liquid`.
`data[attributes][value]` | **String** <br>The text content of the asset, such as the HTML and Liquid markup of a template file.
`data[attributes][theme_id]` | **Uuid** <br>The associated Theme
`data[attributes][remote_file_url]` | **String** <br>The URL of the remote file, for upload only
`data[attributes][file]` | **Carrierwave_file** <br>An object describing the binary file belonging to the asset.
`data[attributes][file_base64]` | **String** <br>File in base 64, for upload only


### Includes

This request accepts the following includes:

`theme`






## Uploading a file



> How to create an asset and upload a file:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/assets' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "assets",
        "attributes": {
          "key": "assets/image.png",
          "theme_id": "d658f9b6-ceca-441a-b5bf-07f8b24c0b5e",
          "file_base64": "data:image/png;base64,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\n"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "9fa540bd-ddf2-40d5-a815-de351b3d39f3",
    "type": "assets",
    "attributes": {
      "created_at": "2023-02-21T10:55:33+00:00",
      "updated_at": "2023-02-21T10:55:33+00:00",
      "key": "assets/image.png",
      "custom": false,
      "checksum": "d6c8d6c485714758ae033483d6773831e27bd7393c141bb73e8e96c14f35e1ad",
      "content_type": "image/png",
      "value": null,
      "published_at": null,
      "theme_id": "d658f9b6-ceca-441a-b5bf-07f8b24c0b5e",
      "file": {
        "url": "/assets/d658f9b6-ceca-441a-b5bf-07f8b24c0b5e/image-d6c8d6c485714758ae033483d6773831e27bd7393c141bb73e8e96c14f35e1ad.png"
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

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=theme`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[assets]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][key]` | **String** <br>The path of the asset within a theme. It consists of the file's directory and filename. For example, the asset `layout/index.liquid` is in the layout directory, so its key is `layout/index.liquid`.
`data[attributes][value]` | **String** <br>The text content of the asset, such as the HTML and Liquid markup of a template file.
`data[attributes][theme_id]` | **Uuid** <br>The associated Theme
`data[attributes][remote_file_url]` | **String** <br>The URL of the remote file, for upload only
`data[attributes][file]` | **Carrierwave_file** <br>An object describing the binary file belonging to the asset.
`data[attributes][file_base64]` | **String** <br>File in base 64, for upload only


### Includes

This request accepts the following includes:

`theme`






## Deleting an asset



> How to delete an asset:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/assets/07d339d9-f383-4e72-b8af-d75b62ffe534' \
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

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=theme`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[assets]=id,created_at,updated_at`


### Includes

This request accepts the following includes:

`theme`





