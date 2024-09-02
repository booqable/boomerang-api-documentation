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
      "id": "dd87e5e0-576e-4258-82d0-20315f7e69cd",
      "type": "menus",
      "attributes": {
        "created_at": "2024-09-02T09:26:35.595439+00:00",
        "updated_at": "2024-09-02T09:26:35.595439+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/44e73532-90ed-4509-8f0e-2c12e1841118?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "44e73532-90ed-4509-8f0e-2c12e1841118",
    "type": "menus",
    "attributes": {
      "created_at": "2024-09-02T09:26:35.136787+00:00",
      "updated_at": "2024-09-02T09:26:35.136787+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "8e3e1d26-4657-43cb-b224-58bf0b044ca0"
          },
          {
            "type": "menu_items",
            "id": "c7c9a564-c229-40d4-a1f7-5f06f22118aa"
          },
          {
            "type": "menu_items",
            "id": "4897c221-947f-4a44-b717-1398f819c807"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "8e3e1d26-4657-43cb-b224-58bf0b044ca0",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-09-02T09:26:35.138510+00:00",
        "updated_at": "2024-09-02T09:26:35.138510+00:00",
        "menu_id": "44e73532-90ed-4509-8f0e-2c12e1841118",
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
      "id": "c7c9a564-c229-40d4-a1f7-5f06f22118aa",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-09-02T09:26:35.140390+00:00",
        "updated_at": "2024-09-02T09:26:35.140390+00:00",
        "menu_id": "44e73532-90ed-4509-8f0e-2c12e1841118",
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
      "id": "4897c221-947f-4a44-b717-1398f819c807",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-09-02T09:26:35.141903+00:00",
        "updated_at": "2024-09-02T09:26:35.141903+00:00",
        "menu_id": "44e73532-90ed-4509-8f0e-2c12e1841118",
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
    "id": "47e95570-4761-45f2-9c75-ef52529677b6",
    "type": "menus",
    "attributes": {
      "created_at": "2024-09-02T09:26:34.241008+00:00",
      "updated_at": "2024-09-02T09:26:34.241008+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/a3c0a029-4b0b-4478-ab21-dd6e63d9f87d' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "a3c0a029-4b0b-4478-ab21-dd6e63d9f87d",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "54368413-e867-40cf-a3ff-898151011227",
              "title": "Contact us"
            },
            {
              "id": "048e29cf-9caf-4458-a6ea-87936745dddf",
              "title": "Start"
            },
            {
              "id": "976125d7-6fdb-4372-8b07-c4455907eb90",
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
    "id": "a3c0a029-4b0b-4478-ab21-dd6e63d9f87d",
    "type": "menus",
    "attributes": {
      "created_at": "2024-09-02T09:26:33.714848+00:00",
      "updated_at": "2024-09-02T09:26:33.759686+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "54368413-e867-40cf-a3ff-898151011227"
          },
          {
            "type": "menu_items",
            "id": "048e29cf-9caf-4458-a6ea-87936745dddf"
          },
          {
            "type": "menu_items",
            "id": "976125d7-6fdb-4372-8b07-c4455907eb90"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "54368413-e867-40cf-a3ff-898151011227",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-09-02T09:26:33.716762+00:00",
        "updated_at": "2024-09-02T09:26:33.761570+00:00",
        "menu_id": "a3c0a029-4b0b-4478-ab21-dd6e63d9f87d",
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
      "id": "048e29cf-9caf-4458-a6ea-87936745dddf",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-09-02T09:26:33.718767+00:00",
        "updated_at": "2024-09-02T09:26:33.763170+00:00",
        "menu_id": "a3c0a029-4b0b-4478-ab21-dd6e63d9f87d",
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
      "id": "976125d7-6fdb-4372-8b07-c4455907eb90",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-09-02T09:26:33.720243+00:00",
        "updated_at": "2024-09-02T09:26:33.764589+00:00",
        "menu_id": "a3c0a029-4b0b-4478-ab21-dd6e63d9f87d",
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
    --url 'https://example.booqable.com/api/boomerang/menus/79469292-6db2-4a26-a48d-0b2251bdc1b5' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "79469292-6db2-4a26-a48d-0b2251bdc1b5",
    "type": "menus",
    "attributes": {
      "created_at": "2024-09-02T09:26:34.683580+00:00",
      "updated_at": "2024-09-02T09:26:34.683580+00:00",
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