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
      "id": "9c33529e-2dfe-4423-8803-9e2dfa3e6942",
      "type": "menus",
      "attributes": {
        "created_at": "2023-03-07T12:11:39+00:00",
        "updated_at": "2023-03-07T12:11:39+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=9c33529e-2dfe-4423-8803-9e2dfa3e6942"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-03-07T12:09:05Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/b978dd77-b4fe-4273-8740-d16d0c2761dd?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "b978dd77-b4fe-4273-8740-d16d0c2761dd",
    "type": "menus",
    "attributes": {
      "created_at": "2023-03-07T12:11:39+00:00",
      "updated_at": "2023-03-07T12:11:39+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=b978dd77-b4fe-4273-8740-d16d0c2761dd"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "92856e72-8cb9-427c-8443-34fdef107b8e"
          },
          {
            "type": "menu_items",
            "id": "3f688368-00f4-4c38-a489-6a2d12e8486e"
          },
          {
            "type": "menu_items",
            "id": "291e373e-088f-4c2b-a920-81d300208b9f"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "92856e72-8cb9-427c-8443-34fdef107b8e",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-07T12:11:39+00:00",
        "updated_at": "2023-03-07T12:11:39+00:00",
        "menu_id": "b978dd77-b4fe-4273-8740-d16d0c2761dd",
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
            "related": "api/boomerang/menus/b978dd77-b4fe-4273-8740-d16d0c2761dd"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=92856e72-8cb9-427c-8443-34fdef107b8e"
          }
        }
      }
    },
    {
      "id": "3f688368-00f4-4c38-a489-6a2d12e8486e",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-07T12:11:39+00:00",
        "updated_at": "2023-03-07T12:11:39+00:00",
        "menu_id": "b978dd77-b4fe-4273-8740-d16d0c2761dd",
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
            "related": "api/boomerang/menus/b978dd77-b4fe-4273-8740-d16d0c2761dd"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=3f688368-00f4-4c38-a489-6a2d12e8486e"
          }
        }
      }
    },
    {
      "id": "291e373e-088f-4c2b-a920-81d300208b9f",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-07T12:11:39+00:00",
        "updated_at": "2023-03-07T12:11:39+00:00",
        "menu_id": "b978dd77-b4fe-4273-8740-d16d0c2761dd",
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
            "related": "api/boomerang/menus/b978dd77-b4fe-4273-8740-d16d0c2761dd"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=291e373e-088f-4c2b-a920-81d300208b9f"
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
    "id": "9cf472f1-e586-43e1-bc13-1527ae78e31f",
    "type": "menus",
    "attributes": {
      "created_at": "2023-03-07T12:11:39+00:00",
      "updated_at": "2023-03-07T12:11:39+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/299be8e4-975a-40ab-901d-6822297b53aa' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "299be8e4-975a-40ab-901d-6822297b53aa",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "826c6199-5c9a-4fc2-8372-e227884d4218",
              "title": "Contact us"
            },
            {
              "id": "3361bfb3-ac93-4ec0-8baa-556155303c85",
              "title": "Start"
            },
            {
              "id": "23d52d4c-474f-4ac0-84f4-e9f80d0f9b8c",
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
    "id": "299be8e4-975a-40ab-901d-6822297b53aa",
    "type": "menus",
    "attributes": {
      "created_at": "2023-03-07T12:11:40+00:00",
      "updated_at": "2023-03-07T12:11:40+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "826c6199-5c9a-4fc2-8372-e227884d4218"
          },
          {
            "type": "menu_items",
            "id": "3361bfb3-ac93-4ec0-8baa-556155303c85"
          },
          {
            "type": "menu_items",
            "id": "23d52d4c-474f-4ac0-84f4-e9f80d0f9b8c"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "826c6199-5c9a-4fc2-8372-e227884d4218",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-07T12:11:40+00:00",
        "updated_at": "2023-03-07T12:11:40+00:00",
        "menu_id": "299be8e4-975a-40ab-901d-6822297b53aa",
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
      "id": "3361bfb3-ac93-4ec0-8baa-556155303c85",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-07T12:11:40+00:00",
        "updated_at": "2023-03-07T12:11:40+00:00",
        "menu_id": "299be8e4-975a-40ab-901d-6822297b53aa",
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
      "id": "23d52d4c-474f-4ac0-84f4-e9f80d0f9b8c",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-07T12:11:40+00:00",
        "updated_at": "2023-03-07T12:11:40+00:00",
        "menu_id": "299be8e4-975a-40ab-901d-6822297b53aa",
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
    --url 'https://example.booqable.com/api/boomerang/menus/ae098279-04c1-49a4-a43f-60aec6634943' \
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