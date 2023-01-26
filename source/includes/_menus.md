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
      "id": "71c9b33d-8c60-4526-8d77-d8ff1cc3039a",
      "type": "menus",
      "attributes": {
        "created_at": "2023-01-26T08:09:58+00:00",
        "updated_at": "2023-01-26T08:09:58+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=71c9b33d-8c60-4526-8d77-d8ff1cc3039a"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-01-26T08:07:51Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/15710da2-6761-44c9-ab1b-234e9b11484e?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "15710da2-6761-44c9-ab1b-234e9b11484e",
    "type": "menus",
    "attributes": {
      "created_at": "2023-01-26T08:09:58+00:00",
      "updated_at": "2023-01-26T08:09:58+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=15710da2-6761-44c9-ab1b-234e9b11484e"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "b5e11675-61f2-4ad0-97e3-38bbdbd1070e"
          },
          {
            "type": "menu_items",
            "id": "5c0d5fdd-8446-4a9d-bace-d0739454e96c"
          },
          {
            "type": "menu_items",
            "id": "6d51a33e-ac43-4e86-a8f7-0a7ee79955e6"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "b5e11675-61f2-4ad0-97e3-38bbdbd1070e",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-01-26T08:09:58+00:00",
        "updated_at": "2023-01-26T08:09:58+00:00",
        "menu_id": "15710da2-6761-44c9-ab1b-234e9b11484e",
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
            "related": "api/boomerang/menus/15710da2-6761-44c9-ab1b-234e9b11484e"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=b5e11675-61f2-4ad0-97e3-38bbdbd1070e"
          }
        }
      }
    },
    {
      "id": "5c0d5fdd-8446-4a9d-bace-d0739454e96c",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-01-26T08:09:58+00:00",
        "updated_at": "2023-01-26T08:09:58+00:00",
        "menu_id": "15710da2-6761-44c9-ab1b-234e9b11484e",
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
            "related": "api/boomerang/menus/15710da2-6761-44c9-ab1b-234e9b11484e"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=5c0d5fdd-8446-4a9d-bace-d0739454e96c"
          }
        }
      }
    },
    {
      "id": "6d51a33e-ac43-4e86-a8f7-0a7ee79955e6",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-01-26T08:09:58+00:00",
        "updated_at": "2023-01-26T08:09:58+00:00",
        "menu_id": "15710da2-6761-44c9-ab1b-234e9b11484e",
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
            "related": "api/boomerang/menus/15710da2-6761-44c9-ab1b-234e9b11484e"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=6d51a33e-ac43-4e86-a8f7-0a7ee79955e6"
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
    "id": "463054c5-64d5-43ee-aef9-b3d1b0dc3515",
    "type": "menus",
    "attributes": {
      "created_at": "2023-01-26T08:09:59+00:00",
      "updated_at": "2023-01-26T08:09:59+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/607d72e1-bcb0-4b0d-88fe-efff9f9456aa' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "607d72e1-bcb0-4b0d-88fe-efff9f9456aa",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "be3f5d43-242a-48ff-b057-c82b00639d50",
              "title": "Contact us"
            },
            {
              "id": "42effac3-d95b-4441-835d-ce57437a1e03",
              "title": "Start"
            },
            {
              "id": "a37dda9f-db80-4889-b8a9-d97f13c3c0af",
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
    "id": "607d72e1-bcb0-4b0d-88fe-efff9f9456aa",
    "type": "menus",
    "attributes": {
      "created_at": "2023-01-26T08:09:59+00:00",
      "updated_at": "2023-01-26T08:09:59+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "be3f5d43-242a-48ff-b057-c82b00639d50"
          },
          {
            "type": "menu_items",
            "id": "42effac3-d95b-4441-835d-ce57437a1e03"
          },
          {
            "type": "menu_items",
            "id": "a37dda9f-db80-4889-b8a9-d97f13c3c0af"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "be3f5d43-242a-48ff-b057-c82b00639d50",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-01-26T08:09:59+00:00",
        "updated_at": "2023-01-26T08:09:59+00:00",
        "menu_id": "607d72e1-bcb0-4b0d-88fe-efff9f9456aa",
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
      "id": "42effac3-d95b-4441-835d-ce57437a1e03",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-01-26T08:09:59+00:00",
        "updated_at": "2023-01-26T08:09:59+00:00",
        "menu_id": "607d72e1-bcb0-4b0d-88fe-efff9f9456aa",
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
      "id": "a37dda9f-db80-4889-b8a9-d97f13c3c0af",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-01-26T08:09:59+00:00",
        "updated_at": "2023-01-26T08:09:59+00:00",
        "menu_id": "607d72e1-bcb0-4b0d-88fe-efff9f9456aa",
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
    --url 'https://example.booqable.com/api/boomerang/menus/4ea95fbb-2247-4658-a48c-18545b482aa6' \
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