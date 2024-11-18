# Menus

Allows creating and managing menus for your shop.

## Endpoints
`GET /api/boomerang/menus`

`GET /api/boomerang/menus/{id}`

`POST /api/boomerang/menus`

`PUT /api/boomerang/menus/{id}`

`DELETE /api/boomerang/menus/{id}`

## Fields
Every menu has the following fields:

Name | Description
-- | --
`id` | **Uuid** `readonly`<br>Primary key
`created_at` | **Datetime** `readonly`<br>When the resource was created
`updated_at` | **Datetime** `readonly`<br>When the resource was last updated
`title` | **String** <br>Name of the menu.
`key` | **String** <br>Key the menu can be referenced by.
`menu_items_attributes` | **Array** `writeonly`<br>Attributes of child menu items to be created or changed.


## Relationships
Menus have the following relationships:

Name | Description
-- | --
`menu_items` | **Menu items** `readonly`<br>Associated Menu items


## Listing menus



> How to fetch a list of menus:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/menus' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "f52a3a8e-46b6-44b6-9304-d817a4a7ac05",
      "type": "menus",
      "attributes": {
        "created_at": "2024-11-18T09:26:17.847241+00:00",
        "updated_at": "2024-11-18T09:26:17.847241+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {}
    }
  ],
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/menus`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=menu_items`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[menus]=created_at,updated_at,title`
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
`title` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`key` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **Array** <br>`count`


### Includes

This request accepts the following includes:

`menu_items` => 
`menu_items` => 
`menu_items`










## Fetching a menu



> How to fetch a menu with it's items:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/menus/eba1c63e-9d46-49bf-ac45-8bfe44269126?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "eba1c63e-9d46-49bf-ac45-8bfe44269126",
    "type": "menus",
    "attributes": {
      "created_at": "2024-11-18T09:26:18.727727+00:00",
      "updated_at": "2024-11-18T09:26:18.727727+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "4bcac3d8-ddce-4f97-815c-25b1f7233965"
          },
          {
            "type": "menu_items",
            "id": "3a1836dc-9520-440f-97da-b8975eca64de"
          },
          {
            "type": "menu_items",
            "id": "9e939359-620d-48c0-a064-2044903287f4"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "4bcac3d8-ddce-4f97-815c-25b1f7233965",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-11-18T09:26:18.729088+00:00",
        "updated_at": "2024-11-18T09:26:18.729088+00:00",
        "menu_id": "eba1c63e-9d46-49bf-ac45-8bfe44269126",
        "parent_menu_item_id": null,
        "title": "About us",
        "value": "/about-us",
        "target_id": null,
        "target_type": "Static",
        "generate_sub_menu_items": false,
        "generated": false,
        "sorting_weight": null
      },
      "relationships": {}
    },
    {
      "id": "3a1836dc-9520-440f-97da-b8975eca64de",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-11-18T09:26:18.730629+00:00",
        "updated_at": "2024-11-18T09:26:18.730629+00:00",
        "menu_id": "eba1c63e-9d46-49bf-ac45-8bfe44269126",
        "parent_menu_item_id": null,
        "title": "Home",
        "value": "/",
        "target_id": null,
        "target_type": "Static",
        "generate_sub_menu_items": false,
        "generated": false,
        "sorting_weight": null
      },
      "relationships": {}
    },
    {
      "id": "9e939359-620d-48c0-a064-2044903287f4",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-11-18T09:26:18.731989+00:00",
        "updated_at": "2024-11-18T09:26:18.731989+00:00",
        "menu_id": "eba1c63e-9d46-49bf-ac45-8bfe44269126",
        "parent_menu_item_id": null,
        "title": "Rentals",
        "value": "/products",
        "target_id": null,
        "target_type": "Static",
        "generate_sub_menu_items": false,
        "generated": false,
        "sorting_weight": null
      },
      "relationships": {}
    }
  ],
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/menus/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=menu_items`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[menus]=created_at,updated_at,title`


### Includes

This request accepts the following includes:

`menu_items`






## Creating a menu with items



> How to create a menu with menu items:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/menus' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "key": "header",
          "menu_items_attributes": [
            {
              "title": "Home",
              "target_type": "Static",
              "value": "/"
            },
            {
              "title": "Resources",
              "target_type": "Static",
              "value": "/resources",
              "menu_items_attributes": [
                {
                  "title": "Blog",
                  "target_type": "Static",
                  "value": "/resources/blog",
                  "menu_items_attributes": [
                    {
                      "title": "Customer stories",
                      "target_type": "Static",
                      "value": "/resources/blog/customer-stories"
                    }
                  ]
                }
              ]
            }
          ]
        }
      },
      "include": "menus"
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "62391326-9b13-4ae7-bc73-ac8571eb2789",
    "type": "menus",
    "attributes": {
      "created_at": "2024-11-18T09:26:18.306530+00:00",
      "updated_at": "2024-11-18T09:26:18.306530+00:00",
      "title": "Header menu",
      "key": "header"
    },
    "relationships": {}
  },
  "meta": {}
}
```

### HTTP Request

`POST /api/boomerang/menus`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=menu_items`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[menus]=created_at,updated_at,title`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][title]` | **String** <br>Name of the menu.
`data[attributes][key]` | **String** <br>Key the menu can be referenced by.
`data[attributes][menu_items_attributes][]` | **Array** <br>Attributes of child menu items to be created or changed.


### Includes

This request accepts the following includes:

`menu_items` => 
`menu_items` => 
`menu_items`










## Updating a menu and it's items



> How to update a menu with nested menu items:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/menus/e3b375d6-ddc5-499c-b3d4-52afda93087e' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "e3b375d6-ddc5-499c-b3d4-52afda93087e",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "4365d605-8b31-4050-97aa-a7b081accf0d",
              "title": "Contact us"
            },
            {
              "id": "c3e45855-4248-4ac6-84ce-9b7fa8f81f14",
              "title": "Start"
            },
            {
              "id": "a205caf5-4032-4513-bb1a-f0b624cbabd9",
              "title": "Rent from us"
            }
          ]
        }
      },
      "include": "menu_items"
    }'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "e3b375d6-ddc5-499c-b3d4-52afda93087e",
    "type": "menus",
    "attributes": {
      "created_at": "2024-11-18T09:26:16.941609+00:00",
      "updated_at": "2024-11-18T09:26:16.971608+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "4365d605-8b31-4050-97aa-a7b081accf0d"
          },
          {
            "type": "menu_items",
            "id": "c3e45855-4248-4ac6-84ce-9b7fa8f81f14"
          },
          {
            "type": "menu_items",
            "id": "a205caf5-4032-4513-bb1a-f0b624cbabd9"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "4365d605-8b31-4050-97aa-a7b081accf0d",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-11-18T09:26:16.943206+00:00",
        "updated_at": "2024-11-18T09:26:16.973537+00:00",
        "menu_id": "e3b375d6-ddc5-499c-b3d4-52afda93087e",
        "parent_menu_item_id": null,
        "title": "Contact us",
        "value": "/about-us",
        "target_id": null,
        "target_type": "Static",
        "generate_sub_menu_items": false,
        "generated": false,
        "sorting_weight": null
      },
      "relationships": {}
    },
    {
      "id": "c3e45855-4248-4ac6-84ce-9b7fa8f81f14",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-11-18T09:26:16.945021+00:00",
        "updated_at": "2024-11-18T09:26:16.974826+00:00",
        "menu_id": "e3b375d6-ddc5-499c-b3d4-52afda93087e",
        "parent_menu_item_id": null,
        "title": "Start",
        "value": "/",
        "target_id": null,
        "target_type": "Static",
        "generate_sub_menu_items": false,
        "generated": false,
        "sorting_weight": null
      },
      "relationships": {}
    },
    {
      "id": "a205caf5-4032-4513-bb1a-f0b624cbabd9",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-11-18T09:26:16.946318+00:00",
        "updated_at": "2024-11-18T09:26:16.975957+00:00",
        "menu_id": "e3b375d6-ddc5-499c-b3d4-52afda93087e",
        "parent_menu_item_id": null,
        "title": "Rent from us",
        "value": "/products",
        "target_id": null,
        "target_type": "Static",
        "generate_sub_menu_items": false,
        "generated": false,
        "sorting_weight": null
      },
      "relationships": {}
    }
  ],
  "meta": {}
}
```

### HTTP Request

`PUT /api/boomerang/menus/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=menu_items`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[menus]=created_at,updated_at,title`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][title]` | **String** <br>Name of the menu.
`data[attributes][key]` | **String** <br>Key the menu can be referenced by.
`data[attributes][menu_items_attributes][]` | **Array** <br>Attributes of child menu items to be created or changed.


### Includes

This request accepts the following includes:

`menu_items` => 
`menu_items` => 
`menu_items`










## Deleting a menu



> How to delete a menu:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/menus/e418b3a6-b164-4fd3-b04d-df22c13b1cb6' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "e418b3a6-b164-4fd3-b04d-df22c13b1cb6",
    "type": "menus",
    "attributes": {
      "created_at": "2024-11-18T09:26:17.416103+00:00",
      "updated_at": "2024-11-18T09:26:17.416103+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {}
  },
  "meta": {}
}
```

### HTTP Request

`DELETE /api/boomerang/menus/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[menus]=created_at,updated_at,title`


### Includes

This request does not accept any includes