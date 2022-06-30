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
      "id": "4c8d1bae-09b3-4d8a-813c-adbdbcbf0c9c",
      "type": "themes",
      "attributes": {
        "created_at": "2022-06-30T08:48:12+00:00",
        "updated_at": "2022-06-30T08:48:12+00:00",
        "name": "Theme 1",
        "identifier": "4224b29e-b777-4556-90dd-8559c203f4e9",
        "version": "1.0",
        "theme_type": "official",
        "description": "A simple theme for setting up your shop",
        "preview_image": "",
        "theme_id": "fd96fe7a-99ce-4201-ae20-f54f34a695c0",
        "installed": true
      },
      "relationships": {
        "assets": {
          "links": {
            "related": "api/boomerang/assets?filter[theme_id]=4c8d1bae-09b3-4d8a-813c-adbdbcbf0c9c"
          }
        },
        "original_theme": {
          "links": {
            "related": "api/boomerang/themes/fd96fe7a-99ce-4201-ae20-f54f34a695c0"
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
      "id": "5ecb06e0-ef71-49d4-aaec-abb850c573c8",
      "type": "themes",
      "attributes": {
        "created_at": "2022-06-30T08:48:13+00:00",
        "updated_at": "2022-06-30T08:48:13+00:00",
        "name": "Official theme",
        "identifier": "d40b2f4b-bf4a-46f7-9add-4259a922694e",
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
            "related": "api/boomerang/assets?filter[theme_id]=5ecb06e0-ef71-49d4-aaec-abb850c573c8"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-06-30T08:45:22Z`
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
          "theme_id": "bbaf6256-0456-4b62-a8b5-cad22b6375a1"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "cb8c0ac3-f50a-4543-87f9-6a0f363fc14f",
    "type": "themes",
    "attributes": {
      "created_at": "2022-06-30T08:48:13+00:00",
      "updated_at": "2022-06-30T08:48:13+00:00",
      "name": "Official theme",
      "identifier": "599cb19f-35e4-441b-9c33-347a48d8bb59",
      "version": null,
      "theme_type": "official",
      "description": null,
      "preview_image": "",
      "theme_id": "bbaf6256-0456-4b62-a8b5-cad22b6375a1",
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
    --url 'https://example.booqable.com/api/boomerang/themes/6b92afb3-4d82-40fb-a7dc-8c910abee75b' \
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