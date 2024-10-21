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
-- | --
`id` | **Uuid** `readonly`<br>
`order_id` | **Uuid** <br>The associated Order
`transition_from` | **String_enum** <br>The current status of the Order. One of: `new`, `concept`, `reserved`, `started`, `stopped`, `archived`, `canceled`. 
`transition_to` | **String_enum** <br>The new status of the Order. One of: `concept`, `reserved`, `started`, `stopped`, `archived`, `canceled`.<br>It is only possible to transition to `started` or `stopped` in combination with `revert: true`. 
`revert` | **Boolean** <br>Indicates if this transition reverts the Order back to an earlier status. "Earlier status" does not require this specific Order to ever have been in that status (e.g. `concept` can have been skipped). "Earlier" means earlier in the conceptual progressing of statuses of Orders in general. 
`confirm_shortage` | **Boolean** <br>A value of `true` overrides shortage warnings. This is only possible when _reserving_ an Order. 


## Relationships
Order status transitions have the following relationships:

Name | Description
-- | --
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
          "order_id": "3834c822-d603-4eee-af85-b13a5fb3c109",
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
    "id": "7f2dac37-6155-5ce7-9c76-70ee99377c56",
    "type": "order_status_transitions",
    "attributes": {
      "order_id": "3834c822-d603-4eee-af85-b13a5fb3c109",
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
    --url 'https://example.booqable.com/api/boomerang/order_status_transitions' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "order_status_transitions",
        "attributes": {
          "order_id": "402c4fc2-98b2-4a40-845b-aa660f2a18fd",
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
    "id": "9285a472-77cd-51bb-8b58-0503145f2bbb",
    "type": "order_status_transitions",
    "attributes": {
      "order_id": "402c4fc2-98b2-4a40-845b-aa660f2a18fd",
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
    --url 'https://example.booqable.com/api/boomerang/order_status_transitions' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "order_status_transitions",
        "attributes": {
          "order_id": "b4dfcb4a-6bd9-4fe9-be07-5a63a307323a",
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
            "item_id": "b4932504-ef4e-46cc-959b-86024487e9c3",
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
          "order_id": "b2aba71b-2aa5-4ac2-8eb3-a5e0a21da355",
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
            "item_id": "f1372cc5-0dcf-48e8-a656-ac7deddd9602",
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
          "order_id": "3b00efca-3fca-4aa4-b0b6-e59376b7731f",
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
    "id": "f96fdd66-bf4a-5ca6-8349-75231dcc09d2",
    "type": "order_status_transitions",
    "attributes": {
      "order_id": "3b00efca-3fca-4aa4-b0b6-e59376b7731f",
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
    --url 'https://example.booqable.com/api/boomerang/order_status_transitions' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "order_status_transitions",
        "attributes": {
          "order_id": "c4da9f78-5e87-43a0-a504-9ba30f47126d",
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
            "item_id": "58178080-e6e0-48b5-9164-0fcdf0e86627",
            "unavailable": [
              "a23dc22e-35e6-4d24-9e59-9bd3a757acc0"
            ],
            "available": [
              "40a04c92-a679-4455-89e0-e5a0b8288cea"
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
          "order_id": "40dfef97-6287-4535-bf6c-eafbc3276c1d",
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
          "order_id": "ebac3eb3-dbb7-42d2-9ae1-1665b816bd10",
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
    "id": "993eaa2f-53a7-5fe4-a2c8-a1eb9e5727f4",
    "type": "order_status_transitions",
    "attributes": {
      "order_id": "ebac3eb3-dbb7-42d2-9ae1-1665b816bd10",
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
    --url 'https://example.booqable.com/api/boomerang/order_status_transitions' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "order_status_transitions",
        "attributes": {
          "order_id": "b0543ec9-778b-45c2-a572-b0ebba5f9584",
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
    "id": "b6d33283-f0b6-5ace-a2c2-e825d2be0e62",
    "type": "order_status_transitions",
    "attributes": {
      "order_id": "b0543ec9-778b-45c2-a572-b0ebba5f9584",
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
`include` | **String** <br>List of comma seperated relationships `?include=order`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[order_status_transitions]=order_id,transition_from,transition_to`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][order_id]` | **Uuid** <br>The associated Order
`data[attributes][transition_from]` | **String_enum** <br>The current status of the Order. One of: `new`, `concept`, `reserved`, `started`, `stopped`, `archived`, `canceled`. 
`data[attributes][transition_to]` | **String_enum** <br>The new status of the Order. One of: `concept`, `reserved`, `started`, `stopped`, `archived`, `canceled`.<br>It is only possible to transition to `started` or `stopped` in combination with `revert: true`. 
`data[attributes][revert]` | **Boolean** <br>Indicates if this transition reverts the Order back to an earlier status. "Earlier status" does not require this specific Order to ever have been in that status (e.g. `concept` can have been skipped). "Earlier" means earlier in the conceptual progressing of statuses of Orders in general. 
`data[attributes][confirm_shortage]` | **Boolean** <br>A value of `true` overrides shortage warnings. This is only possible when _reserving_ an Order. 


### Includes

This request accepts the following includes:

`order` => 
`plannings`


`stock_item_plannings`







