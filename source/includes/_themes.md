# Themes

Themes are the basis for creating advanced custom online stores.
They organise custom assets and enable quick switching between different designs and content.
A company can 'install' a theme from the available themes, this creates a local copy which allows customizing the theme to your needs.

## Endpoints
`DELETE /api/boomerang/themes/{id}`

`POST /api/boomerang/themes`

`GET /api/boomerang/themes`

## Fields
Every theme has the following fields:

Name | Description
-- | --
`id` | **Uuid** `readonly`<br>Primary key
`created_at` | **Datetime** `readonly`<br>When the resource was created
`updated_at` | **Datetime** `readonly`<br>When the resource was last updated
`name` | **String** <br>Name of the theme
`identifier` | **String** <br>UUID used to link this theme
`version` | **String** <br>Theme version
`theme_id` | **Uuid** <br>Present for installed themes, Original ID of installed theme
`theme_type` | **String** <br>Theme type, determines where the theme can be found. Custom themes are private. One of `marketplace`, `official`, `custom`
`description` | **String** <br>Theme description
`market` | **String** <br>The market (industry) which fits best for the theme
`preview_url` | **String** <br>The URL where the theme could be previewed
`detail_url` | **String** <br>The URL where more info about the theme is available
`preview_image_long_url` | **String** `readonly`<br>Theme rectangle image preview image url
`preview_image_medium_url` | **String** `readonly`<br>Theme medium image preview image url
`preview_image_large_url` | **String** `readonly`<br>Theme large image preview image url
`installed` | **Boolean** `readonly`<br>Whether or not this theme is installed


## Relationships
Themes have the following relationships:

Name | Description
-- | --
`assets` | **Assets** `readonly`<br>Associated Assets
`original_theme` | **Themes** `readonly`<br>Associated Original theme


## Deleting a theme



> How to delete a theme:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/themes/43b07246-ee57-404c-846b-7482d9468227' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "meta": {}
}
```

### HTTP Request

`DELETE /api/boomerang/themes/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[themes]=created_at,updated_at,name`


### Includes

This request does not accept any includes
## Creating a theme



> How to fork a theme to create a new theme:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/themes' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "themes",
        "attributes": {
          "name": "New theme",
          "theme_id": "ca26fe82-c312-402b-b409-63fd08c4be13"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "8e4b0692-60c0-4f5b-a55c-87d7dadccfb1",
    "type": "themes",
    "attributes": {
      "created_at": "2024-02-05T09:18:42+00:00",
      "updated_at": "2024-02-05T09:18:42+00:00",
      "name": "Official theme",
      "identifier": "7da0d9d3-0295-4621-941d-95fcd264510e",
      "version": null,
      "theme_id": "ca26fe82-c312-402b-b409-63fd08c4be13",
      "theme_type": "official",
      "description": null,
      "market": null,
      "preview_url": null,
      "detail_url": null,
      "preview_image_long_url": null,
      "preview_image_medium_url": null,
      "preview_image_large_url": null,
      "installed": true
    },
    "relationships": {
      "assets": {
        "meta": {
          "included": false
        }
      },
      "original_theme": {
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

`POST /api/boomerang/themes`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=assets`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[themes]=created_at,updated_at,name`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][name]` | **String** <br>Name of the theme
`data[attributes][identifier]` | **String** <br>UUID used to link this theme
`data[attributes][version]` | **String** <br>Theme version
`data[attributes][theme_id]` | **Uuid** <br>Present for installed themes, Original ID of installed theme
`data[attributes][theme_type]` | **String** <br>Theme type, determines where the theme can be found. Custom themes are private. One of `marketplace`, `official`, `custom`
`data[attributes][market]` | **String** <br>The market (industry) which fits best for the theme
`data[attributes][preview_url]` | **String** <br>The URL where the theme could be previewed
`data[attributes][detail_url]` | **String** <br>The URL where more info about the theme is available


### Includes

This request accepts the following includes:

`assets`






## Listing themes



> How to fetch a list of installed themes:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/themes' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "ca8736ca-4b02-45b8-9e91-fed61c2a1a4a",
      "type": "themes",
      "attributes": {
        "created_at": "2024-02-05T09:18:45+00:00",
        "updated_at": "2024-02-05T09:18:45+00:00",
        "name": "Theme 12",
        "identifier": "7001795e-749f-4a2a-9cf4-29bb33499546",
        "version": "1.0",
        "theme_id": "86c18c07-2daf-4050-92a3-5cc259ba3051",
        "theme_type": "official",
        "description": "A simple theme for setting up your shop",
        "market": null,
        "preview_url": null,
        "detail_url": null,
        "preview_image_long_url": null,
        "preview_image_medium_url": null,
        "preview_image_large_url": null,
        "installed": true
      },
      "relationships": {
        "assets": {
          "links": {
            "related": "api/boomerang/assets?filter[theme_id]=ca8736ca-4b02-45b8-9e91-fed61c2a1a4a"
          }
        },
        "original_theme": {
          "links": {
            "related": "api/boomerang/themes/86c18c07-2daf-4050-92a3-5cc259ba3051"
          }
        }
      }
    }
  ],
  "meta": {}
}
```


> How to fetch a list of themes which are available for installation:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/themes?filter%5Bavailable_for_installation%5D=true' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "900cfc2a-c2c1-478a-897f-9ac150fc69e1",
      "type": "themes",
      "attributes": {
        "created_at": "2024-02-05T09:18:47+00:00",
        "updated_at": "2024-02-05T09:18:47+00:00",
        "name": "Official theme",
        "identifier": "636e7f1e-7998-46b5-a8ac-f594f0febe54",
        "version": "1.0",
        "theme_id": null,
        "theme_type": "official",
        "description": null,
        "market": null,
        "preview_url": null,
        "detail_url": null,
        "preview_image_long_url": null,
        "preview_image_medium_url": null,
        "preview_image_large_url": null,
        "installed": false
      },
      "relationships": {
        "assets": {
          "links": {
            "related": "api/boomerang/assets?filter[theme_id]=900cfc2a-c2c1-478a-897f-9ac150fc69e1"
          }
        },
        "original_theme": {
          "links": {
            "related": null
          }
        }
      }
    }
  ],
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/themes`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[themes]=created_at,updated_at,name`
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
`name` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`identifier` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`version` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`theme_type` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`installed` | **Boolean** <br>`eq`
`available_for_installation` | **Boolean** <br>`eq`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **Array** <br>`count`


### Includes

This request does not accept any includes