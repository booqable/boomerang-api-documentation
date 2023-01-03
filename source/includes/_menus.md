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
      "id": "4a46a0a6-8a7f-4d8e-9149-cf2a6380088c",
      "type": "menus",
      "attributes": {
        "created_at": "2023-01-03T12:13:07+00:00",
        "updated_at": "2023-01-03T12:13:07+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=4a46a0a6-8a7f-4d8e-9149-cf2a6380088c"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-01-03T12:11:08Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/4a0947fc-bf40-4e17-9ad2-d0b7595d637f?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "4a0947fc-bf40-4e17-9ad2-d0b7595d637f",
    "type": "menus",
    "attributes": {
      "created_at": "2023-01-03T12:13:07+00:00",
      "updated_at": "2023-01-03T12:13:07+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=4a0947fc-bf40-4e17-9ad2-d0b7595d637f"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "19f40b57-2809-4b19-bf82-ebc42e58b4a1"
          },
          {
            "type": "menu_items",
            "id": "f3a63679-8466-41df-baa9-50307404d7a9"
          },
          {
            "type": "menu_items",
            "id": "60105ab3-854c-4ed2-8acb-77c58b362a0d"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "19f40b57-2809-4b19-bf82-ebc42e58b4a1",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-01-03T12:13:07+00:00",
        "updated_at": "2023-01-03T12:13:07+00:00",
        "menu_id": "4a0947fc-bf40-4e17-9ad2-d0b7595d637f",
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
            "related": "api/boomerang/menus/4a0947fc-bf40-4e17-9ad2-d0b7595d637f"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=19f40b57-2809-4b19-bf82-ebc42e58b4a1"
          }
        }
      }
    },
    {
      "id": "f3a63679-8466-41df-baa9-50307404d7a9",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-01-03T12:13:07+00:00",
        "updated_at": "2023-01-03T12:13:07+00:00",
        "menu_id": "4a0947fc-bf40-4e17-9ad2-d0b7595d637f",
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
            "related": "api/boomerang/menus/4a0947fc-bf40-4e17-9ad2-d0b7595d637f"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=f3a63679-8466-41df-baa9-50307404d7a9"
          }
        }
      }
    },
    {
      "id": "60105ab3-854c-4ed2-8acb-77c58b362a0d",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-01-03T12:13:07+00:00",
        "updated_at": "2023-01-03T12:13:07+00:00",
        "menu_id": "4a0947fc-bf40-4e17-9ad2-d0b7595d637f",
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
            "related": "api/boomerang/menus/4a0947fc-bf40-4e17-9ad2-d0b7595d637f"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=60105ab3-854c-4ed2-8acb-77c58b362a0d"
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
    "id": "0d6e8157-cc2a-4a3d-90bc-1c617e95a33e",
    "type": "menus",
    "attributes": {
      "created_at": "2023-01-03T12:13:08+00:00",
      "updated_at": "2023-01-03T12:13:08+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/9543cccf-ed77-4e18-b02d-ae5918daaef2' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "9543cccf-ed77-4e18-b02d-ae5918daaef2",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "cf25819a-8749-4fa3-9642-485085e433ca",
              "title": "Contact us"
            },
            {
              "id": "eb622f86-9994-4094-9649-88a360b4c080",
              "title": "Start"
            },
            {
              "id": "fdffb6ed-d7d0-40e5-ab70-eff8623d12eb",
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
    "id": "9543cccf-ed77-4e18-b02d-ae5918daaef2",
    "type": "menus",
    "attributes": {
      "created_at": "2023-01-03T12:13:09+00:00",
      "updated_at": "2023-01-03T12:13:09+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "cf25819a-8749-4fa3-9642-485085e433ca"
          },
          {
            "type": "menu_items",
            "id": "eb622f86-9994-4094-9649-88a360b4c080"
          },
          {
            "type": "menu_items",
            "id": "fdffb6ed-d7d0-40e5-ab70-eff8623d12eb"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "cf25819a-8749-4fa3-9642-485085e433ca",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-01-03T12:13:09+00:00",
        "updated_at": "2023-01-03T12:13:09+00:00",
        "menu_id": "9543cccf-ed77-4e18-b02d-ae5918daaef2",
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
      "id": "eb622f86-9994-4094-9649-88a360b4c080",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-01-03T12:13:09+00:00",
        "updated_at": "2023-01-03T12:13:09+00:00",
        "menu_id": "9543cccf-ed77-4e18-b02d-ae5918daaef2",
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
      "id": "fdffb6ed-d7d0-40e5-ab70-eff8623d12eb",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-01-03T12:13:09+00:00",
        "updated_at": "2023-01-03T12:13:09+00:00",
        "menu_id": "9543cccf-ed77-4e18-b02d-ae5918daaef2",
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
    --url 'https://example.booqable.com/api/boomerang/menus/561ffd78-9a13-47d9-bbc9-a1e81bea1d23' \
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