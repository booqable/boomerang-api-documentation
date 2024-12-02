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
`id` | **Uuid** `readonly`<br>Primary key
`actions` | **Array** `writeonly`<br>Array of actions to be performed. The actions are executed atomically, and succeed as a whole, or fail as a whole. 
`confirm_shortage` | **Boolean** `writeonly`<br>A value of `true` overrides shortage warnings when booking products on a reserved or started Order. 
`order_id` | **Uuid** `readonly-after-create`<br>Associated Order


## Relationships
Order fulfillments have the following relationships:

Name | Description
-- | --
`changed_lines` | **[Lines](#lines)** <br>Associated Changed lines
`changed_plannings` | **[Plannings](#plannings)** <br>Associated Changed plannings
`changed_stock_item_plannings` | **[Stock item plannings](#stock-item-plannings)** <br>Associated Changed stock item plannings
`order` | **[Order](#orders)** <br>Associated Order


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
          "order_id": "e86573ff-b5d6-4763-9519-4e0b1117db1d",
          "confirm_shortage": null,
          "actions": [
            {
              "action": "book_product",
              "mode": "create_new",
              "product_id": "a5104a7f-e2b5-4993-8b80-fdfe944596f0",
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
    "id": "505fdb2c-5e32-5356-9c9a-01b0ca7b5a53",
    "type": "order_fulfillments",
    "attributes": {
      "order_id": "e86573ff-b5d6-4763-9519-4e0b1117db1d"
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
          "order_id": "6c122bb6-9978-4f05-8047-04b7f32b8633",
          "confirm_shortage": null,
          "actions": [
            {
              "action": "book_product",
              "mode": "infer_planning",
              "product_id": "3aa3524f-4bda-4a6a-9817-d01860d45469",
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
    "id": "9089e274-1861-502a-9ac5-b0668cfb4b8d",
    "type": "order_fulfillments",
    "attributes": {
      "order_id": "6c122bb6-9978-4f05-8047-04b7f32b8633"
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
          "order_id": "d42d4ddc-2374-4b8b-ba9e-f461a8a1678f",
          "confirm_shortage": null,
          "actions": [
            {
              "action": "book_product",
              "mode": "update_existing",
              "product_id": "cab6a3b4-6af5-474c-869b-555e2615d0b6",
              "planning_id": "bde85ad1-2ddd-492c-8b6f-a1110c10e3d2",
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
    "id": "ede54dc1-4e0b-5cbf-8d3f-35620624b39f",
    "type": "order_fulfillments",
    "attributes": {
      "order_id": "d42d4ddc-2374-4b8b-ba9e-f461a8a1678f"
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
          "order_id": "b16bae29-8ae6-4bee-9f34-5727e770c9ea",
          "confirm_shortage": null,
          "actions": [
            {
              "action": "book_stock_items",
              "mode": "infer_planning",
              "product_id": "258dfade-cff3-4fc4-8c23-1e79fa84374a",
              "stock_item_ids": [
                "14173541-557e-4eb0-bee7-b993ac9ba8ee",
                "cc2eacb3-98a8-4916-a091-62283ebac9ca"
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
    "id": "fea6a8fd-cc76-524e-a37c-d9f7a43778ac",
    "type": "order_fulfillments",
    "attributes": {
      "order_id": "b16bae29-8ae6-4bee-9f34-5727e770c9ea"
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
          "order_id": "e5eef8ce-4774-48e3-906e-fa6bbd1a879d",
          "confirm_shortage": null,
          "actions": [
            {
              "action": "book_bundle",
              "bundle_id": "c6b293d3-62d0-45e6-9912-3ac13726a16c",
              "quantity": 1,
              "product_variations": [
                {
                  "bundle_item_id": "39cf71ed-0434-4a27-96be-714b1214c7be",
                  "product_id": "61eb3383-7744-4acc-ae7f-1b3f43a793a9"
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
    "id": "1fdbf5c1-657c-5f83-8a27-61b0d6ed843e",
    "type": "order_fulfillments",
    "attributes": {
      "order_id": "e5eef8ce-4774-48e3-906e-fa6bbd1a879d"
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
`data[attributes][order_id]` | **Uuid** <br>Associated Order


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
          "order_id": "1b1a292c-3af4-405d-b001-9b5446f2a338",
          "actions": [
            {
              "action": "specify_stock_items",
              "product_id": "8a93252a-e498-4461-83a7-9da46c3f10dd",
              "planning_id": "c7d4e77b-b911-4d14-90cd-8af5fbef13f2",
              "stock_item_ids_to_add": [
                "54c6f3d4-5554-4db3-bef4-23ee4c13b02f"
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
    "id": "a97d144e-83b4-5984-8ce5-afe8e0d2684c",
    "type": "order_fulfillments",
    "attributes": {
      "order_id": "1b1a292c-3af4-405d-b001-9b5446f2a338"
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
          "order_id": "652a4f87-0c70-44b8-9ad9-2e0587da88cc",
          "actions": [
            {
              "action": "specify_stock_items",
              "product_id": "5772b9a4-1109-414b-ae7c-f2f89dd6e564",
              "planning_id": "3fa75153-3f00-4b2e-8bd3-f3ced2eda0d7",
              "stock_item_ids_to_add": [],
              "stock_item_ids_to_remove": [
                "038fbb81-a8bf-4fcc-b552-82f3f546ed54"
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
    "id": "2007ad41-cd34-5fc5-99f8-91f57d11639d",
    "type": "order_fulfillments",
    "attributes": {
      "order_id": "652a4f87-0c70-44b8-9ad9-2e0587da88cc"
    },
    "relationships": {
      "changed_stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "0bad3876-5d18-4042-aff1-66eef90ec13f"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "0bad3876-5d18-4042-aff1-66eef90ec13f",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2024-12-02T09:22:23.155923+00:00",
        "updated_at": "2024-12-02T09:22:23.262387+00:00",
        "archived": true,
        "archived_at": "2024-12-02T09:22:23.257190+00:00",
        "reserved": false,
        "started": false,
        "stopped": false,
        "stock_item_id": "038fbb81-a8bf-4fcc-b552-82f3f546ed54",
        "planning_id": "3fa75153-3f00-4b2e-8bd3-f3ced2eda0d7",
        "order_id": "652a4f87-0c70-44b8-9ad9-2e0587da88cc"
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
`data[attributes][order_id]` | **Uuid** <br>Associated Order


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
          "order_id": "3649998b-fdfa-4f5a-a3af-65c2fe34b6cf",
          "confirm_shortage": null,
          "actions": [
            {
              "action": "start_product",
              "product_id": "9fb98095-8b46-4570-a757-13b9a7a93552",
              "planning_id": "5acdec7d-d4c7-4844-9694-5641ca79399b",
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
    "id": "c63b213e-4258-5566-862a-6541c8c2cb67",
    "type": "order_fulfillments",
    "attributes": {
      "order_id": "3649998b-fdfa-4f5a-a3af-65c2fe34b6cf"
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
          "order_id": "27ffc906-fed0-4d7e-9051-abda6c83fe09",
          "confirm_shortage": null,
          "actions": [
            {
              "action": "start_stock_items",
              "product_id": "e59968a8-6462-44ee-8a0c-b1bdf584c97e",
              "planning_id": "f4d57b47-0dda-4a5a-a19e-e96ac6ddcc07",
              "stock_item_ids": [
                "dbaf4faa-de44-4b06-a254-522182945540"
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
    "id": "368dd8dd-613f-58d6-bf19-c92723098ac5",
    "type": "order_fulfillments",
    "attributes": {
      "order_id": "27ffc906-fed0-4d7e-9051-abda6c83fe09"
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
`data[attributes][order_id]` | **Uuid** <br>Associated Order


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
          "order_id": "96d7fe5e-82e3-48cd-b386-5e58f75977a6",
          "actions": [
            {
              "action": "stop_product",
              "product_id": "24516f34-ebe2-45d2-b5f2-86be4a9a8585",
              "planning_id": "893a71cd-daa6-40e2-a88d-05a03c412e6c",
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
    "id": "95f26061-851e-5569-b913-16083c6807f6",
    "type": "order_fulfillments",
    "attributes": {
      "order_id": "96d7fe5e-82e3-48cd-b386-5e58f75977a6"
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
          "order_id": "1d3f279c-8e13-4e85-a8b5-91c957d64b06",
          "actions": [
            {
              "action": "stop_stock_items",
              "product_id": "31cc4032-7271-405d-bb9a-6dedae1e3198",
              "planning_id": "46e6cd19-2c55-4764-abb7-c6e4d0b627ac",
              "stock_item_ids": [
                "f347dddb-c0f6-4ccb-ad4c-145f73a4b0d4"
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
    "id": "b38aa7a0-27bc-575c-ac9a-9e7fd89b4d6e",
    "type": "order_fulfillments",
    "attributes": {
      "order_id": "1d3f279c-8e13-4e85-a8b5-91c957d64b06"
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
`data[attributes][order_id]` | **Uuid** <br>Associated Order


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







