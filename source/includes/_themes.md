# Themes

Themes are the basis for creating advanced custom online stores.
They organise custom assets and enable quick switching between different designs and content.
A company can 'install' a theme from the available themes, this creates a local copy which allows customizing the theme to your needs.

## Endpoints
`DELETE /api/boomerang/themes/{id}`

`GET /api/boomerang/themes`

`POST /api/boomerang/themes`

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
    --url 'https://example.booqable.com/api/boomerang/themes/d72f3830-0e85-45b8-8521-6a9f1667b629' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "d72f3830-0e85-45b8-8521-6a9f1667b629",
    "type": "themes",
    "attributes": {
      "created_at": "2024-05-20T09:26:41+00:00",
      "updated_at": "2024-05-20T09:26:41+00:00",
      "name": "Theme 10",
      "identifier": "5e798ba5-84a9-486d-acf5-e26663b60962",
      "version": "1.0",
      "theme_id": "c2f3a5d5-8f7a-4795-8918-9d8ff6c1363a",
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
        "links": {
          "related": "api/boomerang/assets?filter[theme_id]=d72f3830-0e85-45b8-8521-6a9f1667b629"
        }
      },
      "original_theme": {
        "links": {
          "related": "api/boomerang/themes/c2f3a5d5-8f7a-4795-8918-9d8ff6c1363a"
        }
      }
    }
  },
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
## Listing themes



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
      "id": "fba4cb1d-1839-40b2-a8fe-4eed0b25ee95",
      "type": "themes",
      "attributes": {
        "created_at": "2024-05-20T09:26:42+00:00",
        "updated_at": "2024-05-20T09:26:42+00:00",
        "name": "Official theme",
        "identifier": "8d5eb3a2-2de9-47a5-95fd-a676b3a48bfa",
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
            "related": "api/boomerang/assets?filter[theme_id]=fba4cb1d-1839-40b2-a8fe-4eed0b25ee95"
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
      "id": "52884d8f-340f-4263-87b0-83b9214081c6",
      "type": "themes",
      "attributes": {
        "created_at": "2024-05-20T09:26:44+00:00",
        "updated_at": "2024-05-20T09:26:44+00:00",
        "name": "Theme 12",
        "identifier": "900a5a89-2832-4821-b0df-7d05d11545a4",
        "version": "1.0",
        "theme_id": "9f644a39-bcb2-47e1-87d4-8cf0e745ee90",
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
            "related": "api/boomerang/assets?filter[theme_id]=52884d8f-340f-4263-87b0-83b9214081c6"
          }
        },
        "original_theme": {
          "links": {
            "related": "api/boomerang/themes/9f644a39-bcb2-47e1-87d4-8cf0e745ee90"
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
          "theme_id": "74059497-cdf6-42f8-8a3b-198ff3cfc1f8"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "42fbd6bc-e65f-4b0a-b08e-5644899f055d",
    "type": "themes",
    "attributes": {
      "created_at": "2024-05-20T09:26:47+00:00",
      "updated_at": "2024-05-20T09:26:47+00:00",
      "name": "Official theme",
      "identifier": "4f83ea6b-9de6-4964-9740-fc097018ff04",
      "version": null,
      "theme_id": "74059497-cdf6-42f8-8a3b-198ff3cfc1f8",
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





