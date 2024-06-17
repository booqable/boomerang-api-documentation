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
      "id": "0404d70d-4991-4489-8295-b29637d542d3",
      "type": "menus",
      "attributes": {
        "created_at": "2024-06-17T09:23:44.983763+00:00",
        "updated_at": "2024-06-17T09:23:44.983763+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=0404d70d-4991-4489-8295-b29637d542d3"
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
    --url 'https://example.booqable.com/api/boomerang/menus/f8ff08af-fe6c-4cb3-9cdb-a6160232e311?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "f8ff08af-fe6c-4cb3-9cdb-a6160232e311",
    "type": "menus",
    "attributes": {
      "created_at": "2024-06-17T09:23:47.839441+00:00",
      "updated_at": "2024-06-17T09:23:47.839441+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=f8ff08af-fe6c-4cb3-9cdb-a6160232e311"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "b372dd63-ae02-4ece-9625-845df4f6c6ca"
          },
          {
            "type": "menu_items",
            "id": "b9192325-f19b-49d9-96fe-b7a8654fb615"
          },
          {
            "type": "menu_items",
            "id": "d7236006-ec7c-4933-b411-ff5e47a45290"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "b372dd63-ae02-4ece-9625-845df4f6c6ca",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-06-17T09:23:47.842607+00:00",
        "updated_at": "2024-06-17T09:23:47.842607+00:00",
        "menu_id": "f8ff08af-fe6c-4cb3-9cdb-a6160232e311",
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
            "related": "api/boomerang/menus/f8ff08af-fe6c-4cb3-9cdb-a6160232e311"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=b372dd63-ae02-4ece-9625-845df4f6c6ca"
          }
        }
      }
    },
    {
      "id": "b9192325-f19b-49d9-96fe-b7a8654fb615",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-06-17T09:23:47.846163+00:00",
        "updated_at": "2024-06-17T09:23:47.846163+00:00",
        "menu_id": "f8ff08af-fe6c-4cb3-9cdb-a6160232e311",
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
            "related": "api/boomerang/menus/f8ff08af-fe6c-4cb3-9cdb-a6160232e311"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=b9192325-f19b-49d9-96fe-b7a8654fb615"
          }
        }
      }
    },
    {
      "id": "d7236006-ec7c-4933-b411-ff5e47a45290",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-06-17T09:23:47.849379+00:00",
        "updated_at": "2024-06-17T09:23:47.849379+00:00",
        "menu_id": "f8ff08af-fe6c-4cb3-9cdb-a6160232e311",
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
            "related": "api/boomerang/menus/f8ff08af-fe6c-4cb3-9cdb-a6160232e311"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=d7236006-ec7c-4933-b411-ff5e47a45290"
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
    "id": "cc0cf26a-93a8-4a13-a500-5a545c6f4fc0",
    "type": "menus",
    "attributes": {
      "created_at": "2024-06-17T09:23:46.322504+00:00",
      "updated_at": "2024-06-17T09:23:46.322504+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/7db13271-8276-4902-8903-134b90c8ab9b' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "7db13271-8276-4902-8903-134b90c8ab9b",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "26225736-91bc-4e5d-ad2b-34c92b1ed74a",
              "title": "Contact us"
            },
            {
              "id": "8fcb6697-7cd1-4903-b84e-a4997760aeee",
              "title": "Start"
            },
            {
              "id": "8a385e2d-13c4-4c43-8b5f-25c30c6701ad",
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
    "id": "7db13271-8276-4902-8903-134b90c8ab9b",
    "type": "menus",
    "attributes": {
      "created_at": "2024-06-17T09:23:47.085461+00:00",
      "updated_at": "2024-06-17T09:23:47.198694+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "26225736-91bc-4e5d-ad2b-34c92b1ed74a"
          },
          {
            "type": "menu_items",
            "id": "8fcb6697-7cd1-4903-b84e-a4997760aeee"
          },
          {
            "type": "menu_items",
            "id": "8a385e2d-13c4-4c43-8b5f-25c30c6701ad"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "26225736-91bc-4e5d-ad2b-34c92b1ed74a",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-06-17T09:23:47.091073+00:00",
        "updated_at": "2024-06-17T09:23:47.202746+00:00",
        "menu_id": "7db13271-8276-4902-8903-134b90c8ab9b",
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
      "id": "8fcb6697-7cd1-4903-b84e-a4997760aeee",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-06-17T09:23:47.097348+00:00",
        "updated_at": "2024-06-17T09:23:47.223459+00:00",
        "menu_id": "7db13271-8276-4902-8903-134b90c8ab9b",
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
      "id": "8a385e2d-13c4-4c43-8b5f-25c30c6701ad",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-06-17T09:23:47.103489+00:00",
        "updated_at": "2024-06-17T09:23:47.241488+00:00",
        "menu_id": "7db13271-8276-4902-8903-134b90c8ab9b",
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
    --url 'https://example.booqable.com/api/boomerang/menus/11ea3847-4aa6-458e-948e-b3a284415a4a' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "11ea3847-4aa6-458e-948e-b3a284415a4a",
    "type": "menus",
    "attributes": {
      "created_at": "2024-06-17T09:23:45.499418+00:00",
      "updated_at": "2024-06-17T09:23:45.499418+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=11ea3847-4aa6-458e-948e-b3a284415a4a"
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