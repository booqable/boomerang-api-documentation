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
      "id": "521df17a-d61e-42f8-8fda-b1ab345320dc",
      "type": "menus",
      "attributes": {
        "created_at": "2023-02-13T12:13:53+00:00",
        "updated_at": "2023-02-13T12:13:53+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=521df17a-d61e-42f8-8fda-b1ab345320dc"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-13T12:12:14Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/9d5a9946-cecb-4aa6-afff-c814fcb1c00c?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "9d5a9946-cecb-4aa6-afff-c814fcb1c00c",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-13T12:13:54+00:00",
      "updated_at": "2023-02-13T12:13:54+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=9d5a9946-cecb-4aa6-afff-c814fcb1c00c"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "f970eaf4-956e-4008-92ac-f9278857f675"
          },
          {
            "type": "menu_items",
            "id": "f47374d4-4305-479a-8cd1-1e97ec5e2d9e"
          },
          {
            "type": "menu_items",
            "id": "62563e50-653b-47d4-8155-08ebcc34934a"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "f970eaf4-956e-4008-92ac-f9278857f675",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-13T12:13:54+00:00",
        "updated_at": "2023-02-13T12:13:54+00:00",
        "menu_id": "9d5a9946-cecb-4aa6-afff-c814fcb1c00c",
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
            "related": "api/boomerang/menus/9d5a9946-cecb-4aa6-afff-c814fcb1c00c"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=f970eaf4-956e-4008-92ac-f9278857f675"
          }
        }
      }
    },
    {
      "id": "f47374d4-4305-479a-8cd1-1e97ec5e2d9e",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-13T12:13:54+00:00",
        "updated_at": "2023-02-13T12:13:54+00:00",
        "menu_id": "9d5a9946-cecb-4aa6-afff-c814fcb1c00c",
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
            "related": "api/boomerang/menus/9d5a9946-cecb-4aa6-afff-c814fcb1c00c"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=f47374d4-4305-479a-8cd1-1e97ec5e2d9e"
          }
        }
      }
    },
    {
      "id": "62563e50-653b-47d4-8155-08ebcc34934a",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-13T12:13:54+00:00",
        "updated_at": "2023-02-13T12:13:54+00:00",
        "menu_id": "9d5a9946-cecb-4aa6-afff-c814fcb1c00c",
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
            "related": "api/boomerang/menus/9d5a9946-cecb-4aa6-afff-c814fcb1c00c"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=62563e50-653b-47d4-8155-08ebcc34934a"
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
    "id": "d1bc9c66-3cc4-4c79-8c08-2cefd5891fa0",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-13T12:13:54+00:00",
      "updated_at": "2023-02-13T12:13:54+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/94bcf562-6fbc-4d72-880e-8c26d68fb73b' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "94bcf562-6fbc-4d72-880e-8c26d68fb73b",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "c4929650-0ebe-49d2-9eb9-7a59d9baffd4",
              "title": "Contact us"
            },
            {
              "id": "2624630e-0e7a-4da6-a5f4-e80ac6ec75a5",
              "title": "Start"
            },
            {
              "id": "019c4341-6cd1-47c8-b371-2ffd8ac39191",
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
    "id": "94bcf562-6fbc-4d72-880e-8c26d68fb73b",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-13T12:13:55+00:00",
      "updated_at": "2023-02-13T12:13:55+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "c4929650-0ebe-49d2-9eb9-7a59d9baffd4"
          },
          {
            "type": "menu_items",
            "id": "2624630e-0e7a-4da6-a5f4-e80ac6ec75a5"
          },
          {
            "type": "menu_items",
            "id": "019c4341-6cd1-47c8-b371-2ffd8ac39191"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "c4929650-0ebe-49d2-9eb9-7a59d9baffd4",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-13T12:13:55+00:00",
        "updated_at": "2023-02-13T12:13:55+00:00",
        "menu_id": "94bcf562-6fbc-4d72-880e-8c26d68fb73b",
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
      "id": "2624630e-0e7a-4da6-a5f4-e80ac6ec75a5",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-13T12:13:55+00:00",
        "updated_at": "2023-02-13T12:13:55+00:00",
        "menu_id": "94bcf562-6fbc-4d72-880e-8c26d68fb73b",
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
      "id": "019c4341-6cd1-47c8-b371-2ffd8ac39191",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-13T12:13:55+00:00",
        "updated_at": "2023-02-13T12:13:55+00:00",
        "menu_id": "94bcf562-6fbc-4d72-880e-8c26d68fb73b",
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
    --url 'https://example.booqable.com/api/boomerang/menus/7c46a505-a9a1-4cf9-af10-f2fdaf4ec305' \
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