# Order status transitions

Transitions the status of an `Order` to another status.

See [`Order`](#orders) for a desciption of the different statuses.

Note that you can not transition to `started` or to `stopped`.
The `Order` will transition to those statuses automatically when
starting or stopping items through the [Fulfillment API](#fulfillments).
It is however possible to revert to the `started` or the `stopped` status.

### Errors

When the Order can not be transitioned, and `error.code` is `items_not_available`,
then the `error.meta.blocking.*.reason` or `error.meta.warning.*.reason`
attribute contains one of the following reasons:

- `stock_item_specified`
  One or more of the `StockItems` on this `Order` have also been planned
  for other current or future `Orders`. The Product is specified in
  the `error.meta.blocking.*.item_id` attribute
  and `error.meta.blocking.*.unavailable` contains the problematic StockItems.

- `shortage`
  A shortage would be created for one or more of the `Products` on this `Order`.
  When the shortages would within the shortage limits of the products,
  a warning is returned. Otherwise a blocking error is returned.
  When reserving an Order, a warning can be overriden by setting `confirm_shortage` to `true`.
  The Product is specified in the `error.meta.warning.*.item_id` or
  `error.meta.blocking.*.item_id` attribute.

Note that is is possible to get multiple warnings and errors of different
types at the same time.

### Permissions

- Canceling an Order requires the `cancel_orders` permission.
- Reverting an Order requires the `revert_orders` permission.

## Fields
Every order status transition has the following fields:

Name | Description
- | -
`id` | **Uuid** `readonly`<br>
`order_id` | **Uuid** <br>The associated Order
`transition_from` | **String_enum** <br>The current status of the Order. One of: `new`, `concept`, `reserved`, `started`, `stopped`, `archived`, `canceled`. 
`transition_to` | **String_enum** <br>The new status of the Order. One of: `concept`, `reserved`, `started`, `stopped`, `archived`, `canceled`.<br>It is only possible to transition to `started` or `stopped` in combination with `revert: true`. 
`revert` | **Boolean** <br>Indicates if this transition reverts the Order back to an earlier status. "Earlier status" does not require this specific Order to ever have been in that status (e.g. `concept` can have been skipped). "Earlier" means earlier in the conceptual progressing of statuses of Orders in general. 
`confirm_shortage` | **Boolean** <br>A value of `true` overrides shortage warnings. This is only possible when _reserving_ an Order. 


## Relationships
Order status transitions have the following relationships:

Name | Description
- | -
`order` | **Orders** `readonly`<br>Associated Order


## Transition



> Save a new Order as concept:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/order_status_transitions' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "order_status_transitions",
        "attributes": {
          "order_id": "47883c71-2d51-48fe-af7a-81efe46ef80e",
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
    "id": "bfe90a6b-eca0-56db-b121-68c3ec9b1fa4",
    "type": "order_status_transitions",
    "attributes": {
      "order_id": "47883c71-2d51-48fe-af7a-81efe46ef80e",
      "transition_from": "new",
      "transition_to": "concept",
      "revert": null,
      "confirm_shortage": null
    },
    "relationships": {
      "order": {
        "meta": {
          "included": false
        }
      }
    }
  },
  "meta": {}
}
```


> Reserve a concept Order:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/order_status_transitions' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "order_status_transitions",
        "attributes": {
          "order_id": "4ef1f784-ae5f-4aa7-a242-cd9f3c23e6b8",
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
    "id": "a6cf937d-cc69-52f6-ad7f-4e8aa9cc03cc",
    "type": "order_status_transitions",
    "attributes": {
      "order_id": "4ef1f784-ae5f-4aa7-a242-cd9f3c23e6b8",
      "transition_from": "concept",
      "transition_to": "reserved",
      "revert": null,
      "confirm_shortage": null
    },
    "relationships": {
      "order": {
        "meta": {
          "included": false
        }
      }
    }
  },
  "meta": {}
}
```


> Reserve a concept Order, causing a blocking shortage error:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/order_status_transitions' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "order_status_transitions",
        "attributes": {
          "order_id": "e7944483-bdc0-4521-870c-ea306ac5a60a",
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
            "item_id": "8e034812-7bdf-45f5-9f87-c320e39705e3",
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
    --url 'https://example.booqable.com/api/boomerang/order_status_transitions' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "order_status_transitions",
        "attributes": {
          "order_id": "8abcc1b3-2913-4a20-996b-2d5af47200cc",
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
            "item_id": "f79e21df-bf28-4b28-9503-d9fc9c8f3a08",
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
    --url 'https://example.booqable.com/api/boomerang/order_status_transitions' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "order_status_transitions",
        "attributes": {
          "order_id": "6b49114a-8a31-4e46-96d6-843b2667ccfc",
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
    "id": "5807c106-aab3-54e0-9c65-a550fa3e45d9",
    "type": "order_status_transitions",
    "attributes": {
      "order_id": "6b49114a-8a31-4e46-96d6-843b2667ccfc",
      "transition_from": "concept",
      "transition_to": "reserved",
      "revert": null,
      "confirm_shortage": true
    },
    "relationships": {
      "order": {
        "meta": {
          "included": false
        }
      }
    }
  },
  "meta": {}
}
```


> Reserve a concept Order, causing a stock item specified error:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/order_status_transitions' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "order_status_transitions",
        "attributes": {
          "order_id": "14833efb-44be-4d00-b480-06e1e39b2885",
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
            "reason": "stock_item_specified",
            "item_id": "1d05ec15-90aa-4576-bfc9-549ad5e695a0",
            "unavailable": [
              "e3f53adf-f4ad-48bb-b516-bb994e73427a"
            ],
            "available": [
              "04d91eed-d471-4aad-82f5-50e2db3b8597"
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
    --url 'https://example.booqable.com/api/boomerang/order_status_transitions' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "order_status_transitions",
        "attributes": {
          "order_id": "579aab64-396a-4989-83a8-ea3bf85921dd",
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
    --url 'https://example.booqable.com/api/boomerang/order_status_transitions' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "order_status_transitions",
        "attributes": {
          "order_id": "77b72232-afc0-4fe2-bc1d-d5563525e647",
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
    "id": "fa99dd5f-a86d-5ac9-bb7d-f6a1719d0fbc",
    "type": "order_status_transitions",
    "attributes": {
      "order_id": "77b72232-afc0-4fe2-bc1d-d5563525e647",
      "transition_from": "stopped",
      "transition_to": "archived",
      "revert": null,
      "confirm_shortage": null
    },
    "relationships": {
      "order": {
        "meta": {
          "included": false
        }
      }
    }
  },
  "meta": {}
}
```


> Revert a reserved Order to 'concept':

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/order_status_transitions' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "order_status_transitions",
        "attributes": {
          "order_id": "4b0f7450-533e-4ac9-a34b-5f51a86a88b1",
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
    "id": "6cdb2027-6f33-518c-94b8-7906bb3c03a0",
    "type": "order_status_transitions",
    "attributes": {
      "order_id": "4b0f7450-533e-4ac9-a34b-5f51a86a88b1",
      "transition_from": "reserved",
      "transition_to": "concept",
      "revert": true,
      "confirm_shortage": null
    },
    "relationships": {
      "order": {
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

`POST /api/boomerang/order_status_transitions`

### Request params

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=order`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[order_status_transitions]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][order_id]` | **Uuid** <br>The associated Order
`data[attributes][transition_from]` | **String_enum** <br>The current status of the Order. One of: `new`, `concept`, `reserved`, `started`, `stopped`, `archived`, `canceled`. 
`data[attributes][transition_to]` | **String_enum** <br>The new status of the Order. One of: `concept`, `reserved`, `started`, `stopped`, `archived`, `canceled`.<br>It is only possible to transition to `started` or `stopped` in combination with `revert: true`. 
`data[attributes][revert]` | **Boolean** <br>Indicates if this transition reverts the Order back to an earlier status. "Earlier status" does not require this specific Order to ever have been in that status (e.g. `concept` can have been skipped). "Earlier" means earlier in the conceptual progressing of statuses of Orders in general. 
`data[attributes][confirm_shortage]` | **Boolean** <br>A value of `true` overrides shortage warnings. This is only possible when _reserving_ an Order. 


### Includes

This request accepts the following includes:

`order`





