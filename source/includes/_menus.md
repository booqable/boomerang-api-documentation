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
      "id": "ca884770-17fb-4c75-8e77-4863a57c7cb1",
      "type": "menus",
      "attributes": {
        "created_at": "2023-01-24T13:22:16+00:00",
        "updated_at": "2023-01-24T13:22:16+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=ca884770-17fb-4c75-8e77-4863a57c7cb1"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-01-24T13:20:21Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/028ea912-27e9-4289-a23d-1eff5c65bb0a?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "028ea912-27e9-4289-a23d-1eff5c65bb0a",
    "type": "menus",
    "attributes": {
      "created_at": "2023-01-24T13:22:16+00:00",
      "updated_at": "2023-01-24T13:22:16+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=028ea912-27e9-4289-a23d-1eff5c65bb0a"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "319e2bf1-74d9-4bcb-b70e-ea7a53aeb361"
          },
          {
            "type": "menu_items",
            "id": "125a732e-a39e-49c6-ae27-4f8317e28a74"
          },
          {
            "type": "menu_items",
            "id": "32f8281e-c4fd-4b59-ad9d-1572efc14940"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "319e2bf1-74d9-4bcb-b70e-ea7a53aeb361",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-01-24T13:22:16+00:00",
        "updated_at": "2023-01-24T13:22:16+00:00",
        "menu_id": "028ea912-27e9-4289-a23d-1eff5c65bb0a",
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
            "related": "api/boomerang/menus/028ea912-27e9-4289-a23d-1eff5c65bb0a"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=319e2bf1-74d9-4bcb-b70e-ea7a53aeb361"
          }
        }
      }
    },
    {
      "id": "125a732e-a39e-49c6-ae27-4f8317e28a74",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-01-24T13:22:16+00:00",
        "updated_at": "2023-01-24T13:22:16+00:00",
        "menu_id": "028ea912-27e9-4289-a23d-1eff5c65bb0a",
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
            "related": "api/boomerang/menus/028ea912-27e9-4289-a23d-1eff5c65bb0a"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=125a732e-a39e-49c6-ae27-4f8317e28a74"
          }
        }
      }
    },
    {
      "id": "32f8281e-c4fd-4b59-ad9d-1572efc14940",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-01-24T13:22:16+00:00",
        "updated_at": "2023-01-24T13:22:16+00:00",
        "menu_id": "028ea912-27e9-4289-a23d-1eff5c65bb0a",
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
            "related": "api/boomerang/menus/028ea912-27e9-4289-a23d-1eff5c65bb0a"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=32f8281e-c4fd-4b59-ad9d-1572efc14940"
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
    "id": "0e82e7b8-90ee-4430-92aa-3bdf1608350a",
    "type": "menus",
    "attributes": {
      "created_at": "2023-01-24T13:22:17+00:00",
      "updated_at": "2023-01-24T13:22:17+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/305f370d-43f6-43b3-959b-85892dfe28e5' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "305f370d-43f6-43b3-959b-85892dfe28e5",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "3c21afe2-9949-457f-8560-643910206b56",
              "title": "Contact us"
            },
            {
              "id": "6e486957-5a7b-4e0a-9c3f-db422eddd34d",
              "title": "Start"
            },
            {
              "id": "f5c8b488-a598-4663-8013-319c23d2cd00",
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
    "id": "305f370d-43f6-43b3-959b-85892dfe28e5",
    "type": "menus",
    "attributes": {
      "created_at": "2023-01-24T13:22:17+00:00",
      "updated_at": "2023-01-24T13:22:17+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "3c21afe2-9949-457f-8560-643910206b56"
          },
          {
            "type": "menu_items",
            "id": "6e486957-5a7b-4e0a-9c3f-db422eddd34d"
          },
          {
            "type": "menu_items",
            "id": "f5c8b488-a598-4663-8013-319c23d2cd00"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "3c21afe2-9949-457f-8560-643910206b56",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-01-24T13:22:17+00:00",
        "updated_at": "2023-01-24T13:22:17+00:00",
        "menu_id": "305f370d-43f6-43b3-959b-85892dfe28e5",
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
      "id": "6e486957-5a7b-4e0a-9c3f-db422eddd34d",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-01-24T13:22:17+00:00",
        "updated_at": "2023-01-24T13:22:17+00:00",
        "menu_id": "305f370d-43f6-43b3-959b-85892dfe28e5",
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
      "id": "f5c8b488-a598-4663-8013-319c23d2cd00",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-01-24T13:22:17+00:00",
        "updated_at": "2023-01-24T13:22:17+00:00",
        "menu_id": "305f370d-43f6-43b3-959b-85892dfe28e5",
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
    --url 'https://example.booqable.com/api/boomerang/menus/ba17e2dc-f53f-429f-aea6-129d22ec8e71' \
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