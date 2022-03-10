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
      "id": "73f6bd67-9242-434e-9ffc-7c50ee9763bc",
      "type": "themes",
      "attributes": {
        "created_at": "2022-03-09T10:04:16+00:00",
        "updated_at": "2022-03-09T10:04:16+00:00",
        "name": "Theme 1",
        "identifier": "da6e44a3-f9fb-4f60-98a0-2a40ee135a16",
        "version": "1.0",
        "theme_type": "official",
        "description": "A simple theme for setting up your shop",
        "preview_image": "",
        "theme_id": "758e512f-02a1-4a84-be93-fad32de79ddb",
        "installed": true
      },
      "relationships": {
        "original_theme": {
          "links": {
            "related": "api/boomerang/themes/758e512f-02a1-4a84-be93-fad32de79ddb"
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
      "id": "1e38d170-48d9-46c0-b654-1fa1f93410a7",
      "type": "themes",
      "attributes": {
        "created_at": "2022-03-09T10:04:16+00:00",
        "updated_at": "2022-03-09T10:04:16+00:00",
        "name": "Official theme",
        "identifier": "b8a16742-23b0-4354-b0d8-4b260c41752e",
        "version": "1.0",
        "theme_type": "official",
        "description": null,
        "preview_image": "",
        "theme_id": null,
        "installed": false
      },
      "relationships": {
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
`include` | **String**<br>List of comma seperated relationships `?include=original_theme`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[themes]=id,created_at,updated_at`
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-03-09T10:01:28Z`
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
          "theme_id": "d3dddc62-1533-4236-a133-080cbbfbeeca"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "7792dadd-beb6-4153-b2ab-fd6852d8fc8c",
    "type": "themes",
    "attributes": {
      "created_at": "2022-03-09T10:04:17+00:00",
      "updated_at": "2022-03-09T10:04:17+00:00",
      "name": "Official theme",
      "identifier": "3bc3be7c-5ecc-40d9-a3fd-c65d780898c2",
      "version": null,
      "theme_type": "official",
      "description": null,
      "preview_image": "",
      "theme_id": "d3dddc62-1533-4236-a133-080cbbfbeeca",
      "installed": true
    },
    "relationships": {
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
`include` | **String**<br>List of comma seperated relationships `?include=original_theme`
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
    --url 'https://example.booqable.com/api/boomerang/themes/b2ef1ac4-e88c-467b-bc06-91c261102bad' \
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
`include` | **String**<br>List of comma seperated relationships `?include=original_theme`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[themes]=id,created_at,updated_at`


### Includes

This request does not accept any includes