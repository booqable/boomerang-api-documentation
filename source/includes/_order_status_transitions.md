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
          "order_id": "7bf2efc1-e0bf-482d-b546-a307b1736dee",
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
    "id": "d951b287-1f59-50b4-be97-ddd4dcf2931d",
    "type": "order_status_transitions",
    "attributes": {
      "order_id": "7bf2efc1-e0bf-482d-b546-a307b1736dee",
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
          "order_id": "668a72a4-75da-492b-a3ae-b74d2b054905",
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
    "id": "8f29564d-78bf-5239-b8a0-2ede083cb61b",
    "type": "order_status_transitions",
    "attributes": {
      "order_id": "668a72a4-75da-492b-a3ae-b74d2b054905",
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
          "order_id": "834934c4-c638-48ea-aded-9b128d455c28",
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
            "item_id": "90715c6d-5542-4ae4-8843-c6ea7723ff91",
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
          "order_id": "6ae52611-d4cd-4089-8424-579547220cf9",
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
            "item_id": "e901ebc6-801e-48ea-bed7-ed92d351699a",
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
          "order_id": "7e8810ec-df42-413d-9e44-aa6151f8ee6c",
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
    "id": "3d289808-391f-53b6-93a7-3b714716fae3",
    "type": "order_status_transitions",
    "attributes": {
      "order_id": "7e8810ec-df42-413d-9e44-aa6151f8ee6c",
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
          "order_id": "e7b4a035-f6b3-4826-8eea-f99f41e863eb",
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
            "item_id": "f041feeb-88f3-4cd9-a244-864a392a0a68",
            "unavailable": [
              "492a923a-95b9-4d1a-b4ca-d0cfbb5265e7"
            ],
            "available": [
              "e7cf20ee-74fe-4aad-b67a-bba6aec025b2"
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
          "order_id": "7da862f9-1e62-4e44-a7ad-9914bdefb11a",
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
          "order_id": "652c033c-13c9-4fc4-9c6c-0ade3abf7051",
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
    "id": "60d104df-9e3c-5dca-a398-e6f6c5e8a360",
    "type": "order_status_transitions",
    "attributes": {
      "order_id": "652c033c-13c9-4fc4-9c6c-0ade3abf7051",
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
          "order_id": "bf54e3ec-c8ba-4c18-971c-0e392f44d9b8",
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
    "id": "6dab584d-bf21-5789-80ec-68a4d50ad820",
    "type": "order_status_transitions",
    "attributes": {
      "order_id": "bf54e3ec-c8ba-4c18-971c-0e392f44d9b8",
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





