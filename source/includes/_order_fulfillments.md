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


## Start



> Start StockItems:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/order_fulfillments' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "order_fulfillments",
        "attributes": {
          "order_id": "a7d3d3d1-9ed9-4708-b685-e0e407217f2c",
          "confirm_shortage": null,
          "actions": [
            {
              "action": "start_stock_items",
              "product_id": "865398c0-09fc-421b-80eb-effb92c06e8c",
              "planning_id": "4a53bd59-94ef-4289-8df7-155fb55b45de",
              "stock_item_ids": [
                "a3e52acc-70a9-43a0-a823-ca7a5105a3bc"
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
    "id": "9c2dc6d9-ae3f-5cda-bbbc-1a0399ae7eea",
    "type": "order_fulfillments",
    "attributes": {
      "order_id": "a7d3d3d1-9ed9-4708-b685-e0e407217f2c"
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


> Start a Product:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/order_fulfillments' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "order_fulfillments",
        "attributes": {
          "order_id": "542d8891-57c2-4e58-bd34-25125793a6fc",
          "confirm_shortage": null,
          "actions": [
            {
              "action": "start_product",
              "product_id": "acef5a2b-a786-431e-91fc-894640047175",
              "planning_id": "0d55a519-5a0f-41d9-a280-398113c09e7f",
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
    "id": "1566fbdf-c657-500f-a251-0ed1a126ada7",
    "type": "order_fulfillments",
    "attributes": {
      "order_id": "542d8891-57c2-4e58-bd34-25125793a6fc"
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

`order`


`changed_lines` => 
`item` => 
`photo`






`changed_plannings`


`changed_stock_item_plannings`






## Specify



> Remove a StockItem:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/order_fulfillments' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "order_fulfillments",
        "attributes": {
          "order_id": "c53aa0c3-7d09-400a-b0c1-652aa25dbcf4",
          "actions": [
            {
              "action": "specify_stock_items",
              "product_id": "78f5f044-6dd5-47db-b44c-951c5320c71a",
              "planning_id": "10874f32-c46d-4de2-926d-ffc2ce9d9950",
              "stock_item_ids_to_add": [],
              "stock_item_ids_to_remove": [
                "148a94fd-5999-43a4-ade5-1a7994604cfd"
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
    "id": "3f8ae784-2785-5ff5-ac7d-4a12df71647c",
    "type": "order_fulfillments",
    "attributes": {
      "order_id": "c53aa0c3-7d09-400a-b0c1-652aa25dbcf4"
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


> Add a StockItem:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/order_fulfillments' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "order_fulfillments",
        "attributes": {
          "order_id": "5e3cbf88-82b3-43e4-b72d-dbaf183d1a77",
          "actions": [
            {
              "action": "specify_stock_items",
              "product_id": "0cebc0ba-7d2b-4a2d-a2d0-353af7cf36a9",
              "planning_id": "33d28160-41cd-468c-9528-8ddf418e5bf1",
              "stock_item_ids_to_add": [
                "f5193361-b154-41fc-947e-e48ea73cf969"
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
    "id": "ef620093-6b0d-5931-b743-3e98d998ee92",
    "type": "order_fulfillments",
    "attributes": {
      "order_id": "5e3cbf88-82b3-43e4-b72d-dbaf183d1a77"
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

`order`


`changed_lines` => 
`item` => 
`photo`






`changed_plannings`


`changed_stock_item_plannings`






## Stop



> Stop StockItems:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/order_fulfillments' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "order_fulfillments",
        "attributes": {
          "order_id": "b4229754-aab5-4daa-b68e-35fa0f044016",
          "actions": [
            {
              "action": "stop_stock_items",
              "product_id": "162d785c-0be0-4b3f-8ebe-d1812b6a1316",
              "planning_id": "24195879-7657-4ee0-8f93-adde756ee6dd",
              "stock_item_ids": [
                "0bb21329-b42b-4280-a796-5c479fbf2e18"
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
    "id": "6584ef92-bd10-576b-9b0c-d31fcd1e4d77",
    "type": "order_fulfillments",
    "attributes": {
      "order_id": "b4229754-aab5-4daa-b68e-35fa0f044016"
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


> Stop a Product:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/order_fulfillments' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "order_fulfillments",
        "attributes": {
          "order_id": "9c508b17-568d-4930-9b6d-96098fcdde4e",
          "actions": [
            {
              "action": "stop_product",
              "product_id": "9e0aefee-ca40-4725-8b50-2d015b172388",
              "planning_id": "3b71e647-302d-4e30-b4df-91a06dfc7f61",
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
    "id": "36ffa24f-5e0b-51f0-a05d-c295414aa212",
    "type": "order_fulfillments",
    "attributes": {
      "order_id": "9c508b17-568d-4930-9b6d-96098fcdde4e"
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

`order`


`changed_lines` => 
`item` => 
`photo`






`changed_plannings`


`changed_stock_item_plannings`






## Book



> Book a Product (Update Automatically):

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/order_fulfillments' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "order_fulfillments",
        "attributes": {
          "order_id": "dc527a98-6c07-4e23-b9e0-e0cf5b2b2f8a",
          "confirm_shortage": null,
          "actions": [
            {
              "action": "book_product",
              "mode": "infer_planning",
              "product_id": "c95b1cc2-7d10-4cb1-8204-164d89bd8f1d",
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
    "id": "3eb1481c-5b67-573a-b356-e4c76e918c50",
    "type": "order_fulfillments",
    "attributes": {
      "order_id": "dc527a98-6c07-4e23-b9e0-e0cf5b2b2f8a"
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


> Book a Bundle:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/order_fulfillments' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "order_fulfillments",
        "attributes": {
          "order_id": "810a1dc3-0d97-49c1-ba14-4c3d968326f0",
          "confirm_shortage": null,
          "actions": [
            {
              "action": "book_bundle",
              "bundle_id": "f62a24eb-6a1c-4865-ac87-6ab68daabaa3",
              "quantity": 1,
              "product_variations": [
                {
                  "bundle_item_id": "3059a918-9339-4429-aaad-71a6d4559fde",
                  "product_id": "c8bbd356-1040-4b20-a028-680098ee3abd"
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
    "id": "d08d3f6e-d695-545a-b5ac-7bd739072203",
    "type": "order_fulfillments",
    "attributes": {
      "order_id": "810a1dc3-0d97-49c1-ba14-4c3d968326f0"
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
    --url 'https://example.booqable.com/api/boomerang/order_fulfillments' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "order_fulfillments",
        "attributes": {
          "order_id": "457cea77-6ae4-493c-b625-723b1dc6284c",
          "confirm_shortage": null,
          "actions": [
            {
              "action": "book_stock_items",
              "mode": "infer_planning",
              "product_id": "338c04c6-8b4d-4190-b808-88435d801c4a",
              "stock_item_ids": [
                "a802942e-4931-4b9a-a6b0-15e942e3560e",
                "b1dd52d7-db11-4fff-afe3-801a9b77175a"
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
    "id": "553ba3a5-4935-5c14-a656-b1bba93468ce",
    "type": "order_fulfillments",
    "attributes": {
      "order_id": "457cea77-6ae4-493c-b625-723b1dc6284c"
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
    --url 'https://example.booqable.com/api/boomerang/order_fulfillments' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "order_fulfillments",
        "attributes": {
          "order_id": "26db8f77-089a-40bc-8a12-bba923b24859",
          "confirm_shortage": null,
          "actions": [
            {
              "action": "book_product",
              "mode": "create_new",
              "product_id": "406d8e05-f328-4eed-9fab-65a9627ea2e6",
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
    "id": "2af70457-0e50-5dc7-9668-3476dd2ee172",
    "type": "order_fulfillments",
    "attributes": {
      "order_id": "26db8f77-089a-40bc-8a12-bba923b24859"
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

`order`


`changed_lines` => 
`item` => 
`photo`






`changed_plannings`


`changed_stock_item_plannings`





