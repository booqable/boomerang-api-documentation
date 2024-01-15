# Menus

Allows creating and managing menus for your shop.

## Endpoints
`GET /api/boomerang/menus`

`DELETE /api/boomerang/menus/{id}`

`PUT /api/boomerang/menus/{id}`

`GET /api/boomerang/menus/{id}`

`POST /api/boomerang/menus`

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
      "id": "d2409057-ff57-43b6-a5c4-070df69834cb",
      "type": "menus",
      "attributes": {
        "created_at": "2024-01-15T09:14:19+00:00",
        "updated_at": "2024-01-15T09:14:19+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=d2409057-ff57-43b6-a5c4-070df69834cb"
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










## Deleting a menu



> How to delete a menu:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/menus/40c00c2f-6d30-41ba-89bf-e85df46b7b88' \
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
## Updating a menu and it's items



> How to update a menu with nested menu items:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/menus/ee90377b-3a48-483b-a746-802600f27976' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "ee90377b-3a48-483b-a746-802600f27976",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "15618622-4906-47e8-82d3-177b4981f79e",
              "title": "Contact us"
            },
            {
              "id": "a1d3bf3c-242d-4148-951e-93304bea2055",
              "title": "Start"
            },
            {
              "id": "f22c3754-8498-43d6-8816-97cc2cdb9088",
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
    "id": "ee90377b-3a48-483b-a746-802600f27976",
    "type": "menus",
    "attributes": {
      "created_at": "2024-01-15T09:14:21+00:00",
      "updated_at": "2024-01-15T09:14:21+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "15618622-4906-47e8-82d3-177b4981f79e"
          },
          {
            "type": "menu_items",
            "id": "a1d3bf3c-242d-4148-951e-93304bea2055"
          },
          {
            "type": "menu_items",
            "id": "f22c3754-8498-43d6-8816-97cc2cdb9088"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "15618622-4906-47e8-82d3-177b4981f79e",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-01-15T09:14:21+00:00",
        "updated_at": "2024-01-15T09:14:21+00:00",
        "menu_id": "ee90377b-3a48-483b-a746-802600f27976",
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
      "id": "a1d3bf3c-242d-4148-951e-93304bea2055",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-01-15T09:14:21+00:00",
        "updated_at": "2024-01-15T09:14:21+00:00",
        "menu_id": "ee90377b-3a48-483b-a746-802600f27976",
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
      "id": "f22c3754-8498-43d6-8816-97cc2cdb9088",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-01-15T09:14:21+00:00",
        "updated_at": "2024-01-15T09:14:21+00:00",
        "menu_id": "ee90377b-3a48-483b-a746-802600f27976",
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










## Fetching a price structure



> How to fetch a menu with it's items:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/menus/f617f92e-542c-4a8a-a157-fa257fe880cf?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "f617f92e-542c-4a8a-a157-fa257fe880cf",
    "type": "menus",
    "attributes": {
      "created_at": "2024-01-15T09:14:21+00:00",
      "updated_at": "2024-01-15T09:14:21+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=f617f92e-542c-4a8a-a157-fa257fe880cf"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "33bb2487-4c5c-4eff-bf1e-456ff8cd47e9"
          },
          {
            "type": "menu_items",
            "id": "bc4759d6-9ced-49f5-a25d-c8f23f161b96"
          },
          {
            "type": "menu_items",
            "id": "2ed48354-a0d7-4690-b600-cb7c6762fb9e"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "33bb2487-4c5c-4eff-bf1e-456ff8cd47e9",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-01-15T09:14:21+00:00",
        "updated_at": "2024-01-15T09:14:21+00:00",
        "menu_id": "f617f92e-542c-4a8a-a157-fa257fe880cf",
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
            "related": "api/boomerang/menus/f617f92e-542c-4a8a-a157-fa257fe880cf"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=33bb2487-4c5c-4eff-bf1e-456ff8cd47e9"
          }
        }
      }
    },
    {
      "id": "bc4759d6-9ced-49f5-a25d-c8f23f161b96",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-01-15T09:14:21+00:00",
        "updated_at": "2024-01-15T09:14:21+00:00",
        "menu_id": "f617f92e-542c-4a8a-a157-fa257fe880cf",
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
            "related": "api/boomerang/menus/f617f92e-542c-4a8a-a157-fa257fe880cf"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=bc4759d6-9ced-49f5-a25d-c8f23f161b96"
          }
        }
      }
    },
    {
      "id": "2ed48354-a0d7-4690-b600-cb7c6762fb9e",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-01-15T09:14:21+00:00",
        "updated_at": "2024-01-15T09:14:21+00:00",
        "menu_id": "f617f92e-542c-4a8a-a157-fa257fe880cf",
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
            "related": "api/boomerang/menus/f617f92e-542c-4a8a-a157-fa257fe880cf"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=2ed48354-a0d7-4690-b600-cb7c6762fb9e"
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
    "id": "cd18f26f-8b54-4cd1-b784-4a6850436edb",
    "type": "menus",
    "attributes": {
      "created_at": "2024-01-15T09:14:22+00:00",
      "updated_at": "2024-01-15T09:14:22+00:00",
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









