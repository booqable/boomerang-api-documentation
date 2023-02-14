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
      "id": "ec61598b-218f-47aa-892c-75a1d2c3dd02",
      "type": "menus",
      "attributes": {
        "created_at": "2023-02-14T11:07:19+00:00",
        "updated_at": "2023-02-14T11:07:19+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=ec61598b-218f-47aa-892c-75a1d2c3dd02"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-14T11:05:20Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/40e463e4-75f4-40c4-a364-322da9766fed?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "40e463e4-75f4-40c4-a364-322da9766fed",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-14T11:07:19+00:00",
      "updated_at": "2023-02-14T11:07:19+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=40e463e4-75f4-40c4-a364-322da9766fed"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "5d28a7e1-2e51-4682-9162-2c2394e47009"
          },
          {
            "type": "menu_items",
            "id": "cae03e56-e96b-4c14-8008-1db4a0719ca8"
          },
          {
            "type": "menu_items",
            "id": "635c5a2f-fa2a-4cfb-8e17-f1e2ddf304b1"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "5d28a7e1-2e51-4682-9162-2c2394e47009",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-14T11:07:19+00:00",
        "updated_at": "2023-02-14T11:07:19+00:00",
        "menu_id": "40e463e4-75f4-40c4-a364-322da9766fed",
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
            "related": "api/boomerang/menus/40e463e4-75f4-40c4-a364-322da9766fed"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=5d28a7e1-2e51-4682-9162-2c2394e47009"
          }
        }
      }
    },
    {
      "id": "cae03e56-e96b-4c14-8008-1db4a0719ca8",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-14T11:07:19+00:00",
        "updated_at": "2023-02-14T11:07:19+00:00",
        "menu_id": "40e463e4-75f4-40c4-a364-322da9766fed",
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
            "related": "api/boomerang/menus/40e463e4-75f4-40c4-a364-322da9766fed"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=cae03e56-e96b-4c14-8008-1db4a0719ca8"
          }
        }
      }
    },
    {
      "id": "635c5a2f-fa2a-4cfb-8e17-f1e2ddf304b1",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-14T11:07:19+00:00",
        "updated_at": "2023-02-14T11:07:19+00:00",
        "menu_id": "40e463e4-75f4-40c4-a364-322da9766fed",
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
            "related": "api/boomerang/menus/40e463e4-75f4-40c4-a364-322da9766fed"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=635c5a2f-fa2a-4cfb-8e17-f1e2ddf304b1"
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
    "id": "de165c41-38d3-4e40-a5ef-58795ea511d2",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-14T11:07:20+00:00",
      "updated_at": "2023-02-14T11:07:20+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/705529fa-9768-48ce-8767-01741b871188' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "705529fa-9768-48ce-8767-01741b871188",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "f732692c-0ff8-4d4f-ab34-12a84e4ccff5",
              "title": "Contact us"
            },
            {
              "id": "768d09df-959b-4b34-9164-ab331834711b",
              "title": "Start"
            },
            {
              "id": "006fb090-dea5-4473-9af8-2846d03c0155",
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
    "id": "705529fa-9768-48ce-8767-01741b871188",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-14T11:07:20+00:00",
      "updated_at": "2023-02-14T11:07:20+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "f732692c-0ff8-4d4f-ab34-12a84e4ccff5"
          },
          {
            "type": "menu_items",
            "id": "768d09df-959b-4b34-9164-ab331834711b"
          },
          {
            "type": "menu_items",
            "id": "006fb090-dea5-4473-9af8-2846d03c0155"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "f732692c-0ff8-4d4f-ab34-12a84e4ccff5",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-14T11:07:20+00:00",
        "updated_at": "2023-02-14T11:07:20+00:00",
        "menu_id": "705529fa-9768-48ce-8767-01741b871188",
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
      "id": "768d09df-959b-4b34-9164-ab331834711b",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-14T11:07:20+00:00",
        "updated_at": "2023-02-14T11:07:20+00:00",
        "menu_id": "705529fa-9768-48ce-8767-01741b871188",
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
      "id": "006fb090-dea5-4473-9af8-2846d03c0155",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-14T11:07:20+00:00",
        "updated_at": "2023-02-14T11:07:20+00:00",
        "menu_id": "705529fa-9768-48ce-8767-01741b871188",
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
    --url 'https://example.booqable.com/api/boomerang/menus/f1fe13d8-251d-4798-a309-fdfc8a500126' \
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