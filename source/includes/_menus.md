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
      "id": "65769ce0-f740-49d0-84bd-e7ffd1ec96c6",
      "type": "menus",
      "attributes": {
        "created_at": "2023-01-10T14:07:10+00:00",
        "updated_at": "2023-01-10T14:07:10+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=65769ce0-f740-49d0-84bd-e7ffd1ec96c6"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-01-10T14:04:56Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/aad8301a-4d35-4445-8d81-e7d97c6e6fcb?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "aad8301a-4d35-4445-8d81-e7d97c6e6fcb",
    "type": "menus",
    "attributes": {
      "created_at": "2023-01-10T14:07:11+00:00",
      "updated_at": "2023-01-10T14:07:11+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=aad8301a-4d35-4445-8d81-e7d97c6e6fcb"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "ade2a24a-b36a-40f7-a0c2-194f74a05270"
          },
          {
            "type": "menu_items",
            "id": "23425e63-6805-493e-b3e8-506037ddd5f0"
          },
          {
            "type": "menu_items",
            "id": "7c022d2a-0afb-4a5d-8696-8ed5d36df5a7"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "ade2a24a-b36a-40f7-a0c2-194f74a05270",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-01-10T14:07:11+00:00",
        "updated_at": "2023-01-10T14:07:11+00:00",
        "menu_id": "aad8301a-4d35-4445-8d81-e7d97c6e6fcb",
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
            "related": "api/boomerang/menus/aad8301a-4d35-4445-8d81-e7d97c6e6fcb"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=ade2a24a-b36a-40f7-a0c2-194f74a05270"
          }
        }
      }
    },
    {
      "id": "23425e63-6805-493e-b3e8-506037ddd5f0",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-01-10T14:07:11+00:00",
        "updated_at": "2023-01-10T14:07:11+00:00",
        "menu_id": "aad8301a-4d35-4445-8d81-e7d97c6e6fcb",
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
            "related": "api/boomerang/menus/aad8301a-4d35-4445-8d81-e7d97c6e6fcb"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=23425e63-6805-493e-b3e8-506037ddd5f0"
          }
        }
      }
    },
    {
      "id": "7c022d2a-0afb-4a5d-8696-8ed5d36df5a7",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-01-10T14:07:11+00:00",
        "updated_at": "2023-01-10T14:07:11+00:00",
        "menu_id": "aad8301a-4d35-4445-8d81-e7d97c6e6fcb",
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
            "related": "api/boomerang/menus/aad8301a-4d35-4445-8d81-e7d97c6e6fcb"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=7c022d2a-0afb-4a5d-8696-8ed5d36df5a7"
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
    "id": "db23b485-a743-47f0-b248-506c9d73ceb4",
    "type": "menus",
    "attributes": {
      "created_at": "2023-01-10T14:07:11+00:00",
      "updated_at": "2023-01-10T14:07:11+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/20067773-a054-469d-be07-1e42051c55d5' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "20067773-a054-469d-be07-1e42051c55d5",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "3204e6ed-1e00-4bc3-9dd0-511c64f05636",
              "title": "Contact us"
            },
            {
              "id": "a147858a-e9b4-40d1-85f4-f6423ca53ce1",
              "title": "Start"
            },
            {
              "id": "dedcc983-1782-4348-a18d-2e36e586c698",
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
    "id": "20067773-a054-469d-be07-1e42051c55d5",
    "type": "menus",
    "attributes": {
      "created_at": "2023-01-10T14:07:12+00:00",
      "updated_at": "2023-01-10T14:07:12+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "3204e6ed-1e00-4bc3-9dd0-511c64f05636"
          },
          {
            "type": "menu_items",
            "id": "a147858a-e9b4-40d1-85f4-f6423ca53ce1"
          },
          {
            "type": "menu_items",
            "id": "dedcc983-1782-4348-a18d-2e36e586c698"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "3204e6ed-1e00-4bc3-9dd0-511c64f05636",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-01-10T14:07:12+00:00",
        "updated_at": "2023-01-10T14:07:12+00:00",
        "menu_id": "20067773-a054-469d-be07-1e42051c55d5",
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
      "id": "a147858a-e9b4-40d1-85f4-f6423ca53ce1",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-01-10T14:07:12+00:00",
        "updated_at": "2023-01-10T14:07:12+00:00",
        "menu_id": "20067773-a054-469d-be07-1e42051c55d5",
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
      "id": "dedcc983-1782-4348-a18d-2e36e586c698",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-01-10T14:07:12+00:00",
        "updated_at": "2023-01-10T14:07:12+00:00",
        "menu_id": "20067773-a054-469d-be07-1e42051c55d5",
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
    --url 'https://example.booqable.com/api/boomerang/menus/4b388e8d-8904-44bf-8ef3-0e7419aba920' \
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