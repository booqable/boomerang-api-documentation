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
`title` | **String**<br>Name of the menu.
`key` | **String**<br>Key the menu can be referenced by.
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
      "id": "a6e2ee8b-447a-4437-b923-1c5e90897f7b",
      "type": "menus",
      "attributes": {
        "created_at": "2022-07-14T12:40:40+00:00",
        "updated_at": "2022-07-14T12:40:40+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=a6e2ee8b-447a-4437-b923-1c5e90897f7b"
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=menu_items`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[menus]=id,created_at,updated_at`
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-07-14T12:38:59Z`
`sort` | **String**<br>How to sort the data `?sort=-created_at`
`meta` | **Hash**<br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String**<br>The page to request
`page[size]` | **String**<br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
`id` | **Uuid**<br>`eq`, `not_eq`
`created_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`title` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`key` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array**<br>`count`


### Includes

This request does not accept any includes
## Fetching a price structure



> How to fetch a menu with it's items:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/menus/2c2cd2dc-92f4-4585-93d7-71bc0dca59e7?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "2c2cd2dc-92f4-4585-93d7-71bc0dca59e7",
    "type": "menus",
    "attributes": {
      "created_at": "2022-07-14T12:40:41+00:00",
      "updated_at": "2022-07-14T12:40:41+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=2c2cd2dc-92f4-4585-93d7-71bc0dca59e7"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "c958c771-2810-4017-876f-d3d0a54c47ce"
          },
          {
            "type": "menu_items",
            "id": "8aaa747d-20c7-4f4c-8bdc-d2f309ac4077"
          },
          {
            "type": "menu_items",
            "id": "480dfce7-2325-45ea-a1e9-cff4c9e5ce71"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "c958c771-2810-4017-876f-d3d0a54c47ce",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-07-14T12:40:41+00:00",
        "updated_at": "2022-07-14T12:40:41+00:00",
        "menu_id": "2c2cd2dc-92f4-4585-93d7-71bc0dca59e7",
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
            "related": "api/boomerang/menus/2c2cd2dc-92f4-4585-93d7-71bc0dca59e7"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=c958c771-2810-4017-876f-d3d0a54c47ce"
          }
        }
      }
    },
    {
      "id": "8aaa747d-20c7-4f4c-8bdc-d2f309ac4077",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-07-14T12:40:41+00:00",
        "updated_at": "2022-07-14T12:40:41+00:00",
        "menu_id": "2c2cd2dc-92f4-4585-93d7-71bc0dca59e7",
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
            "related": "api/boomerang/menus/2c2cd2dc-92f4-4585-93d7-71bc0dca59e7"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=8aaa747d-20c7-4f4c-8bdc-d2f309ac4077"
          }
        }
      }
    },
    {
      "id": "480dfce7-2325-45ea-a1e9-cff4c9e5ce71",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-07-14T12:40:41+00:00",
        "updated_at": "2022-07-14T12:40:41+00:00",
        "menu_id": "2c2cd2dc-92f4-4585-93d7-71bc0dca59e7",
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
            "related": "api/boomerang/menus/2c2cd2dc-92f4-4585-93d7-71bc0dca59e7"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=480dfce7-2325-45ea-a1e9-cff4c9e5ce71"
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=menu_items`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[menus]=id,created_at,updated_at`


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
    "id": "c8242916-322c-4a85-a6d8-71e86bdf99ca",
    "type": "menus",
    "attributes": {
      "created_at": "2022-07-14T12:40:41+00:00",
      "updated_at": "2022-07-14T12:40:41+00:00",
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=menu_items`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[menus]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][title]` | **String**<br>Name of the menu.
`data[attributes][key]` | **String**<br>Key the menu can be referenced by.
`data[attributes][menu_items_attributes][]` | **Array**<br>Attributes of child menu items to be created or changed.


### Includes

This request accepts the following includes:

`menu_items` => 
`menu_items` => 
`menu_items`










## Updating a menu and it's items



> How to update a menu with nested menu items:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/menus/6ba4301a-40f4-43c2-8a03-ad91ea9edc23' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "6ba4301a-40f4-43c2-8a03-ad91ea9edc23",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "aa43232a-c102-4eaf-9b7c-e83cb3d3848e",
              "title": "Contact us"
            },
            {
              "id": "52e2da2b-0597-474c-a089-66d333202ad0",
              "title": "Start"
            },
            {
              "id": "ec08ebd2-bd54-45f1-9c63-c2e5b75a93cf",
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
    "id": "6ba4301a-40f4-43c2-8a03-ad91ea9edc23",
    "type": "menus",
    "attributes": {
      "created_at": "2022-07-14T12:40:41+00:00",
      "updated_at": "2022-07-14T12:40:41+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "aa43232a-c102-4eaf-9b7c-e83cb3d3848e"
          },
          {
            "type": "menu_items",
            "id": "52e2da2b-0597-474c-a089-66d333202ad0"
          },
          {
            "type": "menu_items",
            "id": "ec08ebd2-bd54-45f1-9c63-c2e5b75a93cf"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "aa43232a-c102-4eaf-9b7c-e83cb3d3848e",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-07-14T12:40:41+00:00",
        "updated_at": "2022-07-14T12:40:41+00:00",
        "menu_id": "6ba4301a-40f4-43c2-8a03-ad91ea9edc23",
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
      "id": "52e2da2b-0597-474c-a089-66d333202ad0",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-07-14T12:40:41+00:00",
        "updated_at": "2022-07-14T12:40:41+00:00",
        "menu_id": "6ba4301a-40f4-43c2-8a03-ad91ea9edc23",
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
      "id": "ec08ebd2-bd54-45f1-9c63-c2e5b75a93cf",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-07-14T12:40:41+00:00",
        "updated_at": "2022-07-14T12:40:41+00:00",
        "menu_id": "6ba4301a-40f4-43c2-8a03-ad91ea9edc23",
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=menu_items`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[menus]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][title]` | **String**<br>Name of the menu.
`data[attributes][key]` | **String**<br>Key the menu can be referenced by.
`data[attributes][menu_items_attributes][]` | **Array**<br>Attributes of child menu items to be created or changed.


### Includes

This request accepts the following includes:

`menu_items` => 
`menu_items` => 
`menu_items`










## Deleting a menu



> How to delete a menu:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/menus/20ff6cf3-c441-44e4-9eec-8e3d183075e1' \
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=menu_items`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[menus]=id,created_at,updated_at`


### Includes

This request does not accept any includes