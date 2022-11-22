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

```json
{
  "action": "book_product",
  "product_id": "<id>",
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
          "order_id": "286710dc-7017-408d-b070-31f9a51e1b76",
          "actions": [
            {
              "action": "book_bundle",
              "bundle_id": "a379703d-00d6-41d0-95d0-ea7b63d71419",
              "product_variations": [
                {
                  "bundle_item_id": "77f166ff-c507-4cf4-bbff-1b09934bd337",
                  "product_id": "6979eb50-354d-4948-af62-69299cfb8b44"
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
    "id": "3381e837-b1a8-59ce-927e-aaac06601187",
    "type": "order_fulfilments",
    "attributes": {
      "order_id": "286710dc-7017-408d-b070-31f9a51e1b76"
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
          "order_id": "253f4600-584f-484c-bcbc-45f74be55064",
          "actions": [
            {
              "action": "book_product",
              "product_id": "bfe1c5c6-4f5c-46c7-88ad-a1c04a9f5401",
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
    "id": "62f77548-b44a-50bf-bf0f-1731f205a097",
    "type": "order_fulfilments",
    "attributes": {
      "order_id": "253f4600-584f-484c-bcbc-45f74be55064"
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
          "order_id": "e1c3c70c-26a3-4e9b-8f82-948fb9b4b65e",
          "actions": [
            {
              "action": "book_stock_items",
              "product_id": "a76a7aeb-60c8-416b-8414-4190b2d26a78",
              "stock_item_ids": [
                "d095f57d-8492-4aac-84bb-d3ee98a8d4c5",
                "b7fdadce-0895-4cf2-8d46-c54b781c15f6"
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
    "id": "3fab0edc-9f2f-555d-bb04-76f74c7908df",
    "type": "order_fulfilments",
    "attributes": {
      "order_id": "e1c3c70c-26a3-4e9b-8f82-948fb9b4b65e"
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
          "order_id": "3dc6f968-668c-432e-8238-dda89220c066",
          "actions": [
            {
              "action": "start_product",
              "product_id": "f8f642a9-76e1-4fdc-8862-79dbcacc4e2b",
              "planning_id": "375fbf9a-7142-41c4-8075-39fe1f0ae539",
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
    "id": "f0583bce-31a8-562e-b44e-415a53742604",
    "type": "order_fulfilments",
    "attributes": {
      "order_id": "3dc6f968-668c-432e-8238-dda89220c066"
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
          "order_id": "2c316877-e18d-4a86-91f9-20fc465b10e9",
          "actions": [
            {
              "action": "start_stock_items",
              "product_id": "75151fee-b613-43e2-8801-91b31805ff04",
              "planning_id": "5b1095a9-5d99-4faa-a8db-8d329d1c427c",
              "stock_item_ids": [
                "95b76a58-dd29-40bd-b492-8b6a5e81f6de"
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
    "id": "b1e55f09-b39a-55c6-b33e-96ff97cd7690",
    "type": "order_fulfilments",
    "attributes": {
      "order_id": "2c316877-e18d-4a86-91f9-20fc465b10e9"
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
          "order_id": "ed9bafc2-b141-4d0a-82f3-a2ac2f020f20",
          "actions": [
            {
              "action": "stop_product",
              "product_id": "078a1845-032d-4c01-bdd4-c9f4f10125b3",
              "planning_id": "5582debf-4207-4c92-b4f4-3e0951a96881",
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
    "id": "56d6971a-d683-598f-aaeb-bc5b549aff1e",
    "type": "order_fulfilments",
    "attributes": {
      "order_id": "ed9bafc2-b141-4d0a-82f3-a2ac2f020f20"
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
          "order_id": "bc8d65bc-61c1-47dc-9096-a7b1c2a10ea5",
          "actions": [
            {
              "action": "stop_stock_items",
              "product_id": "73959e28-edfb-42a4-aa46-c343a4caba53",
              "planning_id": "76e54504-b4d5-4584-a9c2-d47211dfb996",
              "stock_item_ids": [
                "36b2caa7-b544-409b-ae0d-a5384ac8967b"
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
    "id": "30d390a9-77ce-5cb6-8c24-2f08a5bd8c07",
    "type": "order_fulfilments",
    "attributes": {
      "order_id": "bc8d65bc-61c1-47dc-9096-a7b1c2a10ea5"
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





