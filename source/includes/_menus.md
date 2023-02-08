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
      "id": "0b141a57-02e3-4235-8eb7-f3c923e84eaa",
      "type": "menus",
      "attributes": {
        "created_at": "2023-02-08T13:51:59+00:00",
        "updated_at": "2023-02-08T13:51:59+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=0b141a57-02e3-4235-8eb7-f3c923e84eaa"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-08T13:50:28Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/7da4dd63-fab3-49f6-965f-a1d239beeeba?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "7da4dd63-fab3-49f6-965f-a1d239beeeba",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-08T13:51:59+00:00",
      "updated_at": "2023-02-08T13:51:59+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=7da4dd63-fab3-49f6-965f-a1d239beeeba"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "c9da73aa-8c8e-4d5b-bab8-eb13d966819f"
          },
          {
            "type": "menu_items",
            "id": "e65cf91f-7943-4c65-b95e-646738c0ade9"
          },
          {
            "type": "menu_items",
            "id": "1864752f-628f-47b5-a2e2-5929f4089d2e"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "c9da73aa-8c8e-4d5b-bab8-eb13d966819f",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-08T13:51:59+00:00",
        "updated_at": "2023-02-08T13:51:59+00:00",
        "menu_id": "7da4dd63-fab3-49f6-965f-a1d239beeeba",
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
            "related": "api/boomerang/menus/7da4dd63-fab3-49f6-965f-a1d239beeeba"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=c9da73aa-8c8e-4d5b-bab8-eb13d966819f"
          }
        }
      }
    },
    {
      "id": "e65cf91f-7943-4c65-b95e-646738c0ade9",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-08T13:51:59+00:00",
        "updated_at": "2023-02-08T13:51:59+00:00",
        "menu_id": "7da4dd63-fab3-49f6-965f-a1d239beeeba",
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
            "related": "api/boomerang/menus/7da4dd63-fab3-49f6-965f-a1d239beeeba"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=e65cf91f-7943-4c65-b95e-646738c0ade9"
          }
        }
      }
    },
    {
      "id": "1864752f-628f-47b5-a2e2-5929f4089d2e",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-08T13:51:59+00:00",
        "updated_at": "2023-02-08T13:51:59+00:00",
        "menu_id": "7da4dd63-fab3-49f6-965f-a1d239beeeba",
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
            "related": "api/boomerang/menus/7da4dd63-fab3-49f6-965f-a1d239beeeba"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=1864752f-628f-47b5-a2e2-5929f4089d2e"
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
    "id": "6200faf1-0ce1-4961-8f84-5d2ed41b73b0",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-08T13:52:00+00:00",
      "updated_at": "2023-02-08T13:52:00+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/1c03d7f9-ff04-4de6-be03-b5796e8297ff' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "1c03d7f9-ff04-4de6-be03-b5796e8297ff",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "3e51129c-e90f-40bc-a635-d6947d135524",
              "title": "Contact us"
            },
            {
              "id": "fd34966a-1211-442b-a4f7-60fd3c455096",
              "title": "Start"
            },
            {
              "id": "27d57581-df17-48c1-97a9-25febfc61359",
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
    "id": "1c03d7f9-ff04-4de6-be03-b5796e8297ff",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-08T13:52:00+00:00",
      "updated_at": "2023-02-08T13:52:00+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "3e51129c-e90f-40bc-a635-d6947d135524"
          },
          {
            "type": "menu_items",
            "id": "fd34966a-1211-442b-a4f7-60fd3c455096"
          },
          {
            "type": "menu_items",
            "id": "27d57581-df17-48c1-97a9-25febfc61359"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "3e51129c-e90f-40bc-a635-d6947d135524",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-08T13:52:00+00:00",
        "updated_at": "2023-02-08T13:52:00+00:00",
        "menu_id": "1c03d7f9-ff04-4de6-be03-b5796e8297ff",
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
      "id": "fd34966a-1211-442b-a4f7-60fd3c455096",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-08T13:52:00+00:00",
        "updated_at": "2023-02-08T13:52:00+00:00",
        "menu_id": "1c03d7f9-ff04-4de6-be03-b5796e8297ff",
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
      "id": "27d57581-df17-48c1-97a9-25febfc61359",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-08T13:52:00+00:00",
        "updated_at": "2023-02-08T13:52:00+00:00",
        "menu_id": "1c03d7f9-ff04-4de6-be03-b5796e8297ff",
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
    --url 'https://example.booqable.com/api/boomerang/menus/f6c5455b-325c-43dd-9717-b10e8c833a59' \
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