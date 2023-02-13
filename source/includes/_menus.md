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
- | -
`id` | **Uuid** `readonly`<br>Primary key
`created_at` | **Datetime** `readonly`<br>When the resource was created
`updated_at` | **Datetime** `readonly`<br>When the resource was last updated
`title` | **String** <br>Name of the menu.
`key` | **String** <br>Key the menu can be referenced by.
`menu_items_attributes` | **Array** `writeonly`<br>Attributes of child menu items to be created or changed.


## Relationships
Menus have the following relationships:

Name | Description
- | -
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
      "id": "f665693d-71a8-4121-91f5-c52edffa118d",
      "type": "menus",
      "attributes": {
        "created_at": "2023-02-13T09:09:38+00:00",
        "updated_at": "2023-02-13T09:09:38+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=f665693d-71a8-4121-91f5-c52edffa118d"
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
- | -
`include` | **String** <br>List of comma seperated relationships `?include=menu_items`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[menus]=id,created_at,updated_at`
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-13T09:07:29Z`
`sort` | **String** <br>How to sort the data `?sort=-created_at`
`meta` | **Hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String** <br>The page to request
`page[size]` | **String** <br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
`id` | **Uuid** <br>`eq`, `not_eq`
`created_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`title` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`key` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array** <br>`count`


### Includes

This request does not accept any includes
## Fetching a price structure



> How to fetch a menu with it's items:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/menus/6b66add0-1093-449c-bf9f-dc56472a0912?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "6b66add0-1093-449c-bf9f-dc56472a0912",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-13T09:09:39+00:00",
      "updated_at": "2023-02-13T09:09:39+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=6b66add0-1093-449c-bf9f-dc56472a0912"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "7953ee00-6e67-4870-bd41-85cdf234c82f"
          },
          {
            "type": "menu_items",
            "id": "287eac07-9114-4f67-ac37-e0f010170fbc"
          },
          {
            "type": "menu_items",
            "id": "811e2881-f462-431d-a6dc-b40fdce51be6"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "7953ee00-6e67-4870-bd41-85cdf234c82f",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-13T09:09:39+00:00",
        "updated_at": "2023-02-13T09:09:39+00:00",
        "menu_id": "6b66add0-1093-449c-bf9f-dc56472a0912",
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
            "related": "api/boomerang/menus/6b66add0-1093-449c-bf9f-dc56472a0912"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=7953ee00-6e67-4870-bd41-85cdf234c82f"
          }
        }
      }
    },
    {
      "id": "287eac07-9114-4f67-ac37-e0f010170fbc",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-13T09:09:39+00:00",
        "updated_at": "2023-02-13T09:09:39+00:00",
        "menu_id": "6b66add0-1093-449c-bf9f-dc56472a0912",
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
            "related": "api/boomerang/menus/6b66add0-1093-449c-bf9f-dc56472a0912"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=287eac07-9114-4f67-ac37-e0f010170fbc"
          }
        }
      }
    },
    {
      "id": "811e2881-f462-431d-a6dc-b40fdce51be6",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-13T09:09:39+00:00",
        "updated_at": "2023-02-13T09:09:39+00:00",
        "menu_id": "6b66add0-1093-449c-bf9f-dc56472a0912",
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
            "related": "api/boomerang/menus/6b66add0-1093-449c-bf9f-dc56472a0912"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=811e2881-f462-431d-a6dc-b40fdce51be6"
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
- | -
`include` | **String** <br>List of comma seperated relationships `?include=menu_items`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[menus]=id,created_at,updated_at`


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
    "id": "316529e9-2a20-45d1-9604-635a73750fc7",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-13T09:09:39+00:00",
      "updated_at": "2023-02-13T09:09:39+00:00",
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
- | -
`include` | **String** <br>List of comma seperated relationships `?include=menu_items`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[menus]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
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
    --url 'https://example.booqable.com/api/boomerang/menus/ff2045e0-2ae1-46d1-939c-52fd794c83e2' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "ff2045e0-2ae1-46d1-939c-52fd794c83e2",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "8161070d-830a-4a50-b154-13ab2cbe4f7c",
              "title": "Contact us"
            },
            {
              "id": "00c48d27-9c43-4416-a4d1-c098a0fa2e1a",
              "title": "Start"
            },
            {
              "id": "a7aab62b-62a7-4119-b648-eec594ab182d",
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
    "id": "ff2045e0-2ae1-46d1-939c-52fd794c83e2",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-13T09:09:40+00:00",
      "updated_at": "2023-02-13T09:09:40+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "8161070d-830a-4a50-b154-13ab2cbe4f7c"
          },
          {
            "type": "menu_items",
            "id": "00c48d27-9c43-4416-a4d1-c098a0fa2e1a"
          },
          {
            "type": "menu_items",
            "id": "a7aab62b-62a7-4119-b648-eec594ab182d"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "8161070d-830a-4a50-b154-13ab2cbe4f7c",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-13T09:09:40+00:00",
        "updated_at": "2023-02-13T09:09:40+00:00",
        "menu_id": "ff2045e0-2ae1-46d1-939c-52fd794c83e2",
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
      "id": "00c48d27-9c43-4416-a4d1-c098a0fa2e1a",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-13T09:09:40+00:00",
        "updated_at": "2023-02-13T09:09:40+00:00",
        "menu_id": "ff2045e0-2ae1-46d1-939c-52fd794c83e2",
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
      "id": "a7aab62b-62a7-4119-b648-eec594ab182d",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-13T09:09:40+00:00",
        "updated_at": "2023-02-13T09:09:40+00:00",
        "menu_id": "ff2045e0-2ae1-46d1-939c-52fd794c83e2",
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
- | -
`include` | **String** <br>List of comma seperated relationships `?include=menu_items`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[menus]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
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
    --url 'https://example.booqable.com/api/boomerang/menus/bb712282-7c26-41f8-a257-78c5e1cc82ae' \
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
- | -
`include` | **String** <br>List of comma seperated relationships `?include=menu_items`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[menus]=id,created_at,updated_at`


### Includes

This request does not accept any includes