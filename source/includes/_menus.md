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
      "id": "71638b2e-1a5b-4d94-ad8b-93d1ab6f7b5c",
      "type": "menus",
      "attributes": {
        "created_at": "2023-03-01T14:17:55+00:00",
        "updated_at": "2023-03-01T14:17:55+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=71638b2e-1a5b-4d94-ad8b-93d1ab6f7b5c"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-03-01T14:15:14Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/b710cac4-74a0-45e9-a1aa-74937108baa6?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "b710cac4-74a0-45e9-a1aa-74937108baa6",
    "type": "menus",
    "attributes": {
      "created_at": "2023-03-01T14:17:55+00:00",
      "updated_at": "2023-03-01T14:17:55+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=b710cac4-74a0-45e9-a1aa-74937108baa6"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "9e025c03-29b5-4081-b6cb-2f4bbcc92aff"
          },
          {
            "type": "menu_items",
            "id": "d2f79fd8-94a0-4201-abb4-25dffe77ac5e"
          },
          {
            "type": "menu_items",
            "id": "fccd3519-459a-43ee-b061-9211d0b5ccb3"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "9e025c03-29b5-4081-b6cb-2f4bbcc92aff",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-01T14:17:55+00:00",
        "updated_at": "2023-03-01T14:17:55+00:00",
        "menu_id": "b710cac4-74a0-45e9-a1aa-74937108baa6",
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
            "related": "api/boomerang/menus/b710cac4-74a0-45e9-a1aa-74937108baa6"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=9e025c03-29b5-4081-b6cb-2f4bbcc92aff"
          }
        }
      }
    },
    {
      "id": "d2f79fd8-94a0-4201-abb4-25dffe77ac5e",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-01T14:17:55+00:00",
        "updated_at": "2023-03-01T14:17:55+00:00",
        "menu_id": "b710cac4-74a0-45e9-a1aa-74937108baa6",
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
            "related": "api/boomerang/menus/b710cac4-74a0-45e9-a1aa-74937108baa6"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=d2f79fd8-94a0-4201-abb4-25dffe77ac5e"
          }
        }
      }
    },
    {
      "id": "fccd3519-459a-43ee-b061-9211d0b5ccb3",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-01T14:17:55+00:00",
        "updated_at": "2023-03-01T14:17:55+00:00",
        "menu_id": "b710cac4-74a0-45e9-a1aa-74937108baa6",
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
            "related": "api/boomerang/menus/b710cac4-74a0-45e9-a1aa-74937108baa6"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=fccd3519-459a-43ee-b061-9211d0b5ccb3"
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
    "id": "f94e763f-8254-4f43-b951-b22e9fb5de1f",
    "type": "menus",
    "attributes": {
      "created_at": "2023-03-01T14:17:56+00:00",
      "updated_at": "2023-03-01T14:17:56+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/0de444d1-3c39-41bd-b9e1-fdc54bebc184' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "0de444d1-3c39-41bd-b9e1-fdc54bebc184",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "a5a71ffa-84df-4ab4-ac6e-d9fba43c1615",
              "title": "Contact us"
            },
            {
              "id": "48922f14-ef19-49ec-b640-680e13ee16ce",
              "title": "Start"
            },
            {
              "id": "357d7511-5ac7-435d-aa0d-884acbe3cb1c",
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
    "id": "0de444d1-3c39-41bd-b9e1-fdc54bebc184",
    "type": "menus",
    "attributes": {
      "created_at": "2023-03-01T14:17:57+00:00",
      "updated_at": "2023-03-01T14:17:57+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "a5a71ffa-84df-4ab4-ac6e-d9fba43c1615"
          },
          {
            "type": "menu_items",
            "id": "48922f14-ef19-49ec-b640-680e13ee16ce"
          },
          {
            "type": "menu_items",
            "id": "357d7511-5ac7-435d-aa0d-884acbe3cb1c"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "a5a71ffa-84df-4ab4-ac6e-d9fba43c1615",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-01T14:17:57+00:00",
        "updated_at": "2023-03-01T14:17:57+00:00",
        "menu_id": "0de444d1-3c39-41bd-b9e1-fdc54bebc184",
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
      "id": "48922f14-ef19-49ec-b640-680e13ee16ce",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-01T14:17:57+00:00",
        "updated_at": "2023-03-01T14:17:57+00:00",
        "menu_id": "0de444d1-3c39-41bd-b9e1-fdc54bebc184",
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
      "id": "357d7511-5ac7-435d-aa0d-884acbe3cb1c",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-01T14:17:57+00:00",
        "updated_at": "2023-03-01T14:17:57+00:00",
        "menu_id": "0de444d1-3c39-41bd-b9e1-fdc54bebc184",
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
    --url 'https://example.booqable.com/api/boomerang/menus/a6c5bd7b-309f-49ee-8661-f56effa07b0c' \
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