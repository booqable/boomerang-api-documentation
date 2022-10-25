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
      "id": "2b8efc8f-26c3-4691-b2c5-f0599c2263a6",
      "type": "menus",
      "attributes": {
        "created_at": "2022-10-25T14:59:42+00:00",
        "updated_at": "2022-10-25T14:59:42+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=2b8efc8f-26c3-4691-b2c5-f0599c2263a6"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-10-25T14:57:41Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/e6d66df9-49d8-4448-8692-412b4f6d01b4?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "e6d66df9-49d8-4448-8692-412b4f6d01b4",
    "type": "menus",
    "attributes": {
      "created_at": "2022-10-25T14:59:43+00:00",
      "updated_at": "2022-10-25T14:59:43+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=e6d66df9-49d8-4448-8692-412b4f6d01b4"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "45b00f09-5d30-4c60-9931-c667a79d7010"
          },
          {
            "type": "menu_items",
            "id": "93bd96ea-50d0-491e-83e4-140a223c5131"
          },
          {
            "type": "menu_items",
            "id": "2e23a903-de5b-4e58-b459-5e31a4620c13"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "45b00f09-5d30-4c60-9931-c667a79d7010",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-10-25T14:59:43+00:00",
        "updated_at": "2022-10-25T14:59:43+00:00",
        "menu_id": "e6d66df9-49d8-4448-8692-412b4f6d01b4",
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
            "related": "api/boomerang/menus/e6d66df9-49d8-4448-8692-412b4f6d01b4"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=45b00f09-5d30-4c60-9931-c667a79d7010"
          }
        }
      }
    },
    {
      "id": "93bd96ea-50d0-491e-83e4-140a223c5131",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-10-25T14:59:43+00:00",
        "updated_at": "2022-10-25T14:59:43+00:00",
        "menu_id": "e6d66df9-49d8-4448-8692-412b4f6d01b4",
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
            "related": "api/boomerang/menus/e6d66df9-49d8-4448-8692-412b4f6d01b4"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=93bd96ea-50d0-491e-83e4-140a223c5131"
          }
        }
      }
    },
    {
      "id": "2e23a903-de5b-4e58-b459-5e31a4620c13",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-10-25T14:59:43+00:00",
        "updated_at": "2022-10-25T14:59:43+00:00",
        "menu_id": "e6d66df9-49d8-4448-8692-412b4f6d01b4",
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
            "related": "api/boomerang/menus/e6d66df9-49d8-4448-8692-412b4f6d01b4"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=2e23a903-de5b-4e58-b459-5e31a4620c13"
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
    "id": "f05bfbe9-6b99-45b6-992b-df12cffacddf",
    "type": "menus",
    "attributes": {
      "created_at": "2022-10-25T14:59:43+00:00",
      "updated_at": "2022-10-25T14:59:43+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/67ff8504-65ca-4395-94ef-1de133f58ae0' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "67ff8504-65ca-4395-94ef-1de133f58ae0",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "4cbfd736-ca60-4b45-9c08-89ff97d8c6e8",
              "title": "Contact us"
            },
            {
              "id": "66ffb88d-56fb-44e2-b854-e80e0ded7da0",
              "title": "Start"
            },
            {
              "id": "82b4005d-6125-4b91-b478-49cf4d6b37e1",
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
    "id": "67ff8504-65ca-4395-94ef-1de133f58ae0",
    "type": "menus",
    "attributes": {
      "created_at": "2022-10-25T14:59:43+00:00",
      "updated_at": "2022-10-25T14:59:43+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "4cbfd736-ca60-4b45-9c08-89ff97d8c6e8"
          },
          {
            "type": "menu_items",
            "id": "66ffb88d-56fb-44e2-b854-e80e0ded7da0"
          },
          {
            "type": "menu_items",
            "id": "82b4005d-6125-4b91-b478-49cf4d6b37e1"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "4cbfd736-ca60-4b45-9c08-89ff97d8c6e8",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-10-25T14:59:43+00:00",
        "updated_at": "2022-10-25T14:59:43+00:00",
        "menu_id": "67ff8504-65ca-4395-94ef-1de133f58ae0",
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
      "id": "66ffb88d-56fb-44e2-b854-e80e0ded7da0",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-10-25T14:59:43+00:00",
        "updated_at": "2022-10-25T14:59:43+00:00",
        "menu_id": "67ff8504-65ca-4395-94ef-1de133f58ae0",
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
      "id": "82b4005d-6125-4b91-b478-49cf4d6b37e1",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-10-25T14:59:43+00:00",
        "updated_at": "2022-10-25T14:59:43+00:00",
        "menu_id": "67ff8504-65ca-4395-94ef-1de133f58ae0",
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
    --url 'https://example.booqable.com/api/boomerang/menus/f5b3dea9-4065-46d8-a702-c25e53584eb6' \
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