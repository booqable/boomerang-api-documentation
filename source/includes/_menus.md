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
      "id": "6b68e0da-3a8a-469c-b1e8-0fcd0cbf263f",
      "type": "menus",
      "attributes": {
        "created_at": "2023-02-13T16:01:13+00:00",
        "updated_at": "2023-02-13T16:01:13+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=6b68e0da-3a8a-469c-b1e8-0fcd0cbf263f"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-13T15:59:17Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/93a3e5a6-1ed2-4673-a64d-83272eff3386?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "93a3e5a6-1ed2-4673-a64d-83272eff3386",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-13T16:01:16+00:00",
      "updated_at": "2023-02-13T16:01:16+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=93a3e5a6-1ed2-4673-a64d-83272eff3386"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "2e0aeb75-829e-431e-bf19-7a9437212749"
          },
          {
            "type": "menu_items",
            "id": "76163a41-00f4-428f-a3a7-b354f92c7e3c"
          },
          {
            "type": "menu_items",
            "id": "356c127f-bac0-4500-8cae-99c54d60e44c"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "2e0aeb75-829e-431e-bf19-7a9437212749",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-13T16:01:16+00:00",
        "updated_at": "2023-02-13T16:01:16+00:00",
        "menu_id": "93a3e5a6-1ed2-4673-a64d-83272eff3386",
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
            "related": "api/boomerang/menus/93a3e5a6-1ed2-4673-a64d-83272eff3386"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=2e0aeb75-829e-431e-bf19-7a9437212749"
          }
        }
      }
    },
    {
      "id": "76163a41-00f4-428f-a3a7-b354f92c7e3c",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-13T16:01:16+00:00",
        "updated_at": "2023-02-13T16:01:16+00:00",
        "menu_id": "93a3e5a6-1ed2-4673-a64d-83272eff3386",
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
            "related": "api/boomerang/menus/93a3e5a6-1ed2-4673-a64d-83272eff3386"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=76163a41-00f4-428f-a3a7-b354f92c7e3c"
          }
        }
      }
    },
    {
      "id": "356c127f-bac0-4500-8cae-99c54d60e44c",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-13T16:01:16+00:00",
        "updated_at": "2023-02-13T16:01:16+00:00",
        "menu_id": "93a3e5a6-1ed2-4673-a64d-83272eff3386",
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
            "related": "api/boomerang/menus/93a3e5a6-1ed2-4673-a64d-83272eff3386"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=356c127f-bac0-4500-8cae-99c54d60e44c"
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
    "id": "5cf8552d-d148-4da6-8504-8e2641a388ba",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-13T16:01:16+00:00",
      "updated_at": "2023-02-13T16:01:16+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/f2802242-aed9-43ea-aaa7-e6ab0726d773' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "f2802242-aed9-43ea-aaa7-e6ab0726d773",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "05b9f12a-1e1b-4ccd-80f8-ff7f34648499",
              "title": "Contact us"
            },
            {
              "id": "0b2b8429-65f5-44a7-a241-d6138c979d43",
              "title": "Start"
            },
            {
              "id": "ff279707-7604-4544-b7fc-7827b38378b3",
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
    "id": "f2802242-aed9-43ea-aaa7-e6ab0726d773",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-13T16:01:17+00:00",
      "updated_at": "2023-02-13T16:01:17+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "05b9f12a-1e1b-4ccd-80f8-ff7f34648499"
          },
          {
            "type": "menu_items",
            "id": "0b2b8429-65f5-44a7-a241-d6138c979d43"
          },
          {
            "type": "menu_items",
            "id": "ff279707-7604-4544-b7fc-7827b38378b3"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "05b9f12a-1e1b-4ccd-80f8-ff7f34648499",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-13T16:01:17+00:00",
        "updated_at": "2023-02-13T16:01:17+00:00",
        "menu_id": "f2802242-aed9-43ea-aaa7-e6ab0726d773",
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
      "id": "0b2b8429-65f5-44a7-a241-d6138c979d43",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-13T16:01:17+00:00",
        "updated_at": "2023-02-13T16:01:17+00:00",
        "menu_id": "f2802242-aed9-43ea-aaa7-e6ab0726d773",
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
      "id": "ff279707-7604-4544-b7fc-7827b38378b3",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-13T16:01:17+00:00",
        "updated_at": "2023-02-13T16:01:17+00:00",
        "menu_id": "f2802242-aed9-43ea-aaa7-e6ab0726d773",
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
    --url 'https://example.booqable.com/api/boomerang/menus/f025f45a-287d-400f-adb1-6b9fba6608fa' \
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