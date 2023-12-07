# Menus

Allows creating and managing menus for your shop.

## Endpoints
`GET /api/boomerang/menus`

`DELETE /api/boomerang/menus/{id}`

`POST /api/boomerang/menus`

`PUT /api/boomerang/menus/{id}`

`GET /api/boomerang/menus/{id}`

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
      "id": "1f836a61-8aaa-4310-8f62-a856602ba236",
      "type": "menus",
      "attributes": {
        "created_at": "2023-12-07T18:41:14+00:00",
        "updated_at": "2023-12-07T18:41:14+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=1f836a61-8aaa-4310-8f62-a856602ba236"
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










## Deleting a menu



> How to delete a menu:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/menus/1c454dd5-e627-4dd9-a5ea-181fb1b016fa' \
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
    "id": "7031a6dd-1d0c-48a0-9561-de1c1f291042",
    "type": "menus",
    "attributes": {
      "created_at": "2023-12-07T18:41:15+00:00",
      "updated_at": "2023-12-07T18:41:15+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/9b83049b-3af4-4971-a925-c12ec61ea165' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "9b83049b-3af4-4971-a925-c12ec61ea165",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "96bd667c-2a82-42f4-8f8f-1f3502b00959",
              "title": "Contact us"
            },
            {
              "id": "2b8cea28-f31e-4325-bd55-c37251fae343",
              "title": "Start"
            },
            {
              "id": "ca0f55ad-29f9-4710-b019-e11c7faf1f79",
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
    "id": "9b83049b-3af4-4971-a925-c12ec61ea165",
    "type": "menus",
    "attributes": {
      "created_at": "2023-12-07T18:41:16+00:00",
      "updated_at": "2023-12-07T18:41:16+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "96bd667c-2a82-42f4-8f8f-1f3502b00959"
          },
          {
            "type": "menu_items",
            "id": "2b8cea28-f31e-4325-bd55-c37251fae343"
          },
          {
            "type": "menu_items",
            "id": "ca0f55ad-29f9-4710-b019-e11c7faf1f79"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "96bd667c-2a82-42f4-8f8f-1f3502b00959",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-12-07T18:41:16+00:00",
        "updated_at": "2023-12-07T18:41:16+00:00",
        "menu_id": "9b83049b-3af4-4971-a925-c12ec61ea165",
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
      "id": "2b8cea28-f31e-4325-bd55-c37251fae343",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-12-07T18:41:16+00:00",
        "updated_at": "2023-12-07T18:41:16+00:00",
        "menu_id": "9b83049b-3af4-4971-a925-c12ec61ea165",
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
      "id": "ca0f55ad-29f9-4710-b019-e11c7faf1f79",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-12-07T18:41:16+00:00",
        "updated_at": "2023-12-07T18:41:16+00:00",
        "menu_id": "9b83049b-3af4-4971-a925-c12ec61ea165",
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










## Fetching a price structure



> How to fetch a menu with it's items:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/menus/51e049e4-6c50-49ba-9e47-baa17e752487?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "51e049e4-6c50-49ba-9e47-baa17e752487",
    "type": "menus",
    "attributes": {
      "created_at": "2023-12-07T18:41:16+00:00",
      "updated_at": "2023-12-07T18:41:16+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=51e049e4-6c50-49ba-9e47-baa17e752487"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "061ac143-5d79-483a-b258-7706297a6c53"
          },
          {
            "type": "menu_items",
            "id": "df367ab2-d3a3-4afd-a97d-01bcf4c18811"
          },
          {
            "type": "menu_items",
            "id": "14bab270-eeb8-421b-9e77-ac26877a8a85"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "061ac143-5d79-483a-b258-7706297a6c53",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-12-07T18:41:16+00:00",
        "updated_at": "2023-12-07T18:41:16+00:00",
        "menu_id": "51e049e4-6c50-49ba-9e47-baa17e752487",
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
            "related": "api/boomerang/menus/51e049e4-6c50-49ba-9e47-baa17e752487"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=061ac143-5d79-483a-b258-7706297a6c53"
          }
        }
      }
    },
    {
      "id": "df367ab2-d3a3-4afd-a97d-01bcf4c18811",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-12-07T18:41:16+00:00",
        "updated_at": "2023-12-07T18:41:16+00:00",
        "menu_id": "51e049e4-6c50-49ba-9e47-baa17e752487",
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
            "related": "api/boomerang/menus/51e049e4-6c50-49ba-9e47-baa17e752487"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=df367ab2-d3a3-4afd-a97d-01bcf4c18811"
          }
        }
      }
    },
    {
      "id": "14bab270-eeb8-421b-9e77-ac26877a8a85",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-12-07T18:41:16+00:00",
        "updated_at": "2023-12-07T18:41:16+00:00",
        "menu_id": "51e049e4-6c50-49ba-9e47-baa17e752487",
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
            "related": "api/boomerang/menus/51e049e4-6c50-49ba-9e47-baa17e752487"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=14bab270-eeb8-421b-9e77-ac26877a8a85"
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





