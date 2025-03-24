# Order fulfillments

Takes an [Order](#orders) through the fulfillment process.

## Actions

<aside class="warning">
<b>Limitation:</b> At the moment not all (types of) actions can
be combined in the same request.
</aside>

#### Book a Bundle

Books a [Bundle](#bundles) on an [Order](#orders).

For each unspecified [BundleItem](#bundle-items) a product variation needs to be selected.
Specified [BundleItems](#bundle-items) are automatically booked. These must not be included
in the request. When a [Bundle](#bundles) only contains specified [BundleItems](#bundle-items), an empty
list of product variations must be provided.

The `quantity` attribute sets the quantity of the [Bundle](#bundles) itself,
and multiplies the quantities of all products in the [Bundle](#bundles).

The `confirm_shortage` attribute (on the resource, not on the action),
overrides shortage warnings when booking on a reserved or started order.

```json
{
  "action": "book_bundle",
  "bundle_id": "<id>",
  "quantity": N,
  "product_variations": [
    {
      "bundle_item_id": "<id>",
      "product_id": "<id>"
    },
    {
      "bundle_item_id": "<id>",
      "product_id": "<id>"
    }
  ]
}
```

#### Book a Product

Books a quantity of a Product on an Order. This can be any
type of Product, including trackable Products.

This action supports 3 modes:
- `create_new`, a new Planning and Line are created.
- `update_existing`, the quantity is added to an existing Planning/Line
- `infer_planning`, behaves as `update_existing` when a Planning for
  the same Product exists. Behaves as `create_new` when there is no
  existing Planning for the Product.

The `confirm_shortage` attribute (on the resource, not on the action),
overrides shortage warnings when booking on a reserved or started order.

```json
{
  "action": "book_product",
  "mode": "create_new",
  "planning_id": "<id>",  // required for `mode==update_existing`
  "product_id": "<id>",
  "quantity": N,
}
```

#### Book StockItems

Books one or more StockItems of a trackable Product on an Order.

This action supports 3 modes:
- `create_new`, a new Planning and Line are created.
- `update_existing`, the StockItems are booked on an existing Planning/Line.
  If needed, the quantity of the Planning is increased to accomodate all
  newly booked StockItems.
- `infer_planning`, behaves as `update_existing` when a Planning for
  the same Product exists. Behaves as `create_new` when there is no
  existing Planning for the Product.

The `confirm_shortage` attribute (on the resource, not on the action),
overrides shortage warnings when booking on a reserved or started order.

```json
{
  "action": "book_stock_items",
  "stock_item_ids": ["<id>"],
  "planning_id": "<id>",  // required for `mode==update_existing`
  "product_id": "<id>",
  "mode": "infer_planning",
}
```

#### Specify StockItems

Adds or removes one or more StockItems from an existing Planning.

It is not possible to specify more StockItems than there is
remaining quantity left on the Planning.
[StockItems](#stock-items) that have already been started cannot be removed.

```json
{
  "action": "specify_stock_items",
  "product_id": "<id>",
  "planning_id": "<id>",
  "stock_item_ids_to_add": ["<id>", "<id>"],
  "stock_item_ids_to_remove": ["<id>", "<id>"]
}
```

When removing StockItems, the archived StockItemPlannings are returned
as part of the `changed_stock_item_plannings` relation.

#### Start a Product

A quantity of a product is started. The quantity can
be the same as the booked quantity, or less when
a subset of items is started.

The `confirm_shortage` attribute (on the resource, not on the action),
overrides shortage warnings when booking on a reserved or started order.

```json
{
  "action": "start_product",
  "product_id": "<id>",
  "planning_id": "<id>",
  "quantity": N
}
```

#### Start StockItems

One or more stock items of a trackable product are started.

The `confirm_shortage` attribute (on the resource, not on the action),
overrides shortage warnings when booking on a reserved or started order.

```json
{
  "action": "start_stock_items",
  "product_id": "<id>",
  "planning_id": "<id>",
  "stock_item_ids": ["<id>", "<id>"]
}
```

#### Stop a Product

A quantity of a product is returned. The
product needs to have started. The quantity can
be the same as the started quantity, or less when
a subset of items is returned.

Consumables and Services cannot be stopped.

```json
{
  "action": "stop_product",
  "product_id": "<id>",
  "planning_id": "<id>",
  "quantity": N
}
```

#### Stop StockItems

One or more stock items of a trackable product are returned.
Only stock items that have been started can be stopped.

```json
{
  "action": "stop_stock_items",
  "product_id": "<id>",
  "planning_id": "<id>",
  "stock_item_ids": ["<id>", "<id>"]
}
```

## Errors

Booking and starting items can be blocked by shortage
errors and other kinds of inventory errors.

## Relationships
Name | Description
-- | --
`changed_lines` | **[Lines](#lines)** `hasmany`<br>The [Lines](#lines) that have (indirectly) been created or changed by the fulfillment actions. 
`changed_plannings` | **[Plannings](#plannings)** `hasmany`<br>The [Plannings](#plannings) that have (indirectly) been created or changed by the fulfillment actions. 
`changed_stock_item_plannings` | **[Stock item plannings](#stock-item-plannings)** `hasmany`<br>The [StockItemPlannings](#stock-item-plannings) that have (indirectly) been created or changed by the fulfillment actions. 
`order` | **[Order](#orders)** `required`<br>The [Order](#orders) to be fulfilled. 


Check matching attributes under [Fields](#order-fulfillments-fields) to see which relations can be written.
<br/ >
Check each individual operation to see which relations can be included as a sideload.
## Fields

 Name | Description
-- | --
`actions` | **array** `writeonly`<br>Array of actions to be performed. The actions are executed atomically, and succeed as a whole, or fail as a whole. 
`confirm_shortage` | **boolean** `writeonly`<br>A value of `true` overrides shortage warnings when booking products on a reserved or started [Order](#orders). 
`id` | **uuid** `readonly`<br>Primary key.
`order_id` | **uuid** `readonly-after-create`<br>The [Order](#orders) to be fulfilled. 


## Book


> Book a Product (on a new Planning):

```shell
  curl --request POST
       --url 'https://example.booqable.com/api/boomerang/order_fulfillments'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "type": "order_fulfillments",
           "attributes": {
             "order_id": "ff0e6b03-a401-4136-878d-03515e0a3506",
             "confirm_shortage": null,
             "actions": [
               {
                 "action": "book_product",
                 "mode": "create_new",
                 "product_id": "58f2c5fd-6ac5-4557-82b8-4c33a2d89335",
                 "quantity": 3
               }
             ]
           }
         }
       }'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "b19330e5-df47-4444-86b2-67785dd806ab",
      "type": "order_fulfillments",
      "attributes": {
        "order_id": "ff0e6b03-a401-4136-878d-03515e0a3506"
      },
      "relationships": {}
    },
    "meta": {}
  }
```

> Book a Product (on an existing Planning if there is any):

```shell
  curl --request POST
       --url 'https://example.booqable.com/api/boomerang/order_fulfillments'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "type": "order_fulfillments",
           "attributes": {
             "order_id": "89ac038f-2546-4b89-8e0b-1ff27baca905",
             "confirm_shortage": null,
             "actions": [
               {
                 "action": "book_product",
                 "mode": "infer_planning",
                 "product_id": "b495248c-6a73-4745-8921-839868860e99",
                 "planning_id": null,
                 "quantity": 3
               }
             ]
           }
         }
       }'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "6c4f57c9-8c1c-4e4d-8ccd-d681eb651f43",
      "type": "order_fulfillments",
      "attributes": {
        "order_id": "89ac038f-2546-4b89-8e0b-1ff27baca905"
      },
      "relationships": {}
    },
    "meta": {}
  }
```

> Book a Product (on a specified Planning):

```shell
  curl --request POST
       --url 'https://example.booqable.com/api/boomerang/order_fulfillments'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "type": "order_fulfillments",
           "attributes": {
             "order_id": "157cec54-7cba-4324-85f7-eff41c768bab",
             "confirm_shortage": null,
             "actions": [
               {
                 "action": "book_product",
                 "mode": "update_existing",
                 "product_id": "965c1191-d5fa-4a9b-848c-fe79ad1d5594",
                 "planning_id": "08e98893-bab0-41b3-8913-ef8719114ef5",
                 "quantity": 3
               }
             ]
           }
         }
       }'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "3dc24c42-ceeb-4922-8fe9-cea120a58529",
      "type": "order_fulfillments",
      "attributes": {
        "order_id": "157cec54-7cba-4324-85f7-eff41c768bab"
      },
      "relationships": {}
    },
    "meta": {}
  }
```

> Book StockItems:

```shell
  curl --request POST
       --url 'https://example.booqable.com/api/boomerang/order_fulfillments'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "type": "order_fulfillments",
           "attributes": {
             "order_id": "3d6a2dd6-55e4-4d4c-8072-e885f8315a7d",
             "confirm_shortage": null,
             "actions": [
               {
                 "action": "book_stock_items",
                 "mode": "infer_planning",
                 "product_id": "8c9026b0-3f2d-4769-8658-1bbb8a272b80",
                 "stock_item_ids": [
                   "57720425-1bd2-4475-85ac-3341b8efb4dc",
                   "cd8f2e40-ff1b-47f7-8214-ba69e52251ed"
                 ]
               }
             ]
           }
         }
       }'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "3ae75561-67df-49a3-80e2-3bb12a12ed2b",
      "type": "order_fulfillments",
      "attributes": {
        "order_id": "3d6a2dd6-55e4-4d4c-8072-e885f8315a7d"
      },
      "relationships": {}
    },
    "meta": {}
  }
```

> Book a Bundle:

```shell
  curl --request POST
       --url 'https://example.booqable.com/api/boomerang/order_fulfillments'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "type": "order_fulfillments",
           "attributes": {
             "order_id": "b1d40ff0-0ab6-4316-83f7-6603b72c3c0b",
             "confirm_shortage": null,
             "actions": [
               {
                 "action": "book_bundle",
                 "bundle_id": "1e5e1bd0-f59a-42a5-85ef-20d318221df3",
                 "quantity": 1,
                 "product_variations": [
                   {
                     "bundle_item_id": "09afe94a-0976-40b4-8993-b5caddafedd4",
                     "product_id": "97f7f012-d0e9-4c03-82a6-af889c86f673"
                   }
                 ]
               }
             ]
           }
         }
       }'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "bf2f5b82-4ee5-47d2-866a-c48bacca6d24",
      "type": "order_fulfillments",
      "attributes": {
        "order_id": "b1d40ff0-0ab6-4316-83f7-6603b72c3c0b"
      },
      "relationships": {}
    },
    "meta": {}
  }
```

### HTTP Request

`POST /api/boomerang/order_fulfillments`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[order_fulfillments]=order_id`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=order,changed_lines,changed_plannings`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][actions][]` | **array** <br>Array of actions to be performed. The actions are executed atomically, and succeed as a whole, or fail as a whole. 
`data[attributes][confirm_shortage]` | **boolean** <br>A value of `true` overrides shortage warnings when booking products on a reserved or started [Order](#orders). 
`data[attributes][order_id]` | **uuid** <br>The [Order](#orders) to be fulfilled. 


### Includes

This request accepts the following includes:

`order` => 
`tax_values`


`transfers`




`changed_lines` => 
`item` => 
`photo`






`changed_plannings`


`changed_stock_item_plannings` => 
`stock_item`








## Specify


> Add a StockItem:

```shell
  curl --request POST
       --url 'https://example.booqable.com/api/boomerang/order_fulfillments'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "type": "order_fulfillments",
           "attributes": {
             "order_id": "3c6bb0a1-73c7-4087-8437-35dc26e866de",
             "actions": [
               {
                 "action": "specify_stock_items",
                 "product_id": "c34c820b-79b4-4c39-8a00-471d67934308",
                 "planning_id": "4b6038b6-5a01-4af0-83ec-0468429660c6",
                 "stock_item_ids_to_add": [
                   "5bb20b10-c7e9-4b2f-8a04-48aa9f12f117"
                 ],
                 "stock_item_ids_to_remove": []
               }
             ]
           }
         }
       }'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "989891a6-cab1-4a93-8d5f-ea2bc4703ad0",
      "type": "order_fulfillments",
      "attributes": {
        "order_id": "3c6bb0a1-73c7-4087-8437-35dc26e866de"
      },
      "relationships": {}
    },
    "meta": {}
  }
```

> Remove a StockItem:

```shell
  curl --request POST
       --url 'https://example.booqable.com/api/boomerang/order_fulfillments'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "type": "order_fulfillments",
           "attributes": {
             "order_id": "fd750947-416c-4da3-8158-cf456b81dc87",
             "actions": [
               {
                 "action": "specify_stock_items",
                 "product_id": "45cd8238-74d4-4f33-836f-31a80860316a",
                 "planning_id": "efda8344-0d43-4bf2-8360-2eaf863301df",
                 "stock_item_ids_to_add": [],
                 "stock_item_ids_to_remove": [
                   "1cf99ea9-3582-4711-8d60-f289187d90b5"
                 ]
               }
             ]
           }
         },
         "include": "changed_stock_item_plannings"
       }'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "16ff306e-ebff-4248-8533-bb32ff205846",
      "type": "order_fulfillments",
      "attributes": {
        "order_id": "fd750947-416c-4da3-8158-cf456b81dc87"
      },
      "relationships": {
        "changed_stock_item_plannings": {
          "data": [
            {
              "type": "stock_item_plannings",
              "id": "43523e16-c1e3-4352-8ab5-c90542c2f035"
            }
          ]
        }
      }
    },
    "included": [
      {
        "id": "43523e16-c1e3-4352-8ab5-c90542c2f035",
        "type": "stock_item_plannings",
        "attributes": {
          "created_at": "2016-07-05T01:17:01.000000+00:00",
          "updated_at": "2016-07-05T01:17:01.000000+00:00",
          "archived": true,
          "archived_at": "2016-07-05T01:17:01.000000+00:00",
          "reserved": false,
          "started": false,
          "stopped": false,
          "stock_item_id": "1cf99ea9-3582-4711-8d60-f289187d90b5",
          "planning_id": "efda8344-0d43-4bf2-8360-2eaf863301df",
          "order_id": "fd750947-416c-4da3-8158-cf456b81dc87"
        },
        "relationships": {}
      }
    ],
    "meta": {}
  }
```

### HTTP Request

`POST /api/boomerang/order_fulfillments`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[order_fulfillments]=order_id`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=order,changed_lines,changed_plannings`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][actions][]` | **array** <br>Array of actions to be performed. The actions are executed atomically, and succeed as a whole, or fail as a whole. 
`data[attributes][confirm_shortage]` | **boolean** <br>A value of `true` overrides shortage warnings when booking products on a reserved or started [Order](#orders). 
`data[attributes][order_id]` | **uuid** <br>The [Order](#orders) to be fulfilled. 


### Includes

This request accepts the following includes:

`order` => 
`tax_values`


`transfers`




`changed_lines` => 
`item` => 
`photo`






`changed_plannings`


`changed_stock_item_plannings` => 
`stock_item`








## Start


> Start a Product:

```shell
  curl --request POST
       --url 'https://example.booqable.com/api/boomerang/order_fulfillments'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "type": "order_fulfillments",
           "attributes": {
             "order_id": "a9d2797d-f82f-4ca0-8f3a-8fc4e84e499a",
             "confirm_shortage": null,
             "actions": [
               {
                 "action": "start_product",
                 "product_id": "3aa6808c-eb63-4f82-8c19-a65e206b5b18",
                 "planning_id": "ce05c511-c28f-4a58-8d1c-23cc25bfec2a",
                 "quantity": 1
               }
             ]
           }
         }
       }'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "5c62cc0f-134c-43a1-8d05-0a531f4bedcd",
      "type": "order_fulfillments",
      "attributes": {
        "order_id": "a9d2797d-f82f-4ca0-8f3a-8fc4e84e499a"
      },
      "relationships": {}
    },
    "meta": {}
  }
```

> Start StockItems:

```shell
  curl --request POST
       --url 'https://example.booqable.com/api/boomerang/order_fulfillments'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "type": "order_fulfillments",
           "attributes": {
             "order_id": "69b468c6-e985-416f-897c-33103eb875b3",
             "confirm_shortage": null,
             "actions": [
               {
                 "action": "start_stock_items",
                 "product_id": "df12b4c9-8a40-4d3c-86ca-cb26ad8c478a",
                 "planning_id": "964a14e3-4d5a-4466-8ba7-205f25d4797d",
                 "stock_item_ids": [
                   "fc165af7-9778-4d13-8fdb-fc647e19a9e3"
                 ]
               }
             ]
           }
         }
       }'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "406efcb5-8979-43e7-8eea-b73ffd347952",
      "type": "order_fulfillments",
      "attributes": {
        "order_id": "69b468c6-e985-416f-897c-33103eb875b3"
      },
      "relationships": {}
    },
    "meta": {}
  }
```

### HTTP Request

`POST /api/boomerang/order_fulfillments`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[order_fulfillments]=order_id`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=order,changed_lines,changed_plannings`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][actions][]` | **array** <br>Array of actions to be performed. The actions are executed atomically, and succeed as a whole, or fail as a whole. 
`data[attributes][confirm_shortage]` | **boolean** <br>A value of `true` overrides shortage warnings when booking products on a reserved or started [Order](#orders). 
`data[attributes][order_id]` | **uuid** <br>The [Order](#orders) to be fulfilled. 


### Includes

This request accepts the following includes:

`order` => 
`tax_values`


`transfers`




`changed_lines` => 
`item` => 
`photo`






`changed_plannings`


`changed_stock_item_plannings` => 
`stock_item`








## Stop


> Stop a Product:

```shell
  curl --request POST
       --url 'https://example.booqable.com/api/boomerang/order_fulfillments'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "type": "order_fulfillments",
           "attributes": {
             "order_id": "a8576b48-8993-43b2-84ce-ab2403706fb9",
             "actions": [
               {
                 "action": "stop_product",
                 "product_id": "4ac65a34-99d1-423b-8389-ee49e2d7f3c6",
                 "planning_id": "8af7930b-bdab-4c3c-853b-48ba3d38d9fe",
                 "quantity": 1
               }
             ]
           }
         }
       }'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "1175185d-b612-4647-8bfd-24aa016dba47",
      "type": "order_fulfillments",
      "attributes": {
        "order_id": "a8576b48-8993-43b2-84ce-ab2403706fb9"
      },
      "relationships": {}
    },
    "meta": {}
  }
```

> Stop StockItems:

```shell
  curl --request POST
       --url 'https://example.booqable.com/api/boomerang/order_fulfillments'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "type": "order_fulfillments",
           "attributes": {
             "order_id": "7a2fbde4-94f3-4043-81b0-d6c4efe6dc39",
             "actions": [
               {
                 "action": "stop_stock_items",
                 "product_id": "9625c967-e233-4ef4-8546-78c7727754ba",
                 "planning_id": "b3c5171d-0080-443f-89f6-08984a27e706",
                 "stock_item_ids": [
                   "cda3cf3c-d51c-4f60-8868-6100ab309d69"
                 ]
               }
             ]
           }
         }
       }'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "942d8391-0f00-4a32-840c-750509db3102",
      "type": "order_fulfillments",
      "attributes": {
        "order_id": "7a2fbde4-94f3-4043-81b0-d6c4efe6dc39"
      },
      "relationships": {}
    },
    "meta": {}
  }
```

### HTTP Request

`POST /api/boomerang/order_fulfillments`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[order_fulfillments]=order_id`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=order,changed_lines,changed_plannings`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][actions][]` | **array** <br>Array of actions to be performed. The actions are executed atomically, and succeed as a whole, or fail as a whole. 
`data[attributes][confirm_shortage]` | **boolean** <br>A value of `true` overrides shortage warnings when booking products on a reserved or started [Order](#orders). 
`data[attributes][order_id]` | **uuid** <br>The [Order](#orders) to be fulfilled. 


### Includes

This request accepts the following includes:

`order` => 
`tax_values`


`transfers`




`changed_lines` => 
`item` => 
`photo`






`changed_plannings`


`changed_stock_item_plannings` => 
`stock_item`







