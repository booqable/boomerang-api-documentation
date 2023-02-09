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
      "id": "ca1b5d8f-d536-4f03-962e-a06838bc56db",
      "type": "menus",
      "attributes": {
        "created_at": "2023-02-09T11:03:21+00:00",
        "updated_at": "2023-02-09T11:03:21+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=ca1b5d8f-d536-4f03-962e-a06838bc56db"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-09T11:01:31Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/e282307b-68a2-4418-ab80-8cd8401d7972?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "e282307b-68a2-4418-ab80-8cd8401d7972",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-09T11:03:22+00:00",
      "updated_at": "2023-02-09T11:03:22+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=e282307b-68a2-4418-ab80-8cd8401d7972"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "7d13c18c-89e1-4a3b-8ae4-01028781729d"
          },
          {
            "type": "menu_items",
            "id": "1fe72492-7a51-4032-99fb-733571476572"
          },
          {
            "type": "menu_items",
            "id": "e27ab196-6774-46a8-b96b-06fe2be05dba"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "7d13c18c-89e1-4a3b-8ae4-01028781729d",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-09T11:03:22+00:00",
        "updated_at": "2023-02-09T11:03:22+00:00",
        "menu_id": "e282307b-68a2-4418-ab80-8cd8401d7972",
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
            "related": "api/boomerang/menus/e282307b-68a2-4418-ab80-8cd8401d7972"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=7d13c18c-89e1-4a3b-8ae4-01028781729d"
          }
        }
      }
    },
    {
      "id": "1fe72492-7a51-4032-99fb-733571476572",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-09T11:03:22+00:00",
        "updated_at": "2023-02-09T11:03:22+00:00",
        "menu_id": "e282307b-68a2-4418-ab80-8cd8401d7972",
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
            "related": "api/boomerang/menus/e282307b-68a2-4418-ab80-8cd8401d7972"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=1fe72492-7a51-4032-99fb-733571476572"
          }
        }
      }
    },
    {
      "id": "e27ab196-6774-46a8-b96b-06fe2be05dba",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-09T11:03:22+00:00",
        "updated_at": "2023-02-09T11:03:22+00:00",
        "menu_id": "e282307b-68a2-4418-ab80-8cd8401d7972",
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
            "related": "api/boomerang/menus/e282307b-68a2-4418-ab80-8cd8401d7972"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=e27ab196-6774-46a8-b96b-06fe2be05dba"
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
    "id": "d6dc1eb7-d2e6-4ec1-b917-d428252c5cd7",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-09T11:03:22+00:00",
      "updated_at": "2023-02-09T11:03:22+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/cfb2ed10-8cf9-4ff0-b86d-c722ca1d15bc' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "cfb2ed10-8cf9-4ff0-b86d-c722ca1d15bc",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "2b3f542c-94a5-4a29-84ad-1a29f9fbff48",
              "title": "Contact us"
            },
            {
              "id": "71606967-2306-431a-b14f-edefa1f542e6",
              "title": "Start"
            },
            {
              "id": "579fb8ef-6a73-4901-809a-45306fbeba2e",
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
    "id": "cfb2ed10-8cf9-4ff0-b86d-c722ca1d15bc",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-09T11:03:22+00:00",
      "updated_at": "2023-02-09T11:03:22+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "2b3f542c-94a5-4a29-84ad-1a29f9fbff48"
          },
          {
            "type": "menu_items",
            "id": "71606967-2306-431a-b14f-edefa1f542e6"
          },
          {
            "type": "menu_items",
            "id": "579fb8ef-6a73-4901-809a-45306fbeba2e"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "2b3f542c-94a5-4a29-84ad-1a29f9fbff48",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-09T11:03:22+00:00",
        "updated_at": "2023-02-09T11:03:22+00:00",
        "menu_id": "cfb2ed10-8cf9-4ff0-b86d-c722ca1d15bc",
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
      "id": "71606967-2306-431a-b14f-edefa1f542e6",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-09T11:03:22+00:00",
        "updated_at": "2023-02-09T11:03:22+00:00",
        "menu_id": "cfb2ed10-8cf9-4ff0-b86d-c722ca1d15bc",
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
      "id": "579fb8ef-6a73-4901-809a-45306fbeba2e",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-09T11:03:22+00:00",
        "updated_at": "2023-02-09T11:03:22+00:00",
        "menu_id": "cfb2ed10-8cf9-4ff0-b86d-c722ca1d15bc",
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
    --url 'https://example.booqable.com/api/boomerang/menus/63a7b6b5-2962-4ac8-8416-61dbe5e81d4c' \
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