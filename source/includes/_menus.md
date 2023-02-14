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
      "id": "1834b2ef-e9c7-4436-b405-11fcb868f5ef",
      "type": "menus",
      "attributes": {
        "created_at": "2023-02-14T15:28:01+00:00",
        "updated_at": "2023-02-14T15:28:01+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=1834b2ef-e9c7-4436-b405-11fcb868f5ef"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-14T15:25:58Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/0fd5b52b-a035-4803-94d5-abf036437a33?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "0fd5b52b-a035-4803-94d5-abf036437a33",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-14T15:28:02+00:00",
      "updated_at": "2023-02-14T15:28:02+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=0fd5b52b-a035-4803-94d5-abf036437a33"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "f418445f-da15-4a1e-b250-f798130e20ed"
          },
          {
            "type": "menu_items",
            "id": "6cdf580c-502c-4a22-862c-2309216663a7"
          },
          {
            "type": "menu_items",
            "id": "9e69eb74-14bf-4402-a3e1-d72a02a5dca0"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "f418445f-da15-4a1e-b250-f798130e20ed",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-14T15:28:02+00:00",
        "updated_at": "2023-02-14T15:28:02+00:00",
        "menu_id": "0fd5b52b-a035-4803-94d5-abf036437a33",
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
            "related": "api/boomerang/menus/0fd5b52b-a035-4803-94d5-abf036437a33"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=f418445f-da15-4a1e-b250-f798130e20ed"
          }
        }
      }
    },
    {
      "id": "6cdf580c-502c-4a22-862c-2309216663a7",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-14T15:28:02+00:00",
        "updated_at": "2023-02-14T15:28:02+00:00",
        "menu_id": "0fd5b52b-a035-4803-94d5-abf036437a33",
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
            "related": "api/boomerang/menus/0fd5b52b-a035-4803-94d5-abf036437a33"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=6cdf580c-502c-4a22-862c-2309216663a7"
          }
        }
      }
    },
    {
      "id": "9e69eb74-14bf-4402-a3e1-d72a02a5dca0",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-14T15:28:02+00:00",
        "updated_at": "2023-02-14T15:28:02+00:00",
        "menu_id": "0fd5b52b-a035-4803-94d5-abf036437a33",
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
            "related": "api/boomerang/menus/0fd5b52b-a035-4803-94d5-abf036437a33"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=9e69eb74-14bf-4402-a3e1-d72a02a5dca0"
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
    "id": "e06a014c-a5a2-45b6-b1fe-9dd749067bb1",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-14T15:28:02+00:00",
      "updated_at": "2023-02-14T15:28:02+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/05ba14d3-6619-4bb5-bef5-6143506b37db' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "05ba14d3-6619-4bb5-bef5-6143506b37db",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "d876cad0-1efe-49cf-bc6c-42f20c1c733a",
              "title": "Contact us"
            },
            {
              "id": "59b0fd6b-7ba4-4b9f-bea5-efc45843a5f7",
              "title": "Start"
            },
            {
              "id": "f8ed29dd-9b79-49e3-9919-122627366c70",
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
    "id": "05ba14d3-6619-4bb5-bef5-6143506b37db",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-14T15:28:03+00:00",
      "updated_at": "2023-02-14T15:28:03+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "d876cad0-1efe-49cf-bc6c-42f20c1c733a"
          },
          {
            "type": "menu_items",
            "id": "59b0fd6b-7ba4-4b9f-bea5-efc45843a5f7"
          },
          {
            "type": "menu_items",
            "id": "f8ed29dd-9b79-49e3-9919-122627366c70"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "d876cad0-1efe-49cf-bc6c-42f20c1c733a",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-14T15:28:03+00:00",
        "updated_at": "2023-02-14T15:28:03+00:00",
        "menu_id": "05ba14d3-6619-4bb5-bef5-6143506b37db",
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
      "id": "59b0fd6b-7ba4-4b9f-bea5-efc45843a5f7",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-14T15:28:03+00:00",
        "updated_at": "2023-02-14T15:28:03+00:00",
        "menu_id": "05ba14d3-6619-4bb5-bef5-6143506b37db",
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
      "id": "f8ed29dd-9b79-49e3-9919-122627366c70",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-14T15:28:03+00:00",
        "updated_at": "2023-02-14T15:28:03+00:00",
        "menu_id": "05ba14d3-6619-4bb5-bef5-6143506b37db",
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
    --url 'https://example.booqable.com/api/boomerang/menus/37bd6937-782f-4c63-a80f-b63bfaac79e8' \
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