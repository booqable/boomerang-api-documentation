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
          "order_id": "bbe5384d-3a74-4a54-85b6-74a74eb87dce",
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
    "id": "e778f9f4-3de8-5783-a602-77cb207886e2",
    "type": "order_status_transitions",
    "attributes": {
      "order_id": "bbe5384d-3a74-4a54-85b6-74a74eb87dce",
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
          "order_id": "f89ca950-1dfa-4015-aa20-9cfbafa2df2c",
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
    "id": "c6ae0ef1-82a9-563c-ae16-6e7f2c37c55c",
    "type": "order_status_transitions",
    "attributes": {
      "order_id": "f89ca950-1dfa-4015-aa20-9cfbafa2df2c",
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
          "order_id": "98242b31-56f0-44c9-9c4b-79923b73d893",
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
            "item_id": "527e8d01-13d8-4a96-a640-e3b76698e8f0",
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
          "order_id": "c087bf60-4299-48b3-a0ed-73d9160d5f30",
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
            "item_id": "2ad8c5d0-b85e-47f3-bc8e-a953068624b6",
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
          "order_id": "6a95a2ec-602f-46db-a30e-6765c957a892",
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
    "id": "5d01a389-f941-592e-93cd-2023e044019f",
    "type": "order_status_transitions",
    "attributes": {
      "order_id": "6a95a2ec-602f-46db-a30e-6765c957a892",
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
          "order_id": "a59e97a7-b093-4827-a1aa-3c8238ad7bd9",
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
            "item_id": "a89f4507-8918-4d16-8fe8-8a8e67330cfa",
            "unavailable": [
              "05d03472-a09d-4463-90ad-b81b5a3b0a90"
            ],
            "available": [
              "b1711867-7372-4992-9aef-19401daa4c9b"
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
          "order_id": "6aebb5a9-605a-4b77-b957-e781afd807a1",
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
          "order_id": "774c5f18-55bb-46d9-9ef9-47b64ec9ff44",
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
    "id": "d0eec14d-d9ce-5d4a-997f-838bf79101a2",
    "type": "order_status_transitions",
    "attributes": {
      "order_id": "774c5f18-55bb-46d9-9ef9-47b64ec9ff44",
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
          "order_id": "1d2b27ae-ce9a-4818-af42-b4a3579cbadd",
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
    "id": "9380fc1a-ba03-5fe4-90a1-ed5f15dff60f",
    "type": "order_status_transitions",
    "attributes": {
      "order_id": "1d2b27ae-ce9a-4818-af42-b4a3579cbadd",
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





