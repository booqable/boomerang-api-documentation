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
      "id": "36f1587f-6ac0-477e-af9f-8338d7dc2f97",
      "type": "menus",
      "attributes": {
        "created_at": "2024-06-10T09:29:21.897681+00:00",
        "updated_at": "2024-06-10T09:29:21.897681+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=36f1587f-6ac0-477e-af9f-8338d7dc2f97"
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
    --url 'https://example.booqable.com/api/boomerang/menus/c291aeee-5c24-45e1-b26b-99d5d6dc9ed6?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "c291aeee-5c24-45e1-b26b-99d5d6dc9ed6",
    "type": "menus",
    "attributes": {
      "created_at": "2024-06-10T09:29:20.985950+00:00",
      "updated_at": "2024-06-10T09:29:20.985950+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=c291aeee-5c24-45e1-b26b-99d5d6dc9ed6"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "9a880927-7b20-4675-80ab-5504e727b9c7"
          },
          {
            "type": "menu_items",
            "id": "b96c50c1-fa13-4d3e-8045-e9047df1e47a"
          },
          {
            "type": "menu_items",
            "id": "ca22b273-b908-42b4-a9eb-c8a0ac44870c"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "9a880927-7b20-4675-80ab-5504e727b9c7",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-06-10T09:29:20.989095+00:00",
        "updated_at": "2024-06-10T09:29:20.989095+00:00",
        "menu_id": "c291aeee-5c24-45e1-b26b-99d5d6dc9ed6",
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
            "related": "api/boomerang/menus/c291aeee-5c24-45e1-b26b-99d5d6dc9ed6"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=9a880927-7b20-4675-80ab-5504e727b9c7"
          }
        }
      }
    },
    {
      "id": "b96c50c1-fa13-4d3e-8045-e9047df1e47a",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-06-10T09:29:20.992674+00:00",
        "updated_at": "2024-06-10T09:29:20.992674+00:00",
        "menu_id": "c291aeee-5c24-45e1-b26b-99d5d6dc9ed6",
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
            "related": "api/boomerang/menus/c291aeee-5c24-45e1-b26b-99d5d6dc9ed6"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=b96c50c1-fa13-4d3e-8045-e9047df1e47a"
          }
        }
      }
    },
    {
      "id": "ca22b273-b908-42b4-a9eb-c8a0ac44870c",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-06-10T09:29:20.995635+00:00",
        "updated_at": "2024-06-10T09:29:20.995635+00:00",
        "menu_id": "c291aeee-5c24-45e1-b26b-99d5d6dc9ed6",
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
            "related": "api/boomerang/menus/c291aeee-5c24-45e1-b26b-99d5d6dc9ed6"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=ca22b273-b908-42b4-a9eb-c8a0ac44870c"
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
    "id": "45193588-1f79-4b7c-bec1-f83526d9197c",
    "type": "menus",
    "attributes": {
      "created_at": "2024-06-10T09:29:22.744047+00:00",
      "updated_at": "2024-06-10T09:29:22.744047+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/f67d1828-447f-495d-9f59-1d2f8c8d2204' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "f67d1828-447f-495d-9f59-1d2f8c8d2204",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "7c7b3184-f87e-4519-8142-925480021f95",
              "title": "Contact us"
            },
            {
              "id": "9c76eb66-7ac2-4ad8-8acf-2b6f2a3bad72",
              "title": "Start"
            },
            {
              "id": "e77a9df6-cc45-4304-85ee-41be639a9eae",
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
    "id": "f67d1828-447f-495d-9f59-1d2f8c8d2204",
    "type": "menus",
    "attributes": {
      "created_at": "2024-06-10T09:29:23.943635+00:00",
      "updated_at": "2024-06-10T09:29:24.052289+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "7c7b3184-f87e-4519-8142-925480021f95"
          },
          {
            "type": "menu_items",
            "id": "9c76eb66-7ac2-4ad8-8acf-2b6f2a3bad72"
          },
          {
            "type": "menu_items",
            "id": "e77a9df6-cc45-4304-85ee-41be639a9eae"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "7c7b3184-f87e-4519-8142-925480021f95",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-06-10T09:29:23.946118+00:00",
        "updated_at": "2024-06-10T09:29:24.056111+00:00",
        "menu_id": "f67d1828-447f-495d-9f59-1d2f8c8d2204",
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
      "id": "9c76eb66-7ac2-4ad8-8acf-2b6f2a3bad72",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-06-10T09:29:23.948813+00:00",
        "updated_at": "2024-06-10T09:29:24.059690+00:00",
        "menu_id": "f67d1828-447f-495d-9f59-1d2f8c8d2204",
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
      "id": "e77a9df6-cc45-4304-85ee-41be639a9eae",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-06-10T09:29:23.952432+00:00",
        "updated_at": "2024-06-10T09:29:24.062972+00:00",
        "menu_id": "f67d1828-447f-495d-9f59-1d2f8c8d2204",
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
    --url 'https://example.booqable.com/api/boomerang/menus/99e0b90e-e0df-4332-b134-0bdac0309093' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "99e0b90e-e0df-4332-b134-0bdac0309093",
    "type": "menus",
    "attributes": {
      "created_at": "2024-06-10T09:29:23.369232+00:00",
      "updated_at": "2024-06-10T09:29:23.369232+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=99e0b90e-e0df-4332-b134-0bdac0309093"
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