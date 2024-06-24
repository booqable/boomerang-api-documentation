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
      "id": "2ad2683d-f89b-4790-8e99-54408efe1a6d",
      "type": "menus",
      "attributes": {
        "created_at": "2024-06-24T09:54:27.264160+00:00",
        "updated_at": "2024-06-24T09:54:27.264160+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=2ad2683d-f89b-4790-8e99-54408efe1a6d"
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










## Fetching a menu



> How to fetch a menu with it's items:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/menus/c8e0c4a0-47dc-4c12-a86e-35fcfdcf9832?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "c8e0c4a0-47dc-4c12-a86e-35fcfdcf9832",
    "type": "menus",
    "attributes": {
      "created_at": "2024-06-24T09:54:26.618665+00:00",
      "updated_at": "2024-06-24T09:54:26.618665+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=c8e0c4a0-47dc-4c12-a86e-35fcfdcf9832"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "af393800-4e19-497d-ab81-36bf08e0fd69"
          },
          {
            "type": "menu_items",
            "id": "45f2167d-e210-4a26-9d47-f8e0dfc8f481"
          },
          {
            "type": "menu_items",
            "id": "071a5ead-d260-47bb-9886-6a1f49f731ee"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "af393800-4e19-497d-ab81-36bf08e0fd69",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-06-24T09:54:26.621767+00:00",
        "updated_at": "2024-06-24T09:54:26.621767+00:00",
        "menu_id": "c8e0c4a0-47dc-4c12-a86e-35fcfdcf9832",
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
            "related": "api/boomerang/menus/c8e0c4a0-47dc-4c12-a86e-35fcfdcf9832"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=af393800-4e19-497d-ab81-36bf08e0fd69"
          }
        }
      }
    },
    {
      "id": "45f2167d-e210-4a26-9d47-f8e0dfc8f481",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-06-24T09:54:26.625058+00:00",
        "updated_at": "2024-06-24T09:54:26.625058+00:00",
        "menu_id": "c8e0c4a0-47dc-4c12-a86e-35fcfdcf9832",
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
            "related": "api/boomerang/menus/c8e0c4a0-47dc-4c12-a86e-35fcfdcf9832"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=45f2167d-e210-4a26-9d47-f8e0dfc8f481"
          }
        }
      }
    },
    {
      "id": "071a5ead-d260-47bb-9886-6a1f49f731ee",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-06-24T09:54:26.627978+00:00",
        "updated_at": "2024-06-24T09:54:26.627978+00:00",
        "menu_id": "c8e0c4a0-47dc-4c12-a86e-35fcfdcf9832",
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
            "related": "api/boomerang/menus/c8e0c4a0-47dc-4c12-a86e-35fcfdcf9832"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=071a5ead-d260-47bb-9886-6a1f49f731ee"
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
    "id": "706cae97-4206-4f22-ba32-9a56ed15f473",
    "type": "menus",
    "attributes": {
      "created_at": "2024-06-24T09:54:25.986291+00:00",
      "updated_at": "2024-06-24T09:54:25.986291+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/dd61343e-ae93-4fb0-98cd-d9969408b416' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "dd61343e-ae93-4fb0-98cd-d9969408b416",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "88ba93e1-0463-4d0d-bc5e-3349f0a68140",
              "title": "Contact us"
            },
            {
              "id": "6a91bd5d-0425-4ca9-9736-dcc013a088a7",
              "title": "Start"
            },
            {
              "id": "011bb962-7a32-465b-9908-9b0719b08017",
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
    "id": "dd61343e-ae93-4fb0-98cd-d9969408b416",
    "type": "menus",
    "attributes": {
      "created_at": "2024-06-24T09:54:28.016259+00:00",
      "updated_at": "2024-06-24T09:54:28.101031+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "88ba93e1-0463-4d0d-bc5e-3349f0a68140"
          },
          {
            "type": "menu_items",
            "id": "6a91bd5d-0425-4ca9-9736-dcc013a088a7"
          },
          {
            "type": "menu_items",
            "id": "011bb962-7a32-465b-9908-9b0719b08017"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "88ba93e1-0463-4d0d-bc5e-3349f0a68140",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-06-24T09:54:28.019342+00:00",
        "updated_at": "2024-06-24T09:54:28.104665+00:00",
        "menu_id": "dd61343e-ae93-4fb0-98cd-d9969408b416",
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
      "id": "6a91bd5d-0425-4ca9-9736-dcc013a088a7",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-06-24T09:54:28.022756+00:00",
        "updated_at": "2024-06-24T09:54:28.108138+00:00",
        "menu_id": "dd61343e-ae93-4fb0-98cd-d9969408b416",
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
      "id": "011bb962-7a32-465b-9908-9b0719b08017",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-06-24T09:54:28.025520+00:00",
        "updated_at": "2024-06-24T09:54:28.111391+00:00",
        "menu_id": "dd61343e-ae93-4fb0-98cd-d9969408b416",
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
    --url 'https://example.booqable.com/api/boomerang/menus/d3fe4fc7-0175-4d33-9ab8-186e40e714c7' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "d3fe4fc7-0175-4d33-9ab8-186e40e714c7",
    "type": "menus",
    "attributes": {
      "created_at": "2024-06-24T09:54:28.854634+00:00",
      "updated_at": "2024-06-24T09:54:28.854634+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=d3fe4fc7-0175-4d33-9ab8-186e40e714c7"
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