# Order fulfilments

Takes an Order through the fulfilment process.

## Limitations

Not all types of actions can be combined in the
same request.

## Actions

#### Book a Bundle

Books a Bundle on an Order. For each unspecified
BundleItem a Product variation needs to be selected.
Specified BundleItems are automatically booked. These
should not be included in the request.

```json
{
  "action": "book_bundle",
  "bundle_id": "<id>",
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
          "order_id": "0e8b3a1b-e468-4512-a1a0-3d01eea8f4c5",
          "actions": [
            {
              "action": "book_bundle",
              "bundle_id": "b52624c0-680d-4234-889a-e59b934cd639",
              "product_variations": [
                {
                  "bundle_item_id": "704939e9-4bf1-48f6-ad35-0d0d51504c4b",
                  "product_id": "cd925556-8cb1-4113-bbe8-bab564a3e744"
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
    "id": "2dc653ae-ee44-59c7-89e1-71ecfae3e7f3",
    "type": "order_fulfilments",
    "attributes": {
      "order_id": "0e8b3a1b-e468-4512-a1a0-3d01eea8f4c5"
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


> Book a Product:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/order_fulfilments' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "order_fulfilments",
        "attributes": {
          "order_id": "64ec8773-9480-4ea6-967b-95fe4ad160b5",
          "actions": [
            {
              "action": "book_product",
              "mode": "update_existing",
              "product_id": "837d9019-8ca7-4414-ad20-efab175610fd",
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
    "id": "efbdb8b7-cc25-5803-a748-64df2ddeea60",
    "type": "order_fulfilments",
    "attributes": {
      "order_id": "64ec8773-9480-4ea6-967b-95fe4ad160b5"
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
          "order_id": "86a26013-b9b7-40b5-8ab7-2e36939ab6aa",
          "actions": [
            {
              "action": "book_stock_items",
              "product_id": "68f4d94f-114d-4684-b2c3-52a205370e4c",
              "stock_item_ids": [
                "2a87fb76-cb4d-4cae-bd20-4ad7502f4304",
                "30948630-4067-4803-9fc6-bc4e1a9fac94"
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
    "id": "1e3a098f-8980-5071-a526-9f22ebbcbdf8",
    "type": "order_fulfilments",
    "attributes": {
      "order_id": "86a26013-b9b7-40b5-8ab7-2e36939ab6aa"
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
          "order_id": "113d2c35-0aea-4d84-80dd-fc1d7d95057b",
          "actions": [
            {
              "action": "start_product",
              "product_id": "4627a2b2-e461-4eef-b01b-e876279f94db",
              "planning_id": "93854568-d82b-40e7-bb4d-0a7a8ab6feb5",
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
    "id": "89028dbc-8d19-54ba-8257-33fdc96ac8b8",
    "type": "order_fulfilments",
    "attributes": {
      "order_id": "113d2c35-0aea-4d84-80dd-fc1d7d95057b"
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
          "order_id": "ba2fd95e-0618-4b53-9c2d-22b36bb93747",
          "actions": [
            {
              "action": "start_stock_items",
              "product_id": "6ec90d9e-a8dc-4564-9600-534ec5095fbd",
              "planning_id": "66df5a12-8f5c-4ebb-805e-e85162848365",
              "stock_item_ids": [
                "455a1d57-a413-42af-87ba-b98e02b7e42a"
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
    "id": "bceb7baf-59f5-56a6-99f8-9383de0a0912",
    "type": "order_fulfilments",
    "attributes": {
      "order_id": "ba2fd95e-0618-4b53-9c2d-22b36bb93747"
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
          "order_id": "2a6d7088-0ad2-410d-ac3f-ea396d5a2c3b",
          "actions": [
            {
              "action": "stop_product",
              "product_id": "520702f0-b79e-4626-8aa2-9e0aec6cfbde",
              "planning_id": "faa0202b-8711-4b46-81ae-38c5bb7b6fec",
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
    "id": "23c9da50-0dc9-5c81-aaea-186cbdb94f53",
    "type": "order_fulfilments",
    "attributes": {
      "order_id": "2a6d7088-0ad2-410d-ac3f-ea396d5a2c3b"
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
          "order_id": "001df704-3777-4188-b15b-62f6305cf74b",
          "actions": [
            {
              "action": "stop_stock_items",
              "product_id": "dd1eba6f-a193-49fc-94b8-005dc0166abd",
              "planning_id": "54cf6c16-fa27-47be-9e39-eb1aab70f9d2",
              "stock_item_ids": [
                "94101535-12be-442a-8365-fcd18d714df8"
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
    "id": "c33a2ed0-db8e-5f8b-9f27-99b086127cf2",
    "type": "order_fulfilments",
    "attributes": {
      "order_id": "001df704-3777-4188-b15b-62f6305cf74b"
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





