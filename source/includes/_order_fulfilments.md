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
          "order_id": "0f7972c0-83f5-44c8-8fdf-90574e693938",
          "actions": [
            {
              "action": "book_bundle",
              "bundle_id": "ac8d3eff-f604-4946-a9a0-86116b3f7dbe",
              "product_variations": [
                {
                  "bundle_item_id": "7dcc7c04-51b8-4f3d-818d-3739d0da7e27",
                  "product_id": "3d536238-bf2e-47e3-9229-26ef1e726b51"
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
    "id": "ea5ae1fb-7db6-5426-986c-23b05158650d",
    "type": "order_fulfilments",
    "attributes": {
      "order_id": "0f7972c0-83f5-44c8-8fdf-90574e693938"
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
          "order_id": "da65f6a3-9091-4c22-b712-00299273940c",
          "actions": [
            {
              "action": "book_product",
              "product_id": "e2023f5f-c5bd-428c-a607-2dabbed13ccb",
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
    "id": "06d6e85d-2505-57d0-acf5-e19dcabfac5b",
    "type": "order_fulfilments",
    "attributes": {
      "order_id": "da65f6a3-9091-4c22-b712-00299273940c"
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
          "order_id": "6b617458-07e3-43b0-a2d2-3c107c0254ed",
          "actions": [
            {
              "action": "book_stock_items",
              "product_id": "7a4ed1c5-a52b-42c4-8492-9ce9e1a7f37d",
              "stock_item_ids": [
                "25e7e6fe-0ec8-4a8c-9f1c-7380c7556740",
                "a0e9e4ae-5b4e-4ea7-aca8-d821f6bfa3ec"
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
    "id": "9ea1a9bc-29b3-541c-80ee-cb04b7992f70",
    "type": "order_fulfilments",
    "attributes": {
      "order_id": "6b617458-07e3-43b0-a2d2-3c107c0254ed"
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
          "order_id": "6f437c4b-c3f2-4e3a-afec-00592cc3772f",
          "actions": [
            {
              "action": "start_product",
              "product_id": "799360f7-c405-4844-84bc-3eab92eb1ef6",
              "planning_id": "cb9756c2-969e-4483-8f0e-7442e195c5b2",
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
    "id": "6b9fc08a-84a9-5805-9b23-fc4caec705f6",
    "type": "order_fulfilments",
    "attributes": {
      "order_id": "6f437c4b-c3f2-4e3a-afec-00592cc3772f"
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
          "order_id": "38b6103c-788a-4bd1-8fa2-2b4ae6e15cfd",
          "actions": [
            {
              "action": "start_stock_items",
              "product_id": "f68e3862-0ffe-49c9-87f9-0179db433e7b",
              "planning_id": "7ccbc5a0-ef93-4a97-bfdd-9289d17eca0d",
              "stock_item_ids": [
                "5b273d74-54a6-4b81-8084-54f469c9bcb3"
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
    "id": "a4b81fa7-02ec-5795-80b9-07cb0a419c42",
    "type": "order_fulfilments",
    "attributes": {
      "order_id": "38b6103c-788a-4bd1-8fa2-2b4ae6e15cfd"
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
          "order_id": "f9db9375-c7fe-4e88-a4b7-3268e8a90b89",
          "actions": [
            {
              "action": "stop_product",
              "product_id": "1c77f909-87b4-4d65-a7d5-5f66c3647b27",
              "planning_id": "adefc487-835c-4290-bfb1-053bd264b5e2",
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
    "id": "c33cd889-1905-54fd-92b9-c54c585affdf",
    "type": "order_fulfilments",
    "attributes": {
      "order_id": "f9db9375-c7fe-4e88-a4b7-3268e8a90b89"
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
          "order_id": "0350a07f-028d-453d-9ef8-4125c7be4aeb",
          "actions": [
            {
              "action": "stop_stock_items",
              "product_id": "cf657883-a2eb-478c-8167-86d08c0374e5",
              "planning_id": "4a3f268c-47d4-4b41-9421-eaaed6c5c502",
              "stock_item_ids": [
                "79c5a1be-90ca-4073-82f1-df057b8bee13"
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
    "id": "f373c3a6-a0eb-5773-9475-69a37a7d5fb7",
    "type": "order_fulfilments",
    "attributes": {
      "order_id": "0350a07f-028d-453d-9ef8-4125c7be4aeb"
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





