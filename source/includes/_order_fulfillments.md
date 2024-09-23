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
          "order_id": "5819855e-b553-466e-8fa7-bd91b8cfb6cb",
          "confirm_shortage": null,
          "actions": [
            {
              "action": "book_product",
              "mode": "create_new",
              "product_id": "45ffb4b0-b59b-4e70-aa62-9dcf68939fbe",
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
    "id": "040c6e2a-b2d5-51a9-a8b0-3fd5e0a3a449",
    "type": "order_fulfillments",
    "attributes": {
      "order_id": "5819855e-b553-466e-8fa7-bd91b8cfb6cb"
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
          "order_id": "fb353991-ed0f-4112-90b3-81b9142add70",
          "confirm_shortage": null,
          "actions": [
            {
              "action": "book_product",
              "mode": "infer_planning",
              "product_id": "5907578d-f554-4dea-a3aa-fe9c234d2f14",
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
    "id": "b9cb5a09-1cc0-5dc7-b5f2-01d7a11d3f0b",
    "type": "order_fulfillments",
    "attributes": {
      "order_id": "fb353991-ed0f-4112-90b3-81b9142add70"
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
          "order_id": "68945830-95c6-484f-a193-e7adcc5dbbc7",
          "confirm_shortage": null,
          "actions": [
            {
              "action": "book_product",
              "mode": "update_existing",
              "product_id": "a55370f1-0cbb-47b1-9446-d0575e554a8b",
              "planning_id": "14798fec-9822-47b2-a650-131cd95312f5",
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
    "id": "37936eab-0058-5bf2-af32-e28211af50fb",
    "type": "order_fulfillments",
    "attributes": {
      "order_id": "68945830-95c6-484f-a193-e7adcc5dbbc7"
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
          "order_id": "75e44cf3-16a3-47ab-b3ba-a049d17f2e80",
          "confirm_shortage": null,
          "actions": [
            {
              "action": "book_stock_items",
              "mode": "infer_planning",
              "product_id": "2122743c-6f78-4270-a0fe-3d158a3a567d",
              "stock_item_ids": [
                "f0c49ffc-779d-4cc6-ae00-15a0b6275b0f",
                "d2046e4f-1efa-4245-b85d-8abaf1cd88a7"
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
    "id": "2ebcac34-74ac-5f77-b773-b97a8ec1d3ae",
    "type": "order_fulfillments",
    "attributes": {
      "order_id": "75e44cf3-16a3-47ab-b3ba-a049d17f2e80"
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
          "order_id": "163de921-f4e6-4e5c-a5a0-adc34e99fe21",
          "confirm_shortage": null,
          "actions": [
            {
              "action": "book_bundle",
              "bundle_id": "5322b052-f549-497b-a0e0-3e8d3c2bd9ee",
              "quantity": 1,
              "product_variations": [
                {
                  "bundle_item_id": "6677c446-a05d-4c44-a499-1881c8ef5ab2",
                  "product_id": "37983401-6cd6-43e2-9d2f-69924784750b"
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
    "id": "5012a3e7-d41e-5841-a0c7-51f97fdf4768",
    "type": "order_fulfillments",
    "attributes": {
      "order_id": "163de921-f4e6-4e5c-a5a0-adc34e99fe21"
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
          "order_id": "e2c42aa0-40d6-4261-abd2-f7ba9f105bbd",
          "actions": [
            {
              "action": "specify_stock_items",
              "product_id": "65bc4b0b-b84e-437d-ad42-8fdf4fb209c7",
              "planning_id": "68cc43dc-cd05-48fe-8fc7-be5f4bf67622",
              "stock_item_ids_to_add": [
                "52e3b9fc-6cdb-4312-8437-99799e485e41"
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
    "id": "60348ae3-4771-577b-8af5-285dd5ece359",
    "type": "order_fulfillments",
    "attributes": {
      "order_id": "e2c42aa0-40d6-4261-abd2-f7ba9f105bbd"
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
          "order_id": "8a3440a0-3c86-4a2f-8064-f612714ff4f1",
          "actions": [
            {
              "action": "specify_stock_items",
              "product_id": "59d9462f-a0f7-45dd-8a3e-543d97c2c415",
              "planning_id": "c26112fe-7ae9-43d4-98e5-20af17af3300",
              "stock_item_ids_to_add": [],
              "stock_item_ids_to_remove": [
                "29e413a8-a695-4488-abf1-42e3778bc85c"
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
    "id": "119b2b0f-c5de-51e6-9551-b3c3329053f5",
    "type": "order_fulfillments",
    "attributes": {
      "order_id": "8a3440a0-3c86-4a2f-8064-f612714ff4f1"
    },
    "relationships": {
      "changed_stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "07d217b3-d4f8-4055-87f8-2327891065c0"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "07d217b3-d4f8-4055-87f8-2327891065c0",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2024-09-23T09:27:31.554439+00:00",
        "updated_at": "2024-09-23T09:27:31.687237+00:00",
        "archived": true,
        "archived_at": "2024-09-23T09:27:31.681314+00:00",
        "reserved": false,
        "started": false,
        "stopped": false,
        "stock_item_id": "29e413a8-a695-4488-abf1-42e3778bc85c",
        "planning_id": "c26112fe-7ae9-43d4-98e5-20af17af3300",
        "order_id": "8a3440a0-3c86-4a2f-8064-f612714ff4f1"
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
          "order_id": "e407edf9-0642-4e63-9627-0a9031dae61b",
          "confirm_shortage": null,
          "actions": [
            {
              "action": "start_product",
              "product_id": "b0635ab0-f7c6-4980-ba91-7114b74e558b",
              "planning_id": "b2e76252-a937-4dfc-8a52-8e457a85c0b8",
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
    "id": "1b06fe09-8399-579d-a1d3-470e8f98ddc7",
    "type": "order_fulfillments",
    "attributes": {
      "order_id": "e407edf9-0642-4e63-9627-0a9031dae61b"
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
          "order_id": "9310814d-9395-49ae-a375-37f7d70372e8",
          "confirm_shortage": null,
          "actions": [
            {
              "action": "start_stock_items",
              "product_id": "bb670490-18a4-459b-b806-23849e3e168f",
              "planning_id": "f94305ba-1fbe-4cd6-aa90-97d86daf6034",
              "stock_item_ids": [
                "21cf0a1a-9c29-4c20-9672-5f646274b87c"
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
    "id": "31c56433-60a2-59cc-8270-e8403ec6eb46",
    "type": "order_fulfillments",
    "attributes": {
      "order_id": "9310814d-9395-49ae-a375-37f7d70372e8"
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
          "order_id": "f65219a6-bfd4-416b-acc2-7da3b2e644af",
          "actions": [
            {
              "action": "stop_product",
              "product_id": "765554c9-b513-4243-b1e7-2b613b66c295",
              "planning_id": "ac7c7f44-e700-4780-9556-bbe5be46dd94",
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
    "id": "5e9534c0-8a85-5c7f-8df8-139e373a2428",
    "type": "order_fulfillments",
    "attributes": {
      "order_id": "f65219a6-bfd4-416b-acc2-7da3b2e644af"
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
          "order_id": "474a0064-f7d8-4fc9-acad-cd746e834d66",
          "actions": [
            {
              "action": "stop_stock_items",
              "product_id": "7070dd1f-aaac-431f-b2a0-45b53a3a7d48",
              "planning_id": "f4675d67-496f-4040-88b0-d03cac5fd6a4",
              "stock_item_ids": [
                "6eeaa1fa-8abd-4ced-940c-d4869e36b88e"
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
    "id": "d28d0aaa-33ec-5bb7-9365-cce59da88f56",
    "type": "order_fulfillments",
    "attributes": {
      "order_id": "474a0064-f7d8-4fc9-acad-cd746e834d66"
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







