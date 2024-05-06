# Menus

Allows creating and managing menus for your shop.

## Endpoints
`PUT /api/boomerang/menus/{id}`

`DELETE /api/boomerang/menus/{id}`

`POST /api/boomerang/menus`

`GET /api/boomerang/menus`

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


## Updating a menu and it's items



> How to update a menu with nested menu items:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/menus/905a35ea-2d90-4c7c-a1b0-bddeede8c33a' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "905a35ea-2d90-4c7c-a1b0-bddeede8c33a",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "349c55a1-d632-4cdb-a946-a71792d563b6",
              "title": "Contact us"
            },
            {
              "id": "3bfcbdc8-aae8-470c-8d7e-139f252de8b9",
              "title": "Start"
            },
            {
              "id": "ff874dfc-7ec2-42eb-a172-921b8b901d2c",
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
    "id": "905a35ea-2d90-4c7c-a1b0-bddeede8c33a",
    "type": "menus",
    "attributes": {
      "created_at": "2024-05-06T09:25:22+00:00",
      "updated_at": "2024-05-06T09:25:22+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "349c55a1-d632-4cdb-a946-a71792d563b6"
          },
          {
            "type": "menu_items",
            "id": "3bfcbdc8-aae8-470c-8d7e-139f252de8b9"
          },
          {
            "type": "menu_items",
            "id": "ff874dfc-7ec2-42eb-a172-921b8b901d2c"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "349c55a1-d632-4cdb-a946-a71792d563b6",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-05-06T09:25:22+00:00",
        "updated_at": "2024-05-06T09:25:22+00:00",
        "menu_id": "905a35ea-2d90-4c7c-a1b0-bddeede8c33a",
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
      "id": "3bfcbdc8-aae8-470c-8d7e-139f252de8b9",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-05-06T09:25:22+00:00",
        "updated_at": "2024-05-06T09:25:22+00:00",
        "menu_id": "905a35ea-2d90-4c7c-a1b0-bddeede8c33a",
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
      "id": "ff874dfc-7ec2-42eb-a172-921b8b901d2c",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-05-06T09:25:22+00:00",
        "updated_at": "2024-05-06T09:25:22+00:00",
        "menu_id": "905a35ea-2d90-4c7c-a1b0-bddeede8c33a",
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
    --url 'https://example.booqable.com/api/boomerang/menus/fda06848-ef41-420d-8cb9-fb3cab1b1a22' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "fda06848-ef41-420d-8cb9-fb3cab1b1a22",
    "type": "menus",
    "attributes": {
      "created_at": "2024-05-06T09:25:23+00:00",
      "updated_at": "2024-05-06T09:25:23+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=fda06848-ef41-420d-8cb9-fb3cab1b1a22"
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
    "id": "376267d2-ea35-4b1c-a218-1a8cb6984311",
    "type": "menus",
    "attributes": {
      "created_at": "2024-05-06T09:25:24+00:00",
      "updated_at": "2024-05-06T09:25:24+00:00",
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
      "id": "2bc02d95-a1cd-47e4-9783-c19a2719c8ef",
      "type": "menus",
      "attributes": {
        "created_at": "2024-05-06T09:25:24+00:00",
        "updated_at": "2024-05-06T09:25:24+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=2bc02d95-a1cd-47e4-9783-c19a2719c8ef"
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
    --url 'https://example.booqable.com/api/boomerang/menus/eba94113-eab0-461b-9970-b8de941825fd?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "eba94113-eab0-461b-9970-b8de941825fd",
    "type": "menus",
    "attributes": {
      "created_at": "2024-05-06T09:25:25+00:00",
      "updated_at": "2024-05-06T09:25:25+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=eba94113-eab0-461b-9970-b8de941825fd"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "1fa8de8f-1564-4c27-9539-63bf39e80982"
          },
          {
            "type": "menu_items",
            "id": "161236a3-dbed-4bf5-be74-0d3272939374"
          },
          {
            "type": "menu_items",
            "id": "90efee21-5aee-4783-91a9-20dd4c172238"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "1fa8de8f-1564-4c27-9539-63bf39e80982",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-05-06T09:25:25+00:00",
        "updated_at": "2024-05-06T09:25:25+00:00",
        "menu_id": "eba94113-eab0-461b-9970-b8de941825fd",
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
            "related": "api/boomerang/menus/eba94113-eab0-461b-9970-b8de941825fd"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=1fa8de8f-1564-4c27-9539-63bf39e80982"
          }
        }
      }
    },
    {
      "id": "161236a3-dbed-4bf5-be74-0d3272939374",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-05-06T09:25:25+00:00",
        "updated_at": "2024-05-06T09:25:25+00:00",
        "menu_id": "eba94113-eab0-461b-9970-b8de941825fd",
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
            "related": "api/boomerang/menus/eba94113-eab0-461b-9970-b8de941825fd"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=161236a3-dbed-4bf5-be74-0d3272939374"
          }
        }
      }
    },
    {
      "id": "90efee21-5aee-4783-91a9-20dd4c172238",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-05-06T09:25:25+00:00",
        "updated_at": "2024-05-06T09:25:25+00:00",
        "menu_id": "eba94113-eab0-461b-9970-b8de941825fd",
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
            "related": "api/boomerang/menus/eba94113-eab0-461b-9970-b8de941825fd"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=90efee21-5aee-4783-91a9-20dd4c172238"
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





