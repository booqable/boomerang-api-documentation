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
      "id": "89173d75-6cb9-4f7a-b720-33ea952f6564",
      "type": "menus",
      "attributes": {
        "created_at": "2023-02-20T10:24:22+00:00",
        "updated_at": "2023-02-20T10:24:22+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=89173d75-6cb9-4f7a-b720-33ea952f6564"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-20T10:22:24Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/c3c6045f-8b3d-4d8a-981a-e8739919c71b?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "c3c6045f-8b3d-4d8a-981a-e8739919c71b",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-20T10:24:23+00:00",
      "updated_at": "2023-02-20T10:24:23+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=c3c6045f-8b3d-4d8a-981a-e8739919c71b"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "3b51420f-6f81-4e1d-949e-4de22e6d1474"
          },
          {
            "type": "menu_items",
            "id": "ef90dd8b-380b-40d0-bc79-a07cd8c5c2b4"
          },
          {
            "type": "menu_items",
            "id": "8c3ab844-dba8-4899-a121-af707f0d49c7"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "3b51420f-6f81-4e1d-949e-4de22e6d1474",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-20T10:24:23+00:00",
        "updated_at": "2023-02-20T10:24:23+00:00",
        "menu_id": "c3c6045f-8b3d-4d8a-981a-e8739919c71b",
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
            "related": "api/boomerang/menus/c3c6045f-8b3d-4d8a-981a-e8739919c71b"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=3b51420f-6f81-4e1d-949e-4de22e6d1474"
          }
        }
      }
    },
    {
      "id": "ef90dd8b-380b-40d0-bc79-a07cd8c5c2b4",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-20T10:24:23+00:00",
        "updated_at": "2023-02-20T10:24:23+00:00",
        "menu_id": "c3c6045f-8b3d-4d8a-981a-e8739919c71b",
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
            "related": "api/boomerang/menus/c3c6045f-8b3d-4d8a-981a-e8739919c71b"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=ef90dd8b-380b-40d0-bc79-a07cd8c5c2b4"
          }
        }
      }
    },
    {
      "id": "8c3ab844-dba8-4899-a121-af707f0d49c7",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-20T10:24:23+00:00",
        "updated_at": "2023-02-20T10:24:23+00:00",
        "menu_id": "c3c6045f-8b3d-4d8a-981a-e8739919c71b",
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
            "related": "api/boomerang/menus/c3c6045f-8b3d-4d8a-981a-e8739919c71b"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=8c3ab844-dba8-4899-a121-af707f0d49c7"
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
    "id": "db8faae9-9cfb-4af2-bd7a-bfe13f8c391e",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-20T10:24:23+00:00",
      "updated_at": "2023-02-20T10:24:23+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/3cc8b21a-6034-491e-ab81-ec2955008d9e' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "3cc8b21a-6034-491e-ab81-ec2955008d9e",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "124dfd3e-d360-4116-a070-dea46864e535",
              "title": "Contact us"
            },
            {
              "id": "4aaeebc3-6548-4374-b6d1-188ea42d4c3f",
              "title": "Start"
            },
            {
              "id": "e37d5d0d-fe0c-4702-9fab-fa77a431a4a1",
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
    "id": "3cc8b21a-6034-491e-ab81-ec2955008d9e",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-20T10:24:24+00:00",
      "updated_at": "2023-02-20T10:24:24+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "124dfd3e-d360-4116-a070-dea46864e535"
          },
          {
            "type": "menu_items",
            "id": "4aaeebc3-6548-4374-b6d1-188ea42d4c3f"
          },
          {
            "type": "menu_items",
            "id": "e37d5d0d-fe0c-4702-9fab-fa77a431a4a1"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "124dfd3e-d360-4116-a070-dea46864e535",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-20T10:24:24+00:00",
        "updated_at": "2023-02-20T10:24:24+00:00",
        "menu_id": "3cc8b21a-6034-491e-ab81-ec2955008d9e",
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
      "id": "4aaeebc3-6548-4374-b6d1-188ea42d4c3f",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-20T10:24:24+00:00",
        "updated_at": "2023-02-20T10:24:24+00:00",
        "menu_id": "3cc8b21a-6034-491e-ab81-ec2955008d9e",
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
      "id": "e37d5d0d-fe0c-4702-9fab-fa77a431a4a1",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-20T10:24:24+00:00",
        "updated_at": "2023-02-20T10:24:24+00:00",
        "menu_id": "3cc8b21a-6034-491e-ab81-ec2955008d9e",
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
    --url 'https://example.booqable.com/api/boomerang/menus/88a96c4d-17e1-460f-ab26-f4f67031e7cd' \
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