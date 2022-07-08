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
      "id": "9116d93f-f759-4cb7-abc9-14365bbaa92d",
      "type": "themes",
      "attributes": {
        "created_at": "2022-07-08T13:13:08+00:00",
        "updated_at": "2022-07-08T13:13:08+00:00",
        "name": "Theme 1",
        "identifier": "03d7d6e4-63da-4ba1-8571-58c4ec305707",
        "version": "1.0",
        "theme_type": "official",
        "description": "A simple theme for setting up your shop",
        "preview_image": "",
        "theme_id": "442de78f-7c83-491c-91ce-7001c3bcedec",
        "installed": true
      },
      "relationships": {
        "assets": {
          "links": {
            "related": "api/boomerang/assets?filter[theme_id]=9116d93f-f759-4cb7-abc9-14365bbaa92d"
          }
        },
        "original_theme": {
          "links": {
            "related": "api/boomerang/themes/442de78f-7c83-491c-91ce-7001c3bcedec"
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
      "id": "ea6f458c-96f7-47c3-bcac-ff11676b051c",
      "type": "themes",
      "attributes": {
        "created_at": "2022-07-08T13:13:09+00:00",
        "updated_at": "2022-07-08T13:13:09+00:00",
        "name": "Official theme",
        "identifier": "12f81af9-675e-4b6d-a142-67a9bf09fbd5",
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
            "related": "api/boomerang/assets?filter[theme_id]=ea6f458c-96f7-47c3-bcac-ff11676b051c"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-07-08T13:10:10Z`
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
          "theme_id": "8ef80809-0e19-470d-a2ef-8285018514ca"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "d67a7112-6d3d-4ebd-87d3-aec681dc4f40",
    "type": "themes",
    "attributes": {
      "created_at": "2022-07-08T13:13:09+00:00",
      "updated_at": "2022-07-08T13:13:09+00:00",
      "name": "Official theme",
      "identifier": "79ca4f75-2ac5-4f5b-a383-2649e1f54dc9",
      "version": null,
      "theme_type": "official",
      "description": null,
      "preview_image": "",
      "theme_id": "8ef80809-0e19-470d-a2ef-8285018514ca",
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
    --url 'https://example.booqable.com/api/boomerang/themes/5970300c-780b-4378-bed4-ae433f8d6c6d' \
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