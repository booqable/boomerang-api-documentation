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
-- | --
`id` | **Uuid** `readonly`<br>Primary key
`created_at` | **Datetime** `readonly`<br>When the resource was created
`updated_at` | **Datetime** `readonly`<br>When the resource was last updated
`title` | **String** <br>Name of the menu.
`key` | **String** <br>Key the menu can be referenced by.
`menu_items_attributes` | **Array** `writeonly`<br>Attributes of child menu items to be created or changed.


## Relationships
Menus have the following relationships:

Name | Description
-- | --
`menu_items` | **[Menu items](#menu-items)** <br>Associated Menu items


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
      "id": "00ad6385-e547-4bb2-8b3a-891ab20f2f0c",
      "type": "menus",
      "attributes": {
        "created_at": "2024-12-02T09:23:20.436585+00:00",
        "updated_at": "2024-12-02T09:23:20.436585+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {}
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
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=menu_items`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[menus]=created_at,updated_at,title`
`filter` | **Hash** <br>The filters to apply `?filter[attribute][eq]=value`
`sort` | **String** <br>How to sort the data `?sort=attribute1,-attribute2`
`meta` | **Hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String** <br>The page to request
`page[size]` | **String** <br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
-- | --
`id` | **Uuid** <br>`eq`, `not_eq`
`created_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`title` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`key` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **Array** <br>`count`


### Includes

This request accepts the following includes:

`menu_items` => 
`menu_items` => 
`menu_items`










## Fetching a menu



> How to fetch a menu with it's items:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/menus/cf51247b-068f-4464-a04d-e81c0ed34c36?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "cf51247b-068f-4464-a04d-e81c0ed34c36",
    "type": "menus",
    "attributes": {
      "created_at": "2024-12-02T09:23:21.266108+00:00",
      "updated_at": "2024-12-02T09:23:21.266108+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "687f0bb1-cf90-4bce-940b-fc218adbb5c4"
          },
          {
            "type": "menu_items",
            "id": "7f09ac1c-5497-4e1f-aa46-fda9d8f11ccf"
          },
          {
            "type": "menu_items",
            "id": "8d9e3b13-67fc-4f6c-bdbd-6c2ae9075d3a"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "687f0bb1-cf90-4bce-940b-fc218adbb5c4",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-12-02T09:23:21.267473+00:00",
        "updated_at": "2024-12-02T09:23:21.267473+00:00",
        "menu_id": "cf51247b-068f-4464-a04d-e81c0ed34c36",
        "parent_menu_item_id": null,
        "title": "About us",
        "value": "/about-us",
        "target_id": null,
        "target_type": "Static",
        "generate_sub_menu_items": false,
        "generated": false,
        "sorting_weight": null
      },
      "relationships": {}
    },
    {
      "id": "7f09ac1c-5497-4e1f-aa46-fda9d8f11ccf",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-12-02T09:23:21.269061+00:00",
        "updated_at": "2024-12-02T09:23:21.269061+00:00",
        "menu_id": "cf51247b-068f-4464-a04d-e81c0ed34c36",
        "parent_menu_item_id": null,
        "title": "Home",
        "value": "/",
        "target_id": null,
        "target_type": "Static",
        "generate_sub_menu_items": false,
        "generated": false,
        "sorting_weight": null
      },
      "relationships": {}
    },
    {
      "id": "8d9e3b13-67fc-4f6c-bdbd-6c2ae9075d3a",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-12-02T09:23:21.270379+00:00",
        "updated_at": "2024-12-02T09:23:21.270379+00:00",
        "menu_id": "cf51247b-068f-4464-a04d-e81c0ed34c36",
        "parent_menu_item_id": null,
        "title": "Rentals",
        "value": "/products",
        "target_id": null,
        "target_type": "Static",
        "generate_sub_menu_items": false,
        "generated": false,
        "sorting_weight": null
      },
      "relationships": {}
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
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=menu_items`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[menus]=created_at,updated_at,title`


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
    "id": "f4c83283-2176-4907-980c-ce8a6dd05b10",
    "type": "menus",
    "attributes": {
      "created_at": "2024-12-02T09:23:19.594415+00:00",
      "updated_at": "2024-12-02T09:23:19.594415+00:00",
      "title": "Header menu",
      "key": "header"
    },
    "relationships": {}
  },
  "meta": {}
}
```

### HTTP Request

`POST /api/boomerang/menus`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=menu_items`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[menus]=created_at,updated_at,title`


### Request body

This request accepts the following body:

Name | Description
-- | --
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
    --url 'https://example.booqable.com/api/boomerang/menus/5f118bb2-8d00-4599-b451-fbb41cbacdb3' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "5f118bb2-8d00-4599-b451-fbb41cbacdb3",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "e7ff834b-616f-49d6-ba8e-b578f8710ec6",
              "title": "Contact us"
            },
            {
              "id": "573c9628-1edb-45bb-994b-efc88015e15b",
              "title": "Start"
            },
            {
              "id": "706452f9-3c44-44c3-9109-29273e594d3f",
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
    "id": "5f118bb2-8d00-4599-b451-fbb41cbacdb3",
    "type": "menus",
    "attributes": {
      "created_at": "2024-12-02T09:23:19.944145+00:00",
      "updated_at": "2024-12-02T09:23:19.989439+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "e7ff834b-616f-49d6-ba8e-b578f8710ec6"
          },
          {
            "type": "menu_items",
            "id": "573c9628-1edb-45bb-994b-efc88015e15b"
          },
          {
            "type": "menu_items",
            "id": "706452f9-3c44-44c3-9109-29273e594d3f"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "e7ff834b-616f-49d6-ba8e-b578f8710ec6",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-12-02T09:23:19.946100+00:00",
        "updated_at": "2024-12-02T09:23:19.991632+00:00",
        "menu_id": "5f118bb2-8d00-4599-b451-fbb41cbacdb3",
        "parent_menu_item_id": null,
        "title": "Contact us",
        "value": "/about-us",
        "target_id": null,
        "target_type": "Static",
        "generate_sub_menu_items": false,
        "generated": false,
        "sorting_weight": null
      },
      "relationships": {}
    },
    {
      "id": "573c9628-1edb-45bb-994b-efc88015e15b",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-12-02T09:23:19.948346+00:00",
        "updated_at": "2024-12-02T09:23:19.993576+00:00",
        "menu_id": "5f118bb2-8d00-4599-b451-fbb41cbacdb3",
        "parent_menu_item_id": null,
        "title": "Start",
        "value": "/",
        "target_id": null,
        "target_type": "Static",
        "generate_sub_menu_items": false,
        "generated": false,
        "sorting_weight": null
      },
      "relationships": {}
    },
    {
      "id": "706452f9-3c44-44c3-9109-29273e594d3f",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-12-02T09:23:19.950370+00:00",
        "updated_at": "2024-12-02T09:23:19.995344+00:00",
        "menu_id": "5f118bb2-8d00-4599-b451-fbb41cbacdb3",
        "parent_menu_item_id": null,
        "title": "Rent from us",
        "value": "/products",
        "target_id": null,
        "target_type": "Static",
        "generate_sub_menu_items": false,
        "generated": false,
        "sorting_weight": null
      },
      "relationships": {}
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
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=menu_items`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[menus]=created_at,updated_at,title`


### Request body

This request accepts the following body:

Name | Description
-- | --
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
    --url 'https://example.booqable.com/api/boomerang/menus/2dcf8f87-c3f8-4c16-97a1-f91758c2a316' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "2dcf8f87-c3f8-4c16-97a1-f91758c2a316",
    "type": "menus",
    "attributes": {
      "created_at": "2024-12-02T09:23:20.909827+00:00",
      "updated_at": "2024-12-02T09:23:20.909827+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {}
  },
  "meta": {}
}
```

### HTTP Request

`DELETE /api/boomerang/menus/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[menus]=created_at,updated_at,title`


### Includes

This request does not accept any includes