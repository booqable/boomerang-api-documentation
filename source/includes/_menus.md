# Menus

Allows creating and managing menus for your shop.

## Relationships
Name | Description
-- | --
`menu_items` | **[Menu items](#menu-items)** `hasmany`<br>The menu items inside this menu. <br/> Menu items can be created/updated through the menu resource by writing the `menu_items_attributes` attributes. 


Check matching attributes under [Fields](#menus-fields) to see which relations can be written.
<br/ >
Check each individual operation to see which relations can be included as a sideload.
## Fields

 Name | Description
-- | --
`created_at` | **datetime** `readonly`<br>When the resource was created.
`id` | **uuid** `readonly`<br>Primary key.
`key` | **string** <br>Key the menu can be referenced by. 
`menu_items_attributes` | **array** `writeonly`<br>Attributes of child menu items to be created or changed. 
`title` | **string** <br>Name of the menu. 
`updated_at` | **datetime** `readonly`<br>When the resource was last updated.


## List menus


> How to fetch a list of menus:

```shell
  curl --get 'https://example.booqable.com/api/4/menus'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": [
      {
        "id": "47de8124-76c7-4c70-8dd4-e193e10d8a83",
        "type": "menus",
        "attributes": {
          "created_at": "2026-10-21T15:03:03.000000+00:00",
          "updated_at": "2026-10-21T15:03:03.000000+00:00",
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
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[menus]=created_at,updated_at,title`
`filter` | **hash** <br>The filters to apply `?filter[attribute][eq]=value`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=menu_items`
`meta` | **hash** <br>Metadata to send along. `?meta[total][]=count`
`page[number]` | **string** <br>The page to request.
`page[size]` | **string** <br>The amount of items per page.
`sort` | **string** <br>How to sort the data. `?sort=attribute1,-attribute2`


### Filters

This request can be filtered on:

Name | Description
-- | --
`created_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`id` | **uuid** <br>`eq`, `not_eq`
`key` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`title` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`updated_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **array** <br>`count`


### Includes

This request accepts the following includes:

<ul>
  <li>
    <code>menu_items</code>
    <ul>
      <li>
          <code>menu_items</code>
          <ul>
            <li><code>menu_items</code></li>
          </ul>
      </li>
    </ul>
  </li>
</ul>


## Fetch a menu


> How to fetch a menu with it's items:

```shell
  curl --get 'https://example.booqable.com/api/4/menus/2eb56457-180f-43b7-8c3f-a98b59a2c2f8'
       --header 'content-type: application/json'
       --data-urlencode 'include=menu_items'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "2eb56457-180f-43b7-8c3f-a98b59a2c2f8",
      "type": "menus",
      "attributes": {
        "created_at": "2027-02-22T04:06:00.000000+00:00",
        "updated_at": "2027-02-22T04:06:00.000000+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "data": [
            {
              "type": "menu_items",
              "id": "5ef7931b-cd45-4cf4-87af-44208dfbdc70"
            },
            {
              "type": "menu_items",
              "id": "0b136dc9-a2cd-4afd-86cf-d338e77d6a33"
            },
            {
              "type": "menu_items",
              "id": "17e2ef54-8fad-479f-89b5-56ea9c192dbf"
            }
          ]
        }
      }
    },
    "included": [
      {
        "id": "5ef7931b-cd45-4cf4-87af-44208dfbdc70",
        "type": "menu_items",
        "attributes": {
          "created_at": "2027-02-22T04:06:00.000000+00:00",
          "updated_at": "2027-02-22T04:06:00.000000+00:00",
          "menu_id": "2eb56457-180f-43b7-8c3f-a98b59a2c2f8",
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
        "id": "0b136dc9-a2cd-4afd-86cf-d338e77d6a33",
        "type": "menu_items",
        "attributes": {
          "created_at": "2027-02-22T04:06:00.000000+00:00",
          "updated_at": "2027-02-22T04:06:00.000000+00:00",
          "menu_id": "2eb56457-180f-43b7-8c3f-a98b59a2c2f8",
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
        "id": "17e2ef54-8fad-479f-89b5-56ea9c192dbf",
        "type": "menu_items",
        "attributes": {
          "created_at": "2027-02-22T04:06:00.000000+00:00",
          "updated_at": "2027-02-22T04:06:00.000000+00:00",
          "menu_id": "2eb56457-180f-43b7-8c3f-a98b59a2c2f8",
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
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[menus]=created_at,updated_at,title`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=menu_items`


### Includes

This request accepts the following includes:

<ul>
  <li><code>menu_items</code></li>
</ul>


## Create a menu with items


> How to create a menu with menu items:

```shell
  curl --request POST
       --url 'https://example.booqable.com/api/4/menus'
       --header 'content-type: application/json'
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
      "id": "aae7d0d8-1016-4447-8186-cd85ff781c72",
      "type": "menus",
      "attributes": {
        "created_at": "2016-12-25T01:06:00.000000+00:00",
        "updated_at": "2016-12-25T01:06:00.000000+00:00",
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
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[menus]=created_at,updated_at,title`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=menu_items`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][key]` | **string** <br>Key the menu can be referenced by. 
`data[attributes][menu_items_attributes][]` | **array** <br>Attributes of child menu items to be created or changed. 
`data[attributes][title]` | **string** <br>Name of the menu. 


### Includes

This request accepts the following includes:

<ul>
  <li>
    <code>menu_items</code>
    <ul>
      <li>
          <code>menu_items</code>
          <ul>
            <li><code>menu_items</code></li>
          </ul>
      </li>
    </ul>
  </li>
</ul>


## Update a menu and its items


> How to update a menu with nested menu items:

```shell
  curl --request PUT
       --url 'https://example.booqable.com/api/4/menus/dc0609dc-2052-4f73-8ea2-6297fd7fff67'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "id": "dc0609dc-2052-4f73-8ea2-6297fd7fff67",
           "type": "menus",
           "attributes": {
             "title": "Header menu",
             "menu_items_attributes": [
               {
                 "id": "4b5212e3-68d4-4eeb-8465-6171b82ce2ae",
                 "title": "Contact us"
               },
               {
                 "id": "38c3bfdc-4a26-4c9a-8286-d22cf0f0c9df",
                 "title": "Start"
               },
               {
                 "id": "82d55a1e-b4cc-46f0-8861-5c8b60f27934",
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
      "id": "dc0609dc-2052-4f73-8ea2-6297fd7fff67",
      "type": "menus",
      "attributes": {
        "created_at": "2015-11-12T02:35:00.000000+00:00",
        "updated_at": "2015-11-12T02:35:00.000000+00:00",
        "title": "Header menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "data": [
            {
              "type": "menu_items",
              "id": "4b5212e3-68d4-4eeb-8465-6171b82ce2ae"
            },
            {
              "type": "menu_items",
              "id": "38c3bfdc-4a26-4c9a-8286-d22cf0f0c9df"
            },
            {
              "type": "menu_items",
              "id": "82d55a1e-b4cc-46f0-8861-5c8b60f27934"
            }
          ]
        }
      }
    },
    "included": [
      {
        "id": "4b5212e3-68d4-4eeb-8465-6171b82ce2ae",
        "type": "menu_items",
        "attributes": {
          "created_at": "2015-11-12T02:35:00.000000+00:00",
          "updated_at": "2015-11-12T02:35:00.000000+00:00",
          "menu_id": "dc0609dc-2052-4f73-8ea2-6297fd7fff67",
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
        "id": "38c3bfdc-4a26-4c9a-8286-d22cf0f0c9df",
        "type": "menu_items",
        "attributes": {
          "created_at": "2015-11-12T02:35:00.000000+00:00",
          "updated_at": "2015-11-12T02:35:00.000000+00:00",
          "menu_id": "dc0609dc-2052-4f73-8ea2-6297fd7fff67",
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
        "id": "82d55a1e-b4cc-46f0-8861-5c8b60f27934",
        "type": "menu_items",
        "attributes": {
          "created_at": "2015-11-12T02:35:00.000000+00:00",
          "updated_at": "2015-11-12T02:35:00.000000+00:00",
          "menu_id": "dc0609dc-2052-4f73-8ea2-6297fd7fff67",
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
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[menus]=created_at,updated_at,title`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=menu_items`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][key]` | **string** <br>Key the menu can be referenced by. 
`data[attributes][menu_items_attributes][]` | **array** <br>Attributes of child menu items to be created or changed. 
`data[attributes][title]` | **string** <br>Name of the menu. 


### Includes

This request accepts the following includes:

<ul>
  <li>
    <code>menu_items</code>
    <ul>
      <li>
          <code>menu_items</code>
          <ul>
            <li><code>menu_items</code></li>
          </ul>
      </li>
    </ul>
  </li>
</ul>


## Delete a menu


> How to delete a menu:

```shell
  curl --request DELETE
       --url 'https://example.booqable.com/api/4/menus/79334335-bb00-454a-83cb-280735693ac0'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "79334335-bb00-454a-83cb-280735693ac0",
      "type": "menus",
      "attributes": {
        "created_at": "2026-03-23T10:29:00.000000+00:00",
        "updated_at": "2026-03-23T10:29:00.000000+00:00",
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
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[menus]=created_at,updated_at,title`


### Includes

This request does not accept any includes