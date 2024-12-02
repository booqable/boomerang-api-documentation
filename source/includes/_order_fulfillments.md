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
          "order_id": "c32e4163-8d68-4a71-a78b-fa23eacc7365",
          "confirm_shortage": null,
          "actions": [
            {
              "action": "book_product",
              "mode": "create_new",
              "product_id": "abc540f6-0f61-4274-b106-9ea0abaaa46e",
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
    "id": "5d80b0d0-d97b-50b1-be1f-5613b804044f",
    "type": "order_fulfillments",
    "attributes": {
      "order_id": "c32e4163-8d68-4a71-a78b-fa23eacc7365"
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
          "order_id": "77b6157f-4ee4-4c7b-90cf-53e1cbef6bb6",
          "confirm_shortage": null,
          "actions": [
            {
              "action": "book_product",
              "mode": "infer_planning",
              "product_id": "3a891b7d-53f9-4690-9415-ce3b6cb31c40",
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
    "id": "4eb37973-338c-5505-859f-6d5ef51f82ad",
    "type": "order_fulfillments",
    "attributes": {
      "order_id": "77b6157f-4ee4-4c7b-90cf-53e1cbef6bb6"
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
          "order_id": "7c9389cc-7e39-42e8-9bcb-81f5e63209b0",
          "confirm_shortage": null,
          "actions": [
            {
              "action": "book_product",
              "mode": "update_existing",
              "product_id": "356f9459-9ec3-4ca5-9028-d8c492eb10cf",
              "planning_id": "db8ec2e2-0517-4cc9-bb4e-19ee8b8214b6",
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
    "id": "7b965ba0-3151-5861-81e0-6e9d3e0ce5c5",
    "type": "order_fulfillments",
    "attributes": {
      "order_id": "7c9389cc-7e39-42e8-9bcb-81f5e63209b0"
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
          "order_id": "acfb6667-4514-43c3-b673-fdff5d1a92b8",
          "confirm_shortage": null,
          "actions": [
            {
              "action": "book_stock_items",
              "mode": "infer_planning",
              "product_id": "0daa7640-00dd-4434-8668-400dfdaea67e",
              "stock_item_ids": [
                "a424041b-a048-407c-8d42-baa67de3f49e",
                "298acc66-d509-4405-ae64-467ef15457b5"
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
    "id": "8d6126a1-f070-5012-bf85-d6b073c9bc62",
    "type": "order_fulfillments",
    "attributes": {
      "order_id": "acfb6667-4514-43c3-b673-fdff5d1a92b8"
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
          "order_id": "d4e8383d-bbc9-4825-9a15-6410e57c1b6e",
          "confirm_shortage": null,
          "actions": [
            {
              "action": "book_bundle",
              "bundle_id": "3076ee17-dd79-42be-bf2e-cead81cc3ceb",
              "quantity": 1,
              "product_variations": [
                {
                  "bundle_item_id": "27229be2-4ff0-4f2f-9c74-181503d1b27e",
                  "product_id": "295456d6-9880-4e65-b3af-003840dbb057"
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
    "id": "e1368ab6-4ae1-5c69-99bc-43a747782264",
    "type": "order_fulfillments",
    "attributes": {
      "order_id": "d4e8383d-bbc9-4825-9a15-6410e57c1b6e"
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
          "order_id": "98ddd5bb-e136-4099-a123-db0eb80f9b7c",
          "actions": [
            {
              "action": "specify_stock_items",
              "product_id": "c05c981d-53f5-4717-ba0d-2a45d92483a0",
              "planning_id": "f65fcb12-8fb9-43ab-8fb5-6b1d894ab86b",
              "stock_item_ids_to_add": [
                "f0ae3fc9-0b4a-4d14-abcf-136171a7893c"
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
    "id": "ad592375-74b0-52ae-8b75-fee384bf2cf0",
    "type": "order_fulfillments",
    "attributes": {
      "order_id": "98ddd5bb-e136-4099-a123-db0eb80f9b7c"
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
          "order_id": "eec40209-1d87-4ce2-8564-08ea2160ffd7",
          "actions": [
            {
              "action": "specify_stock_items",
              "product_id": "67804e6b-b1bd-434f-928a-533cd2eab634",
              "planning_id": "57a4a649-2455-4215-ae0a-165955f50e96",
              "stock_item_ids_to_add": [],
              "stock_item_ids_to_remove": [
                "9ab89ed0-0199-4eb1-a77d-0412637b0162"
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
    "id": "71de0b16-e9ba-587f-9492-2188e0443b59",
    "type": "order_fulfillments",
    "attributes": {
      "order_id": "eec40209-1d87-4ce2-8564-08ea2160ffd7"
    },
    "relationships": {
      "changed_stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "ca6d6ad1-47fb-40e8-80f6-e57f2ed1fb15"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "ca6d6ad1-47fb-40e8-80f6-e57f2ed1fb15",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2024-12-02T13:03:16.296352+00:00",
        "updated_at": "2024-12-02T13:03:16.423208+00:00",
        "archived": true,
        "archived_at": "2024-12-02T13:03:16.416342+00:00",
        "reserved": false,
        "started": false,
        "stopped": false,
        "stock_item_id": "9ab89ed0-0199-4eb1-a77d-0412637b0162",
        "planning_id": "57a4a649-2455-4215-ae0a-165955f50e96",
        "order_id": "eec40209-1d87-4ce2-8564-08ea2160ffd7"
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
          "order_id": "92b9662e-2cda-4aff-b525-579393a64042",
          "confirm_shortage": null,
          "actions": [
            {
              "action": "start_product",
              "product_id": "051ab6bb-50e3-4869-910a-5593821a616b",
              "planning_id": "4a327446-1cdc-4f60-8218-79dda108b097",
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
    "id": "f922fbc5-8810-5697-90c0-6b447bc600e7",
    "type": "order_fulfillments",
    "attributes": {
      "order_id": "92b9662e-2cda-4aff-b525-579393a64042"
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
          "order_id": "3c24a70d-9c36-4a27-851b-57495234a96b",
          "confirm_shortage": null,
          "actions": [
            {
              "action": "start_stock_items",
              "product_id": "5f5cd9f0-55d7-4801-91fa-b7976f65fbf8",
              "planning_id": "f917c398-666b-4766-a7a4-c557cdf82656",
              "stock_item_ids": [
                "73be3a28-f0cc-4081-aa40-254901ff210d"
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
    "id": "ad57b663-8f8d-57c2-a434-a88238dc3478",
    "type": "order_fulfillments",
    "attributes": {
      "order_id": "3c24a70d-9c36-4a27-851b-57495234a96b"
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
          "order_id": "fbcd3afe-0498-4a75-977b-8295fef32bdc",
          "actions": [
            {
              "action": "stop_product",
              "product_id": "a36b4472-9c67-42d9-8cf8-877a216203c4",
              "planning_id": "b3107b0d-a0b5-48a5-91b9-b57195e45c0c",
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
    "id": "0be33a9a-11ec-593f-ad4d-cd65377486e8",
    "type": "order_fulfillments",
    "attributes": {
      "order_id": "fbcd3afe-0498-4a75-977b-8295fef32bdc"
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
          "order_id": "a62abda3-9610-4ace-8147-0ed53879e975",
          "actions": [
            {
              "action": "stop_stock_items",
              "product_id": "a5636426-e4ea-4edc-94c0-f22482416e5c",
              "planning_id": "b831b778-0bfe-499c-a040-f47d5556c879",
              "stock_item_ids": [
                "b90c8009-649d-466e-8aec-388cb5c2c1fd"
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
    "id": "7bcdfb1b-ee1f-5943-8f9a-e49debf5d6f3",
    "type": "order_fulfillments",
    "attributes": {
      "order_id": "a62abda3-9610-4ace-8147-0ed53879e975"
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







