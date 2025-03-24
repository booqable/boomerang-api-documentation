# Themes

Themes are the basis for creating advanced custom online stores.
They organize custom assets and enable quick switching between different designs and content.
A company can 'install' a theme from the available themes, this creates a local copy which
allows customizing the theme to your needs.

## Relationships
Name | Description
-- | --
`assets` | **[Assets](#assets)** `hasmany`<br>The assets that make up this theme. 
`original_theme` | **[Theme](#themes)** `required`<br>The original theme, from which this theme is derived. 
`theme` | **[Theme](#themes)** `required`<br>Either the installed theme, or the original theme. 


Check matching attributes under [Fields](#themes-fields) to see which relations can be written.
<br/ >
Check each individual operation to see which relations can be included as a sideload.
## Fields

 Name | Description
-- | --
`created_at` | **datetime** `readonly`<br>When the resource was created.
`description` | **string** <br>Theme description. 
`detail_url` | **string** <br>The URL where more info about the theme is available. 
`id` | **uuid** `readonly`<br>Primary key.
`identifier` | **string** <br>UUID used to link this theme. 
`installed` | **boolean** `readonly`<br>Whether or not this theme is installed. 
`market` | **string** <br>The market (industry) which fits best for the theme. 
`name` | **string** <br>Name of the theme. 
`preview_image_large_url` | **string** `readonly`<br>Theme large image preview image URL. 
`preview_image_long_url` | **string** `readonly`<br>Theme rectangle image preview image URL. 
`preview_image_medium_url` | **string** `readonly`<br>Theme medium image preview image URL. 
`preview_url` | **string** <br>The URL where the theme could be previewed. 
`theme_id` | **uuid** `readonly-after-create`<br>Either the installed theme, or the original theme. 
`theme_type` | **enum** <br>Theme type, determines where the theme can be found. Custom themes are private.<br> One of: `marketplace`, `official`, `custom`.
`updated_at` | **datetime** `readonly`<br>When the resource was last updated.
`version` | **string** <br>Theme version. 


## List themes


> How to fetch a list of installed themes:

```shell
  curl --get 'https://example.booqable.com/api/boomerang/themes'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": [
      {
        "id": "05c84d06-b503-45c8-8f4a-137d89af6792",
        "type": "themes",
        "attributes": {
          "created_at": "2020-08-03T21:19:00.000000+00:00",
          "updated_at": "2020-08-03T21:19:00.000000+00:00",
          "name": "Theme 9",
          "identifier": "053cc262-8d09-458b-8b80-c475d109e71f",
          "version": "1.0",
          "theme_type": "official",
          "description": "A simple theme for setting up your shop",
          "market": null,
          "preview_url": null,
          "detail_url": null,
          "preview_image_long_url": null,
          "preview_image_medium_url": null,
          "preview_image_large_url": null,
          "installed": true,
          "theme_id": "f24f2dff-91ed-49dd-88ff-65218acbbff2"
        },
        "relationships": {}
      }
    ],
    "meta": {}
  }
```

> How to fetch a list of themes which are available for installation:

```shell
  curl --get 'https://example.booqable.com/api/boomerang/themes'
       --header 'content-type: application/json'
       --data-urlencode 'filter[available_for_installation]=true'
```

> A 200 status response looks like this:

```json
  {
    "data": [
      {
        "id": "b6ff3557-38d5-4441-8824-98d428442590",
        "type": "themes",
        "attributes": {
          "created_at": "2020-08-10T01:34:00.000000+00:00",
          "updated_at": "2020-08-10T01:34:00.000000+00:00",
          "name": "Official theme",
          "identifier": "f4e7c42a-8df9-40fe-8c77-9053bfb8df3d",
          "version": "1.0",
          "theme_type": "official",
          "description": null,
          "market": null,
          "preview_url": null,
          "detail_url": null,
          "preview_image_long_url": null,
          "preview_image_medium_url": null,
          "preview_image_large_url": null,
          "installed": false,
          "theme_id": null
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
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[themes]=created_at,updated_at,name`
`filter` | **hash** <br>The filters to apply `?filter[attribute][eq]=value`
`meta` | **hash** <br>Metadata to send along. `?meta[total][]=count`
`page[number]` | **string** <br>The page to request.
`page[size]` | **string** <br>The amount of items per page.
`sort` | **string** <br>How to sort the data. `?sort=attribute1,-attribute2`


### Filters

This request can be filtered on:

Name | Description
-- | --
`available_for_installation` | **boolean** <br>`eq`
`created_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`id` | **uuid** <br>`eq`, `not_eq`
`identifier` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`installed` | **boolean** <br>`eq`
`market` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`name` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`theme_type` | **enum** <br>`eq`
`updated_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`version` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **array** <br>`count`


### Includes

This request does not accept any includes
## Create a theme


> How to fork a theme to create a new theme:

```shell
  curl --request POST
       --url 'https://example.booqable.com/api/boomerang/themes'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "type": "themes",
           "attributes": {
             "name": "New theme",
             "theme_id": "60be3d8d-1bab-4210-876e-ba676d2a0330"
           }
         }
       }'
```

> A 201 status response looks like this:

```json
  {
    "data": {
      "id": "7fbfd489-c397-461c-804d-d6ce60e09c44",
      "type": "themes",
      "attributes": {
        "created_at": "2027-12-05T03:30:03.000000+00:00",
        "updated_at": "2027-12-05T03:30:03.000000+00:00",
        "name": "Official theme",
        "identifier": "3d841600-9b71-4b37-8d72-fc8a4bb8e526",
        "version": null,
        "theme_type": "official",
        "description": null,
        "market": null,
        "preview_url": null,
        "detail_url": null,
        "preview_image_long_url": null,
        "preview_image_medium_url": null,
        "preview_image_large_url": null,
        "installed": true,
        "theme_id": "60be3d8d-1bab-4210-876e-ba676d2a0330"
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
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[themes]=created_at,updated_at,name`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=assets`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][detail_url]` | **string** <br>The URL where more info about the theme is available. 
`data[attributes][identifier]` | **string** <br>UUID used to link this theme. 
`data[attributes][market]` | **string** <br>The market (industry) which fits best for the theme. 
`data[attributes][name]` | **string** <br>Name of the theme. 
`data[attributes][preview_url]` | **string** <br>The URL where the theme could be previewed. 
`data[attributes][theme_id]` | **uuid** <br>Either the installed theme, or the original theme. 
`data[attributes][theme_type]` | **enum** <br>Theme type, determines where the theme can be found. Custom themes are private.<br> One of: `marketplace`, `official`, `custom`.
`data[attributes][version]` | **string** <br>Theme version. 


### Includes

This request accepts the following includes:

`assets`






## Delete a theme


> How to delete a theme:

```shell
  curl --request DELETE
       --url 'https://example.booqable.com/api/boomerang/themes/e89e2806-1fa0-4dba-8df6-5728b48387cd'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "e89e2806-1fa0-4dba-8df6-5728b48387cd",
      "type": "themes",
      "attributes": {
        "created_at": "2018-01-04T11:23:01.000000+00:00",
        "updated_at": "2018-01-04T11:23:01.000000+00:00",
        "name": "Theme 13",
        "identifier": "3d1c31f5-a209-4af0-8965-779b7850166c",
        "version": "1.0",
        "theme_type": "official",
        "description": null,
        "market": null,
        "preview_url": null,
        "detail_url": null,
        "preview_image_long_url": null,
        "preview_image_medium_url": null,
        "preview_image_large_url": null,
        "installed": true,
        "theme_id": "533e9931-4e57-40d5-8eed-eb3a64dd99db"
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
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[themes]=created_at,updated_at,name`


### Includes

This request does not accept any includes