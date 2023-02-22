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
      "id": "de40aac9-a220-48dd-a073-9dc4e30ef59d",
      "type": "menus",
      "attributes": {
        "created_at": "2023-02-22T11:53:11+00:00",
        "updated_at": "2023-02-22T11:53:11+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=de40aac9-a220-48dd-a073-9dc4e30ef59d"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-22T11:51:19Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/0df18549-38cf-40ed-aa5e-d15210a6ea9a?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "0df18549-38cf-40ed-aa5e-d15210a6ea9a",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-22T11:53:12+00:00",
      "updated_at": "2023-02-22T11:53:12+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=0df18549-38cf-40ed-aa5e-d15210a6ea9a"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "eccde6e9-bf60-42d5-b72c-398b54a4d16b"
          },
          {
            "type": "menu_items",
            "id": "0000f030-48a0-4982-bd82-dc4886f490ec"
          },
          {
            "type": "menu_items",
            "id": "39ba552c-390f-4c0b-98bb-152b7649ee12"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "eccde6e9-bf60-42d5-b72c-398b54a4d16b",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-22T11:53:12+00:00",
        "updated_at": "2023-02-22T11:53:12+00:00",
        "menu_id": "0df18549-38cf-40ed-aa5e-d15210a6ea9a",
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
            "related": "api/boomerang/menus/0df18549-38cf-40ed-aa5e-d15210a6ea9a"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=eccde6e9-bf60-42d5-b72c-398b54a4d16b"
          }
        }
      }
    },
    {
      "id": "0000f030-48a0-4982-bd82-dc4886f490ec",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-22T11:53:12+00:00",
        "updated_at": "2023-02-22T11:53:12+00:00",
        "menu_id": "0df18549-38cf-40ed-aa5e-d15210a6ea9a",
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
            "related": "api/boomerang/menus/0df18549-38cf-40ed-aa5e-d15210a6ea9a"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=0000f030-48a0-4982-bd82-dc4886f490ec"
          }
        }
      }
    },
    {
      "id": "39ba552c-390f-4c0b-98bb-152b7649ee12",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-22T11:53:12+00:00",
        "updated_at": "2023-02-22T11:53:12+00:00",
        "menu_id": "0df18549-38cf-40ed-aa5e-d15210a6ea9a",
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
            "related": "api/boomerang/menus/0df18549-38cf-40ed-aa5e-d15210a6ea9a"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=39ba552c-390f-4c0b-98bb-152b7649ee12"
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
    "id": "614ab45b-53e1-426c-9478-417d46cccb3a",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-22T11:53:12+00:00",
      "updated_at": "2023-02-22T11:53:12+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/6575eed1-2a37-4735-a264-218dd93208f7' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "6575eed1-2a37-4735-a264-218dd93208f7",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "d9d3607a-136c-4c3d-955c-baa5810ff05b",
              "title": "Contact us"
            },
            {
              "id": "27389629-3074-4a75-a6a9-3fc01c07bb47",
              "title": "Start"
            },
            {
              "id": "48b31d0c-0490-4f23-8d64-cdccb8d9e725",
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
    "id": "6575eed1-2a37-4735-a264-218dd93208f7",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-22T11:53:12+00:00",
      "updated_at": "2023-02-22T11:53:13+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "d9d3607a-136c-4c3d-955c-baa5810ff05b"
          },
          {
            "type": "menu_items",
            "id": "27389629-3074-4a75-a6a9-3fc01c07bb47"
          },
          {
            "type": "menu_items",
            "id": "48b31d0c-0490-4f23-8d64-cdccb8d9e725"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "d9d3607a-136c-4c3d-955c-baa5810ff05b",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-22T11:53:12+00:00",
        "updated_at": "2023-02-22T11:53:13+00:00",
        "menu_id": "6575eed1-2a37-4735-a264-218dd93208f7",
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
      "id": "27389629-3074-4a75-a6a9-3fc01c07bb47",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-22T11:53:12+00:00",
        "updated_at": "2023-02-22T11:53:13+00:00",
        "menu_id": "6575eed1-2a37-4735-a264-218dd93208f7",
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
      "id": "48b31d0c-0490-4f23-8d64-cdccb8d9e725",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-22T11:53:12+00:00",
        "updated_at": "2023-02-22T11:53:13+00:00",
        "menu_id": "6575eed1-2a37-4735-a264-218dd93208f7",
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
    --url 'https://example.booqable.com/api/boomerang/menus/42a492c3-1bf6-450c-ad25-c972de5ef42a' \
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