# Themes

Themes are the basis for creating advanced custom online stores.
They organise custom assets and enable quick switching between different designs and content.
A company can 'install' a theme from the available themes, this creates a local copy which allows customizing the theme to your needs.

## Endpoints
`POST /api/boomerang/themes`

`GET /api/boomerang/themes`

`DELETE /api/boomerang/themes/{id}`

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
          "theme_id": "64a35d31-733c-402f-8696-f679f33f4013"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "347deb44-30e3-488f-a19b-f9627ddd055b",
    "type": "themes",
    "attributes": {
      "created_at": "2023-12-07T13:54:57+00:00",
      "updated_at": "2023-12-07T13:54:57+00:00",
      "name": "Official theme",
      "identifier": "ee383fa9-53a1-48d3-bb84-8ed895261763",
      "version": null,
      "theme_id": "64a35d31-733c-402f-8696-f679f33f4013",
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
      "id": "7e9f9deb-20e9-42fd-8de5-03920bec6d9d",
      "type": "themes",
      "attributes": {
        "created_at": "2023-12-07T13:54:57+00:00",
        "updated_at": "2023-12-07T13:54:57+00:00",
        "name": "Theme 2",
        "identifier": "4e0a963c-1bb1-4b04-b1cc-fab7c51f491b",
        "version": "1.0",
        "theme_id": "c360d9a6-c45e-49aa-9f48-6fc49defdeaa",
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
            "related": "api/boomerang/assets?filter[theme_id]=7e9f9deb-20e9-42fd-8de5-03920bec6d9d"
          }
        },
        "original_theme": {
          "links": {
            "related": "api/boomerang/themes/c360d9a6-c45e-49aa-9f48-6fc49defdeaa"
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
      "id": "86f0999c-4ee7-49c9-8ad2-d5b9ecc9a342",
      "type": "themes",
      "attributes": {
        "created_at": "2023-12-07T13:54:58+00:00",
        "updated_at": "2023-12-07T13:54:58+00:00",
        "name": "Official theme",
        "identifier": "4b62825f-1a93-4fbf-a89a-2f9643f795d4",
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
            "related": "api/boomerang/assets?filter[theme_id]=86f0999c-4ee7-49c9-8ad2-d5b9ecc9a342"
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
## Deleting a theme



> How to delete a theme:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/themes/f2a4d305-8e08-4050-86f2-a4679387cb6f' \
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