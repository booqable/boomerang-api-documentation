# Menus

Allows creating and managing menus for your shop.

## Endpoints
`GET /api/boomerang/menus/{id}`

`GET /api/boomerang/menus`

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


## Fetching a price structure



> How to fetch a menu with it's items:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/menus/53bba5d8-9156-4976-9dc5-af7b6b6c4984?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "53bba5d8-9156-4976-9dc5-af7b6b6c4984",
    "type": "menus",
    "attributes": {
      "created_at": "2023-12-11T15:27:46+00:00",
      "updated_at": "2023-12-11T15:27:46+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=53bba5d8-9156-4976-9dc5-af7b6b6c4984"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "1a72b10a-0564-4c83-8447-ead9b4e81166"
          },
          {
            "type": "menu_items",
            "id": "b2707ef2-6c10-4cfb-a047-9e12c8c664af"
          },
          {
            "type": "menu_items",
            "id": "3696dd44-30c2-434d-bae5-619e97fb62ef"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "1a72b10a-0564-4c83-8447-ead9b4e81166",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-12-11T15:27:46+00:00",
        "updated_at": "2023-12-11T15:27:46+00:00",
        "menu_id": "53bba5d8-9156-4976-9dc5-af7b6b6c4984",
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
            "related": "api/boomerang/menus/53bba5d8-9156-4976-9dc5-af7b6b6c4984"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=1a72b10a-0564-4c83-8447-ead9b4e81166"
          }
        }
      }
    },
    {
      "id": "b2707ef2-6c10-4cfb-a047-9e12c8c664af",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-12-11T15:27:46+00:00",
        "updated_at": "2023-12-11T15:27:46+00:00",
        "menu_id": "53bba5d8-9156-4976-9dc5-af7b6b6c4984",
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
            "related": "api/boomerang/menus/53bba5d8-9156-4976-9dc5-af7b6b6c4984"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=b2707ef2-6c10-4cfb-a047-9e12c8c664af"
          }
        }
      }
    },
    {
      "id": "3696dd44-30c2-434d-bae5-619e97fb62ef",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-12-11T15:27:46+00:00",
        "updated_at": "2023-12-11T15:27:46+00:00",
        "menu_id": "53bba5d8-9156-4976-9dc5-af7b6b6c4984",
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
            "related": "api/boomerang/menus/53bba5d8-9156-4976-9dc5-af7b6b6c4984"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=3696dd44-30c2-434d-bae5-619e97fb62ef"
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
      "id": "68466f61-6552-4eed-8322-11d75d262f0f",
      "type": "menus",
      "attributes": {
        "created_at": "2023-12-11T15:27:47+00:00",
        "updated_at": "2023-12-11T15:27:47+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=68466f61-6552-4eed-8322-11d75d262f0f"
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
    "id": "5967be10-b2f0-4809-976b-c9a7a04945f8",
    "type": "menus",
    "attributes": {
      "created_at": "2023-12-11T15:27:47+00:00",
      "updated_at": "2023-12-11T15:27:47+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/f27617e2-542a-424b-8671-caec86a4505a' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "f27617e2-542a-424b-8671-caec86a4505a",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "ec8cbcbe-9c39-4367-a1a4-5671ce4dba9f",
              "title": "Contact us"
            },
            {
              "id": "4aac2920-22c4-47dd-9aa5-02ae73ab5561",
              "title": "Start"
            },
            {
              "id": "78c64e25-562c-41c5-9db7-ddfdd9d1a4ec",
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
    "id": "f27617e2-542a-424b-8671-caec86a4505a",
    "type": "menus",
    "attributes": {
      "created_at": "2023-12-11T15:27:48+00:00",
      "updated_at": "2023-12-11T15:27:48+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "ec8cbcbe-9c39-4367-a1a4-5671ce4dba9f"
          },
          {
            "type": "menu_items",
            "id": "4aac2920-22c4-47dd-9aa5-02ae73ab5561"
          },
          {
            "type": "menu_items",
            "id": "78c64e25-562c-41c5-9db7-ddfdd9d1a4ec"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "ec8cbcbe-9c39-4367-a1a4-5671ce4dba9f",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-12-11T15:27:48+00:00",
        "updated_at": "2023-12-11T15:27:48+00:00",
        "menu_id": "f27617e2-542a-424b-8671-caec86a4505a",
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
      "id": "4aac2920-22c4-47dd-9aa5-02ae73ab5561",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-12-11T15:27:48+00:00",
        "updated_at": "2023-12-11T15:27:48+00:00",
        "menu_id": "f27617e2-542a-424b-8671-caec86a4505a",
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
      "id": "78c64e25-562c-41c5-9db7-ddfdd9d1a4ec",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-12-11T15:27:48+00:00",
        "updated_at": "2023-12-11T15:27:48+00:00",
        "menu_id": "f27617e2-542a-424b-8671-caec86a4505a",
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
    --url 'https://example.booqable.com/api/boomerang/menus/6e99e127-ad57-436f-90fa-5610e3d6be4d' \
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