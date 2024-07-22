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
          "order_id": "fb6a9eb0-2f73-42e2-80df-48bd2135bbdd",
          "confirm_shortage": null,
          "actions": [
            {
              "action": "book_product",
              "mode": "create_new",
              "product_id": "22349424-3c4c-4a79-878c-368c4e9bb37a",
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
    "id": "e3d611f1-fc45-581c-bc28-d66706e20d3e",
    "type": "order_fulfillments",
    "attributes": {
      "order_id": "fb6a9eb0-2f73-42e2-80df-48bd2135bbdd"
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
          "order_id": "0cc75915-7f92-40da-a9c5-35c5d130b86c",
          "confirm_shortage": null,
          "actions": [
            {
              "action": "book_product",
              "mode": "infer_planning",
              "product_id": "f98c4de0-289e-477b-8eee-c33c0e864cb8",
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
    "id": "0b3afa07-bf15-5fc0-a535-59b3ec832fd6",
    "type": "order_fulfillments",
    "attributes": {
      "order_id": "0cc75915-7f92-40da-a9c5-35c5d130b86c"
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
          "order_id": "bda1b1e9-b35b-49a2-a08b-0544476133dd",
          "confirm_shortage": null,
          "actions": [
            {
              "action": "book_product",
              "mode": "update_existing",
              "product_id": "246eebe5-d10f-42c5-965c-e2c7ab06ede3",
              "planning_id": "f844d8c9-1a5d-48f4-ab7d-f3556fb3f1e1",
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
    "id": "4c026565-1044-5620-a7b7-b7da9bd99e3f",
    "type": "order_fulfillments",
    "attributes": {
      "order_id": "bda1b1e9-b35b-49a2-a08b-0544476133dd"
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
          "order_id": "bfed41cc-e610-4b8e-9da3-ae4bed94665d",
          "confirm_shortage": null,
          "actions": [
            {
              "action": "book_stock_items",
              "mode": "infer_planning",
              "product_id": "150f317b-f7df-4d92-a1fe-1bbf2fc77d72",
              "stock_item_ids": [
                "38ee5d20-36f7-449f-bbfa-2c0d6a0cc7b3",
                "23c70275-3aa3-48d9-9b22-fcd6dca7121d"
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
    "id": "9fbc1487-e409-5946-a42e-86b5343cde37",
    "type": "order_fulfillments",
    "attributes": {
      "order_id": "bfed41cc-e610-4b8e-9da3-ae4bed94665d"
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
          "order_id": "7deff3a1-1e2e-4571-9d45-bf606e844160",
          "confirm_shortage": null,
          "actions": [
            {
              "action": "book_bundle",
              "bundle_id": "f9eb6680-6cfc-4641-ae1c-5cebf6cb37c8",
              "quantity": 1,
              "product_variations": [
                {
                  "bundle_item_id": "0a9e26c6-ef16-45f5-9491-f4a6b0c5de25",
                  "product_id": "4e1b84dc-1458-459e-8bdc-d5657858453d"
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
    "id": "85e7664b-9635-54ce-ad07-07afe3ed22fc",
    "type": "order_fulfillments",
    "attributes": {
      "order_id": "7deff3a1-1e2e-4571-9d45-bf606e844160"
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
          "order_id": "297c3638-c090-4428-894c-85bccb163fbc",
          "actions": [
            {
              "action": "specify_stock_items",
              "product_id": "ccbd7f43-1bad-458c-8e7d-f49bd07f9de4",
              "planning_id": "0710a228-a09d-4f4a-ae3e-e35ebd035d41",
              "stock_item_ids_to_add": [
                "dc0b46df-c8c1-423d-b7da-e12320c9ba46"
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
    "id": "8278e515-dbcb-59b1-8107-64d1f2949771",
    "type": "order_fulfillments",
    "attributes": {
      "order_id": "297c3638-c090-4428-894c-85bccb163fbc"
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
          "order_id": "c731ddf3-67c7-4d8f-8897-c44f1163bf79",
          "actions": [
            {
              "action": "specify_stock_items",
              "product_id": "10263434-1e01-4ef1-b407-00f29a02a894",
              "planning_id": "f6018c92-272f-4485-8ef0-f15a9d344791",
              "stock_item_ids_to_add": [],
              "stock_item_ids_to_remove": [
                "5d0d28c3-e233-4df1-9639-190893413ff3"
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
    "id": "05cb1e57-32b7-5b7e-bd63-cbe47037ea66",
    "type": "order_fulfillments",
    "attributes": {
      "order_id": "c731ddf3-67c7-4d8f-8897-c44f1163bf79"
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
          "order_id": "aa7e4a52-8172-4c33-94f0-13a17844f2c7",
          "confirm_shortage": null,
          "actions": [
            {
              "action": "start_product",
              "product_id": "f3b41879-0ea7-4ba6-8f07-16bdfeecf627",
              "planning_id": "3be58f41-8f38-48a2-9467-578d40918108",
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
    "id": "29079f37-03cf-5f9a-b18a-26f834cd539e",
    "type": "order_fulfillments",
    "attributes": {
      "order_id": "aa7e4a52-8172-4c33-94f0-13a17844f2c7"
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
          "order_id": "5c7cc909-2992-4d0b-be46-f3113a618cd8",
          "confirm_shortage": null,
          "actions": [
            {
              "action": "start_stock_items",
              "product_id": "76a27e99-b427-483d-b711-36bb0bd0df4e",
              "planning_id": "7d10102f-a5f0-4710-a626-8128622c9109",
              "stock_item_ids": [
                "446c83fd-162c-4e6b-a8ad-44b3c0bf5eed"
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
    "id": "6da69833-b023-50c6-aef5-cec71442f717",
    "type": "order_fulfillments",
    "attributes": {
      "order_id": "5c7cc909-2992-4d0b-be46-f3113a618cd8"
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
          "order_id": "adc9665e-51b6-4e52-9a8b-22d91cd2be09",
          "actions": [
            {
              "action": "stop_product",
              "product_id": "2c92485b-6603-41f3-b1e2-0d745b213e1d",
              "planning_id": "672b2399-77f3-46ca-ae5c-dd751a5f8ec6",
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
    "id": "1ac6aed1-e1b2-509f-89bf-21b5b433b5e3",
    "type": "order_fulfillments",
    "attributes": {
      "order_id": "adc9665e-51b6-4e52-9a8b-22d91cd2be09"
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
          "order_id": "1f58d831-4d26-4b94-9b5a-783f3ef43dca",
          "actions": [
            {
              "action": "stop_stock_items",
              "product_id": "d4be6c58-b08b-4f81-b6e2-ee37a174572c",
              "planning_id": "aa554851-bdf1-4d3e-8f63-c75b3ee4d7d8",
              "stock_item_ids": [
                "62777fdd-3188-4e8e-8e7f-a60785d66ae7"
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
    "id": "002575e3-7645-5762-989c-fb6fd1cdd3b2",
    "type": "order_fulfillments",
    "attributes": {
      "order_id": "1f58d831-4d26-4b94-9b5a-783f3ef43dca"
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







