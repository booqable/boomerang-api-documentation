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
      "id": "09b5ff0e-8e94-4fe7-a0cb-2dc1ae8618ba",
      "type": "menus",
      "attributes": {
        "created_at": "2023-02-09T14:23:10+00:00",
        "updated_at": "2023-02-09T14:23:10+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=09b5ff0e-8e94-4fe7-a0cb-2dc1ae8618ba"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-09T14:20:39Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/fba5277c-8bd2-4af2-a2df-10e6317b7e20?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "fba5277c-8bd2-4af2-a2df-10e6317b7e20",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-09T14:23:11+00:00",
      "updated_at": "2023-02-09T14:23:11+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=fba5277c-8bd2-4af2-a2df-10e6317b7e20"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "7be1009b-7259-4870-9c2c-b64112f1fd04"
          },
          {
            "type": "menu_items",
            "id": "109d27dc-b196-41f4-8950-95f5f269e2e3"
          },
          {
            "type": "menu_items",
            "id": "0ce04bfe-215f-4b4d-a1b8-ca112e6f6c47"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "7be1009b-7259-4870-9c2c-b64112f1fd04",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-09T14:23:11+00:00",
        "updated_at": "2023-02-09T14:23:11+00:00",
        "menu_id": "fba5277c-8bd2-4af2-a2df-10e6317b7e20",
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
            "related": "api/boomerang/menus/fba5277c-8bd2-4af2-a2df-10e6317b7e20"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=7be1009b-7259-4870-9c2c-b64112f1fd04"
          }
        }
      }
    },
    {
      "id": "109d27dc-b196-41f4-8950-95f5f269e2e3",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-09T14:23:11+00:00",
        "updated_at": "2023-02-09T14:23:11+00:00",
        "menu_id": "fba5277c-8bd2-4af2-a2df-10e6317b7e20",
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
            "related": "api/boomerang/menus/fba5277c-8bd2-4af2-a2df-10e6317b7e20"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=109d27dc-b196-41f4-8950-95f5f269e2e3"
          }
        }
      }
    },
    {
      "id": "0ce04bfe-215f-4b4d-a1b8-ca112e6f6c47",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-09T14:23:11+00:00",
        "updated_at": "2023-02-09T14:23:11+00:00",
        "menu_id": "fba5277c-8bd2-4af2-a2df-10e6317b7e20",
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
            "related": "api/boomerang/menus/fba5277c-8bd2-4af2-a2df-10e6317b7e20"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=0ce04bfe-215f-4b4d-a1b8-ca112e6f6c47"
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
    "id": "d01d8398-0e73-4631-9e87-0daf2d113517",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-09T14:23:11+00:00",
      "updated_at": "2023-02-09T14:23:11+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/f2d98e0e-b7c0-49b3-a313-24a47b6b0886' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "f2d98e0e-b7c0-49b3-a313-24a47b6b0886",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "208e5f4c-6460-4150-9186-b797206ed46d",
              "title": "Contact us"
            },
            {
              "id": "1d638fd4-6584-49a0-81a1-32cfd3f89cd3",
              "title": "Start"
            },
            {
              "id": "fdeaca72-8581-4de8-a2bb-1fb72dbfaf8f",
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
    "id": "f2d98e0e-b7c0-49b3-a313-24a47b6b0886",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-09T14:23:12+00:00",
      "updated_at": "2023-02-09T14:23:12+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "208e5f4c-6460-4150-9186-b797206ed46d"
          },
          {
            "type": "menu_items",
            "id": "1d638fd4-6584-49a0-81a1-32cfd3f89cd3"
          },
          {
            "type": "menu_items",
            "id": "fdeaca72-8581-4de8-a2bb-1fb72dbfaf8f"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "208e5f4c-6460-4150-9186-b797206ed46d",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-09T14:23:12+00:00",
        "updated_at": "2023-02-09T14:23:12+00:00",
        "menu_id": "f2d98e0e-b7c0-49b3-a313-24a47b6b0886",
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
      "id": "1d638fd4-6584-49a0-81a1-32cfd3f89cd3",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-09T14:23:12+00:00",
        "updated_at": "2023-02-09T14:23:12+00:00",
        "menu_id": "f2d98e0e-b7c0-49b3-a313-24a47b6b0886",
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
      "id": "fdeaca72-8581-4de8-a2bb-1fb72dbfaf8f",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-09T14:23:12+00:00",
        "updated_at": "2023-02-09T14:23:12+00:00",
        "menu_id": "f2d98e0e-b7c0-49b3-a313-24a47b6b0886",
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
    --url 'https://example.booqable.com/api/boomerang/menus/3bf4cf5b-cfbf-4112-8e21-f1faf4a4fa58' \
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