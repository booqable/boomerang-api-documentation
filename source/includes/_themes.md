# Themes

Themes are the basis for creating advanced custom online stores.
They organise custom assets and enable quick switching between different designs and content.
A company can 'install' a theme from the available themes, this creates a local copy which allows customizing the theme to your needs.

## Endpoints
`GET /api/boomerang/themes`

`POST /api/boomerang/themes`

`DELETE /api/boomerang/themes/{id}`

## Fields
Every theme has the following fields:

Name | Description
- | -
`id` | **Uuid** `readonly`<br>Primary key
`created_at` | **Datetime** `readonly`<br>When the resource was created
`updated_at` | **Datetime** `readonly`<br>When the resource was last updated
`name` | **String**<br>Name of the theme
`identifier` | **String**<br>UUID used to link this theme
`version` | **String**<br>Theme version
`theme_type` | **String**<br>Theme type, determines where the theme can be found. Custom themes are private. One of `marketplace`, `official`, `custom`
`description` | **String**<br>Theme description
`preview_image` | **String**<br>Theme preview image
`theme_id` | **Uuid**<br>Present for installed themes, Original ID of installed theme
`installed` | **Boolean** `readonly`<br>Whether or not this theme is installed


## Relationships
Themes have the following relationships:

Name | Description
- | -
`assets` | **Assets** `readonly`<br>Associated Assets
`original_theme` | **Themes** `readonly`<br>Associated Original theme


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
      "id": "4e01132f-02e2-40f3-8967-24897df0e997",
      "type": "themes",
      "attributes": {
        "created_at": "2022-06-08T08:07:22+00:00",
        "updated_at": "2022-06-08T08:07:22+00:00",
        "name": "Theme 1",
        "identifier": "273051f9-fa72-4a2e-b52d-974cf65f97df",
        "version": "1.0",
        "theme_type": "official",
        "description": "A simple theme for setting up your shop",
        "preview_image": "",
        "theme_id": "8b12e1ea-f24d-44c4-871c-e4e017e3d874",
        "installed": true
      },
      "relationships": {
        "assets": {
          "links": {
            "related": "api/boomerang/assets?filter[theme_id]=4e01132f-02e2-40f3-8967-24897df0e997"
          }
        },
        "original_theme": {
          "links": {
            "related": "api/boomerang/themes/8b12e1ea-f24d-44c4-871c-e4e017e3d874"
          }
        }
      }
    }
  ],
  "meta": {}
}
```


> How to fetch a list of available themes:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/themes?filter%5Bavailable%5D=true' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "35c439d6-45c6-4a34-b965-8b287bb9615d",
      "type": "themes",
      "attributes": {
        "created_at": "2022-06-08T08:07:22+00:00",
        "updated_at": "2022-06-08T08:07:22+00:00",
        "name": "Official theme",
        "identifier": "91a519eb-d527-4160-9d59-77b8bb54f796",
        "version": "1.0",
        "theme_type": "official",
        "description": null,
        "preview_image": "",
        "theme_id": null,
        "installed": false
      },
      "relationships": {
        "assets": {
          "links": {
            "related": "api/boomerang/assets?filter[theme_id]=35c439d6-45c6-4a34-b965-8b287bb9615d"
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=assets,original_theme`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[themes]=id,created_at,updated_at`
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-06-08T08:04:43Z`
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
`name` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`identifier` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`version` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`theme_type` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`installed` | **Boolean**<br>`eq`
`available` | **Boolean**<br>`eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array**<br>`count`


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
          "theme_id": "438c22e5-ba45-4e8a-af20-cc048a1b34b8"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "5adf2e08-286a-4741-a4cf-ce7d304f76c4",
    "type": "themes",
    "attributes": {
      "created_at": "2022-06-08T08:07:22+00:00",
      "updated_at": "2022-06-08T08:07:22+00:00",
      "name": "Official theme",
      "identifier": "f62ea558-1706-49de-9f57-ddd62e27651a",
      "version": null,
      "theme_type": "official",
      "description": null,
      "preview_image": "",
      "theme_id": "438c22e5-ba45-4e8a-af20-cc048a1b34b8",
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=assets,original_theme`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[themes]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][name]` | **String**<br>Name of the theme
`data[attributes][identifier]` | **String**<br>UUID used to link this theme
`data[attributes][version]` | **String**<br>Theme version
`data[attributes][theme_type]` | **String**<br>Theme type, determines where the theme can be found. Custom themes are private. One of `marketplace`, `official`, `custom`
`data[attributes][preview_image]` | **String**<br>Theme preview image
`data[attributes][theme_id]` | **Uuid**<br>Present for installed themes, Original ID of installed theme


### Includes

This request accepts the following includes:

`assets`






## Deleting a theme



> How to delete a theme:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/themes/5fab0fab-dd81-412a-a006-0e1a57e12aa6' \
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=assets,original_theme`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[themes]=id,created_at,updated_at`


### Includes

This request does not accept any includes