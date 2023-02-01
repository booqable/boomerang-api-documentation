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
      "id": "c7ed4b08-eb87-4e29-9c08-2fcf40eedee0",
      "type": "menus",
      "attributes": {
        "created_at": "2023-02-01T15:15:36+00:00",
        "updated_at": "2023-02-01T15:15:36+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=c7ed4b08-eb87-4e29-9c08-2fcf40eedee0"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-01T15:13:38Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/ff59d408-c4bb-4186-a8de-6a03796a63a1?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "ff59d408-c4bb-4186-a8de-6a03796a63a1",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-01T15:15:36+00:00",
      "updated_at": "2023-02-01T15:15:36+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=ff59d408-c4bb-4186-a8de-6a03796a63a1"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "1c7f1848-8174-4739-859a-29b50e62971c"
          },
          {
            "type": "menu_items",
            "id": "a647abe6-17aa-4ef6-9887-e89e0637df71"
          },
          {
            "type": "menu_items",
            "id": "1e7de49c-d0bd-496f-83d9-790f6c776299"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "1c7f1848-8174-4739-859a-29b50e62971c",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-01T15:15:36+00:00",
        "updated_at": "2023-02-01T15:15:36+00:00",
        "menu_id": "ff59d408-c4bb-4186-a8de-6a03796a63a1",
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
            "related": "api/boomerang/menus/ff59d408-c4bb-4186-a8de-6a03796a63a1"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=1c7f1848-8174-4739-859a-29b50e62971c"
          }
        }
      }
    },
    {
      "id": "a647abe6-17aa-4ef6-9887-e89e0637df71",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-01T15:15:36+00:00",
        "updated_at": "2023-02-01T15:15:36+00:00",
        "menu_id": "ff59d408-c4bb-4186-a8de-6a03796a63a1",
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
            "related": "api/boomerang/menus/ff59d408-c4bb-4186-a8de-6a03796a63a1"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=a647abe6-17aa-4ef6-9887-e89e0637df71"
          }
        }
      }
    },
    {
      "id": "1e7de49c-d0bd-496f-83d9-790f6c776299",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-01T15:15:36+00:00",
        "updated_at": "2023-02-01T15:15:36+00:00",
        "menu_id": "ff59d408-c4bb-4186-a8de-6a03796a63a1",
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
            "related": "api/boomerang/menus/ff59d408-c4bb-4186-a8de-6a03796a63a1"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=1e7de49c-d0bd-496f-83d9-790f6c776299"
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
    "id": "6100b664-26f3-47fc-8926-cd9ad17a808f",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-01T15:15:36+00:00",
      "updated_at": "2023-02-01T15:15:36+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/4ad0842f-503f-49d0-87bf-ba6b9481e35e' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "4ad0842f-503f-49d0-87bf-ba6b9481e35e",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "15118610-2fd3-4aeb-93ee-2625862f245a",
              "title": "Contact us"
            },
            {
              "id": "c1226075-0c3f-41b5-9732-c0f6659b943a",
              "title": "Start"
            },
            {
              "id": "e04b5219-0c83-4b18-ae3e-6196043a026c",
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
    "id": "4ad0842f-503f-49d0-87bf-ba6b9481e35e",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-01T15:15:37+00:00",
      "updated_at": "2023-02-01T15:15:37+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "15118610-2fd3-4aeb-93ee-2625862f245a"
          },
          {
            "type": "menu_items",
            "id": "c1226075-0c3f-41b5-9732-c0f6659b943a"
          },
          {
            "type": "menu_items",
            "id": "e04b5219-0c83-4b18-ae3e-6196043a026c"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "15118610-2fd3-4aeb-93ee-2625862f245a",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-01T15:15:37+00:00",
        "updated_at": "2023-02-01T15:15:37+00:00",
        "menu_id": "4ad0842f-503f-49d0-87bf-ba6b9481e35e",
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
      "id": "c1226075-0c3f-41b5-9732-c0f6659b943a",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-01T15:15:37+00:00",
        "updated_at": "2023-02-01T15:15:37+00:00",
        "menu_id": "4ad0842f-503f-49d0-87bf-ba6b9481e35e",
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
      "id": "e04b5219-0c83-4b18-ae3e-6196043a026c",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-01T15:15:37+00:00",
        "updated_at": "2023-02-01T15:15:37+00:00",
        "menu_id": "4ad0842f-503f-49d0-87bf-ba6b9481e35e",
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
    --url 'https://example.booqable.com/api/boomerang/menus/5d27bd99-5422-41b4-8a39-4bdeb5d6bcc3' \
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