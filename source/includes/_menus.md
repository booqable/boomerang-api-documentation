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
      "id": "67b2e272-d8c9-4f63-8da7-b7872821865e",
      "type": "menus",
      "attributes": {
        "created_at": "2023-02-07T14:51:36+00:00",
        "updated_at": "2023-02-07T14:51:36+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=67b2e272-d8c9-4f63-8da7-b7872821865e"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-07T14:49:43Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/594768c8-2376-4f31-bf17-9533101e00f7?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "594768c8-2376-4f31-bf17-9533101e00f7",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-07T14:51:36+00:00",
      "updated_at": "2023-02-07T14:51:36+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=594768c8-2376-4f31-bf17-9533101e00f7"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "b673e1a2-b8be-4a67-8975-5f32153d2242"
          },
          {
            "type": "menu_items",
            "id": "c9356442-3c9c-42f2-9871-4b44f7f8e6c2"
          },
          {
            "type": "menu_items",
            "id": "04e0774e-6c54-4b68-bce0-94b0839c7128"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "b673e1a2-b8be-4a67-8975-5f32153d2242",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-07T14:51:36+00:00",
        "updated_at": "2023-02-07T14:51:36+00:00",
        "menu_id": "594768c8-2376-4f31-bf17-9533101e00f7",
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
            "related": "api/boomerang/menus/594768c8-2376-4f31-bf17-9533101e00f7"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=b673e1a2-b8be-4a67-8975-5f32153d2242"
          }
        }
      }
    },
    {
      "id": "c9356442-3c9c-42f2-9871-4b44f7f8e6c2",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-07T14:51:36+00:00",
        "updated_at": "2023-02-07T14:51:36+00:00",
        "menu_id": "594768c8-2376-4f31-bf17-9533101e00f7",
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
            "related": "api/boomerang/menus/594768c8-2376-4f31-bf17-9533101e00f7"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=c9356442-3c9c-42f2-9871-4b44f7f8e6c2"
          }
        }
      }
    },
    {
      "id": "04e0774e-6c54-4b68-bce0-94b0839c7128",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-07T14:51:36+00:00",
        "updated_at": "2023-02-07T14:51:36+00:00",
        "menu_id": "594768c8-2376-4f31-bf17-9533101e00f7",
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
            "related": "api/boomerang/menus/594768c8-2376-4f31-bf17-9533101e00f7"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=04e0774e-6c54-4b68-bce0-94b0839c7128"
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
    "id": "4e3267ed-c025-46a1-b0c3-fefe8694fdd8",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-07T14:51:37+00:00",
      "updated_at": "2023-02-07T14:51:37+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/1d68244f-c93f-4079-8bcc-d87f3840d036' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "1d68244f-c93f-4079-8bcc-d87f3840d036",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "498143a0-8354-4319-bd22-ce45da031782",
              "title": "Contact us"
            },
            {
              "id": "e0184b6e-e358-4ebd-9f46-324fc974be89",
              "title": "Start"
            },
            {
              "id": "df213e5a-a2e0-46ec-94aa-9a2d9caee876",
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
    "id": "1d68244f-c93f-4079-8bcc-d87f3840d036",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-07T14:51:37+00:00",
      "updated_at": "2023-02-07T14:51:37+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "498143a0-8354-4319-bd22-ce45da031782"
          },
          {
            "type": "menu_items",
            "id": "e0184b6e-e358-4ebd-9f46-324fc974be89"
          },
          {
            "type": "menu_items",
            "id": "df213e5a-a2e0-46ec-94aa-9a2d9caee876"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "498143a0-8354-4319-bd22-ce45da031782",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-07T14:51:37+00:00",
        "updated_at": "2023-02-07T14:51:37+00:00",
        "menu_id": "1d68244f-c93f-4079-8bcc-d87f3840d036",
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
      "id": "e0184b6e-e358-4ebd-9f46-324fc974be89",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-07T14:51:37+00:00",
        "updated_at": "2023-02-07T14:51:37+00:00",
        "menu_id": "1d68244f-c93f-4079-8bcc-d87f3840d036",
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
      "id": "df213e5a-a2e0-46ec-94aa-9a2d9caee876",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-07T14:51:37+00:00",
        "updated_at": "2023-02-07T14:51:37+00:00",
        "menu_id": "1d68244f-c93f-4079-8bcc-d87f3840d036",
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
    --url 'https://example.booqable.com/api/boomerang/menus/f67a23d4-dd85-4b24-acc7-70aae9709c77' \
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