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
      "id": "866ddcb5-c4c9-49e8-bd99-9157c61145db",
      "type": "menus",
      "attributes": {
        "created_at": "2023-02-24T09:12:06+00:00",
        "updated_at": "2023-02-24T09:12:06+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=866ddcb5-c4c9-49e8-bd99-9157c61145db"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-24T09:10:33Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/a199a7ce-8de1-451b-bed5-0d6b2d1e5cf4?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "a199a7ce-8de1-451b-bed5-0d6b2d1e5cf4",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-24T09:12:07+00:00",
      "updated_at": "2023-02-24T09:12:07+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=a199a7ce-8de1-451b-bed5-0d6b2d1e5cf4"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "92b74572-b311-4f66-a796-153c943562a4"
          },
          {
            "type": "menu_items",
            "id": "018f0104-5ea7-4450-b61b-bb11d241aa6a"
          },
          {
            "type": "menu_items",
            "id": "04036a18-5f0e-443b-9675-2a5e97611e15"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "92b74572-b311-4f66-a796-153c943562a4",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-24T09:12:07+00:00",
        "updated_at": "2023-02-24T09:12:07+00:00",
        "menu_id": "a199a7ce-8de1-451b-bed5-0d6b2d1e5cf4",
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
            "related": "api/boomerang/menus/a199a7ce-8de1-451b-bed5-0d6b2d1e5cf4"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=92b74572-b311-4f66-a796-153c943562a4"
          }
        }
      }
    },
    {
      "id": "018f0104-5ea7-4450-b61b-bb11d241aa6a",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-24T09:12:07+00:00",
        "updated_at": "2023-02-24T09:12:07+00:00",
        "menu_id": "a199a7ce-8de1-451b-bed5-0d6b2d1e5cf4",
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
            "related": "api/boomerang/menus/a199a7ce-8de1-451b-bed5-0d6b2d1e5cf4"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=018f0104-5ea7-4450-b61b-bb11d241aa6a"
          }
        }
      }
    },
    {
      "id": "04036a18-5f0e-443b-9675-2a5e97611e15",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-24T09:12:07+00:00",
        "updated_at": "2023-02-24T09:12:07+00:00",
        "menu_id": "a199a7ce-8de1-451b-bed5-0d6b2d1e5cf4",
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
            "related": "api/boomerang/menus/a199a7ce-8de1-451b-bed5-0d6b2d1e5cf4"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=04036a18-5f0e-443b-9675-2a5e97611e15"
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
    "id": "7eb36e76-fcb0-436f-baef-24b8bb26b1c6",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-24T09:12:07+00:00",
      "updated_at": "2023-02-24T09:12:07+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/5750e2a5-eaf4-4b98-b83f-638e432b8dc7' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "5750e2a5-eaf4-4b98-b83f-638e432b8dc7",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "154ed832-46f0-4ea7-a048-4668f11a05b8",
              "title": "Contact us"
            },
            {
              "id": "0e72fca7-ef99-4139-baec-edfc807a9dcd",
              "title": "Start"
            },
            {
              "id": "d05b2081-7e42-4d8c-b1b9-78d98e20dc17",
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
    "id": "5750e2a5-eaf4-4b98-b83f-638e432b8dc7",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-24T09:12:07+00:00",
      "updated_at": "2023-02-24T09:12:07+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "154ed832-46f0-4ea7-a048-4668f11a05b8"
          },
          {
            "type": "menu_items",
            "id": "0e72fca7-ef99-4139-baec-edfc807a9dcd"
          },
          {
            "type": "menu_items",
            "id": "d05b2081-7e42-4d8c-b1b9-78d98e20dc17"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "154ed832-46f0-4ea7-a048-4668f11a05b8",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-24T09:12:07+00:00",
        "updated_at": "2023-02-24T09:12:07+00:00",
        "menu_id": "5750e2a5-eaf4-4b98-b83f-638e432b8dc7",
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
      "id": "0e72fca7-ef99-4139-baec-edfc807a9dcd",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-24T09:12:07+00:00",
        "updated_at": "2023-02-24T09:12:07+00:00",
        "menu_id": "5750e2a5-eaf4-4b98-b83f-638e432b8dc7",
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
      "id": "d05b2081-7e42-4d8c-b1b9-78d98e20dc17",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-24T09:12:07+00:00",
        "updated_at": "2023-02-24T09:12:07+00:00",
        "menu_id": "5750e2a5-eaf4-4b98-b83f-638e432b8dc7",
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
    --url 'https://example.booqable.com/api/boomerang/menus/45540407-b2a8-441d-9bd5-080f1b338064' \
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