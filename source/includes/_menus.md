# Menus

Allows creating and managing menus for your shop.

## Endpoints
`PUT /api/boomerang/menus/{id}`

`GET /api/boomerang/menus`

`POST /api/boomerang/menus`

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


## Updating a menu and it's items



> How to update a menu with nested menu items:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/menus/6d3ff02c-9a77-4f01-81c0-3962f8023524' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "6d3ff02c-9a77-4f01-81c0-3962f8023524",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "71b1b0af-31cf-42f0-873a-c5a2530b5234",
              "title": "Contact us"
            },
            {
              "id": "ef04f9a6-b478-47dd-a4fe-d261c6dab821",
              "title": "Start"
            },
            {
              "id": "58aadb3c-d2e1-4821-8883-6105ee1904d5",
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
    "id": "6d3ff02c-9a77-4f01-81c0-3962f8023524",
    "type": "menus",
    "attributes": {
      "created_at": "2024-04-15T09:26:54+00:00",
      "updated_at": "2024-04-15T09:26:54+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "71b1b0af-31cf-42f0-873a-c5a2530b5234"
          },
          {
            "type": "menu_items",
            "id": "ef04f9a6-b478-47dd-a4fe-d261c6dab821"
          },
          {
            "type": "menu_items",
            "id": "58aadb3c-d2e1-4821-8883-6105ee1904d5"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "71b1b0af-31cf-42f0-873a-c5a2530b5234",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-04-15T09:26:54+00:00",
        "updated_at": "2024-04-15T09:26:54+00:00",
        "menu_id": "6d3ff02c-9a77-4f01-81c0-3962f8023524",
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
      "id": "ef04f9a6-b478-47dd-a4fe-d261c6dab821",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-04-15T09:26:54+00:00",
        "updated_at": "2024-04-15T09:26:54+00:00",
        "menu_id": "6d3ff02c-9a77-4f01-81c0-3962f8023524",
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
      "id": "58aadb3c-d2e1-4821-8883-6105ee1904d5",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-04-15T09:26:54+00:00",
        "updated_at": "2024-04-15T09:26:54+00:00",
        "menu_id": "6d3ff02c-9a77-4f01-81c0-3962f8023524",
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
      "id": "4f01b1a2-8c5a-4fa2-bed2-0c91cd65e461",
      "type": "menus",
      "attributes": {
        "created_at": "2024-04-15T09:26:55+00:00",
        "updated_at": "2024-04-15T09:26:55+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=4f01b1a2-8c5a-4fa2-bed2-0c91cd65e461"
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
    "id": "ce879738-e859-448d-b3e4-03feee108082",
    "type": "menus",
    "attributes": {
      "created_at": "2024-04-15T09:26:56+00:00",
      "updated_at": "2024-04-15T09:26:56+00:00",
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










## Deleting a menu



> How to delete a menu:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/menus/57a2488f-dd89-499f-9206-46fa361fbbcb' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "57a2488f-dd89-499f-9206-46fa361fbbcb",
    "type": "menus",
    "attributes": {
      "created_at": "2024-04-15T09:26:56+00:00",
      "updated_at": "2024-04-15T09:26:56+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=57a2488f-dd89-499f-9206-46fa361fbbcb"
        }
      }
    }
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
## Fetching a menu



> How to fetch a menu with it's items:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/menus/243818e8-6d3c-4df6-ba64-a025ca4734c1?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "243818e8-6d3c-4df6-ba64-a025ca4734c1",
    "type": "menus",
    "attributes": {
      "created_at": "2024-04-15T09:26:57+00:00",
      "updated_at": "2024-04-15T09:26:57+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=243818e8-6d3c-4df6-ba64-a025ca4734c1"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "5ec723f8-d02f-4b6f-8291-d855aa0111c5"
          },
          {
            "type": "menu_items",
            "id": "d189c06f-0d52-41d5-9e39-3e581a70bbf1"
          },
          {
            "type": "menu_items",
            "id": "a39394de-a3b3-41f5-bfb4-fc209bd0f3f4"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "5ec723f8-d02f-4b6f-8291-d855aa0111c5",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-04-15T09:26:57+00:00",
        "updated_at": "2024-04-15T09:26:57+00:00",
        "menu_id": "243818e8-6d3c-4df6-ba64-a025ca4734c1",
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
            "related": "api/boomerang/menus/243818e8-6d3c-4df6-ba64-a025ca4734c1"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=5ec723f8-d02f-4b6f-8291-d855aa0111c5"
          }
        }
      }
    },
    {
      "id": "d189c06f-0d52-41d5-9e39-3e581a70bbf1",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-04-15T09:26:57+00:00",
        "updated_at": "2024-04-15T09:26:57+00:00",
        "menu_id": "243818e8-6d3c-4df6-ba64-a025ca4734c1",
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
            "related": "api/boomerang/menus/243818e8-6d3c-4df6-ba64-a025ca4734c1"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=d189c06f-0d52-41d5-9e39-3e581a70bbf1"
          }
        }
      }
    },
    {
      "id": "a39394de-a3b3-41f5-bfb4-fc209bd0f3f4",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-04-15T09:26:57+00:00",
        "updated_at": "2024-04-15T09:26:57+00:00",
        "menu_id": "243818e8-6d3c-4df6-ba64-a025ca4734c1",
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
            "related": "api/boomerang/menus/243818e8-6d3c-4df6-ba64-a025ca4734c1"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=a39394de-a3b3-41f5-bfb4-fc209bd0f3f4"
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





