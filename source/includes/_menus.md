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
`title` | **String**<br>Name of the menu.
`key` | **String**<br>Key the menu can be referenced by.
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
      "id": "84e25718-9131-4ccd-aedd-a66dc83cb02d",
      "type": "menus",
      "attributes": {
        "created_at": "2022-07-15T09:24:53+00:00",
        "updated_at": "2022-07-15T09:24:53+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=84e25718-9131-4ccd-aedd-a66dc83cb02d"
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=menu_items`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[menus]=id,created_at,updated_at`
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-07-15T09:22:34Z`
`sort` | **String**<br>How to sort the data `?sort=-created_at`
`meta` | **Hash**<br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String**<br>The page to request
`page[size]` | **String**<br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
`id` | **Uuid**<br>`eq`, `not_eq`
`created_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`title` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`key` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array**<br>`count`


### Includes

This request does not accept any includes
## Fetching a price structure



> How to fetch a menu with it's items:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/menus/182b3fce-88cb-45d2-9adf-922f219410d0?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "182b3fce-88cb-45d2-9adf-922f219410d0",
    "type": "menus",
    "attributes": {
      "created_at": "2022-07-15T09:24:54+00:00",
      "updated_at": "2022-07-15T09:24:54+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=182b3fce-88cb-45d2-9adf-922f219410d0"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "a4926e7c-a148-43ca-b831-0c3e809ef779"
          },
          {
            "type": "menu_items",
            "id": "04f116ea-ac07-44f4-a2a7-4b59477023cb"
          },
          {
            "type": "menu_items",
            "id": "19b5fc08-715d-4cd4-901d-f2f01ee343bd"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "a4926e7c-a148-43ca-b831-0c3e809ef779",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-07-15T09:24:54+00:00",
        "updated_at": "2022-07-15T09:24:54+00:00",
        "menu_id": "182b3fce-88cb-45d2-9adf-922f219410d0",
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
            "related": "api/boomerang/menus/182b3fce-88cb-45d2-9adf-922f219410d0"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=a4926e7c-a148-43ca-b831-0c3e809ef779"
          }
        }
      }
    },
    {
      "id": "04f116ea-ac07-44f4-a2a7-4b59477023cb",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-07-15T09:24:54+00:00",
        "updated_at": "2022-07-15T09:24:54+00:00",
        "menu_id": "182b3fce-88cb-45d2-9adf-922f219410d0",
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
            "related": "api/boomerang/menus/182b3fce-88cb-45d2-9adf-922f219410d0"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=04f116ea-ac07-44f4-a2a7-4b59477023cb"
          }
        }
      }
    },
    {
      "id": "19b5fc08-715d-4cd4-901d-f2f01ee343bd",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-07-15T09:24:54+00:00",
        "updated_at": "2022-07-15T09:24:54+00:00",
        "menu_id": "182b3fce-88cb-45d2-9adf-922f219410d0",
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
            "related": "api/boomerang/menus/182b3fce-88cb-45d2-9adf-922f219410d0"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=19b5fc08-715d-4cd4-901d-f2f01ee343bd"
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=menu_items`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[menus]=id,created_at,updated_at`


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
    "id": "f01ad92a-e7bb-453f-9911-8308111d838b",
    "type": "menus",
    "attributes": {
      "created_at": "2022-07-15T09:24:55+00:00",
      "updated_at": "2022-07-15T09:24:55+00:00",
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=menu_items`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[menus]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][title]` | **String**<br>Name of the menu.
`data[attributes][key]` | **String**<br>Key the menu can be referenced by.
`data[attributes][menu_items_attributes][]` | **Array**<br>Attributes of child menu items to be created or changed.


### Includes

This request accepts the following includes:

`menu_items` => 
`menu_items` => 
`menu_items`










## Updating a menu and it's items



> How to update a menu with nested menu items:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/menus/c6d37a08-60a5-40cb-ad5c-c5355bdef80e' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "c6d37a08-60a5-40cb-ad5c-c5355bdef80e",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "623162e7-d73f-4ae9-8d98-13480ca418bb",
              "title": "Contact us"
            },
            {
              "id": "5bc6d345-6e2e-4b55-96ed-af6ab84d9ec2",
              "title": "Start"
            },
            {
              "id": "f3bcb63c-4c53-41d3-9ab4-784e3e2d5171",
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
    "id": "c6d37a08-60a5-40cb-ad5c-c5355bdef80e",
    "type": "menus",
    "attributes": {
      "created_at": "2022-07-15T09:24:55+00:00",
      "updated_at": "2022-07-15T09:24:56+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "623162e7-d73f-4ae9-8d98-13480ca418bb"
          },
          {
            "type": "menu_items",
            "id": "5bc6d345-6e2e-4b55-96ed-af6ab84d9ec2"
          },
          {
            "type": "menu_items",
            "id": "f3bcb63c-4c53-41d3-9ab4-784e3e2d5171"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "623162e7-d73f-4ae9-8d98-13480ca418bb",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-07-15T09:24:55+00:00",
        "updated_at": "2022-07-15T09:24:56+00:00",
        "menu_id": "c6d37a08-60a5-40cb-ad5c-c5355bdef80e",
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
      "id": "5bc6d345-6e2e-4b55-96ed-af6ab84d9ec2",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-07-15T09:24:55+00:00",
        "updated_at": "2022-07-15T09:24:56+00:00",
        "menu_id": "c6d37a08-60a5-40cb-ad5c-c5355bdef80e",
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
      "id": "f3bcb63c-4c53-41d3-9ab4-784e3e2d5171",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-07-15T09:24:55+00:00",
        "updated_at": "2022-07-15T09:24:56+00:00",
        "menu_id": "c6d37a08-60a5-40cb-ad5c-c5355bdef80e",
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=menu_items`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[menus]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][title]` | **String**<br>Name of the menu.
`data[attributes][key]` | **String**<br>Key the menu can be referenced by.
`data[attributes][menu_items_attributes][]` | **Array**<br>Attributes of child menu items to be created or changed.


### Includes

This request accepts the following includes:

`menu_items` => 
`menu_items` => 
`menu_items`










## Deleting a menu



> How to delete a menu:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/menus/fa38c500-5310-4b84-b1f9-9f3983478e60' \
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=menu_items`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[menus]=id,created_at,updated_at`


### Includes

This request does not accept any includes