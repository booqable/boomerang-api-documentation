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
      "id": "8c27ebf3-391c-46a6-9c4d-c1be7d019166",
      "type": "menus",
      "attributes": {
        "created_at": "2022-11-22T16:48:16+00:00",
        "updated_at": "2022-11-22T16:48:16+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=8c27ebf3-391c-46a6-9c4d-c1be7d019166"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-11-22T16:45:19Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/c70ec2b7-06d5-41fa-ba71-01ad9fe1e1ba?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "c70ec2b7-06d5-41fa-ba71-01ad9fe1e1ba",
    "type": "menus",
    "attributes": {
      "created_at": "2022-11-22T16:48:17+00:00",
      "updated_at": "2022-11-22T16:48:17+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=c70ec2b7-06d5-41fa-ba71-01ad9fe1e1ba"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "e05a22fd-1563-4440-9104-0031dc5156e1"
          },
          {
            "type": "menu_items",
            "id": "e22f7f8a-5705-4230-abe7-710ada26b204"
          },
          {
            "type": "menu_items",
            "id": "50511ece-72d2-46e6-a8be-2b35244a0fbe"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "e05a22fd-1563-4440-9104-0031dc5156e1",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-11-22T16:48:17+00:00",
        "updated_at": "2022-11-22T16:48:17+00:00",
        "menu_id": "c70ec2b7-06d5-41fa-ba71-01ad9fe1e1ba",
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
            "related": "api/boomerang/menus/c70ec2b7-06d5-41fa-ba71-01ad9fe1e1ba"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=e05a22fd-1563-4440-9104-0031dc5156e1"
          }
        }
      }
    },
    {
      "id": "e22f7f8a-5705-4230-abe7-710ada26b204",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-11-22T16:48:17+00:00",
        "updated_at": "2022-11-22T16:48:17+00:00",
        "menu_id": "c70ec2b7-06d5-41fa-ba71-01ad9fe1e1ba",
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
            "related": "api/boomerang/menus/c70ec2b7-06d5-41fa-ba71-01ad9fe1e1ba"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=e22f7f8a-5705-4230-abe7-710ada26b204"
          }
        }
      }
    },
    {
      "id": "50511ece-72d2-46e6-a8be-2b35244a0fbe",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-11-22T16:48:17+00:00",
        "updated_at": "2022-11-22T16:48:17+00:00",
        "menu_id": "c70ec2b7-06d5-41fa-ba71-01ad9fe1e1ba",
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
            "related": "api/boomerang/menus/c70ec2b7-06d5-41fa-ba71-01ad9fe1e1ba"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=50511ece-72d2-46e6-a8be-2b35244a0fbe"
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
    "id": "4d3d4fba-1c79-4c40-84f4-5ecb25adfa75",
    "type": "menus",
    "attributes": {
      "created_at": "2022-11-22T16:48:17+00:00",
      "updated_at": "2022-11-22T16:48:17+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/1c8f7d56-0ff4-428a-87e7-4934dc1c4b45' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "1c8f7d56-0ff4-428a-87e7-4934dc1c4b45",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "e7c2c8ff-a8d8-4695-877d-4e455dd6f00f",
              "title": "Contact us"
            },
            {
              "id": "a846a6c1-a237-4f1b-912d-c72475470faf",
              "title": "Start"
            },
            {
              "id": "c48d6ade-3f15-408a-a70f-602ce0b74c51",
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
    "id": "1c8f7d56-0ff4-428a-87e7-4934dc1c4b45",
    "type": "menus",
    "attributes": {
      "created_at": "2022-11-22T16:48:19+00:00",
      "updated_at": "2022-11-22T16:48:19+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "e7c2c8ff-a8d8-4695-877d-4e455dd6f00f"
          },
          {
            "type": "menu_items",
            "id": "a846a6c1-a237-4f1b-912d-c72475470faf"
          },
          {
            "type": "menu_items",
            "id": "c48d6ade-3f15-408a-a70f-602ce0b74c51"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "e7c2c8ff-a8d8-4695-877d-4e455dd6f00f",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-11-22T16:48:19+00:00",
        "updated_at": "2022-11-22T16:48:19+00:00",
        "menu_id": "1c8f7d56-0ff4-428a-87e7-4934dc1c4b45",
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
      "id": "a846a6c1-a237-4f1b-912d-c72475470faf",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-11-22T16:48:19+00:00",
        "updated_at": "2022-11-22T16:48:19+00:00",
        "menu_id": "1c8f7d56-0ff4-428a-87e7-4934dc1c4b45",
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
      "id": "c48d6ade-3f15-408a-a70f-602ce0b74c51",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-11-22T16:48:19+00:00",
        "updated_at": "2022-11-22T16:48:19+00:00",
        "menu_id": "1c8f7d56-0ff4-428a-87e7-4934dc1c4b45",
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
    --url 'https://example.booqable.com/api/boomerang/menus/6cff1e19-19d8-4a99-adee-8220a557a0db' \
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