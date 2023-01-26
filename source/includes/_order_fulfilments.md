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
is added to an existing Planning/Line when possible.

The `confirm_shortage` attribute (on the resource, not on the action),
overrides shortage warnings when booking on a reserved or started order.

```json
{
  "action": "book_product",
  "product_id": "<id>",
  "mode": "create_new",
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
          "order_id": "fb5a8b30-8efd-49f2-bc42-3897d2e6825d",
          "confirm_shortage": null,
          "actions": [
            {
              "action": "book_bundle",
              "bundle_id": "e20557f7-4609-41cc-8b3b-0e2b233cd08c",
              "quantity": 1,
              "product_variations": [
                {
                  "bundle_item_id": "d1467098-3cbd-49ea-8e01-ca4aa9fe501e",
                  "product_id": "728ab34f-8ece-41f2-9bc7-6bc0efac5b70"
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
    "id": "37010e56-80db-51b4-8374-2b85e373c32f",
    "type": "order_fulfilments",
    "attributes": {
      "order_id": "fb5a8b30-8efd-49f2-bc42-3897d2e6825d"
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
          "order_id": "f2b13fc4-de84-42a4-af3f-d675d8d36802",
          "confirm_shortage": null,
          "actions": [
            {
              "action": "book_product",
              "mode": "create_new",
              "product_id": "998ad814-6f4f-4b3a-9ccc-b693550742a5",
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
    "id": "d04469c9-8a48-5bce-bb9f-7f76d567e134",
    "type": "order_fulfilments",
    "attributes": {
      "order_id": "f2b13fc4-de84-42a4-af3f-d675d8d36802"
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
          "order_id": "5b62c422-a44c-4a41-8dc4-d535b7828930",
          "confirm_shortage": null,
          "actions": [
            {
              "action": "book_product",
              "mode": "update_existing",
              "product_id": "b5d17cee-1298-458f-8678-94aaa3972de5",
              "planning_id": "2f7c0111-0b86-44ea-bc82-33d4df3fa247",
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
    "id": "4db2cc60-d8ac-5d1b-80db-d815769f1355",
    "type": "order_fulfilments",
    "attributes": {
      "order_id": "5b62c422-a44c-4a41-8dc4-d535b7828930"
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
          "order_id": "1a20df56-39b4-44d7-b54c-c6746a36fa61",
          "confirm_shortage": null,
          "actions": [
            {
              "action": "book_stock_items",
              "product_id": "720c30e2-fd87-4518-9060-9ca74449f27a",
              "stock_item_ids": [
                "10601573-3a62-4fe3-8cc8-4290cbac1eee",
                "04c384fd-9e19-49e1-bc6e-e7710a0752ec"
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
    "id": "9fb07ff1-73e3-5009-8d6d-55c780327537",
    "type": "order_fulfilments",
    "attributes": {
      "order_id": "1a20df56-39b4-44d7-b54c-c6746a36fa61"
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
          "order_id": "de7a345b-6b43-4279-b0b2-0b7d1170df49",
          "confirm_shortage": null,
          "actions": [
            {
              "action": "start_product",
              "product_id": "3bf97380-bc9e-4edd-8ae3-10768f8eec2d",
              "planning_id": "bce3e9a9-80a7-4bfb-babb-d024ef014867",
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
    "id": "d5fbc24e-d831-56d2-ac74-a6bb7e3cd559",
    "type": "order_fulfilments",
    "attributes": {
      "order_id": "de7a345b-6b43-4279-b0b2-0b7d1170df49"
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
          "order_id": "9c5e0763-d5c3-4bca-a9cf-cd6c3b78e450",
          "confirm_shortage": null,
          "actions": [
            {
              "action": "start_stock_items",
              "product_id": "496409bd-7f91-426b-9cce-49adbd68fb98",
              "planning_id": "fb4c78b2-8ec4-4b5a-95ab-9c9e3937a0b9",
              "stock_item_ids": [
                "f09037a9-410c-4816-b830-4f99c4444e49"
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
    "id": "c8b1e022-cf16-5409-a24d-158ec66698e8",
    "type": "order_fulfilments",
    "attributes": {
      "order_id": "9c5e0763-d5c3-4bca-a9cf-cd6c3b78e450"
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
          "order_id": "75424b82-54d2-4d22-a938-662b47c548b7",
          "actions": [
            {
              "action": "stop_product",
              "product_id": "5b2518a4-7750-45d5-9a5c-9adda1096310",
              "planning_id": "d32efec5-4a24-4b26-aa4d-ae84427b399e",
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
    "id": "777cad71-3b58-5120-baa1-9f0fa97cd25f",
    "type": "order_fulfilments",
    "attributes": {
      "order_id": "75424b82-54d2-4d22-a938-662b47c548b7"
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
          "order_id": "21023eca-7b26-4d2a-af5e-c36c4b798b79",
          "actions": [
            {
              "action": "stop_stock_items",
              "product_id": "99bccf92-94db-4e59-b48a-73b736df95f1",
              "planning_id": "1960f606-f168-4855-8bd7-8ad9166549de",
              "stock_item_ids": [
                "275c1d2c-e731-4d33-94e9-c19b08c3fbd9"
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
    "id": "39b7aeac-ffe2-512f-9dde-490646ced89d",
    "type": "order_fulfilments",
    "attributes": {
      "order_id": "21023eca-7b26-4d2a-af5e-c36c4b798b79"
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





