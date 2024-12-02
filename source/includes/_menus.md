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
`menu_items` | **[Menu items](#menu-items)** <br>Associated Menu items


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
      "id": "b669e78e-d869-4013-87da-6af881f3aede",
      "type": "menus",
      "attributes": {
        "created_at": "2024-12-02T13:01:02.464639+00:00",
        "updated_at": "2024-12-02T13:01:02.464639+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/6361c469-00e8-41de-b317-1a33990cd9b4?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "6361c469-00e8-41de-b317-1a33990cd9b4",
    "type": "menus",
    "attributes": {
      "created_at": "2024-12-02T13:01:05.499631+00:00",
      "updated_at": "2024-12-02T13:01:05.499631+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "4a5e4536-d87c-4c25-b73c-364829b5d71f"
          },
          {
            "type": "menu_items",
            "id": "82ed3799-108a-4515-9b0a-85b86abd29d6"
          },
          {
            "type": "menu_items",
            "id": "bda7b233-ea04-4fea-9623-706d38bef942"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "4a5e4536-d87c-4c25-b73c-364829b5d71f",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-12-02T13:01:05.501939+00:00",
        "updated_at": "2024-12-02T13:01:05.501939+00:00",
        "menu_id": "6361c469-00e8-41de-b317-1a33990cd9b4",
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
      "id": "82ed3799-108a-4515-9b0a-85b86abd29d6",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-12-02T13:01:05.504243+00:00",
        "updated_at": "2024-12-02T13:01:05.504243+00:00",
        "menu_id": "6361c469-00e8-41de-b317-1a33990cd9b4",
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
      "id": "bda7b233-ea04-4fea-9623-706d38bef942",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-12-02T13:01:05.506595+00:00",
        "updated_at": "2024-12-02T13:01:05.506595+00:00",
        "menu_id": "6361c469-00e8-41de-b317-1a33990cd9b4",
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
    "id": "6c67fba2-a139-47ff-ba1c-f903ee1ecb86",
    "type": "menus",
    "attributes": {
      "created_at": "2024-12-02T13:01:04.255681+00:00",
      "updated_at": "2024-12-02T13:01:04.255681+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/82c646ce-2621-4a3b-9386-edcc0eddcc36' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "82c646ce-2621-4a3b-9386-edcc0eddcc36",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "a3aef8bc-dbe8-4966-8b55-3a1c44fadb78",
              "title": "Contact us"
            },
            {
              "id": "eba5f131-3e1b-4bc5-951a-2b15011d3560",
              "title": "Start"
            },
            {
              "id": "f89c12a4-d2bb-442e-b252-4ea1e1e6e0a8",
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
    "id": "82c646ce-2621-4a3b-9386-edcc0eddcc36",
    "type": "menus",
    "attributes": {
      "created_at": "2024-12-02T13:01:03.693350+00:00",
      "updated_at": "2024-12-02T13:01:03.750150+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "a3aef8bc-dbe8-4966-8b55-3a1c44fadb78"
          },
          {
            "type": "menu_items",
            "id": "eba5f131-3e1b-4bc5-951a-2b15011d3560"
          },
          {
            "type": "menu_items",
            "id": "f89c12a4-d2bb-442e-b252-4ea1e1e6e0a8"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "a3aef8bc-dbe8-4966-8b55-3a1c44fadb78",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-12-02T13:01:03.695231+00:00",
        "updated_at": "2024-12-02T13:01:03.753402+00:00",
        "menu_id": "82c646ce-2621-4a3b-9386-edcc0eddcc36",
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
      "id": "eba5f131-3e1b-4bc5-951a-2b15011d3560",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-12-02T13:01:03.697942+00:00",
        "updated_at": "2024-12-02T13:01:03.755974+00:00",
        "menu_id": "82c646ce-2621-4a3b-9386-edcc0eddcc36",
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
      "id": "f89c12a4-d2bb-442e-b252-4ea1e1e6e0a8",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-12-02T13:01:03.699846+00:00",
        "updated_at": "2024-12-02T13:01:03.757904+00:00",
        "menu_id": "82c646ce-2621-4a3b-9386-edcc0eddcc36",
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
    --url 'https://example.booqable.com/api/boomerang/menus/b4c7a244-53a3-412a-88da-fb8287d699d9' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "b4c7a244-53a3-412a-88da-fb8287d699d9",
    "type": "menus",
    "attributes": {
      "created_at": "2024-12-02T13:01:04.839139+00:00",
      "updated_at": "2024-12-02T13:01:04.839139+00:00",
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