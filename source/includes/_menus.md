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
      "id": "8e482165-4d79-4918-a51d-483d3349d1a8",
      "type": "menus",
      "attributes": {
        "created_at": "2023-02-24T08:43:38+00:00",
        "updated_at": "2023-02-24T08:43:38+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=8e482165-4d79-4918-a51d-483d3349d1a8"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-24T08:41:10Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/44472385-b855-4896-bf20-52cf84a59de3?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "44472385-b855-4896-bf20-52cf84a59de3",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-24T08:43:38+00:00",
      "updated_at": "2023-02-24T08:43:38+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=44472385-b855-4896-bf20-52cf84a59de3"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "ebbe4fd0-ca76-4673-8fa4-5dcff49ff431"
          },
          {
            "type": "menu_items",
            "id": "f0ded77f-a53b-4078-848c-b5f697d3d8bb"
          },
          {
            "type": "menu_items",
            "id": "35ebfbf2-f0a4-48bc-ae4a-6a05dee3c64f"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "ebbe4fd0-ca76-4673-8fa4-5dcff49ff431",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-24T08:43:38+00:00",
        "updated_at": "2023-02-24T08:43:38+00:00",
        "menu_id": "44472385-b855-4896-bf20-52cf84a59de3",
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
            "related": "api/boomerang/menus/44472385-b855-4896-bf20-52cf84a59de3"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=ebbe4fd0-ca76-4673-8fa4-5dcff49ff431"
          }
        }
      }
    },
    {
      "id": "f0ded77f-a53b-4078-848c-b5f697d3d8bb",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-24T08:43:38+00:00",
        "updated_at": "2023-02-24T08:43:38+00:00",
        "menu_id": "44472385-b855-4896-bf20-52cf84a59de3",
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
            "related": "api/boomerang/menus/44472385-b855-4896-bf20-52cf84a59de3"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=f0ded77f-a53b-4078-848c-b5f697d3d8bb"
          }
        }
      }
    },
    {
      "id": "35ebfbf2-f0a4-48bc-ae4a-6a05dee3c64f",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-24T08:43:38+00:00",
        "updated_at": "2023-02-24T08:43:38+00:00",
        "menu_id": "44472385-b855-4896-bf20-52cf84a59de3",
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
            "related": "api/boomerang/menus/44472385-b855-4896-bf20-52cf84a59de3"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=35ebfbf2-f0a4-48bc-ae4a-6a05dee3c64f"
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
    "id": "329581e4-fbef-4857-a0a4-3424169d1801",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-24T08:43:39+00:00",
      "updated_at": "2023-02-24T08:43:39+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/c2f18052-7903-4948-9ff3-b507ff8b806c' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "c2f18052-7903-4948-9ff3-b507ff8b806c",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "05c0579c-fc32-4213-871d-39e3819ea5b1",
              "title": "Contact us"
            },
            {
              "id": "14109601-60a3-4b0c-b7bb-85a29aa49496",
              "title": "Start"
            },
            {
              "id": "ec9f8618-fd73-432d-bf10-a9f9e24b553e",
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
    "id": "c2f18052-7903-4948-9ff3-b507ff8b806c",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-24T08:43:39+00:00",
      "updated_at": "2023-02-24T08:43:39+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "05c0579c-fc32-4213-871d-39e3819ea5b1"
          },
          {
            "type": "menu_items",
            "id": "14109601-60a3-4b0c-b7bb-85a29aa49496"
          },
          {
            "type": "menu_items",
            "id": "ec9f8618-fd73-432d-bf10-a9f9e24b553e"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "05c0579c-fc32-4213-871d-39e3819ea5b1",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-24T08:43:39+00:00",
        "updated_at": "2023-02-24T08:43:39+00:00",
        "menu_id": "c2f18052-7903-4948-9ff3-b507ff8b806c",
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
      "id": "14109601-60a3-4b0c-b7bb-85a29aa49496",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-24T08:43:39+00:00",
        "updated_at": "2023-02-24T08:43:39+00:00",
        "menu_id": "c2f18052-7903-4948-9ff3-b507ff8b806c",
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
      "id": "ec9f8618-fd73-432d-bf10-a9f9e24b553e",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-24T08:43:39+00:00",
        "updated_at": "2023-02-24T08:43:39+00:00",
        "menu_id": "c2f18052-7903-4948-9ff3-b507ff8b806c",
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
    --url 'https://example.booqable.com/api/boomerang/menus/dc01ec1b-73f1-4513-bb02-4e3b3a276296' \
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