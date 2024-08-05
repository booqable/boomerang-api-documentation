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
`order` | **Orders** `readonly`<br>Associated Order
`changed_lines` | **Lines** `readonly`<br>Associated Changed lines
`changed_plannings` | **Plannings** `readonly`<br>Associated Changed plannings
`changed_stock_item_plannings` | **Stock item plannings** `readonly`<br>Associated Changed stock item plannings


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
          "order_id": "2262cf37-1cb3-41af-891e-42a1d2b84399",
          "confirm_shortage": null,
          "actions": [
            {
              "action": "book_product",
              "mode": "create_new",
              "product_id": "c3640264-9f89-4350-9551-6768600c9bb5",
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
    "id": "683ef7b6-054c-5f9f-bc20-62b1c42e356d",
    "type": "order_fulfillments",
    "attributes": {
      "order_id": "2262cf37-1cb3-41af-891e-42a1d2b84399"
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
          "order_id": "04ee2a05-eb01-418c-8130-09da9de3ee2e",
          "confirm_shortage": null,
          "actions": [
            {
              "action": "book_product",
              "mode": "infer_planning",
              "product_id": "e06cd3b3-b343-4557-8197-0035d3089c4d",
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
    "id": "3565fe18-f390-57ad-8812-d984ee938f76",
    "type": "order_fulfillments",
    "attributes": {
      "order_id": "04ee2a05-eb01-418c-8130-09da9de3ee2e"
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
          "order_id": "a1c1a89e-aa83-4d8b-82f7-0d4b2c7bcfeb",
          "confirm_shortage": null,
          "actions": [
            {
              "action": "book_product",
              "mode": "update_existing",
              "product_id": "12947f66-5eb7-44a6-8f3e-5ebce5c4c3fe",
              "planning_id": "14db68ca-f025-48fb-8b2c-de924474c97a",
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
    "id": "fd7c27c4-b400-50d2-8162-86d546f4e111",
    "type": "order_fulfillments",
    "attributes": {
      "order_id": "a1c1a89e-aa83-4d8b-82f7-0d4b2c7bcfeb"
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
          "order_id": "d4d3f0b1-04fc-48df-8c31-e8cee48609d5",
          "confirm_shortage": null,
          "actions": [
            {
              "action": "book_stock_items",
              "mode": "infer_planning",
              "product_id": "2da57f0f-7d40-4eae-b6e5-e9b2917eda58",
              "stock_item_ids": [
                "fea1762a-961e-4254-a678-e20f9be4bd48",
                "50576456-cff7-4d3c-a39e-7a3c52b7f6b0"
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
    "id": "e6c8f211-c5f5-5bce-b830-1dc219fdd3b1",
    "type": "order_fulfillments",
    "attributes": {
      "order_id": "d4d3f0b1-04fc-48df-8c31-e8cee48609d5"
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
          "order_id": "abba805c-ccb3-4a00-b94d-033710a62758",
          "confirm_shortage": null,
          "actions": [
            {
              "action": "book_bundle",
              "bundle_id": "acf4f726-39ae-46d9-b529-3cdbc8d81587",
              "quantity": 1,
              "product_variations": [
                {
                  "bundle_item_id": "9f0521ce-da48-4456-afe1-0555b7fddc21",
                  "product_id": "7dd93dbf-58e2-41c7-b8df-de4abc4017f6"
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
    "id": "ac665289-280c-5ea3-b3f7-308c7539d44e",
    "type": "order_fulfillments",
    "attributes": {
      "order_id": "abba805c-ccb3-4a00-b94d-033710a62758"
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
          "order_id": "19b4a58a-ca63-4def-b871-7b65497af19f",
          "actions": [
            {
              "action": "specify_stock_items",
              "product_id": "ec52a04a-4131-41f4-ad44-7e6f97b5a4ed",
              "planning_id": "4630f566-7c66-458d-9e13-021c01544725",
              "stock_item_ids_to_add": [
                "f83eaa0a-2ea5-459e-bf9c-f2e914ce415d"
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
    "id": "cd89185b-283d-55ca-940b-9a68a4eb7411",
    "type": "order_fulfillments",
    "attributes": {
      "order_id": "19b4a58a-ca63-4def-b871-7b65497af19f"
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
          "order_id": "3db75428-4d02-4945-a322-a964b7267adb",
          "actions": [
            {
              "action": "specify_stock_items",
              "product_id": "6184fb37-498c-4b90-a204-523fdccb1d94",
              "planning_id": "e14a6286-9ff6-45b6-b974-011a8241fccf",
              "stock_item_ids_to_add": [],
              "stock_item_ids_to_remove": [
                "61fe31ff-0f28-4716-b5f3-03fb8ed30266"
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
    "id": "18dc221d-53f1-5546-afb3-e12699bcec8f",
    "type": "order_fulfillments",
    "attributes": {
      "order_id": "3db75428-4d02-4945-a322-a964b7267adb"
    },
    "relationships": {
      "changed_stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "f9725195-81e8-4b35-8eee-4f5b813750fa"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "f9725195-81e8-4b35-8eee-4f5b813750fa",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2024-08-05T09:27:31.250093+00:00",
        "updated_at": "2024-08-05T09:27:31.380130+00:00",
        "archived": true,
        "archived_at": "2024-08-05T09:27:31.374280+00:00",
        "reserved": false,
        "started": false,
        "stopped": false,
        "stock_item_id": "61fe31ff-0f28-4716-b5f3-03fb8ed30266",
        "planning_id": "e14a6286-9ff6-45b6-b974-011a8241fccf",
        "order_id": "3db75428-4d02-4945-a322-a964b7267adb"
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
          "order_id": "d3a53219-bafe-4530-8393-86b5277746e6",
          "confirm_shortage": null,
          "actions": [
            {
              "action": "start_product",
              "product_id": "79fa658f-7fa6-404c-82c1-5ee389a4fb71",
              "planning_id": "1a221633-87ff-47f4-ac11-2511736a5c8a",
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
    "id": "c94488f5-fdd5-519e-8c7d-59677ac20f72",
    "type": "order_fulfillments",
    "attributes": {
      "order_id": "d3a53219-bafe-4530-8393-86b5277746e6"
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
          "order_id": "f16d205c-2c73-49ee-9dbb-1321ef20c427",
          "confirm_shortage": null,
          "actions": [
            {
              "action": "start_stock_items",
              "product_id": "2d94aece-8d06-4a4e-b6f6-cd13e5c5d26f",
              "planning_id": "c1dd535f-dc5b-4e3b-9f1b-79c136b40428",
              "stock_item_ids": [
                "db430c17-edb1-485f-885b-184fdf06e596"
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
    "id": "0847aa5a-2e0b-5518-8571-b7a2198c0775",
    "type": "order_fulfillments",
    "attributes": {
      "order_id": "f16d205c-2c73-49ee-9dbb-1321ef20c427"
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
          "order_id": "ef508903-5c44-49a1-9d0c-0784f3802a73",
          "actions": [
            {
              "action": "stop_product",
              "product_id": "1b5d5019-1fcc-4f0a-b397-5ae0e6de754f",
              "planning_id": "225cbc2f-4561-49bb-a838-a687f0adb00d",
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
    "id": "ce76ec29-e778-5d2e-bb1b-c5a4808b3cef",
    "type": "order_fulfillments",
    "attributes": {
      "order_id": "ef508903-5c44-49a1-9d0c-0784f3802a73"
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
          "order_id": "797f636d-d022-4638-bc40-d68a708c2b3a",
          "actions": [
            {
              "action": "stop_stock_items",
              "product_id": "b6da353a-d540-4b1e-8c1c-7c7cb56ae99d",
              "planning_id": "90b7faa1-2514-4670-b537-fe63717d1e83",
              "stock_item_ids": [
                "9c4fdf94-1802-4a5e-965f-b772ee11eec3"
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
    "id": "57b0f7f8-d965-550c-929c-f235df9b3eda",
    "type": "order_fulfillments",
    "attributes": {
      "order_id": "797f636d-d022-4638-bc40-d68a708c2b3a"
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







