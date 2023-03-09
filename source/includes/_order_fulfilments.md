# Order fulfilments

Takes an Order through the fulfilment process.

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

When the `mode` attribute is set to `create_new`, a new Planning
and Line are created. When set to `update_existing`, the quantity
is added to the specified existing Planning/Line.

The `confirm_shortage` attribute (on the resource, not on the action),
overrides shortage warnings when booking on a reserved or started order.

```json
{
  "action": "book_product",
  "mode": "create_new",
  "product_id": "<id>",
  "planning_id": "<id>",  # required for mode `update_existing`
  "quantity": N,
}
```

#### Book StockItems

Books one or more StockItems of a trackable Product on an Order.

The `confirm_shortage` attribute (on the resource, not on the action),
overrides shortage warnings when booking on a reserved or started order.

```json
{
  "action": "book_stock_items",
  "product_id": "<id>",
  "stock_item_ids": ["<id>"],
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
`POST /api/boomerang/order_fulfilments`

## Fields
Every order fulfilment has the following fields:

Name | Description
- | -
`id` | **Uuid** `readonly`<br>
`actions` | **Array** `writeonly`<br>Array of actions to be performed. The actions are executed atomically, and succeed as a whole, or fail as a whole. 
`confirm_shortage` | **Boolean** `writeonly`<br>A value of `true` overrides shortage warnings when booking products on a reserved or started Order. 
`order_id` | **Uuid** <br>The associated Order


## Relationships
Order fulfilments have the following relationships:

Name | Description
- | -
`order` | **Orders** `readonly`<br>Associated Order
`changed_lines` | **Lines** `readonly`<br>Associated Changed lines
`changed_plannings` | **Plannings** `readonly`<br>Associated Changed plannings
`changed_stock_item_plannings` | **Stock item plannings** `readonly`<br>Associated Changed stock item plannings


## Book



> Book a Bundle:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/order_fulfilments' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "order_fulfilments",
        "attributes": {
          "order_id": "e7b3ccdc-8733-4b08-a090-ab2d3b8cc3a8",
          "confirm_shortage": null,
          "actions": [
            {
              "action": "book_bundle",
              "bundle_id": "3c9037e1-a0f4-4b80-8f7d-ce306e15ff8b",
              "quantity": 1,
              "product_variations": [
                {
                  "bundle_item_id": "3c8ae5a3-19dc-42ce-b142-33f5487f4267",
                  "product_id": "85f1adbe-12d9-4403-ab90-8244f7f6b9b5"
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
    "id": "f8d13e15-cf0c-5dd7-921c-36a92ed03305",
    "type": "order_fulfilments",
    "attributes": {
      "order_id": "e7b3ccdc-8733-4b08-a090-ab2d3b8cc3a8"
    },
    "relationships": {
      "order": {
        "meta": {
          "included": false
        }
      },
      "changed_lines": {
        "meta": {
          "included": false
        }
      },
      "changed_plannings": {
        "meta": {
          "included": false
        }
      },
      "changed_stock_item_plannings": {
        "meta": {
          "included": false
        }
      }
    }
  },
  "meta": {}
}
```


> Book a Product (New):

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/order_fulfilments' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "order_fulfilments",
        "attributes": {
          "order_id": "6b59a3a6-6d97-4565-beb1-f1135c1992e4",
          "confirm_shortage": null,
          "actions": [
            {
              "action": "book_product",
              "mode": "create_new",
              "product_id": "8d5887a7-d368-4c86-afac-d8e84b5d7750",
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
    "id": "041d93e9-00a5-5bce-b43f-90d95f0f4b1a",
    "type": "order_fulfilments",
    "attributes": {
      "order_id": "6b59a3a6-6d97-4565-beb1-f1135c1992e4"
    },
    "relationships": {
      "order": {
        "meta": {
          "included": false
        }
      },
      "changed_lines": {
        "meta": {
          "included": false
        }
      },
      "changed_plannings": {
        "meta": {
          "included": false
        }
      },
      "changed_stock_item_plannings": {
        "meta": {
          "included": false
        }
      }
    }
  },
  "meta": {}
}
```


> Book a Product (Update):

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/order_fulfilments' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "order_fulfilments",
        "attributes": {
          "order_id": "d4fbc626-574b-4aac-8fd5-1c34c594472d",
          "confirm_shortage": null,
          "actions": [
            {
              "action": "book_product",
              "mode": "update_existing",
              "product_id": "d59e1c27-0dcc-4413-9c70-da0c334d5560",
              "planning_id": "9b3e51fa-a76e-4a2e-86b6-ba6162bab740",
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
    "id": "3bbfe0e2-9f5a-50bc-8dcb-0832972af75f",
    "type": "order_fulfilments",
    "attributes": {
      "order_id": "d4fbc626-574b-4aac-8fd5-1c34c594472d"
    },
    "relationships": {
      "order": {
        "meta": {
          "included": false
        }
      },
      "changed_lines": {
        "meta": {
          "included": false
        }
      },
      "changed_plannings": {
        "meta": {
          "included": false
        }
      },
      "changed_stock_item_plannings": {
        "meta": {
          "included": false
        }
      }
    }
  },
  "meta": {}
}
```


> Book StockItems:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/order_fulfilments' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "order_fulfilments",
        "attributes": {
          "order_id": "be54dc81-bebb-4e1f-98d0-cba69dd94c60",
          "confirm_shortage": null,
          "actions": [
            {
              "action": "book_stock_items",
              "product_id": "fab205bc-34f7-4569-b979-43abc3a2ff29",
              "stock_item_ids": [
                "2bed98a6-57b7-4c8a-8723-ba124a2c7b7e",
                "e64a4188-b96a-40f8-aaba-c6ae06344fdc"
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
    "id": "85ddad9a-42fb-568f-92e9-60b5eb1dedad",
    "type": "order_fulfilments",
    "attributes": {
      "order_id": "be54dc81-bebb-4e1f-98d0-cba69dd94c60"
    },
    "relationships": {
      "order": {
        "meta": {
          "included": false
        }
      },
      "changed_lines": {
        "meta": {
          "included": false
        }
      },
      "changed_plannings": {
        "meta": {
          "included": false
        }
      },
      "changed_stock_item_plannings": {
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

`POST /api/boomerang/order_fulfilments`

### Request params

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=order,changed_lines,changed_plannings`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[order_fulfilments]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][actions][]` | **Array** <br>Array of actions to be performed. The actions are executed atomically, and succeed as a whole, or fail as a whole. 
`data[attributes][confirm_shortage]` | **Boolean** <br>A value of `true` overrides shortage warnings when booking products on a reserved or started Order. 
`data[attributes][order_id]` | **Uuid** <br>The associated Order


### Includes

This request accepts the following includes:

`order`


`changed_lines` => 
`item` => 
`photo`






`changed_plannings`


`changed_stock_item_plannings`






## Specify



> Add a StockItem:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/order_fulfilments' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "order_fulfilments",
        "attributes": {
          "order_id": "12d767c4-763b-45ed-aab1-690292de966c",
          "actions": [
            {
              "action": "specify_stock_items",
              "product_id": "b9476a9a-501f-48cb-8745-155db6ac4715",
              "planning_id": "6d7dc264-6dbd-46f5-bef9-381de3bbb37d",
              "stock_item_ids_to_add": [
                "ec933adb-73c9-4dba-8b8b-7f590949715e"
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
    "id": "5806a2e0-a4f3-52e5-a406-18125a95a445",
    "type": "order_fulfilments",
    "attributes": {
      "order_id": "12d767c4-763b-45ed-aab1-690292de966c"
    },
    "relationships": {
      "order": {
        "meta": {
          "included": false
        }
      },
      "changed_lines": {
        "meta": {
          "included": false
        }
      },
      "changed_plannings": {
        "meta": {
          "included": false
        }
      },
      "changed_stock_item_plannings": {
        "meta": {
          "included": false
        }
      }
    }
  },
  "meta": {}
}
```


> Remove a StockItem:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/order_fulfilments' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "order_fulfilments",
        "attributes": {
          "order_id": "0dc05a7f-fc08-4c50-b644-5ee9e703577f",
          "actions": [
            {
              "action": "specify_stock_items",
              "product_id": "7fd5b282-1c85-4fe3-98c9-3a2c4cb233e5",
              "planning_id": "538a3953-ac94-4654-9d5e-be718fd5c45b",
              "stock_item_ids_to_add": [],
              "stock_item_ids_to_remove": [
                "5e0222c1-e97a-4f1e-818e-ea6bc0ad2de4"
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
    "id": "4dfdcea5-7b4e-5648-9884-e4557dd284e2",
    "type": "order_fulfilments",
    "attributes": {
      "order_id": "0dc05a7f-fc08-4c50-b644-5ee9e703577f"
    },
    "relationships": {
      "order": {
        "meta": {
          "included": false
        }
      },
      "changed_lines": {
        "meta": {
          "included": false
        }
      },
      "changed_plannings": {
        "meta": {
          "included": false
        }
      },
      "changed_stock_item_plannings": {
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

`POST /api/boomerang/order_fulfilments`

### Request params

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=order,changed_lines,changed_plannings`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[order_fulfilments]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][actions][]` | **Array** <br>Array of actions to be performed. The actions are executed atomically, and succeed as a whole, or fail as a whole. 
`data[attributes][confirm_shortage]` | **Boolean** <br>A value of `true` overrides shortage warnings when booking products on a reserved or started Order. 
`data[attributes][order_id]` | **Uuid** <br>The associated Order


### Includes

This request accepts the following includes:

`order`


`changed_lines` => 
`item` => 
`photo`






`changed_plannings`


`changed_stock_item_plannings`






## Start



> Start a Product:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/order_fulfilments' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "order_fulfilments",
        "attributes": {
          "order_id": "1c023328-9dee-48df-b323-1ffe5589876e",
          "confirm_shortage": null,
          "actions": [
            {
              "action": "start_product",
              "product_id": "9b2e4be4-bb1d-4759-968d-c22b24fa6e09",
              "planning_id": "350cb052-1c1d-4703-af88-59e0d7088a32",
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
    "id": "ca0ee76e-f6b2-5cbc-88f7-67f3d8e26980",
    "type": "order_fulfilments",
    "attributes": {
      "order_id": "1c023328-9dee-48df-b323-1ffe5589876e"
    },
    "relationships": {
      "order": {
        "meta": {
          "included": false
        }
      },
      "changed_lines": {
        "meta": {
          "included": false
        }
      },
      "changed_plannings": {
        "meta": {
          "included": false
        }
      },
      "changed_stock_item_plannings": {
        "meta": {
          "included": false
        }
      }
    }
  },
  "meta": {}
}
```


> Start StockItems:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/order_fulfilments' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "order_fulfilments",
        "attributes": {
          "order_id": "2cc7a039-e9ca-48db-b906-74875b713e77",
          "confirm_shortage": null,
          "actions": [
            {
              "action": "start_stock_items",
              "product_id": "7c9d31dc-0be4-4d10-b450-af1a2df905f8",
              "planning_id": "3703336d-585c-4364-8779-0c11d7a2f6e4",
              "stock_item_ids": [
                "4e1ac164-b25f-4361-ba31-80209618e9ec"
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
    "id": "a19d3c66-474d-570e-9e5d-ebc4ef8960d5",
    "type": "order_fulfilments",
    "attributes": {
      "order_id": "2cc7a039-e9ca-48db-b906-74875b713e77"
    },
    "relationships": {
      "order": {
        "meta": {
          "included": false
        }
      },
      "changed_lines": {
        "meta": {
          "included": false
        }
      },
      "changed_plannings": {
        "meta": {
          "included": false
        }
      },
      "changed_stock_item_plannings": {
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

`POST /api/boomerang/order_fulfilments`

### Request params

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=order,changed_lines,changed_plannings`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[order_fulfilments]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][actions][]` | **Array** <br>Array of actions to be performed. The actions are executed atomically, and succeed as a whole, or fail as a whole. 
`data[attributes][confirm_shortage]` | **Boolean** <br>A value of `true` overrides shortage warnings when booking products on a reserved or started Order. 
`data[attributes][order_id]` | **Uuid** <br>The associated Order


### Includes

This request accepts the following includes:

`order`


`changed_lines` => 
`item` => 
`photo`






`changed_plannings`


`changed_stock_item_plannings`






## Stop



> Stop a Product:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/order_fulfilments' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "order_fulfilments",
        "attributes": {
          "order_id": "dadc9f15-7ecb-48cb-879a-a2e856b6121a",
          "actions": [
            {
              "action": "stop_product",
              "product_id": "07b41ad1-91bc-4598-8066-6bf1fe6baf6a",
              "planning_id": "66bca2f6-066f-4079-900b-2a86e36158b2",
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
    "id": "f60488e4-a27f-5674-ae26-13e12f9da974",
    "type": "order_fulfilments",
    "attributes": {
      "order_id": "dadc9f15-7ecb-48cb-879a-a2e856b6121a"
    },
    "relationships": {
      "order": {
        "meta": {
          "included": false
        }
      },
      "changed_lines": {
        "meta": {
          "included": false
        }
      },
      "changed_plannings": {
        "meta": {
          "included": false
        }
      },
      "changed_stock_item_plannings": {
        "meta": {
          "included": false
        }
      }
    }
  },
  "meta": {}
}
```


> Stop StockItems:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/order_fulfilments' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "order_fulfilments",
        "attributes": {
          "order_id": "809c4646-7e50-4025-964c-2c26b468af2f",
          "actions": [
            {
              "action": "stop_stock_items",
              "product_id": "a244914d-10d0-4c80-85f3-34fb12d40b46",
              "planning_id": "7be5f229-a1a1-4a70-b440-4dab951c6848",
              "stock_item_ids": [
                "5ce81678-b7dd-4d51-a121-0909a5684069"
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
    "id": "151441d9-5fdc-5c26-89ae-59ea3dc9b64a",
    "type": "order_fulfilments",
    "attributes": {
      "order_id": "809c4646-7e50-4025-964c-2c26b468af2f"
    },
    "relationships": {
      "order": {
        "meta": {
          "included": false
        }
      },
      "changed_lines": {
        "meta": {
          "included": false
        }
      },
      "changed_plannings": {
        "meta": {
          "included": false
        }
      },
      "changed_stock_item_plannings": {
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

`POST /api/boomerang/order_fulfilments`

### Request params

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=order,changed_lines,changed_plannings`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[order_fulfilments]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][actions][]` | **Array** <br>Array of actions to be performed. The actions are executed atomically, and succeed as a whole, or fail as a whole. 
`data[attributes][confirm_shortage]` | **Boolean** <br>A value of `true` overrides shortage warnings when booking products on a reserved or started Order. 
`data[attributes][order_id]` | **Uuid** <br>The associated Order


### Includes

This request accepts the following includes:

`order`


`changed_lines` => 
`item` => 
`photo`






`changed_plannings`


`changed_stock_item_plannings`





