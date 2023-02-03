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
      "id": "ceafcf40-6130-40f5-bd8d-829036f2d455",
      "type": "menus",
      "attributes": {
        "created_at": "2023-02-03T13:10:09+00:00",
        "updated_at": "2023-02-03T13:10:09+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=ceafcf40-6130-40f5-bd8d-829036f2d455"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-03T13:08:12Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/bac89756-723f-4c10-be69-8d4ca9a7ee53?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "bac89756-723f-4c10-be69-8d4ca9a7ee53",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-03T13:10:09+00:00",
      "updated_at": "2023-02-03T13:10:09+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=bac89756-723f-4c10-be69-8d4ca9a7ee53"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "93c868d5-7a99-4d6b-a98b-8dee06123c44"
          },
          {
            "type": "menu_items",
            "id": "d0df70c1-383d-4c06-b060-67d330c02d6c"
          },
          {
            "type": "menu_items",
            "id": "40fdcf28-24c6-4cb6-a928-e1637cf500c8"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "93c868d5-7a99-4d6b-a98b-8dee06123c44",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-03T13:10:09+00:00",
        "updated_at": "2023-02-03T13:10:09+00:00",
        "menu_id": "bac89756-723f-4c10-be69-8d4ca9a7ee53",
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
            "related": "api/boomerang/menus/bac89756-723f-4c10-be69-8d4ca9a7ee53"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=93c868d5-7a99-4d6b-a98b-8dee06123c44"
          }
        }
      }
    },
    {
      "id": "d0df70c1-383d-4c06-b060-67d330c02d6c",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-03T13:10:09+00:00",
        "updated_at": "2023-02-03T13:10:09+00:00",
        "menu_id": "bac89756-723f-4c10-be69-8d4ca9a7ee53",
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
            "related": "api/boomerang/menus/bac89756-723f-4c10-be69-8d4ca9a7ee53"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=d0df70c1-383d-4c06-b060-67d330c02d6c"
          }
        }
      }
    },
    {
      "id": "40fdcf28-24c6-4cb6-a928-e1637cf500c8",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-03T13:10:09+00:00",
        "updated_at": "2023-02-03T13:10:09+00:00",
        "menu_id": "bac89756-723f-4c10-be69-8d4ca9a7ee53",
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
            "related": "api/boomerang/menus/bac89756-723f-4c10-be69-8d4ca9a7ee53"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=40fdcf28-24c6-4cb6-a928-e1637cf500c8"
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
    "id": "015ff50d-aefc-4fbd-9160-fbe73be565d0",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-03T13:10:10+00:00",
      "updated_at": "2023-02-03T13:10:10+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/a40abb39-3f5a-4992-8575-e75374269d03' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "a40abb39-3f5a-4992-8575-e75374269d03",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "76d75956-72f4-4e34-a7b1-7243da930649",
              "title": "Contact us"
            },
            {
              "id": "aa7236d6-52b4-4a96-b1d2-2379db5e0cec",
              "title": "Start"
            },
            {
              "id": "a925cff5-7eaa-42e0-af0e-4323f0ce5510",
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
    "id": "a40abb39-3f5a-4992-8575-e75374269d03",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-03T13:10:11+00:00",
      "updated_at": "2023-02-03T13:10:11+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "76d75956-72f4-4e34-a7b1-7243da930649"
          },
          {
            "type": "menu_items",
            "id": "aa7236d6-52b4-4a96-b1d2-2379db5e0cec"
          },
          {
            "type": "menu_items",
            "id": "a925cff5-7eaa-42e0-af0e-4323f0ce5510"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "76d75956-72f4-4e34-a7b1-7243da930649",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-03T13:10:11+00:00",
        "updated_at": "2023-02-03T13:10:11+00:00",
        "menu_id": "a40abb39-3f5a-4992-8575-e75374269d03",
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
      "id": "aa7236d6-52b4-4a96-b1d2-2379db5e0cec",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-03T13:10:11+00:00",
        "updated_at": "2023-02-03T13:10:11+00:00",
        "menu_id": "a40abb39-3f5a-4992-8575-e75374269d03",
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
      "id": "a925cff5-7eaa-42e0-af0e-4323f0ce5510",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-03T13:10:11+00:00",
        "updated_at": "2023-02-03T13:10:11+00:00",
        "menu_id": "a40abb39-3f5a-4992-8575-e75374269d03",
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
    --url 'https://example.booqable.com/api/boomerang/menus/d270298f-07d6-4350-b290-83babb8f97cd' \
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