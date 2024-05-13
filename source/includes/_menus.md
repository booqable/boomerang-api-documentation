# Menus

Allows creating and managing menus for your shop.

## Endpoints
`GET /api/boomerang/menus/{id}`

`PUT /api/boomerang/menus/{id}`

`DELETE /api/boomerang/menus/{id}`

`POST /api/boomerang/menus`

`GET /api/boomerang/menus`

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


## Fetching a menu



> How to fetch a menu with it's items:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/menus/f9eb8a4e-253a-4b09-a6f4-14ce3586cf2a?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "f9eb8a4e-253a-4b09-a6f4-14ce3586cf2a",
    "type": "menus",
    "attributes": {
      "created_at": "2024-05-13T09:29:35+00:00",
      "updated_at": "2024-05-13T09:29:35+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=f9eb8a4e-253a-4b09-a6f4-14ce3586cf2a"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "b5bdb748-5ca4-4f00-81a6-41b283eaeb09"
          },
          {
            "type": "menu_items",
            "id": "8b1e6478-5a25-4c87-b15b-50438a7ba0d1"
          },
          {
            "type": "menu_items",
            "id": "328f5e71-9c8a-46b0-a4df-d135caa38c47"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "b5bdb748-5ca4-4f00-81a6-41b283eaeb09",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-05-13T09:29:35+00:00",
        "updated_at": "2024-05-13T09:29:35+00:00",
        "menu_id": "f9eb8a4e-253a-4b09-a6f4-14ce3586cf2a",
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
            "related": "api/boomerang/menus/f9eb8a4e-253a-4b09-a6f4-14ce3586cf2a"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=b5bdb748-5ca4-4f00-81a6-41b283eaeb09"
          }
        }
      }
    },
    {
      "id": "8b1e6478-5a25-4c87-b15b-50438a7ba0d1",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-05-13T09:29:35+00:00",
        "updated_at": "2024-05-13T09:29:35+00:00",
        "menu_id": "f9eb8a4e-253a-4b09-a6f4-14ce3586cf2a",
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
            "related": "api/boomerang/menus/f9eb8a4e-253a-4b09-a6f4-14ce3586cf2a"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=8b1e6478-5a25-4c87-b15b-50438a7ba0d1"
          }
        }
      }
    },
    {
      "id": "328f5e71-9c8a-46b0-a4df-d135caa38c47",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-05-13T09:29:35+00:00",
        "updated_at": "2024-05-13T09:29:35+00:00",
        "menu_id": "f9eb8a4e-253a-4b09-a6f4-14ce3586cf2a",
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
            "related": "api/boomerang/menus/f9eb8a4e-253a-4b09-a6f4-14ce3586cf2a"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=328f5e71-9c8a-46b0-a4df-d135caa38c47"
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






## Updating a menu and it's items



> How to update a menu with nested menu items:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/menus/3657d101-62b4-45c3-8ba4-f46a1d7c69cb' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "3657d101-62b4-45c3-8ba4-f46a1d7c69cb",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "6d104b83-e4ac-47eb-b945-140bbf4eb311",
              "title": "Contact us"
            },
            {
              "id": "440f5ae3-9e56-4bed-8583-53ea49c5389b",
              "title": "Start"
            },
            {
              "id": "191c0070-26a5-491f-933f-415bcb9d4113",
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
    "id": "3657d101-62b4-45c3-8ba4-f46a1d7c69cb",
    "type": "menus",
    "attributes": {
      "created_at": "2024-05-13T09:29:37+00:00",
      "updated_at": "2024-05-13T09:29:37+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "6d104b83-e4ac-47eb-b945-140bbf4eb311"
          },
          {
            "type": "menu_items",
            "id": "440f5ae3-9e56-4bed-8583-53ea49c5389b"
          },
          {
            "type": "menu_items",
            "id": "191c0070-26a5-491f-933f-415bcb9d4113"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "6d104b83-e4ac-47eb-b945-140bbf4eb311",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-05-13T09:29:37+00:00",
        "updated_at": "2024-05-13T09:29:37+00:00",
        "menu_id": "3657d101-62b4-45c3-8ba4-f46a1d7c69cb",
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
      "id": "440f5ae3-9e56-4bed-8583-53ea49c5389b",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-05-13T09:29:37+00:00",
        "updated_at": "2024-05-13T09:29:37+00:00",
        "menu_id": "3657d101-62b4-45c3-8ba4-f46a1d7c69cb",
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
      "id": "191c0070-26a5-491f-933f-415bcb9d4113",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-05-13T09:29:37+00:00",
        "updated_at": "2024-05-13T09:29:37+00:00",
        "menu_id": "3657d101-62b4-45c3-8ba4-f46a1d7c69cb",
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
    --url 'https://example.booqable.com/api/boomerang/menus/771e9c76-d0ea-43e0-88dd-44ecc9edaa90' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "771e9c76-d0ea-43e0-88dd-44ecc9edaa90",
    "type": "menus",
    "attributes": {
      "created_at": "2024-05-13T09:29:39+00:00",
      "updated_at": "2024-05-13T09:29:39+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=771e9c76-d0ea-43e0-88dd-44ecc9edaa90"
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
    "id": "fa785a02-10e7-4d59-bd26-6b80ffa034b8",
    "type": "menus",
    "attributes": {
      "created_at": "2024-05-13T09:29:40+00:00",
      "updated_at": "2024-05-13T09:29:40+00:00",
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
      "id": "c5a3dd4a-d7a5-4541-a935-3335659462ab",
      "type": "menus",
      "attributes": {
        "created_at": "2024-05-13T09:29:41+00:00",
        "updated_at": "2024-05-13T09:29:41+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=c5a3dd4a-d7a5-4541-a935-3335659462ab"
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









