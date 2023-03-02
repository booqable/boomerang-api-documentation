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
      "id": "8771819f-46b5-4ed8-929c-5e1028215619",
      "type": "menus",
      "attributes": {
        "created_at": "2023-03-02T09:24:57+00:00",
        "updated_at": "2023-03-02T09:24:57+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=8771819f-46b5-4ed8-929c-5e1028215619"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-03-02T09:22:42Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/e3cc30c5-5463-4dc2-ae7b-5e5e3a1143dd?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "e3cc30c5-5463-4dc2-ae7b-5e5e3a1143dd",
    "type": "menus",
    "attributes": {
      "created_at": "2023-03-02T09:24:57+00:00",
      "updated_at": "2023-03-02T09:24:57+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=e3cc30c5-5463-4dc2-ae7b-5e5e3a1143dd"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "38ed9ac1-a09b-489b-88ad-2b4ce11af0f1"
          },
          {
            "type": "menu_items",
            "id": "76cb9298-04af-49cd-8100-e959e4500829"
          },
          {
            "type": "menu_items",
            "id": "073fbb62-5b03-40c7-b084-18d206251ff3"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "38ed9ac1-a09b-489b-88ad-2b4ce11af0f1",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-02T09:24:57+00:00",
        "updated_at": "2023-03-02T09:24:57+00:00",
        "menu_id": "e3cc30c5-5463-4dc2-ae7b-5e5e3a1143dd",
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
            "related": "api/boomerang/menus/e3cc30c5-5463-4dc2-ae7b-5e5e3a1143dd"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=38ed9ac1-a09b-489b-88ad-2b4ce11af0f1"
          }
        }
      }
    },
    {
      "id": "76cb9298-04af-49cd-8100-e959e4500829",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-02T09:24:57+00:00",
        "updated_at": "2023-03-02T09:24:57+00:00",
        "menu_id": "e3cc30c5-5463-4dc2-ae7b-5e5e3a1143dd",
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
            "related": "api/boomerang/menus/e3cc30c5-5463-4dc2-ae7b-5e5e3a1143dd"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=76cb9298-04af-49cd-8100-e959e4500829"
          }
        }
      }
    },
    {
      "id": "073fbb62-5b03-40c7-b084-18d206251ff3",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-02T09:24:57+00:00",
        "updated_at": "2023-03-02T09:24:57+00:00",
        "menu_id": "e3cc30c5-5463-4dc2-ae7b-5e5e3a1143dd",
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
            "related": "api/boomerang/menus/e3cc30c5-5463-4dc2-ae7b-5e5e3a1143dd"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=073fbb62-5b03-40c7-b084-18d206251ff3"
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
    "id": "96776c4a-9c5a-4999-9e1e-97dac9a1da3d",
    "type": "menus",
    "attributes": {
      "created_at": "2023-03-02T09:24:58+00:00",
      "updated_at": "2023-03-02T09:24:58+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/5ccd1ece-18c7-4507-943f-c4f9ec64075e' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "5ccd1ece-18c7-4507-943f-c4f9ec64075e",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "aa656fb1-6996-4d28-93da-e92245c3347d",
              "title": "Contact us"
            },
            {
              "id": "37021588-82fe-46e1-a079-50520b79daac",
              "title": "Start"
            },
            {
              "id": "6febe8ec-20e6-4300-813a-39b0c83ba910",
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
    "id": "5ccd1ece-18c7-4507-943f-c4f9ec64075e",
    "type": "menus",
    "attributes": {
      "created_at": "2023-03-02T09:24:58+00:00",
      "updated_at": "2023-03-02T09:24:58+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "aa656fb1-6996-4d28-93da-e92245c3347d"
          },
          {
            "type": "menu_items",
            "id": "37021588-82fe-46e1-a079-50520b79daac"
          },
          {
            "type": "menu_items",
            "id": "6febe8ec-20e6-4300-813a-39b0c83ba910"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "aa656fb1-6996-4d28-93da-e92245c3347d",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-02T09:24:58+00:00",
        "updated_at": "2023-03-02T09:24:58+00:00",
        "menu_id": "5ccd1ece-18c7-4507-943f-c4f9ec64075e",
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
      "id": "37021588-82fe-46e1-a079-50520b79daac",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-02T09:24:58+00:00",
        "updated_at": "2023-03-02T09:24:58+00:00",
        "menu_id": "5ccd1ece-18c7-4507-943f-c4f9ec64075e",
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
      "id": "6febe8ec-20e6-4300-813a-39b0c83ba910",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-02T09:24:58+00:00",
        "updated_at": "2023-03-02T09:24:58+00:00",
        "menu_id": "5ccd1ece-18c7-4507-943f-c4f9ec64075e",
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
    --url 'https://example.booqable.com/api/boomerang/menus/e74609a9-2f4a-4d6d-8211-d9e8e6fdea06' \
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