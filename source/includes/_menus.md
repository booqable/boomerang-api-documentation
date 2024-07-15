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
      "id": "f093d919-33c5-45d5-a94f-57054139a9de",
      "type": "menus",
      "attributes": {
        "created_at": "2024-07-15T09:23:00.264565+00:00",
        "updated_at": "2024-07-15T09:23:00.264565+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/bc6a6d6e-ca02-4fcf-a43b-f835af6c8279?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "bc6a6d6e-ca02-4fcf-a43b-f835af6c8279",
    "type": "menus",
    "attributes": {
      "created_at": "2024-07-15T09:22:55.938693+00:00",
      "updated_at": "2024-07-15T09:22:55.938693+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "9b18d71a-1421-43b4-b7cb-070b1491863c"
          },
          {
            "type": "menu_items",
            "id": "9343d880-3558-4d77-a070-cbd828430b79"
          },
          {
            "type": "menu_items",
            "id": "3fc65c0e-0bb1-40a2-bdbb-48132e03b926"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "9b18d71a-1421-43b4-b7cb-070b1491863c",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-07-15T09:22:55.943142+00:00",
        "updated_at": "2024-07-15T09:22:55.943142+00:00",
        "menu_id": "bc6a6d6e-ca02-4fcf-a43b-f835af6c8279",
        "parent_menu_item_id": null,
        "title": "About us",
        "value": "/about-us",
        "target_id": null,
        "target_type": "Static",
        "sorting_weight": null
      },
      "relationships": {}
    },
    {
      "id": "9343d880-3558-4d77-a070-cbd828430b79",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-07-15T09:22:55.946935+00:00",
        "updated_at": "2024-07-15T09:22:55.946935+00:00",
        "menu_id": "bc6a6d6e-ca02-4fcf-a43b-f835af6c8279",
        "parent_menu_item_id": null,
        "title": "Home",
        "value": "/",
        "target_id": null,
        "target_type": "Static",
        "sorting_weight": null
      },
      "relationships": {}
    },
    {
      "id": "3fc65c0e-0bb1-40a2-bdbb-48132e03b926",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-07-15T09:22:55.950916+00:00",
        "updated_at": "2024-07-15T09:22:55.950916+00:00",
        "menu_id": "bc6a6d6e-ca02-4fcf-a43b-f835af6c8279",
        "parent_menu_item_id": null,
        "title": "Rentals",
        "value": "/products",
        "target_id": null,
        "target_type": "Static",
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
    "id": "f7afcd0f-8a02-42e2-b55c-40e426ceec2c",
    "type": "menus",
    "attributes": {
      "created_at": "2024-07-15T09:22:58.382137+00:00",
      "updated_at": "2024-07-15T09:22:58.382137+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/97d75175-95dd-455e-bb46-56ec224191b1' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "97d75175-95dd-455e-bb46-56ec224191b1",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "84c05cd4-f7e4-4523-9426-d86858ec95c0",
              "title": "Contact us"
            },
            {
              "id": "6c9f1db7-633d-4669-9c7f-43ca2cbfe631",
              "title": "Start"
            },
            {
              "id": "f657ca38-152c-4900-bd24-d53e715d05f6",
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
    "id": "97d75175-95dd-455e-bb46-56ec224191b1",
    "type": "menus",
    "attributes": {
      "created_at": "2024-07-15T09:22:57.579955+00:00",
      "updated_at": "2024-07-15T09:22:57.658539+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "84c05cd4-f7e4-4523-9426-d86858ec95c0"
          },
          {
            "type": "menu_items",
            "id": "6c9f1db7-633d-4669-9c7f-43ca2cbfe631"
          },
          {
            "type": "menu_items",
            "id": "f657ca38-152c-4900-bd24-d53e715d05f6"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "84c05cd4-f7e4-4523-9426-d86858ec95c0",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-07-15T09:22:57.583940+00:00",
        "updated_at": "2024-07-15T09:22:57.663061+00:00",
        "menu_id": "97d75175-95dd-455e-bb46-56ec224191b1",
        "parent_menu_item_id": null,
        "title": "Contact us",
        "value": "/about-us",
        "target_id": null,
        "target_type": "Static",
        "sorting_weight": null
      },
      "relationships": {}
    },
    {
      "id": "6c9f1db7-633d-4669-9c7f-43ca2cbfe631",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-07-15T09:22:57.589125+00:00",
        "updated_at": "2024-07-15T09:22:57.667077+00:00",
        "menu_id": "97d75175-95dd-455e-bb46-56ec224191b1",
        "parent_menu_item_id": null,
        "title": "Start",
        "value": "/",
        "target_id": null,
        "target_type": "Static",
        "sorting_weight": null
      },
      "relationships": {}
    },
    {
      "id": "f657ca38-152c-4900-bd24-d53e715d05f6",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-07-15T09:22:57.593360+00:00",
        "updated_at": "2024-07-15T09:22:57.670276+00:00",
        "menu_id": "97d75175-95dd-455e-bb46-56ec224191b1",
        "parent_menu_item_id": null,
        "title": "Rent from us",
        "value": "/products",
        "target_id": null,
        "target_type": "Static",
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
    --url 'https://example.booqable.com/api/boomerang/menus/c778b777-38fd-455d-9a0e-4a53c28f5fce' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "c778b777-38fd-455d-9a0e-4a53c28f5fce",
    "type": "menus",
    "attributes": {
      "created_at": "2024-07-15T09:22:59.273036+00:00",
      "updated_at": "2024-07-15T09:22:59.273036+00:00",
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