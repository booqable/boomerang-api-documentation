# Menus

Allows creating and managing menus for your shop.

## Endpoints
`DELETE /api/boomerang/menus/{id}`

`GET /api/boomerang/menus/{id}`

`GET /api/boomerang/menus`

`PUT /api/boomerang/menus/{id}`

`POST /api/boomerang/menus`

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


## Deleting a menu



> How to delete a menu:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/menus/bf327a02-4b85-4b87-8dce-02195ea8e146' \
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
## Fetching a price structure



> How to fetch a menu with it's items:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/menus/6c3fd498-b399-4905-87e1-09117fee2760?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "6c3fd498-b399-4905-87e1-09117fee2760",
    "type": "menus",
    "attributes": {
      "created_at": "2024-02-26T09:14:19+00:00",
      "updated_at": "2024-02-26T09:14:19+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=6c3fd498-b399-4905-87e1-09117fee2760"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "ae3e7051-0c60-4e2c-b937-2407fd7b09ba"
          },
          {
            "type": "menu_items",
            "id": "6be48b82-b7e3-489e-bc50-eed89fcb2a09"
          },
          {
            "type": "menu_items",
            "id": "89512b22-92d2-4187-b197-0ddb7b2b1e8a"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "ae3e7051-0c60-4e2c-b937-2407fd7b09ba",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-02-26T09:14:19+00:00",
        "updated_at": "2024-02-26T09:14:19+00:00",
        "menu_id": "6c3fd498-b399-4905-87e1-09117fee2760",
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
            "related": "api/boomerang/menus/6c3fd498-b399-4905-87e1-09117fee2760"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=ae3e7051-0c60-4e2c-b937-2407fd7b09ba"
          }
        }
      }
    },
    {
      "id": "6be48b82-b7e3-489e-bc50-eed89fcb2a09",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-02-26T09:14:19+00:00",
        "updated_at": "2024-02-26T09:14:19+00:00",
        "menu_id": "6c3fd498-b399-4905-87e1-09117fee2760",
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
            "related": "api/boomerang/menus/6c3fd498-b399-4905-87e1-09117fee2760"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=6be48b82-b7e3-489e-bc50-eed89fcb2a09"
          }
        }
      }
    },
    {
      "id": "89512b22-92d2-4187-b197-0ddb7b2b1e8a",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-02-26T09:14:19+00:00",
        "updated_at": "2024-02-26T09:14:19+00:00",
        "menu_id": "6c3fd498-b399-4905-87e1-09117fee2760",
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
            "related": "api/boomerang/menus/6c3fd498-b399-4905-87e1-09117fee2760"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=89512b22-92d2-4187-b197-0ddb7b2b1e8a"
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
      "id": "cf7b8f02-3fdc-4941-8f57-5ecc32cae14b",
      "type": "menus",
      "attributes": {
        "created_at": "2024-02-26T09:14:20+00:00",
        "updated_at": "2024-02-26T09:14:20+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=cf7b8f02-3fdc-4941-8f57-5ecc32cae14b"
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
    --url 'https://example.booqable.com/api/boomerang/menus/931bb2e6-b6d5-4bff-8288-27f0a87facdb' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "931bb2e6-b6d5-4bff-8288-27f0a87facdb",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "e48277ff-7a4e-4c2d-bc9e-ca49aa362e91",
              "title": "Contact us"
            },
            {
              "id": "bfd11436-17fe-4fa7-a94b-454641fbb949",
              "title": "Start"
            },
            {
              "id": "4fd1b68c-a133-48dd-963a-237332275964",
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
    "id": "931bb2e6-b6d5-4bff-8288-27f0a87facdb",
    "type": "menus",
    "attributes": {
      "created_at": "2024-02-26T09:14:21+00:00",
      "updated_at": "2024-02-26T09:14:21+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "e48277ff-7a4e-4c2d-bc9e-ca49aa362e91"
          },
          {
            "type": "menu_items",
            "id": "bfd11436-17fe-4fa7-a94b-454641fbb949"
          },
          {
            "type": "menu_items",
            "id": "4fd1b68c-a133-48dd-963a-237332275964"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "e48277ff-7a4e-4c2d-bc9e-ca49aa362e91",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-02-26T09:14:21+00:00",
        "updated_at": "2024-02-26T09:14:21+00:00",
        "menu_id": "931bb2e6-b6d5-4bff-8288-27f0a87facdb",
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
      "id": "bfd11436-17fe-4fa7-a94b-454641fbb949",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-02-26T09:14:21+00:00",
        "updated_at": "2024-02-26T09:14:21+00:00",
        "menu_id": "931bb2e6-b6d5-4bff-8288-27f0a87facdb",
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
      "id": "4fd1b68c-a133-48dd-963a-237332275964",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-02-26T09:14:21+00:00",
        "updated_at": "2024-02-26T09:14:21+00:00",
        "menu_id": "931bb2e6-b6d5-4bff-8288-27f0a87facdb",
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
    "id": "5f478f9c-a88c-4cbe-ad49-774c7d40ccc9",
    "type": "menus",
    "attributes": {
      "created_at": "2024-02-26T09:14:21+00:00",
      "updated_at": "2024-02-26T09:14:21+00:00",
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









