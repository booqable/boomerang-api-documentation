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
      "id": "73fe0408-e109-4dda-8d5b-a285777e8144",
      "type": "themes",
      "attributes": {
        "created_at": "2024-11-04T09:25:03.830700+00:00",
        "updated_at": "2024-11-04T09:25:03.830700+00:00",
        "name": "Theme 4",
        "identifier": "8600be8a-f537-47b1-9c27-0486c39fb5bd",
        "version": "1.0",
        "theme_id": "07cb9968-1043-4ccf-a607-69d1c5cda7c0",
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
      "relationships": {}
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
      "id": "e1d11234-c38d-47d1-b47a-6f4d5934278c",
      "type": "themes",
      "attributes": {
        "created_at": "2024-11-04T09:25:03.191521+00:00",
        "updated_at": "2024-11-04T09:25:03.191521+00:00",
        "name": "Official theme",
        "identifier": "fb88a44b-6d66-44a7-ae8b-8787f0a5971d",
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
      "relationships": {}
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
`market` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
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
          "theme_id": "0fb263a6-c381-47ed-8e3f-bd55defe3b67"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "1e9727f8-3e97-4adb-87dc-2fd180b7e0aa",
    "type": "themes",
    "attributes": {
      "created_at": "2024-11-04T09:25:04.476498+00:00",
      "updated_at": "2024-11-04T09:25:04.476498+00:00",
      "name": "Official theme",
      "identifier": "c036bb01-f560-410c-aba7-8fcb199038d2",
      "version": null,
      "theme_id": "0fb263a6-c381-47ed-8e3f-bd55defe3b67",
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
    "relationships": {}
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






## Deleting a theme



> How to delete a theme:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/themes/10a48b18-b44d-499e-ac82-1ccf0a36d618' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "10a48b18-b44d-499e-ac82-1ccf0a36d618",
    "type": "themes",
    "attributes": {
      "created_at": "2024-11-04T09:25:02.262030+00:00",
      "updated_at": "2024-11-04T09:25:02.262030+00:00",
      "name": "Theme 2",
      "identifier": "c9df5009-e5d5-4cf0-89f9-67ab23664db7",
      "version": "1.0",
      "theme_id": "724c0360-c4a7-48a8-80a3-2296405b66ab",
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
    "relationships": {}
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