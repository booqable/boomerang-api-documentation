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
          "order_id": "6a7d9fa3-0c21-4bdf-bdc7-8eb426c0c0f3",
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
    "id": "8b419a02-9f6b-5f4f-bc68-ba89da2bfc6c",
    "type": "order_status_transitions",
    "attributes": {
      "order_id": "6a7d9fa3-0c21-4bdf-bdc7-8eb426c0c0f3",
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
          "order_id": "1af3183e-167e-4e20-8dfb-29f3736d109c",
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
    "id": "3498cab0-59b3-5c35-a32f-572f6e1e2206",
    "type": "order_status_transitions",
    "attributes": {
      "order_id": "1af3183e-167e-4e20-8dfb-29f3736d109c",
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
          "order_id": "05ec45a3-f9e8-48fd-ab59-ebeb92c674cb",
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
            "item_id": "d374c7cc-1a17-4b6f-b647-765a21319d27",
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
          "order_id": "47c713af-62a4-4e78-973f-0c25119720d6",
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
            "item_id": "9c1039ca-2827-4cbb-8950-3412d32821b1",
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
          "order_id": "b31c3b81-af7f-4291-89e3-ec81fe5c45e5",
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
    "id": "79ffe06b-35a4-566e-86b0-f3a6d3d60cb4",
    "type": "order_status_transitions",
    "attributes": {
      "order_id": "b31c3b81-af7f-4291-89e3-ec81fe5c45e5",
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
          "order_id": "00bc9046-e7dd-43a4-a70d-4dfbb4ce5c96",
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
            "item_id": "44a2994a-37c3-4b03-897d-8b36eff63be5",
            "unavailable": [
              "65024c2b-d6aa-4a1b-9dfd-1a5f111a2059"
            ],
            "available": [
              "5119788d-5c7f-4fbf-86d4-f938b0992adb"
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
          "order_id": "64b9a7ed-849d-41a4-bb2b-54ebc8ef60e1",
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
          "order_id": "9829d05a-b509-4d2d-ae7a-082d1370d607",
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
    "id": "d117fcc0-27a5-545a-a3e7-60415e680a5f",
    "type": "order_status_transitions",
    "attributes": {
      "order_id": "9829d05a-b509-4d2d-ae7a-082d1370d607",
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
          "order_id": "8a4241d9-ddbc-4d67-8ccc-234f9e6d6f1f",
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
    "id": "876895ff-b12a-5542-9a91-3ac30895f234",
    "type": "order_status_transitions",
    "attributes": {
      "order_id": "8a4241d9-ddbc-4d67-8ccc-234f9e6d6f1f",
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





