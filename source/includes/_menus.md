# Menus

Allows creating and managing menus for your shop.

## Endpoints
`GET /api/boomerang/menus`

`POST /api/boomerang/menus`

`PUT /api/boomerang/menus/{id}`

`DELETE /api/boomerang/menus/{id}`

`GET /api/boomerang/menus/{id}`

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
      "id": "debf0dc6-a39b-4e7f-a511-3127dea84238",
      "type": "menus",
      "attributes": {
        "created_at": "2024-03-11T09:18:48+00:00",
        "updated_at": "2024-03-11T09:18:48+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=debf0dc6-a39b-4e7f-a511-3127dea84238"
          }
        }
      }
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
    "id": "406ee424-c2e9-428d-9e69-7a066812d99b",
    "type": "menus",
    "attributes": {
      "created_at": "2024-03-11T09:18:49+00:00",
      "updated_at": "2024-03-11T09:18:49+00:00",
      "title": "Header menu",
      "key": "header"
    },
    "relationships": {
      "menu_items": {
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
    --url 'https://example.booqable.com/api/boomerang/menus/8f9cdd12-89e5-4f29-9347-7c9b9ef660c0' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "8f9cdd12-89e5-4f29-9347-7c9b9ef660c0",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "43c254ce-d27f-43cb-af31-300566a5d262",
              "title": "Contact us"
            },
            {
              "id": "6d0873c7-de0b-48d6-9913-b5ea02d96b75",
              "title": "Start"
            },
            {
              "id": "ba2e7473-f87a-4ecd-9735-f1e594d9c26f",
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
    "id": "8f9cdd12-89e5-4f29-9347-7c9b9ef660c0",
    "type": "menus",
    "attributes": {
      "created_at": "2024-03-11T09:18:49+00:00",
      "updated_at": "2024-03-11T09:18:49+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "43c254ce-d27f-43cb-af31-300566a5d262"
          },
          {
            "type": "menu_items",
            "id": "6d0873c7-de0b-48d6-9913-b5ea02d96b75"
          },
          {
            "type": "menu_items",
            "id": "ba2e7473-f87a-4ecd-9735-f1e594d9c26f"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "43c254ce-d27f-43cb-af31-300566a5d262",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-03-11T09:18:49+00:00",
        "updated_at": "2024-03-11T09:18:49+00:00",
        "menu_id": "8f9cdd12-89e5-4f29-9347-7c9b9ef660c0",
        "parent_menu_item_id": null,
        "title": "Contact us",
        "value": "/about-us",
        "target_id": null,
        "target_type": "Static",
        "sorting_weight": null
      },
      "relationships": {
        "menu": {
          "meta": {
            "included": false
          }
        },
        "menu_items": {
          "meta": {
            "included": false
          }
        }
      }
    },
    {
      "id": "6d0873c7-de0b-48d6-9913-b5ea02d96b75",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-03-11T09:18:49+00:00",
        "updated_at": "2024-03-11T09:18:49+00:00",
        "menu_id": "8f9cdd12-89e5-4f29-9347-7c9b9ef660c0",
        "parent_menu_item_id": null,
        "title": "Start",
        "value": "/",
        "target_id": null,
        "target_type": "Static",
        "sorting_weight": null
      },
      "relationships": {
        "menu": {
          "meta": {
            "included": false
          }
        },
        "menu_items": {
          "meta": {
            "included": false
          }
        }
      }
    },
    {
      "id": "ba2e7473-f87a-4ecd-9735-f1e594d9c26f",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-03-11T09:18:49+00:00",
        "updated_at": "2024-03-11T09:18:49+00:00",
        "menu_id": "8f9cdd12-89e5-4f29-9347-7c9b9ef660c0",
        "parent_menu_item_id": null,
        "title": "Rent from us",
        "value": "/products",
        "target_id": null,
        "target_type": "Static",
        "sorting_weight": null
      },
      "relationships": {
        "menu": {
          "meta": {
            "included": false
          }
        },
        "menu_items": {
          "meta": {
            "included": false
          }
        }
      }
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
    --url 'https://example.booqable.com/api/boomerang/menus/acccfe5a-05b9-4e69-9ec1-6f19bc0c6faf' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
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
## Fetching a price structure



> How to fetch a menu with it's items:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/menus/ab118302-4351-437b-b7ce-11549b886bd8?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "ab118302-4351-437b-b7ce-11549b886bd8",
    "type": "menus",
    "attributes": {
      "created_at": "2024-03-11T09:18:50+00:00",
      "updated_at": "2024-03-11T09:18:50+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=ab118302-4351-437b-b7ce-11549b886bd8"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "4154036b-68e8-462f-b700-70ea85f803a1"
          },
          {
            "type": "menu_items",
            "id": "24dab68b-9913-482b-8a7b-439ee011a49d"
          },
          {
            "type": "menu_items",
            "id": "082d0ed5-d7c3-40d4-8a78-9fabcc45debd"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "4154036b-68e8-462f-b700-70ea85f803a1",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-03-11T09:18:50+00:00",
        "updated_at": "2024-03-11T09:18:50+00:00",
        "menu_id": "ab118302-4351-437b-b7ce-11549b886bd8",
        "parent_menu_item_id": null,
        "title": "About us",
        "value": "/about-us",
        "target_id": null,
        "target_type": "Static",
        "sorting_weight": null
      },
      "relationships": {
        "menu": {
          "links": {
            "related": "api/boomerang/menus/ab118302-4351-437b-b7ce-11549b886bd8"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=4154036b-68e8-462f-b700-70ea85f803a1"
          }
        }
      }
    },
    {
      "id": "24dab68b-9913-482b-8a7b-439ee011a49d",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-03-11T09:18:50+00:00",
        "updated_at": "2024-03-11T09:18:50+00:00",
        "menu_id": "ab118302-4351-437b-b7ce-11549b886bd8",
        "parent_menu_item_id": null,
        "title": "Home",
        "value": "/",
        "target_id": null,
        "target_type": "Static",
        "sorting_weight": null
      },
      "relationships": {
        "menu": {
          "links": {
            "related": "api/boomerang/menus/ab118302-4351-437b-b7ce-11549b886bd8"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=24dab68b-9913-482b-8a7b-439ee011a49d"
          }
        }
      }
    },
    {
      "id": "082d0ed5-d7c3-40d4-8a78-9fabcc45debd",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-03-11T09:18:50+00:00",
        "updated_at": "2024-03-11T09:18:50+00:00",
        "menu_id": "ab118302-4351-437b-b7ce-11549b886bd8",
        "parent_menu_item_id": null,
        "title": "Rentals",
        "value": "/products",
        "target_id": null,
        "target_type": "Static",
        "sorting_weight": null
      },
      "relationships": {
        "menu": {
          "links": {
            "related": "api/boomerang/menus/ab118302-4351-437b-b7ce-11549b886bd8"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=082d0ed5-d7c3-40d4-8a78-9fabcc45debd"
          }
        }
      }
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





