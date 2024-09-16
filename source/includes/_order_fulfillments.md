# Order fulfillments

Takes an Order through the fulfillment process.

## Actions

<aside class="warning">
<b>Limitation:</b> At the moment not all (types of) actions can
be combined in the same request.
</aside>

#### Book a Bundle

Books a Bundle on an Order.

For each unspecified BundleItem a product variation needs to be selected.
Specified BundleItems are automatically booked. These must not be included
in the request. When a Bundle only contains specified BundleItems, an empty
list of product variations must be provided.

The `quantity` attribute sets the quantity of the Bundle itself,
and multiplies the quantities of all products in the Bundle.

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
StockItems that have already been started can not be removed.

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

Consumables and services can not be stopped.

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

## Endpoints
`POST /api/boomerang/order_fulfillments`

## Fields
Every order fulfillment has the following fields:

Name | Description
-- | --
`id` | **Uuid** `readonly`<br>
`actions` | **Array** `writeonly`<br>Array of actions to be performed. The actions are executed atomically, and succeed as a whole, or fail as a whole. 
`confirm_shortage` | **Boolean** `writeonly`<br>A value of `true` overrides shortage warnings when booking products on a reserved or started Order. 
`order_id` | **Uuid** <br>The associated Order


## Relationships
Order fulfillments have the following relationships:

Name | Description
-- | --
`changed_lines` | **Lines** `readonly`<br>Associated Changed lines
`changed_plannings` | **Plannings** `readonly`<br>Associated Changed plannings
`changed_stock_item_plannings` | **Stock item plannings** `readonly`<br>Associated Changed stock item plannings
`order` | **Orders** `readonly`<br>Associated Order


## Book



> Book a Product (on a new Planning):

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/order_fulfillments' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "order_fulfillments",
        "attributes": {
          "order_id": "14a1b7d9-5f4c-48e8-a78e-0d30f59f779f",
          "confirm_shortage": null,
          "actions": [
            {
              "action": "book_product",
              "mode": "create_new",
              "product_id": "2bae438b-c4a2-4b05-a673-fc9484fb1c7c",
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
    "id": "1ea86611-eb8e-5cb8-8e79-a2986fea663f",
    "type": "order_fulfillments",
    "attributes": {
      "order_id": "14a1b7d9-5f4c-48e8-a78e-0d30f59f779f"
    },
    "relationships": {}
  },
  "meta": {}
}
```


> Book a Product (on an existing Planning if there is any):

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/order_fulfillments' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "order_fulfillments",
        "attributes": {
          "order_id": "92d27a25-7477-4187-bc77-6981f54c36c5",
          "confirm_shortage": null,
          "actions": [
            {
              "action": "book_product",
              "mode": "infer_planning",
              "product_id": "fdbc8255-3445-4e6b-b357-66a2f5091370",
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
    "id": "4b410a32-e52a-5fc9-bf94-ad2165cc1ee8",
    "type": "order_fulfillments",
    "attributes": {
      "order_id": "92d27a25-7477-4187-bc77-6981f54c36c5"
    },
    "relationships": {}
  },
  "meta": {}
}
```


> Book a Product (on a specified Planning):

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/order_fulfillments' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "order_fulfillments",
        "attributes": {
          "order_id": "abe3dcc2-01ff-4a79-8802-be93f9ea2bad",
          "confirm_shortage": null,
          "actions": [
            {
              "action": "book_product",
              "mode": "update_existing",
              "product_id": "89cb4259-e8e8-452f-9ecc-1a0d1250fead",
              "planning_id": "f9d0e633-61ae-44dc-a557-b93f59b745b4",
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
    "id": "c292ae23-77b3-512d-955d-1f9794381ac8",
    "type": "order_fulfillments",
    "attributes": {
      "order_id": "abe3dcc2-01ff-4a79-8802-be93f9ea2bad"
    },
    "relationships": {}
  },
  "meta": {}
}
```


> Book StockItems:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/order_fulfillments' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "order_fulfillments",
        "attributes": {
          "order_id": "665a69a8-2e03-4659-8378-e04acb6235a4",
          "confirm_shortage": null,
          "actions": [
            {
              "action": "book_stock_items",
              "mode": "infer_planning",
              "product_id": "46b4ffa0-5cd4-4f12-af28-d2c201e019d9",
              "stock_item_ids": [
                "b1180774-27dd-4f70-90c9-af6dfc2cafef",
                "684fe984-5313-4cb2-8331-27721c781ff9"
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
    "id": "1894538d-f7d4-5e75-8c2e-bb1b4af977b2",
    "type": "order_fulfillments",
    "attributes": {
      "order_id": "665a69a8-2e03-4659-8378-e04acb6235a4"
    },
    "relationships": {}
  },
  "meta": {}
}
```


> Book a Bundle:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/order_fulfillments' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "order_fulfillments",
        "attributes": {
          "order_id": "0813076c-0f5d-4501-b5e6-1494bb2f0c62",
          "confirm_shortage": null,
          "actions": [
            {
              "action": "book_bundle",
              "bundle_id": "7a7f5c18-1b2d-44c0-a663-70f90e7f328e",
              "quantity": 1,
              "product_variations": [
                {
                  "bundle_item_id": "602f52db-dc98-4d4e-aa10-a33daf604559",
                  "product_id": "7b5cd3ec-d861-4076-bd20-d9057f330554"
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
    "id": "7ba807c2-1065-5db6-8fe8-3736aa561020",
    "type": "order_fulfillments",
    "attributes": {
      "order_id": "0813076c-0f5d-4501-b5e6-1494bb2f0c62"
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
`include` | **String** <br>List of comma seperated relationships `?include=order,changed_lines,changed_plannings`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[order_fulfillments]=order_id`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][actions][]` | **Array** <br>Array of actions to be performed. The actions are executed atomically, and succeed as a whole, or fail as a whole. 
`data[attributes][confirm_shortage]` | **Boolean** <br>A value of `true` overrides shortage warnings when booking products on a reserved or started Order. 
`data[attributes][order_id]` | **Uuid** <br>The associated Order


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
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/order_fulfillments' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "order_fulfillments",
        "attributes": {
          "order_id": "b50c3660-bbf0-4c87-8b4e-e973e9f4c04d",
          "actions": [
            {
              "action": "specify_stock_items",
              "product_id": "c1b482c3-dffa-400e-93ce-e65b938a7b3f",
              "planning_id": "7b6158ca-ffd3-40ca-9f9b-2d9ecd48be9b",
              "stock_item_ids_to_add": [
                "6a61dbd6-5309-43ec-9b4c-bde42a492724"
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
    "id": "375b4da7-8c1c-5eeb-b177-5c854068f4b2",
    "type": "order_fulfillments",
    "attributes": {
      "order_id": "b50c3660-bbf0-4c87-8b4e-e973e9f4c04d"
    },
    "relationships": {}
  },
  "meta": {}
}
```


> Remove a StockItem:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/order_fulfillments' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "order_fulfillments",
        "attributes": {
          "order_id": "1f56167c-c0f0-4f8f-9f39-570c92de33bc",
          "actions": [
            {
              "action": "specify_stock_items",
              "product_id": "9456e2bd-cb45-4c08-a2cc-4c8377ddd138",
              "planning_id": "ceb7d55e-209f-4560-be49-afd0b19487b4",
              "stock_item_ids_to_add": [],
              "stock_item_ids_to_remove": [
                "6688cde8-23d3-4569-b5ab-6e03492d02f7"
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
    "id": "96cc9c91-d9ec-59af-bc58-3a296be2c7ec",
    "type": "order_fulfillments",
    "attributes": {
      "order_id": "1f56167c-c0f0-4f8f-9f39-570c92de33bc"
    },
    "relationships": {
      "changed_stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "5557b494-e04a-4bb2-92e7-84c5458252e5"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "5557b494-e04a-4bb2-92e7-84c5458252e5",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2024-09-16T09:24:54.189851+00:00",
        "updated_at": "2024-09-16T09:24:54.300809+00:00",
        "archived": true,
        "archived_at": "2024-09-16T09:24:54.294888+00:00",
        "reserved": false,
        "started": false,
        "stopped": false,
        "stock_item_id": "6688cde8-23d3-4569-b5ab-6e03492d02f7",
        "planning_id": "ceb7d55e-209f-4560-be49-afd0b19487b4",
        "order_id": "1f56167c-c0f0-4f8f-9f39-570c92de33bc"
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
`include` | **String** <br>List of comma seperated relationships `?include=order,changed_lines,changed_plannings`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[order_fulfillments]=order_id`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][actions][]` | **Array** <br>Array of actions to be performed. The actions are executed atomically, and succeed as a whole, or fail as a whole. 
`data[attributes][confirm_shortage]` | **Boolean** <br>A value of `true` overrides shortage warnings when booking products on a reserved or started Order. 
`data[attributes][order_id]` | **Uuid** <br>The associated Order


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
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/order_fulfillments' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "order_fulfillments",
        "attributes": {
          "order_id": "3baeda28-764b-45f1-a696-7684fdaff059",
          "confirm_shortage": null,
          "actions": [
            {
              "action": "start_product",
              "product_id": "eab965ff-e207-4062-8d0a-b0464e0059f0",
              "planning_id": "3a15a062-df64-4b1f-ac6d-a8f8f201a07b",
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
    "id": "f01e6966-9ac3-5819-9dad-719022e8ef4e",
    "type": "order_fulfillments",
    "attributes": {
      "order_id": "3baeda28-764b-45f1-a696-7684fdaff059"
    },
    "relationships": {}
  },
  "meta": {}
}
```


> Start StockItems:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/order_fulfillments' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "order_fulfillments",
        "attributes": {
          "order_id": "4a303a7e-09b4-42e4-9d17-7461fc2b64bf",
          "confirm_shortage": null,
          "actions": [
            {
              "action": "start_stock_items",
              "product_id": "301a9492-e430-4da8-9c29-c0bbc33732d4",
              "planning_id": "86ff0b1c-d439-4ade-b6c1-13bb9d2524d9",
              "stock_item_ids": [
                "8412805c-7f2a-40b1-9499-bd0d2ec7b2df"
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
    "id": "cbd000b9-7bb0-5e1d-a03c-47d5f3449bbd",
    "type": "order_fulfillments",
    "attributes": {
      "order_id": "4a303a7e-09b4-42e4-9d17-7461fc2b64bf"
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
`include` | **String** <br>List of comma seperated relationships `?include=order,changed_lines,changed_plannings`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[order_fulfillments]=order_id`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][actions][]` | **Array** <br>Array of actions to be performed. The actions are executed atomically, and succeed as a whole, or fail as a whole. 
`data[attributes][confirm_shortage]` | **Boolean** <br>A value of `true` overrides shortage warnings when booking products on a reserved or started Order. 
`data[attributes][order_id]` | **Uuid** <br>The associated Order


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
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/order_fulfillments' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "order_fulfillments",
        "attributes": {
          "order_id": "9767af60-df3c-43ca-a604-9762f0b86e6e",
          "actions": [
            {
              "action": "stop_product",
              "product_id": "fcecccac-3d80-48f8-b2d8-cdef27ed5c51",
              "planning_id": "bddb3416-0775-4185-b8e0-181e4c18406e",
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
    "id": "92139c03-dd39-5587-9ded-41da5d32771f",
    "type": "order_fulfillments",
    "attributes": {
      "order_id": "9767af60-df3c-43ca-a604-9762f0b86e6e"
    },
    "relationships": {}
  },
  "meta": {}
}
```


> Stop StockItems:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/order_fulfillments' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "order_fulfillments",
        "attributes": {
          "order_id": "52af9b49-438b-4b56-9f28-4e65cbf79868",
          "actions": [
            {
              "action": "stop_stock_items",
              "product_id": "7ac02b6a-7e54-4c29-b059-c249314dfb4a",
              "planning_id": "a64bfcc6-f7d4-4a74-92db-aa915da46f67",
              "stock_item_ids": [
                "e7b2f868-9c90-49a0-bf21-3ad43012b3a9"
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
    "id": "5604f9c0-75de-5962-b7ce-95e47343521c",
    "type": "order_fulfillments",
    "attributes": {
      "order_id": "52af9b49-438b-4b56-9f28-4e65cbf79868"
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
`include` | **String** <br>List of comma seperated relationships `?include=order,changed_lines,changed_plannings`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[order_fulfillments]=order_id`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][actions][]` | **Array** <br>Array of actions to be performed. The actions are executed atomically, and succeed as a whole, or fail as a whole. 
`data[attributes][confirm_shortage]` | **Boolean** <br>A value of `true` overrides shortage warnings when booking products on a reserved or started Order. 
`data[attributes][order_id]` | **Uuid** <br>The associated Order


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







