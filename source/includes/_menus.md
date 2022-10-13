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
      "id": "cbaebfd6-3f60-493d-a370-b5a9990ad2aa",
      "type": "menus",
      "attributes": {
        "created_at": "2022-10-13T08:57:33+00:00",
        "updated_at": "2022-10-13T08:57:33+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=cbaebfd6-3f60-493d-a370-b5a9990ad2aa"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-10-13T08:55:37Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/a2b59bcf-910a-4eb6-a1e7-868e9d29bb6d?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "a2b59bcf-910a-4eb6-a1e7-868e9d29bb6d",
    "type": "menus",
    "attributes": {
      "created_at": "2022-10-13T08:57:33+00:00",
      "updated_at": "2022-10-13T08:57:33+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=a2b59bcf-910a-4eb6-a1e7-868e9d29bb6d"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "debddc4f-5795-4ff6-846d-645ba8fa4748"
          },
          {
            "type": "menu_items",
            "id": "6714d5aa-f143-47df-98ef-fc0050d27e7d"
          },
          {
            "type": "menu_items",
            "id": "406182d4-d924-468b-9de1-34845b7f35b1"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "debddc4f-5795-4ff6-846d-645ba8fa4748",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-10-13T08:57:33+00:00",
        "updated_at": "2022-10-13T08:57:33+00:00",
        "menu_id": "a2b59bcf-910a-4eb6-a1e7-868e9d29bb6d",
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
            "related": "api/boomerang/menus/a2b59bcf-910a-4eb6-a1e7-868e9d29bb6d"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=debddc4f-5795-4ff6-846d-645ba8fa4748"
          }
        }
      }
    },
    {
      "id": "6714d5aa-f143-47df-98ef-fc0050d27e7d",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-10-13T08:57:33+00:00",
        "updated_at": "2022-10-13T08:57:33+00:00",
        "menu_id": "a2b59bcf-910a-4eb6-a1e7-868e9d29bb6d",
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
            "related": "api/boomerang/menus/a2b59bcf-910a-4eb6-a1e7-868e9d29bb6d"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=6714d5aa-f143-47df-98ef-fc0050d27e7d"
          }
        }
      }
    },
    {
      "id": "406182d4-d924-468b-9de1-34845b7f35b1",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-10-13T08:57:33+00:00",
        "updated_at": "2022-10-13T08:57:33+00:00",
        "menu_id": "a2b59bcf-910a-4eb6-a1e7-868e9d29bb6d",
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
            "related": "api/boomerang/menus/a2b59bcf-910a-4eb6-a1e7-868e9d29bb6d"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=406182d4-d924-468b-9de1-34845b7f35b1"
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
    "id": "5e1766bb-f5f3-4ffb-bad9-8ac44993114b",
    "type": "menus",
    "attributes": {
      "created_at": "2022-10-13T08:57:33+00:00",
      "updated_at": "2022-10-13T08:57:33+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/19191285-af63-44a7-86c7-1d2613a5e456' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "19191285-af63-44a7-86c7-1d2613a5e456",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "baac748e-96c0-450c-9fe5-e7e5ece5b2f9",
              "title": "Contact us"
            },
            {
              "id": "0d6c92ed-3fd2-4db3-8ffa-145dc407df1b",
              "title": "Start"
            },
            {
              "id": "94f25668-4b51-4be2-98d6-ad18a4a07039",
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
    "id": "19191285-af63-44a7-86c7-1d2613a5e456",
    "type": "menus",
    "attributes": {
      "created_at": "2022-10-13T08:57:34+00:00",
      "updated_at": "2022-10-13T08:57:34+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "baac748e-96c0-450c-9fe5-e7e5ece5b2f9"
          },
          {
            "type": "menu_items",
            "id": "0d6c92ed-3fd2-4db3-8ffa-145dc407df1b"
          },
          {
            "type": "menu_items",
            "id": "94f25668-4b51-4be2-98d6-ad18a4a07039"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "baac748e-96c0-450c-9fe5-e7e5ece5b2f9",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-10-13T08:57:34+00:00",
        "updated_at": "2022-10-13T08:57:34+00:00",
        "menu_id": "19191285-af63-44a7-86c7-1d2613a5e456",
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
      "id": "0d6c92ed-3fd2-4db3-8ffa-145dc407df1b",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-10-13T08:57:34+00:00",
        "updated_at": "2022-10-13T08:57:34+00:00",
        "menu_id": "19191285-af63-44a7-86c7-1d2613a5e456",
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
      "id": "94f25668-4b51-4be2-98d6-ad18a4a07039",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-10-13T08:57:34+00:00",
        "updated_at": "2022-10-13T08:57:34+00:00",
        "menu_id": "19191285-af63-44a7-86c7-1d2613a5e456",
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
    --url 'https://example.booqable.com/api/boomerang/menus/bb908e65-4066-4ba2-81cc-ddb62d4e60b2' \
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