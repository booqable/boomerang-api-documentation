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
      "id": "e567e9ba-9598-4d95-b934-85d09159f6a4",
      "type": "menus",
      "attributes": {
        "created_at": "2023-02-16T11:00:13+00:00",
        "updated_at": "2023-02-16T11:00:13+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=e567e9ba-9598-4d95-b934-85d09159f6a4"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-16T10:58:40Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/d94712bc-8fdf-4412-a1fc-6636634c1d02?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "d94712bc-8fdf-4412-a1fc-6636634c1d02",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-16T11:00:13+00:00",
      "updated_at": "2023-02-16T11:00:13+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=d94712bc-8fdf-4412-a1fc-6636634c1d02"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "11543e5c-311e-4131-a13f-e397ddfb3ee0"
          },
          {
            "type": "menu_items",
            "id": "462d6e5a-b899-4ca4-883b-404bd0121598"
          },
          {
            "type": "menu_items",
            "id": "8c2b5913-3952-41b0-9450-d70ecb4c680f"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "11543e5c-311e-4131-a13f-e397ddfb3ee0",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-16T11:00:13+00:00",
        "updated_at": "2023-02-16T11:00:13+00:00",
        "menu_id": "d94712bc-8fdf-4412-a1fc-6636634c1d02",
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
            "related": "api/boomerang/menus/d94712bc-8fdf-4412-a1fc-6636634c1d02"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=11543e5c-311e-4131-a13f-e397ddfb3ee0"
          }
        }
      }
    },
    {
      "id": "462d6e5a-b899-4ca4-883b-404bd0121598",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-16T11:00:13+00:00",
        "updated_at": "2023-02-16T11:00:13+00:00",
        "menu_id": "d94712bc-8fdf-4412-a1fc-6636634c1d02",
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
            "related": "api/boomerang/menus/d94712bc-8fdf-4412-a1fc-6636634c1d02"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=462d6e5a-b899-4ca4-883b-404bd0121598"
          }
        }
      }
    },
    {
      "id": "8c2b5913-3952-41b0-9450-d70ecb4c680f",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-16T11:00:13+00:00",
        "updated_at": "2023-02-16T11:00:13+00:00",
        "menu_id": "d94712bc-8fdf-4412-a1fc-6636634c1d02",
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
            "related": "api/boomerang/menus/d94712bc-8fdf-4412-a1fc-6636634c1d02"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=8c2b5913-3952-41b0-9450-d70ecb4c680f"
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
    "id": "2b221ad1-6b87-4018-b5cf-7175ac634a62",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-16T11:00:14+00:00",
      "updated_at": "2023-02-16T11:00:14+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/17ef7aa5-e50d-4ea6-a2c1-cdd568d624ba' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "17ef7aa5-e50d-4ea6-a2c1-cdd568d624ba",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "6503871a-fc56-4cab-ae4a-ac199327ec3d",
              "title": "Contact us"
            },
            {
              "id": "d00fc8ff-c20b-4da5-958e-41a6ebb37d47",
              "title": "Start"
            },
            {
              "id": "8abdf350-235d-4817-86dc-8416dc1b4529",
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
    "id": "17ef7aa5-e50d-4ea6-a2c1-cdd568d624ba",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-16T11:00:14+00:00",
      "updated_at": "2023-02-16T11:00:14+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "6503871a-fc56-4cab-ae4a-ac199327ec3d"
          },
          {
            "type": "menu_items",
            "id": "d00fc8ff-c20b-4da5-958e-41a6ebb37d47"
          },
          {
            "type": "menu_items",
            "id": "8abdf350-235d-4817-86dc-8416dc1b4529"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "6503871a-fc56-4cab-ae4a-ac199327ec3d",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-16T11:00:14+00:00",
        "updated_at": "2023-02-16T11:00:14+00:00",
        "menu_id": "17ef7aa5-e50d-4ea6-a2c1-cdd568d624ba",
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
      "id": "d00fc8ff-c20b-4da5-958e-41a6ebb37d47",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-16T11:00:14+00:00",
        "updated_at": "2023-02-16T11:00:14+00:00",
        "menu_id": "17ef7aa5-e50d-4ea6-a2c1-cdd568d624ba",
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
      "id": "8abdf350-235d-4817-86dc-8416dc1b4529",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-16T11:00:14+00:00",
        "updated_at": "2023-02-16T11:00:14+00:00",
        "menu_id": "17ef7aa5-e50d-4ea6-a2c1-cdd568d624ba",
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
    --url 'https://example.booqable.com/api/boomerang/menus/2f628548-c455-4f06-be07-58b9215b8737' \
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