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
      "id": "45549328-66d6-4e7a-9236-5bf5cad2d5f6",
      "type": "menus",
      "attributes": {
        "created_at": "2024-10-21T09:22:41.301929+00:00",
        "updated_at": "2024-10-21T09:22:41.301929+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/89599aea-d96d-4a43-b3fe-1a61c092d147?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "89599aea-d96d-4a43-b3fe-1a61c092d147",
    "type": "menus",
    "attributes": {
      "created_at": "2024-10-21T09:22:41.740155+00:00",
      "updated_at": "2024-10-21T09:22:41.740155+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "fb68695a-5ea5-42c0-851e-8764ecc77f8a"
          },
          {
            "type": "menu_items",
            "id": "c12bcaed-12db-4b05-bfde-61f5a391f775"
          },
          {
            "type": "menu_items",
            "id": "018eff94-7cc3-453b-a362-8eac2ac63b4a"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "fb68695a-5ea5-42c0-851e-8764ecc77f8a",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-10-21T09:22:41.741592+00:00",
        "updated_at": "2024-10-21T09:22:41.741592+00:00",
        "menu_id": "89599aea-d96d-4a43-b3fe-1a61c092d147",
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
      "id": "c12bcaed-12db-4b05-bfde-61f5a391f775",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-10-21T09:22:41.743202+00:00",
        "updated_at": "2024-10-21T09:22:41.743202+00:00",
        "menu_id": "89599aea-d96d-4a43-b3fe-1a61c092d147",
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
      "id": "018eff94-7cc3-453b-a362-8eac2ac63b4a",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-10-21T09:22:41.744578+00:00",
        "updated_at": "2024-10-21T09:22:41.744578+00:00",
        "menu_id": "89599aea-d96d-4a43-b3fe-1a61c092d147",
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
    "id": "e357240f-6dde-4b5e-8dc7-23dc8cb85ea4",
    "type": "menus",
    "attributes": {
      "created_at": "2024-10-21T09:22:40.826112+00:00",
      "updated_at": "2024-10-21T09:22:40.826112+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/8832702b-3605-49e6-90be-28c0f9ceff3a' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "8832702b-3605-49e6-90be-28c0f9ceff3a",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "09ea93c2-0ae2-46fe-ae79-e6774226130a",
              "title": "Contact us"
            },
            {
              "id": "dd63fda8-c181-4b61-a7ab-793a6b49b9fb",
              "title": "Start"
            },
            {
              "id": "3267478a-5a08-43bf-a8f5-3c41aa41dd1a",
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
    "id": "8832702b-3605-49e6-90be-28c0f9ceff3a",
    "type": "menus",
    "attributes": {
      "created_at": "2024-10-21T09:22:42.205662+00:00",
      "updated_at": "2024-10-21T09:22:42.236374+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "09ea93c2-0ae2-46fe-ae79-e6774226130a"
          },
          {
            "type": "menu_items",
            "id": "dd63fda8-c181-4b61-a7ab-793a6b49b9fb"
          },
          {
            "type": "menu_items",
            "id": "3267478a-5a08-43bf-a8f5-3c41aa41dd1a"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "09ea93c2-0ae2-46fe-ae79-e6774226130a",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-10-21T09:22:42.207091+00:00",
        "updated_at": "2024-10-21T09:22:42.238016+00:00",
        "menu_id": "8832702b-3605-49e6-90be-28c0f9ceff3a",
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
      "id": "dd63fda8-c181-4b61-a7ab-793a6b49b9fb",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-10-21T09:22:42.208753+00:00",
        "updated_at": "2024-10-21T09:22:42.239458+00:00",
        "menu_id": "8832702b-3605-49e6-90be-28c0f9ceff3a",
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
      "id": "3267478a-5a08-43bf-a8f5-3c41aa41dd1a",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-10-21T09:22:42.210090+00:00",
        "updated_at": "2024-10-21T09:22:42.241078+00:00",
        "menu_id": "8832702b-3605-49e6-90be-28c0f9ceff3a",
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
    --url 'https://example.booqable.com/api/boomerang/menus/6ee534c6-d233-454f-8b50-7c15ac69db56' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "6ee534c6-d233-454f-8b50-7c15ac69db56",
    "type": "menus",
    "attributes": {
      "created_at": "2024-10-21T09:22:40.333616+00:00",
      "updated_at": "2024-10-21T09:22:40.333616+00:00",
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