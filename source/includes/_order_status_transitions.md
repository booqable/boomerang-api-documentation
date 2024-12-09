# Order status transitions

Transitions an Order from one status to another status.

See [Order](#orders-statuses) for a description of the different statuses.

Note that you can not transition to `started` or to `stopped`.
The Order will transition to those statuses automatically when
starting or stopping items through the [OrderFulfillment](#fulfillments) resource.
It is however possible to revert to the `started` or the `stopped` status.

It is not possible to resurrect a canceled order.
[Duplicating](#order-duplications) a canceled order is possible.

**Errors**

When the Order can not be transitioned, and `error.code` is `items_not_available`,
then the `error.meta.blocking.*.reason` or `error.meta.warning.*.reason`
attribute contains one of the following reasons:

- `stock_item_specified`
  One or more of the StockItems on this Order have also been planned
  for other current or future `Orders`. The Product is specified in
  the `error.meta.blocking.*.item_id` attribute
  and `error.meta.blocking.*.unavailable` contains the problematic StockItems.

- `shortage`
  A shortage would be created for one or more of the Products on this Order.
  When the shortages would within the shortage limits of the products,
  a warning is returned. Otherwise a blocking error is returned.
  When reserving an Order, a warning can be overriden by setting `confirm_shortage` to `true`.
  The Product is specified in the `error.meta.warning.*.item_id` or
  `error.meta.blocking.*.item_id` attribute.

Note that is is possible to get multiple warnings and errors of different
types at the same time.

**Permissions**

- Canceling an Order requires the `cancel_orders` permission.
- Reverting an Order requires the `revert_orders` permission.

## Relationships
Name | Description
-- | --
`order` | **[Order](#orders)** `required`<br>The order whose status is changed. 


Check matching attributes under [Fields](#order-status-transitions-fields) to see which relations can be written.
<br/ >
Check each individual operation to see which relations can be included as a sideload.
## Fields

 Name | Description
-- | --
`confirm_shortage` | **boolean** <br>A value of `true` overrides shortage warnings. This is only possible when _reserving_ an Order. 
`id` | **uuid** `readonly`<br>Primary key.
`order_id` | **uuid** <br>The order whose status is changed. 
`revert` | **boolean** <br>Indicates if this transition reverts the Order back to an earlier status. "Earlier status" does not require this specific Order to ever have been in that status (e.g. `concept` can have been skipped). "Earlier" means earlier in the conceptual progressing of statuses of Orders in general. 
`transition_from` | **enum** <br>The current status of the Order.<br> One of: `new`, `concept`, `reserved`, `started`, `stopped`, `archived`.
`transition_to` | **enum** <br>The new status of the Order. It is only possible to transition to `started` or `stopped` in combination with `revert: true`.<br> One of: `concept`, `reserved`, `archived`, `canceled`.


## Transition


> Save a new Order as concept:

```shell
  curl --request POST \
       --url 'https://example.booqable.com/api/boomerang/order_status_transitions'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "type": "order_status_transitions",
           "attributes": {
             "order_id": "62131d2f-0b4a-45c7-86b9-1ad5fa771371",
             "transition_from": "new",
             "transition_to": "concept",
             "confirm_shortage": null,
             "revert": null
           }
         }
       }'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "1fa8da73-0d9d-433a-804e-2a196a6bf1a9",
      "type": "order_status_transitions",
      "attributes": {
        "order_id": "62131d2f-0b4a-45c7-86b9-1ad5fa771371",
        "transition_from": "new",
        "transition_to": "concept",
        "revert": null,
        "confirm_shortage": null
      },
      "relationships": {}
    },
    "meta": {}
  }
```

> Reserve a concept Order:

```shell
  curl --request POST \
       --url 'https://example.booqable.com/api/boomerang/order_status_transitions'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "type": "order_status_transitions",
           "attributes": {
             "order_id": "7dbb33d6-22c9-446f-89d0-66f6220a9d65",
             "transition_from": "concept",
             "transition_to": "reserved",
             "confirm_shortage": null,
             "revert": null
           }
         }
       }'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "5ef4d6e7-b7b6-49e8-853b-391f288a55eb",
      "type": "order_status_transitions",
      "attributes": {
        "order_id": "7dbb33d6-22c9-446f-89d0-66f6220a9d65",
        "transition_from": "concept",
        "transition_to": "reserved",
        "revert": null,
        "confirm_shortage": null
      },
      "relationships": {}
    },
    "meta": {}
  }
```

> Reserve a concept Order, causing a blocking shortage error:

```shell
  curl --request POST \
       --url 'https://example.booqable.com/api/boomerang/order_status_transitions'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "type": "order_status_transitions",
           "attributes": {
             "order_id": "2399cd14-2f8a-4ebb-8366-714552f1e32b",
             "transition_from": "concept",
             "transition_to": "reserved",
             "confirm_shortage": null,
             "revert": null
           }
         }
       }'
```

> A 422 status response looks like this:

```json
  {
    "errors": [
      {
        "code": "items_not_available",
        "status": "422",
        "title": "Items not available",
        "detail": "One or more items are not available",
        "meta": {
          "warning": [],
          "blocking": [
            {
              "reason": "shortage",
              "item_id": "63849ebc-fadc-4dd3-8611-21c03eacb114",
              "stock_count": 1,
              "reserved": 0,
              "needed": 2,
              "shortage": 1
            }
          ]
        }
      }
    ]
  }
```

> Reserve a concept Order, causing a shortage warning:

```shell
  curl --request POST \
       --url 'https://example.booqable.com/api/boomerang/order_status_transitions'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "type": "order_status_transitions",
           "attributes": {
             "order_id": "c0d42a57-6fb6-4727-8434-e9dea5e2810f",
             "transition_from": "concept",
             "transition_to": "reserved",
             "confirm_shortage": null,
             "revert": null
           }
         }
       }'
```

> A 422 status response looks like this:

```json
  {
    "errors": [
      {
        "code": "items_not_available",
        "status": "422",
        "title": "Items not available",
        "detail": "One or more items are not available",
        "meta": {
          "warning": [
            {
              "reason": "shortage",
              "item_id": "64959486-4cff-4185-8698-fbebc82a4b0a",
              "stock_count": 1,
              "reserved": 0,
              "needed": 2,
              "shortage": 1
            }
          ],
          "blocking": []
        }
      }
    ]
  }
```

> Reserve a concept Order, and override the shortage warning:

```shell
  curl --request POST \
       --url 'https://example.booqable.com/api/boomerang/order_status_transitions'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "type": "order_status_transitions",
           "attributes": {
             "order_id": "ef64f4c5-c58f-4eac-87dd-0e2aaf793449",
             "transition_from": "concept",
             "transition_to": "reserved",
             "confirm_shortage": true,
             "revert": null
           }
         }
       }'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "fab25b98-897a-498a-86f7-6bfa4924a705",
      "type": "order_status_transitions",
      "attributes": {
        "order_id": "ef64f4c5-c58f-4eac-87dd-0e2aaf793449",
        "transition_from": "concept",
        "transition_to": "reserved",
        "revert": null,
        "confirm_shortage": true
      },
      "relationships": {}
    },
    "meta": {}
  }
```

> Reserve a concept Order, causing a stock item specified error:

```shell
  curl --request POST \
       --url 'https://example.booqable.com/api/boomerang/order_status_transitions'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "type": "order_status_transitions",
           "attributes": {
             "order_id": "89b5f18e-b5b8-453a-8cb8-a4e79f99c9d0",
             "transition_from": "concept",
             "transition_to": "reserved",
             "confirm_shortage": null,
             "revert": null
           }
         }
       }'
```

> A 422 status response looks like this:

```json
  {
    "errors": [
      {
        "code": "stock_item_specified",
        "status": "422",
        "title": "Stock item specified",
        "detail": "One or more items are not available",
        "meta": {
          "warning": [],
          "blocking": [
            {
              "reason": "stock_item_specified",
              "item_id": "baae48c1-e963-41f1-8a93-0f81328d655c",
              "unavailable": [
                "26a12ea9-faa5-4459-8bb4-6caf9defd51b"
              ],
              "available": [
                "ca78a0ea-16b3-4fdc-8c92-ddb1caff31d5"
              ]
            }
          ]
        }
      }
    ]
  }
```

> Archive a reserved Order:

```shell
  curl --request POST \
       --url 'https://example.booqable.com/api/boomerang/order_status_transitions'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "type": "order_status_transitions",
           "attributes": {
             "order_id": "428183f9-884f-4ead-885c-96af503180de",
             "transition_from": "reserved",
             "transition_to": "archived",
             "confirm_shortage": null,
             "revert": null
           }
         }
       }'
```

> A 422 status response looks like this:

```json
  {
    "errors": [
      {
        "code": "wrong_status",
        "status": "422",
        "title": "Wrong status",
        "detail": "Can't transition order from 'reserved' to 'archived'",
        "meta": null
      }
    ]
  }
```

> Archive a stopped Order:

```shell
  curl --request POST \
       --url 'https://example.booqable.com/api/boomerang/order_status_transitions'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "type": "order_status_transitions",
           "attributes": {
             "order_id": "6fde1091-2638-4df5-8664-cf228c0441db",
             "transition_from": "stopped",
             "transition_to": "archived",
             "confirm_shortage": null,
             "revert": null
           }
         }
       }'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "ec20fd1d-c123-48d0-81e5-eae2c73f75e3",
      "type": "order_status_transitions",
      "attributes": {
        "order_id": "6fde1091-2638-4df5-8664-cf228c0441db",
        "transition_from": "stopped",
        "transition_to": "archived",
        "revert": null,
        "confirm_shortage": null
      },
      "relationships": {}
    },
    "meta": {}
  }
```

> Revert a reserved Order to 'concept':

```shell
  curl --request POST \
       --url 'https://example.booqable.com/api/boomerang/order_status_transitions'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "type": "order_status_transitions",
           "attributes": {
             "order_id": "4c006f3f-83ed-40c6-896c-d90896be4b70",
             "transition_from": "reserved",
             "transition_to": "concept",
             "confirm_shortage": null,
             "revert": true
           }
         }
       }'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "2c60e84f-cbcb-411d-8ef9-47385236371f",
      "type": "order_status_transitions",
      "attributes": {
        "order_id": "4c006f3f-83ed-40c6-896c-d90896be4b70",
        "transition_from": "reserved",
        "transition_to": "concept",
        "revert": true,
        "confirm_shortage": null
      },
      "relationships": {}
    },
    "meta": {}
  }
```

### HTTP Request

`POST /api/boomerang/order_status_transitions`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma seperated fields to include `?fields[order_status_transitions]=order_id,transition_from,transition_to`
`include` | **string** <br>List of comma seperated relationships `?include=order`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][confirm_shortage]` | **boolean** <br>A value of `true` overrides shortage warnings. This is only possible when _reserving_ an Order. 
`data[attributes][order_id]` | **uuid** <br>The order whose status is changed. 
`data[attributes][revert]` | **boolean** <br>Indicates if this transition reverts the Order back to an earlier status. "Earlier status" does not require this specific Order to ever have been in that status (e.g. `concept` can have been skipped). "Earlier" means earlier in the conceptual progressing of statuses of Orders in general. 
`data[attributes][transition_from]` | **enum** <br>The current status of the Order.<br> One of: `new`, `concept`, `reserved`, `started`, `stopped`, `archived`.
`data[attributes][transition_to]` | **enum** <br>The new status of the Order. It is only possible to transition to `started` or `stopped` in combination with `revert: true`.<br> One of: `concept`, `reserved`, `archived`, `canceled`.


### Includes

This request accepts the following includes:

`order` => 
`plannings`


`stock_item_plannings`







