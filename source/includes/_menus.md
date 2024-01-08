# Menus

Allows creating and managing menus for your shop.

## Endpoints
`GET /api/boomerang/menus/{id}`

`DELETE /api/boomerang/menus/{id}`

`POST /api/boomerang/menus`

`GET /api/boomerang/menus`

`PUT /api/boomerang/menus/{id}`

## Fields
Every menu has the following fields:

Name | Description
-- | --
`id` | **Uuid** `readonly`<br>Primary key
`created_at` | **Datetime** `readonly`<br>When the resource was created
`updated_at` | **Datetime** `readonly`<br>When the resource was last updated
`title` | **String** <br>Name of the menu.
`key` | **String** <br>Key the menu can be referenced by.
`menu_items_attributes` | **Array** `writeonly`<br>Attributes of child menu items to be created or changed.


## Relationships
Menus have the following relationships:

Name | Description
-- | --
`menu_items` | **Menu items** `readonly`<br>Associated Menu items


## Fetching a price structure



> How to fetch a menu with it's items:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/menus/e1dba6a0-38b8-41a1-ae17-873aa1d9345c?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "e1dba6a0-38b8-41a1-ae17-873aa1d9345c",
    "type": "menus",
    "attributes": {
      "created_at": "2024-01-08T09:17:22+00:00",
      "updated_at": "2024-01-08T09:17:22+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=e1dba6a0-38b8-41a1-ae17-873aa1d9345c"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "fa677ba0-b7fd-422c-a9d7-eea92902fb95"
          },
          {
            "type": "menu_items",
            "id": "7ee625ad-009d-48fa-83d5-8c878245bebf"
          },
          {
            "type": "menu_items",
            "id": "b734418e-085e-4d9e-93bb-73f3df48524e"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "fa677ba0-b7fd-422c-a9d7-eea92902fb95",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-01-08T09:17:22+00:00",
        "updated_at": "2024-01-08T09:17:22+00:00",
        "menu_id": "e1dba6a0-38b8-41a1-ae17-873aa1d9345c",
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
            "related": "api/boomerang/menus/e1dba6a0-38b8-41a1-ae17-873aa1d9345c"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=fa677ba0-b7fd-422c-a9d7-eea92902fb95"
          }
        }
      }
    },
    {
      "id": "7ee625ad-009d-48fa-83d5-8c878245bebf",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-01-08T09:17:22+00:00",
        "updated_at": "2024-01-08T09:17:22+00:00",
        "menu_id": "e1dba6a0-38b8-41a1-ae17-873aa1d9345c",
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
            "related": "api/boomerang/menus/e1dba6a0-38b8-41a1-ae17-873aa1d9345c"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=7ee625ad-009d-48fa-83d5-8c878245bebf"
          }
        }
      }
    },
    {
      "id": "b734418e-085e-4d9e-93bb-73f3df48524e",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-01-08T09:17:22+00:00",
        "updated_at": "2024-01-08T09:17:22+00:00",
        "menu_id": "e1dba6a0-38b8-41a1-ae17-873aa1d9345c",
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
            "related": "api/boomerang/menus/e1dba6a0-38b8-41a1-ae17-873aa1d9345c"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=b734418e-085e-4d9e-93bb-73f3df48524e"
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
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=menu_items`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[menus]=created_at,updated_at,title`


### Includes

This request accepts the following includes:

`menu_items`






## Deleting a menu



> How to delete a menu:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/menus/a8f9bef3-f335-420e-bda8-9257855f0f74' \
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
-- | --
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[menus]=created_at,updated_at,title`


### Includes

This request does not accept any includes
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
    "id": "a04e0713-a047-4eb7-b435-4cf2a912f975",
    "type": "menus",
    "attributes": {
      "created_at": "2024-01-08T09:17:24+00:00",
      "updated_at": "2024-01-08T09:17:24+00:00",
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
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=menu_items`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[menus]=created_at,updated_at,title`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][title]` | **String** <br>Name of the menu.
`data[attributes][key]` | **String** <br>Key the menu can be referenced by.
`data[attributes][menu_items_attributes][]` | **Array** <br>Attributes of child menu items to be created or changed.


### Includes

This request accepts the following includes:

`menu_items` => 
`menu_items` => 
`menu_items`










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
      "id": "dcb2754d-b5fd-40fb-9976-5f434ba5beb4",
      "type": "menus",
      "attributes": {
        "created_at": "2024-01-08T09:17:25+00:00",
        "updated_at": "2024-01-08T09:17:25+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=dcb2754d-b5fd-40fb-9976-5f434ba5beb4"
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
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=menu_items`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[menus]=created_at,updated_at,title`
`filter` | **Hash** <br>The filters to apply `?filter[attribute][eq]=value`
`sort` | **String** <br>How to sort the data `?sort=attribute1,-attribute2`
`meta` | **Hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String** <br>The page to request
`page[size]` | **String** <br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
-- | --
`id` | **Uuid** <br>`eq`, `not_eq`
`created_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`title` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`key` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **Array** <br>`count`


### Includes

This request accepts the following includes:

`menu_items` => 
`menu_items` => 
`menu_items`










## Updating a menu and it's items



> How to update a menu with nested menu items:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/menus/f4e33f77-0856-4052-8a1d-10faff1fea50' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "f4e33f77-0856-4052-8a1d-10faff1fea50",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "0258b482-f666-410a-916f-4a9352b772a5",
              "title": "Contact us"
            },
            {
              "id": "43d85dc9-74f0-4adb-98fb-c483294b0295",
              "title": "Start"
            },
            {
              "id": "6f172eaf-6310-4b67-9193-8b0ceb54a2b3",
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
    "id": "f4e33f77-0856-4052-8a1d-10faff1fea50",
    "type": "menus",
    "attributes": {
      "created_at": "2024-01-08T09:17:26+00:00",
      "updated_at": "2024-01-08T09:17:26+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "0258b482-f666-410a-916f-4a9352b772a5"
          },
          {
            "type": "menu_items",
            "id": "43d85dc9-74f0-4adb-98fb-c483294b0295"
          },
          {
            "type": "menu_items",
            "id": "6f172eaf-6310-4b67-9193-8b0ceb54a2b3"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "0258b482-f666-410a-916f-4a9352b772a5",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-01-08T09:17:26+00:00",
        "updated_at": "2024-01-08T09:17:26+00:00",
        "menu_id": "f4e33f77-0856-4052-8a1d-10faff1fea50",
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
      "id": "43d85dc9-74f0-4adb-98fb-c483294b0295",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-01-08T09:17:26+00:00",
        "updated_at": "2024-01-08T09:17:26+00:00",
        "menu_id": "f4e33f77-0856-4052-8a1d-10faff1fea50",
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
      "id": "6f172eaf-6310-4b67-9193-8b0ceb54a2b3",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-01-08T09:17:26+00:00",
        "updated_at": "2024-01-08T09:17:26+00:00",
        "menu_id": "f4e33f77-0856-4052-8a1d-10faff1fea50",
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
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=menu_items`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[menus]=created_at,updated_at,title`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][title]` | **String** <br>Name of the menu.
`data[attributes][key]` | **String** <br>Key the menu can be referenced by.
`data[attributes][menu_items_attributes][]` | **Array** <br>Attributes of child menu items to be created or changed.


### Includes

This request accepts the following includes:

`menu_items` => 
`menu_items` => 
`menu_items`









