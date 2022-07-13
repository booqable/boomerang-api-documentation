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
      "id": "4ef069c9-f480-4d24-a694-b71ee0bd0111",
      "type": "menus",
      "attributes": {
        "created_at": "2022-07-13T08:18:53+00:00",
        "updated_at": "2022-07-13T08:18:53+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=4ef069c9-f480-4d24-a694-b71ee0bd0111"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-07-13T08:17:07Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/5100dec3-2bf0-41e3-95c1-15ea45bab5c1?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "5100dec3-2bf0-41e3-95c1-15ea45bab5c1",
    "type": "menus",
    "attributes": {
      "created_at": "2022-07-13T08:18:53+00:00",
      "updated_at": "2022-07-13T08:18:53+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=5100dec3-2bf0-41e3-95c1-15ea45bab5c1"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "fb39614c-fa14-4686-af3a-f0d95ec0f865"
          },
          {
            "type": "menu_items",
            "id": "4629f0de-2f23-470f-8772-da48493fe8a6"
          },
          {
            "type": "menu_items",
            "id": "b85e6e48-dffd-436a-b123-1448f22a5c79"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "fb39614c-fa14-4686-af3a-f0d95ec0f865",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-07-13T08:18:53+00:00",
        "updated_at": "2022-07-13T08:18:53+00:00",
        "menu_id": "5100dec3-2bf0-41e3-95c1-15ea45bab5c1",
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
            "related": "api/boomerang/menus/5100dec3-2bf0-41e3-95c1-15ea45bab5c1"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=fb39614c-fa14-4686-af3a-f0d95ec0f865"
          }
        }
      }
    },
    {
      "id": "4629f0de-2f23-470f-8772-da48493fe8a6",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-07-13T08:18:53+00:00",
        "updated_at": "2022-07-13T08:18:53+00:00",
        "menu_id": "5100dec3-2bf0-41e3-95c1-15ea45bab5c1",
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
            "related": "api/boomerang/menus/5100dec3-2bf0-41e3-95c1-15ea45bab5c1"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=4629f0de-2f23-470f-8772-da48493fe8a6"
          }
        }
      }
    },
    {
      "id": "b85e6e48-dffd-436a-b123-1448f22a5c79",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-07-13T08:18:53+00:00",
        "updated_at": "2022-07-13T08:18:53+00:00",
        "menu_id": "5100dec3-2bf0-41e3-95c1-15ea45bab5c1",
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
            "related": "api/boomerang/menus/5100dec3-2bf0-41e3-95c1-15ea45bab5c1"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=b85e6e48-dffd-436a-b123-1448f22a5c79"
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
    "id": "e7ab838d-72eb-4884-b6f7-328e294bbb84",
    "type": "menus",
    "attributes": {
      "created_at": "2022-07-13T08:18:53+00:00",
      "updated_at": "2022-07-13T08:18:53+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/93d12b5f-d843-459a-91df-e6ddca46c858' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "93d12b5f-d843-459a-91df-e6ddca46c858",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "403372b5-f016-41b4-9b3e-3a3e7e01ee84",
              "title": "Contact us"
            },
            {
              "id": "0b4ebea5-3c1d-41a4-bb61-01cad4f984e9",
              "title": "Start"
            },
            {
              "id": "aa9f664d-3ba4-4364-a312-ad0d3b0961f6",
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
    "id": "93d12b5f-d843-459a-91df-e6ddca46c858",
    "type": "menus",
    "attributes": {
      "created_at": "2022-07-13T08:18:54+00:00",
      "updated_at": "2022-07-13T08:18:54+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "403372b5-f016-41b4-9b3e-3a3e7e01ee84"
          },
          {
            "type": "menu_items",
            "id": "0b4ebea5-3c1d-41a4-bb61-01cad4f984e9"
          },
          {
            "type": "menu_items",
            "id": "aa9f664d-3ba4-4364-a312-ad0d3b0961f6"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "403372b5-f016-41b4-9b3e-3a3e7e01ee84",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-07-13T08:18:54+00:00",
        "updated_at": "2022-07-13T08:18:54+00:00",
        "menu_id": "93d12b5f-d843-459a-91df-e6ddca46c858",
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
      "id": "0b4ebea5-3c1d-41a4-bb61-01cad4f984e9",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-07-13T08:18:54+00:00",
        "updated_at": "2022-07-13T08:18:54+00:00",
        "menu_id": "93d12b5f-d843-459a-91df-e6ddca46c858",
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
      "id": "aa9f664d-3ba4-4364-a312-ad0d3b0961f6",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-07-13T08:18:54+00:00",
        "updated_at": "2022-07-13T08:18:54+00:00",
        "menu_id": "93d12b5f-d843-459a-91df-e6ddca46c858",
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
    --url 'https://example.booqable.com/api/boomerang/menus/42746cd4-95e6-4f79-b01a-224317d7f525' \
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