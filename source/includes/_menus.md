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
`title` | **String**<br>Name of the menu.
`key` | **String**<br>Key the menu can be referenced by.
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
      "id": "8c8dc081-9850-4a23-9dbd-284b3a8bf886",
      "type": "menus",
      "attributes": {
        "created_at": "2022-07-12T14:15:25+00:00",
        "updated_at": "2022-07-12T14:15:25+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=8c8dc081-9850-4a23-9dbd-284b3a8bf886"
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=menu_items`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[menus]=id,created_at,updated_at`
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-07-12T14:13:34Z`
`sort` | **String**<br>How to sort the data `?sort=-created_at`
`meta` | **Hash**<br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String**<br>The page to request
`page[size]` | **String**<br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
`id` | **Uuid**<br>`eq`, `not_eq`
`created_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`title` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`key` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array**<br>`count`


### Includes

This request does not accept any includes
## Fetching a price structure



> How to fetch a menu with it's items:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/menus/c4649062-e702-46cf-aa14-d6f33cf0dd16?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "c4649062-e702-46cf-aa14-d6f33cf0dd16",
    "type": "menus",
    "attributes": {
      "created_at": "2022-07-12T14:15:25+00:00",
      "updated_at": "2022-07-12T14:15:25+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=c4649062-e702-46cf-aa14-d6f33cf0dd16"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "42a0863e-6d24-4dfb-bf3a-7010dc54deac"
          },
          {
            "type": "menu_items",
            "id": "803ce921-ebe4-49f9-907d-b130bf307dc6"
          },
          {
            "type": "menu_items",
            "id": "6ca22bd1-713b-43f3-96b6-06976ce5770a"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "42a0863e-6d24-4dfb-bf3a-7010dc54deac",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-07-12T14:15:25+00:00",
        "updated_at": "2022-07-12T14:15:25+00:00",
        "menu_id": "c4649062-e702-46cf-aa14-d6f33cf0dd16",
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
            "related": "api/boomerang/menus/c4649062-e702-46cf-aa14-d6f33cf0dd16"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=42a0863e-6d24-4dfb-bf3a-7010dc54deac"
          }
        }
      }
    },
    {
      "id": "803ce921-ebe4-49f9-907d-b130bf307dc6",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-07-12T14:15:25+00:00",
        "updated_at": "2022-07-12T14:15:25+00:00",
        "menu_id": "c4649062-e702-46cf-aa14-d6f33cf0dd16",
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
            "related": "api/boomerang/menus/c4649062-e702-46cf-aa14-d6f33cf0dd16"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=803ce921-ebe4-49f9-907d-b130bf307dc6"
          }
        }
      }
    },
    {
      "id": "6ca22bd1-713b-43f3-96b6-06976ce5770a",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-07-12T14:15:25+00:00",
        "updated_at": "2022-07-12T14:15:25+00:00",
        "menu_id": "c4649062-e702-46cf-aa14-d6f33cf0dd16",
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
            "related": "api/boomerang/menus/c4649062-e702-46cf-aa14-d6f33cf0dd16"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=6ca22bd1-713b-43f3-96b6-06976ce5770a"
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=menu_items`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[menus]=id,created_at,updated_at`


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
    "id": "92c54966-1762-4c7c-a7d7-b55d28e80e21",
    "type": "menus",
    "attributes": {
      "created_at": "2022-07-12T14:15:26+00:00",
      "updated_at": "2022-07-12T14:15:26+00:00",
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=menu_items`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[menus]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][title]` | **String**<br>Name of the menu.
`data[attributes][key]` | **String**<br>Key the menu can be referenced by.
`data[attributes][menu_items_attributes][]` | **Array**<br>Attributes of child menu items to be created or changed.


### Includes

This request accepts the following includes:

`menu_items` => 
`menu_items` => 
`menu_items`










## Updating a menu and it's items



> How to update a menu with nested menu items:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/menus/16f79441-545e-4ef0-97a4-3d80687583bb' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "16f79441-545e-4ef0-97a4-3d80687583bb",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "43962f6f-f0e2-4306-bb4e-af64cc6e9c10",
              "title": "Contact us"
            },
            {
              "id": "bdd2438f-c2cb-43a4-a1f0-14bad0656104",
              "title": "Start"
            },
            {
              "id": "a303eea9-a7ab-494f-9b95-59354876b067",
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
    "id": "16f79441-545e-4ef0-97a4-3d80687583bb",
    "type": "menus",
    "attributes": {
      "created_at": "2022-07-12T14:15:26+00:00",
      "updated_at": "2022-07-12T14:15:26+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "43962f6f-f0e2-4306-bb4e-af64cc6e9c10"
          },
          {
            "type": "menu_items",
            "id": "bdd2438f-c2cb-43a4-a1f0-14bad0656104"
          },
          {
            "type": "menu_items",
            "id": "a303eea9-a7ab-494f-9b95-59354876b067"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "43962f6f-f0e2-4306-bb4e-af64cc6e9c10",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-07-12T14:15:26+00:00",
        "updated_at": "2022-07-12T14:15:26+00:00",
        "menu_id": "16f79441-545e-4ef0-97a4-3d80687583bb",
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
      "id": "bdd2438f-c2cb-43a4-a1f0-14bad0656104",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-07-12T14:15:26+00:00",
        "updated_at": "2022-07-12T14:15:26+00:00",
        "menu_id": "16f79441-545e-4ef0-97a4-3d80687583bb",
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
      "id": "a303eea9-a7ab-494f-9b95-59354876b067",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-07-12T14:15:26+00:00",
        "updated_at": "2022-07-12T14:15:26+00:00",
        "menu_id": "16f79441-545e-4ef0-97a4-3d80687583bb",
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=menu_items`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[menus]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][title]` | **String**<br>Name of the menu.
`data[attributes][key]` | **String**<br>Key the menu can be referenced by.
`data[attributes][menu_items_attributes][]` | **Array**<br>Attributes of child menu items to be created or changed.


### Includes

This request accepts the following includes:

`menu_items` => 
`menu_items` => 
`menu_items`










## Deleting a menu



> How to delete a menu:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/menus/61a6cb80-4052-4d94-8818-c2078afbeef1' \
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=menu_items`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[menus]=id,created_at,updated_at`


### Includes

This request does not accept any includes