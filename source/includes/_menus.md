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
      "id": "08136dae-02cd-4e03-ac82-25849f4b6db7",
      "type": "menus",
      "attributes": {
        "created_at": "2022-11-04T15:39:03+00:00",
        "updated_at": "2022-11-04T15:39:03+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=08136dae-02cd-4e03-ac82-25849f4b6db7"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-11-04T15:37:25Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/bb386bc9-288c-4c7c-a1ad-63b6c1147516?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "bb386bc9-288c-4c7c-a1ad-63b6c1147516",
    "type": "menus",
    "attributes": {
      "created_at": "2022-11-04T15:39:04+00:00",
      "updated_at": "2022-11-04T15:39:04+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=bb386bc9-288c-4c7c-a1ad-63b6c1147516"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "1ab19b6c-ae5d-4d5f-9249-47d276d1f3f1"
          },
          {
            "type": "menu_items",
            "id": "2db64f59-d261-404f-bfab-1f66338a7650"
          },
          {
            "type": "menu_items",
            "id": "d91c08e6-4a31-4e29-aaf7-71f93348a0de"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "1ab19b6c-ae5d-4d5f-9249-47d276d1f3f1",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-11-04T15:39:04+00:00",
        "updated_at": "2022-11-04T15:39:04+00:00",
        "menu_id": "bb386bc9-288c-4c7c-a1ad-63b6c1147516",
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
            "related": "api/boomerang/menus/bb386bc9-288c-4c7c-a1ad-63b6c1147516"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=1ab19b6c-ae5d-4d5f-9249-47d276d1f3f1"
          }
        }
      }
    },
    {
      "id": "2db64f59-d261-404f-bfab-1f66338a7650",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-11-04T15:39:04+00:00",
        "updated_at": "2022-11-04T15:39:04+00:00",
        "menu_id": "bb386bc9-288c-4c7c-a1ad-63b6c1147516",
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
            "related": "api/boomerang/menus/bb386bc9-288c-4c7c-a1ad-63b6c1147516"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=2db64f59-d261-404f-bfab-1f66338a7650"
          }
        }
      }
    },
    {
      "id": "d91c08e6-4a31-4e29-aaf7-71f93348a0de",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-11-04T15:39:04+00:00",
        "updated_at": "2022-11-04T15:39:04+00:00",
        "menu_id": "bb386bc9-288c-4c7c-a1ad-63b6c1147516",
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
            "related": "api/boomerang/menus/bb386bc9-288c-4c7c-a1ad-63b6c1147516"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=d91c08e6-4a31-4e29-aaf7-71f93348a0de"
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
    "id": "596f0acf-52ff-411a-84c2-e3b05cbe7b02",
    "type": "menus",
    "attributes": {
      "created_at": "2022-11-04T15:39:04+00:00",
      "updated_at": "2022-11-04T15:39:04+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/23fd5c42-1489-4c4c-abb4-505525f1961e' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "23fd5c42-1489-4c4c-abb4-505525f1961e",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "0b13053f-f7bb-445d-8970-75af60c0cb25",
              "title": "Contact us"
            },
            {
              "id": "9fb01ef5-9471-4344-a5a9-f07c731a62e6",
              "title": "Start"
            },
            {
              "id": "9a544911-bb4b-41b3-b23a-3c5ad0a04027",
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
    "id": "23fd5c42-1489-4c4c-abb4-505525f1961e",
    "type": "menus",
    "attributes": {
      "created_at": "2022-11-04T15:39:04+00:00",
      "updated_at": "2022-11-04T15:39:04+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "0b13053f-f7bb-445d-8970-75af60c0cb25"
          },
          {
            "type": "menu_items",
            "id": "9fb01ef5-9471-4344-a5a9-f07c731a62e6"
          },
          {
            "type": "menu_items",
            "id": "9a544911-bb4b-41b3-b23a-3c5ad0a04027"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "0b13053f-f7bb-445d-8970-75af60c0cb25",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-11-04T15:39:04+00:00",
        "updated_at": "2022-11-04T15:39:04+00:00",
        "menu_id": "23fd5c42-1489-4c4c-abb4-505525f1961e",
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
      "id": "9fb01ef5-9471-4344-a5a9-f07c731a62e6",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-11-04T15:39:04+00:00",
        "updated_at": "2022-11-04T15:39:04+00:00",
        "menu_id": "23fd5c42-1489-4c4c-abb4-505525f1961e",
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
      "id": "9a544911-bb4b-41b3-b23a-3c5ad0a04027",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-11-04T15:39:04+00:00",
        "updated_at": "2022-11-04T15:39:04+00:00",
        "menu_id": "23fd5c42-1489-4c4c-abb4-505525f1961e",
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
    --url 'https://example.booqable.com/api/boomerang/menus/668ba68b-0a50-405c-a669-994e412bfd55' \
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