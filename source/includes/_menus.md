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
      "id": "13f636ad-dd53-42c2-a7bf-4055a8faf636",
      "type": "menus",
      "attributes": {
        "created_at": "2023-03-01T10:01:38+00:00",
        "updated_at": "2023-03-01T10:01:38+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=13f636ad-dd53-42c2-a7bf-4055a8faf636"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-03-01T09:59:27Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/a4f4d2b5-d4aa-4df5-bdeb-d64c53861d70?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "a4f4d2b5-d4aa-4df5-bdeb-d64c53861d70",
    "type": "menus",
    "attributes": {
      "created_at": "2023-03-01T10:01:38+00:00",
      "updated_at": "2023-03-01T10:01:38+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=a4f4d2b5-d4aa-4df5-bdeb-d64c53861d70"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "bd794284-b367-44b3-ba27-21c818b064db"
          },
          {
            "type": "menu_items",
            "id": "0aecc2af-2b4b-44b9-ac3d-f7dbc1f1aca6"
          },
          {
            "type": "menu_items",
            "id": "e95e5605-bd6c-4b76-9f7a-cb35362ed349"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "bd794284-b367-44b3-ba27-21c818b064db",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-01T10:01:38+00:00",
        "updated_at": "2023-03-01T10:01:38+00:00",
        "menu_id": "a4f4d2b5-d4aa-4df5-bdeb-d64c53861d70",
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
            "related": "api/boomerang/menus/a4f4d2b5-d4aa-4df5-bdeb-d64c53861d70"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=bd794284-b367-44b3-ba27-21c818b064db"
          }
        }
      }
    },
    {
      "id": "0aecc2af-2b4b-44b9-ac3d-f7dbc1f1aca6",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-01T10:01:38+00:00",
        "updated_at": "2023-03-01T10:01:38+00:00",
        "menu_id": "a4f4d2b5-d4aa-4df5-bdeb-d64c53861d70",
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
            "related": "api/boomerang/menus/a4f4d2b5-d4aa-4df5-bdeb-d64c53861d70"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=0aecc2af-2b4b-44b9-ac3d-f7dbc1f1aca6"
          }
        }
      }
    },
    {
      "id": "e95e5605-bd6c-4b76-9f7a-cb35362ed349",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-01T10:01:38+00:00",
        "updated_at": "2023-03-01T10:01:38+00:00",
        "menu_id": "a4f4d2b5-d4aa-4df5-bdeb-d64c53861d70",
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
            "related": "api/boomerang/menus/a4f4d2b5-d4aa-4df5-bdeb-d64c53861d70"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=e95e5605-bd6c-4b76-9f7a-cb35362ed349"
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
    "id": "318c3d5b-2703-4c28-83f2-ff35357e7f23",
    "type": "menus",
    "attributes": {
      "created_at": "2023-03-01T10:01:39+00:00",
      "updated_at": "2023-03-01T10:01:39+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/ac1ed974-6b8f-41aa-9636-84bb68931f03' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "ac1ed974-6b8f-41aa-9636-84bb68931f03",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "79e5f8c7-5de9-4945-99ac-e5721ec3e0b1",
              "title": "Contact us"
            },
            {
              "id": "4d0435a7-4de1-43b0-b632-b2d1280bc4ec",
              "title": "Start"
            },
            {
              "id": "1a6331d6-e4c2-4e3b-941c-e7bfa3263674",
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
    "id": "ac1ed974-6b8f-41aa-9636-84bb68931f03",
    "type": "menus",
    "attributes": {
      "created_at": "2023-03-01T10:01:39+00:00",
      "updated_at": "2023-03-01T10:01:39+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "79e5f8c7-5de9-4945-99ac-e5721ec3e0b1"
          },
          {
            "type": "menu_items",
            "id": "4d0435a7-4de1-43b0-b632-b2d1280bc4ec"
          },
          {
            "type": "menu_items",
            "id": "1a6331d6-e4c2-4e3b-941c-e7bfa3263674"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "79e5f8c7-5de9-4945-99ac-e5721ec3e0b1",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-01T10:01:39+00:00",
        "updated_at": "2023-03-01T10:01:39+00:00",
        "menu_id": "ac1ed974-6b8f-41aa-9636-84bb68931f03",
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
      "id": "4d0435a7-4de1-43b0-b632-b2d1280bc4ec",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-01T10:01:39+00:00",
        "updated_at": "2023-03-01T10:01:39+00:00",
        "menu_id": "ac1ed974-6b8f-41aa-9636-84bb68931f03",
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
      "id": "1a6331d6-e4c2-4e3b-941c-e7bfa3263674",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-01T10:01:39+00:00",
        "updated_at": "2023-03-01T10:01:39+00:00",
        "menu_id": "ac1ed974-6b8f-41aa-9636-84bb68931f03",
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
    --url 'https://example.booqable.com/api/boomerang/menus/d393ea8f-b71b-4458-adfe-039ea0a9d1a1' \
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