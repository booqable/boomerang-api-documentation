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
      "id": "7ec118cc-1ba6-4af6-acc5-ed4ecc7ed928",
      "type": "menus",
      "attributes": {
        "created_at": "2022-11-16T14:32:00+00:00",
        "updated_at": "2022-11-16T14:32:00+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=7ec118cc-1ba6-4af6-acc5-ed4ecc7ed928"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-11-16T14:30:08Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/0c82e72b-287a-4209-914f-fe2696ab3dab?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "0c82e72b-287a-4209-914f-fe2696ab3dab",
    "type": "menus",
    "attributes": {
      "created_at": "2022-11-16T14:32:00+00:00",
      "updated_at": "2022-11-16T14:32:00+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=0c82e72b-287a-4209-914f-fe2696ab3dab"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "cba143be-4a8b-4abb-85af-77acb453cda9"
          },
          {
            "type": "menu_items",
            "id": "7c1b2def-b191-4811-ade2-e962e5e41a35"
          },
          {
            "type": "menu_items",
            "id": "aaeafb9c-686c-4597-841e-172c353df2cc"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "cba143be-4a8b-4abb-85af-77acb453cda9",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-11-16T14:32:00+00:00",
        "updated_at": "2022-11-16T14:32:00+00:00",
        "menu_id": "0c82e72b-287a-4209-914f-fe2696ab3dab",
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
            "related": "api/boomerang/menus/0c82e72b-287a-4209-914f-fe2696ab3dab"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=cba143be-4a8b-4abb-85af-77acb453cda9"
          }
        }
      }
    },
    {
      "id": "7c1b2def-b191-4811-ade2-e962e5e41a35",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-11-16T14:32:00+00:00",
        "updated_at": "2022-11-16T14:32:00+00:00",
        "menu_id": "0c82e72b-287a-4209-914f-fe2696ab3dab",
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
            "related": "api/boomerang/menus/0c82e72b-287a-4209-914f-fe2696ab3dab"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=7c1b2def-b191-4811-ade2-e962e5e41a35"
          }
        }
      }
    },
    {
      "id": "aaeafb9c-686c-4597-841e-172c353df2cc",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-11-16T14:32:00+00:00",
        "updated_at": "2022-11-16T14:32:00+00:00",
        "menu_id": "0c82e72b-287a-4209-914f-fe2696ab3dab",
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
            "related": "api/boomerang/menus/0c82e72b-287a-4209-914f-fe2696ab3dab"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=aaeafb9c-686c-4597-841e-172c353df2cc"
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
    "id": "4208fe30-b872-431c-a9a2-41a3b8f97551",
    "type": "menus",
    "attributes": {
      "created_at": "2022-11-16T14:32:00+00:00",
      "updated_at": "2022-11-16T14:32:00+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/b3f82f88-4dc4-4149-a4f6-b3f9dc680937' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "b3f82f88-4dc4-4149-a4f6-b3f9dc680937",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "f0955f4d-8610-44db-84f4-27a9ae4e7d7f",
              "title": "Contact us"
            },
            {
              "id": "f104c38d-7fa7-4d8e-8ebd-fc64e19f4b47",
              "title": "Start"
            },
            {
              "id": "ae628812-566a-41a8-874d-9406ed0bb6ce",
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
    "id": "b3f82f88-4dc4-4149-a4f6-b3f9dc680937",
    "type": "menus",
    "attributes": {
      "created_at": "2022-11-16T14:32:01+00:00",
      "updated_at": "2022-11-16T14:32:01+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "f0955f4d-8610-44db-84f4-27a9ae4e7d7f"
          },
          {
            "type": "menu_items",
            "id": "f104c38d-7fa7-4d8e-8ebd-fc64e19f4b47"
          },
          {
            "type": "menu_items",
            "id": "ae628812-566a-41a8-874d-9406ed0bb6ce"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "f0955f4d-8610-44db-84f4-27a9ae4e7d7f",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-11-16T14:32:01+00:00",
        "updated_at": "2022-11-16T14:32:01+00:00",
        "menu_id": "b3f82f88-4dc4-4149-a4f6-b3f9dc680937",
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
      "id": "f104c38d-7fa7-4d8e-8ebd-fc64e19f4b47",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-11-16T14:32:01+00:00",
        "updated_at": "2022-11-16T14:32:01+00:00",
        "menu_id": "b3f82f88-4dc4-4149-a4f6-b3f9dc680937",
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
      "id": "ae628812-566a-41a8-874d-9406ed0bb6ce",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-11-16T14:32:01+00:00",
        "updated_at": "2022-11-16T14:32:01+00:00",
        "menu_id": "b3f82f88-4dc4-4149-a4f6-b3f9dc680937",
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
    --url 'https://example.booqable.com/api/boomerang/menus/b4a463e7-4604-4c82-a530-8f2e2e699bb8' \
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