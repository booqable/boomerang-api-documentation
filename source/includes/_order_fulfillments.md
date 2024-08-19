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
          "order_id": "2b4c0425-76d1-43ee-acf1-748fe078a515",
          "confirm_shortage": null,
          "actions": [
            {
              "action": "book_product",
              "mode": "create_new",
              "product_id": "78466f18-dcfd-4473-8766-8f80c9c6b75a",
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
    "id": "a4109c06-0fc2-5095-ab98-607cbc0d8ea8",
    "type": "order_fulfillments",
    "attributes": {
      "order_id": "2b4c0425-76d1-43ee-acf1-748fe078a515"
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
          "order_id": "31757bb4-2016-4b3b-bcf6-c611f5af066b",
          "confirm_shortage": null,
          "actions": [
            {
              "action": "book_product",
              "mode": "infer_planning",
              "product_id": "3f8cbaf1-0490-4da0-84ed-9f957294811a",
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
    "id": "fa14fb0e-4449-5577-aae1-15435fffcb29",
    "type": "order_fulfillments",
    "attributes": {
      "order_id": "31757bb4-2016-4b3b-bcf6-c611f5af066b"
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
          "order_id": "4f9d2b33-b2da-4193-9fe4-5658e8c80eef",
          "confirm_shortage": null,
          "actions": [
            {
              "action": "book_product",
              "mode": "update_existing",
              "product_id": "bd6d7531-4250-459d-9f58-8edbec79d811",
              "planning_id": "5523b7cb-b12d-4c13-95c6-53bc0170dbd9",
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
    "id": "69c0f80b-3c6d-5ffb-bbb8-e811a6d8c116",
    "type": "order_fulfillments",
    "attributes": {
      "order_id": "4f9d2b33-b2da-4193-9fe4-5658e8c80eef"
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
          "order_id": "5d39dd57-2db3-4506-89fc-b6602bafd3fc",
          "confirm_shortage": null,
          "actions": [
            {
              "action": "book_stock_items",
              "mode": "infer_planning",
              "product_id": "1b4f4597-2b04-434a-aab0-49a2ab5757fa",
              "stock_item_ids": [
                "8024b4e0-7b43-46d8-a83e-42cceb4b97ad",
                "db316442-d4a6-41b7-8e32-67f4c5958d90"
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
    "id": "a8fb0a95-1855-58de-ab8d-5569d0dd1d83",
    "type": "order_fulfillments",
    "attributes": {
      "order_id": "5d39dd57-2db3-4506-89fc-b6602bafd3fc"
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
          "order_id": "47045782-5649-4464-ba57-cb05c1c25bdc",
          "confirm_shortage": null,
          "actions": [
            {
              "action": "book_bundle",
              "bundle_id": "f04ddaba-55c8-44fa-819c-ebe748134b7a",
              "quantity": 1,
              "product_variations": [
                {
                  "bundle_item_id": "b2e8fd17-4e57-48bf-bb11-b4215bc4ea86",
                  "product_id": "d7c68b37-77d9-4483-a52b-4abd18b81ae6"
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
    "id": "853fcbc5-1fbc-5ff9-87a6-148ea28314e0",
    "type": "order_fulfillments",
    "attributes": {
      "order_id": "47045782-5649-4464-ba57-cb05c1c25bdc"
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
          "order_id": "2d79ed82-1091-4e78-918a-323032b33437",
          "actions": [
            {
              "action": "specify_stock_items",
              "product_id": "c16fbaec-e578-4b47-b18c-d13d96762a9b",
              "planning_id": "d2f3215d-da57-42cf-be7d-48135d648e4c",
              "stock_item_ids_to_add": [
                "36c9f119-72e1-49f9-8186-0913d497c7e2"
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
    "id": "61e40829-f94f-5d8b-8fe3-6426511bbcdb",
    "type": "order_fulfillments",
    "attributes": {
      "order_id": "2d79ed82-1091-4e78-918a-323032b33437"
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
          "order_id": "102522de-cfbf-4cbf-86a6-80e459842f59",
          "actions": [
            {
              "action": "specify_stock_items",
              "product_id": "5bd1f053-be45-4ceb-ad51-c0a5682f98bb",
              "planning_id": "491fc871-0172-4f0f-a5a7-d889d06036b5",
              "stock_item_ids_to_add": [],
              "stock_item_ids_to_remove": [
                "a83bb3bd-9076-4cdb-bc8a-984db9892a2c"
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
    "id": "82e18dd0-14eb-5fdc-8ac7-92c288274a0d",
    "type": "order_fulfillments",
    "attributes": {
      "order_id": "102522de-cfbf-4cbf-86a6-80e459842f59"
    },
    "relationships": {
      "changed_stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "90f97e07-4f44-4635-9f9d-b922b0aec11e"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "90f97e07-4f44-4635-9f9d-b922b0aec11e",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2024-08-19T09:23:28.180545+00:00",
        "updated_at": "2024-08-19T09:23:28.307863+00:00",
        "archived": true,
        "archived_at": "2024-08-19T09:23:28.300865+00:00",
        "reserved": false,
        "started": false,
        "stopped": false,
        "stock_item_id": "a83bb3bd-9076-4cdb-bc8a-984db9892a2c",
        "planning_id": "491fc871-0172-4f0f-a5a7-d889d06036b5",
        "order_id": "102522de-cfbf-4cbf-86a6-80e459842f59"
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
          "order_id": "02257192-8406-419f-9db6-93865491ee1a",
          "confirm_shortage": null,
          "actions": [
            {
              "action": "start_product",
              "product_id": "f4c442ce-a23e-4e2c-8088-f9c7db37cc6f",
              "planning_id": "c403085b-3a4b-4d11-8f4a-0b35bf14f027",
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
    "id": "20c64b6f-311e-5813-a89b-26974b1d14fa",
    "type": "order_fulfillments",
    "attributes": {
      "order_id": "02257192-8406-419f-9db6-93865491ee1a"
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
          "order_id": "00a55ec1-b835-4a1e-82a4-573b17431f12",
          "confirm_shortage": null,
          "actions": [
            {
              "action": "start_stock_items",
              "product_id": "1e8ffd60-b053-4e05-ab10-5594ded8f690",
              "planning_id": "02fe28aa-c7c7-426b-8b9f-c71217a4a10e",
              "stock_item_ids": [
                "b4a40b5b-89fd-4772-885c-200e544299a1"
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
    "id": "4fe7f760-90bf-55d4-9bf7-3ea5026a8aeb",
    "type": "order_fulfillments",
    "attributes": {
      "order_id": "00a55ec1-b835-4a1e-82a4-573b17431f12"
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
          "order_id": "fda1e2d2-b85b-42cf-b2c2-b93f70c36554",
          "actions": [
            {
              "action": "stop_product",
              "product_id": "1caad81b-d76b-4e01-9019-795c19fc9f1d",
              "planning_id": "a5bc0499-5cac-46c9-bc7f-fc5d21186b73",
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
    "id": "a493be46-f138-590a-a8d4-7f7342e5e160",
    "type": "order_fulfillments",
    "attributes": {
      "order_id": "fda1e2d2-b85b-42cf-b2c2-b93f70c36554"
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
          "order_id": "d8f3d0cc-4321-4556-8948-2cbb3ffb54ed",
          "actions": [
            {
              "action": "stop_stock_items",
              "product_id": "f42ec4ed-e85f-48ce-8668-715039c337a0",
              "planning_id": "ac070747-2689-4d36-b186-872e3f820762",
              "stock_item_ids": [
                "629099c2-73f8-4e64-9d39-7605fc360d4d"
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
    "id": "365f7fde-aa6e-5638-8312-ec010a46cdae",
    "type": "order_fulfillments",
    "attributes": {
      "order_id": "d8f3d0cc-4321-4556-8948-2cbb3ffb54ed"
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







