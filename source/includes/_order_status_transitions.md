# Order status transitions

Transitions an [Order](#orders) from one status to another status.

See [Order](#orders-statuses) for a description of the different statuses.

Note that you cannot transition to `started` or to `stopped`.
The [Order](#orders) will transition to those statuses automatically when
starting or stopping items through the [OrderFulfillment](#order-fulfillments) resource.
It is however possible to revert to the `started` or the `stopped` status.

It is not possible to resurrect a canceled [Order](#orders).
[Duplicating](#order-duplications) a canceled [Order](#orders) is possible.

<aside class="warning">
  The <code>concept</code> status is deprecated and will be renamed to <code>draft</code> in the near future.
  For a short while both values will be  accepted by this API, but the new value <code>draft</code> should be used as soon as possible.
</aside>

### Errors

When the [Order](#orders) cannot be transitioned, and `error.code` is `items_not_available`,
then the `error.meta.blocking.*.reason` or `error.meta.warning.*.reason`
attribute contains one of the following reasons:

- `stock_item_specified`
  One or more of the [StockItems](#stock-items) on this [Order](#orders) have also been planned
  for other current or future [Orders](#orders). The [Product](#products) is specified in
  the `error.meta.blocking.*.item_id` attribute
  and `error.meta.blocking.*.unavailable` contains the problematic [StockItems](#stock-items).

- `shortage`
  A shortage would be created for one or more of the [Products](#products) on this [Order](#orders).
  When the shortages would be within the shortage limits of the products,
  a warning is returned. Otherwise a blocking error is returned.
  When reserving an [Order](#orders), a warning can be overridden by setting `confirm_shortage` to `true`.
  The [Product](#products) is specified in the `error.meta.warning.*.item_id` or
  `error.meta.blocking.*.item_id` attribute.

Note that is is possible to get multiple warnings and errors of different
types at the same time.

### Permissions

- Canceling an [Order](#orders) requires the `cancel_orders` permission.
- Reverting an [Order](#orders) requires the `revert_orders` permission.

## Relationships
Name | Description
-- | --
`order` | **[Order](#orders)** `required`<br>The [Order](#orders) whose status is changed. 


Check matching attributes under [Fields](#order-status-transitions-fields) to see which relations can be written.
<br/ >
Check each individual operation to see which relations can be included as a sideload.
## Fields

 Name | Description
-- | --
`confirm_shortage` | **boolean** <br>A value of `true` overrides shortage warnings. This is only possible when _reserving_ an [Order](#orders). 
`id` | **uuid** `readonly`<br>Primary key.
`order_id` | **uuid** <br>The [Order](#orders) whose status is changed. 
`revert` | **boolean** <br>Indicates if this transition reverts the [Order](#orders) back to an earlier status. "Earlier status" does not require this specific [Order](#orders) to ever have been in that status (e.g. `concept` can have been skipped). "Earlier" means earlier in the conceptual progressing of statuses of [Orders](#orders) in general. 
`transition_from` | **enum** <br>The current status of the [Order](#orders).<br><aside class="warning inline">   The <code>concept</code> status is deprecated and will be renamed to <code>draft</code> in the near future.   For a short while both values will be  accepted by this API, but the new value <code>draft</code> should be used as soon as possible. </aside><br> One of: `new`, `concept`, `reserved`, `started`, `stopped`, `archived`, `draft`.
`transition_to` | **enum** <br>The new status of the [Order](#orders). It is only possible to transition to `started` or `stopped` in combination with `revert: true`.<br><aside class="warning inline">   The <code>concept</code> status is deprecated and will be renamed to <code>draft</code> in the near future.   For a short while both values will be  accepted by this API, but the new value <code>draft</code> should be used as soon as possible. </aside><br> One of: `concept`, `reserved`, `started`, `stopped`, `archived`, `canceled`, `draft`.


## Transition


> Save a new Order as draft:

```shell
  curl --request POST
       --url 'https://example.booqable.com/api/4/order_status_transitions'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "type": "order_status_transitions",
           "attributes": {
             "order_id": "c0856c50-99cb-4cf4-87c4-39a873d65531",
             "transition_from": "new",
             "transition_to": "draft",
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
      "id": "1d7c16ec-67b9-4c6b-894d-8f412f350115",
      "type": "order_status_transitions",
      "attributes": {
        "order_id": "c0856c50-99cb-4cf4-87c4-39a873d65531",
        "transition_from": "new",
        "transition_to": "draft",
        "revert": null,
        "confirm_shortage": null
      },
      "relationships": {}
    },
    "meta": {}
  }
```

> Reserve a draft Order:

```shell
  curl --request POST
       --url 'https://example.booqable.com/api/4/order_status_transitions'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "type": "order_status_transitions",
           "attributes": {
             "order_id": "e0f4a042-6327-407a-87b1-809014212e7b",
             "transition_from": "draft",
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
      "id": "caee0b5f-30b4-4c86-8986-e56a2e47011a",
      "type": "order_status_transitions",
      "attributes": {
        "order_id": "e0f4a042-6327-407a-87b1-809014212e7b",
        "transition_from": "draft",
        "transition_to": "reserved",
        "revert": null,
        "confirm_shortage": null
      },
      "relationships": {}
    },
    "meta": {}
  }
```

> Reserve a draft Order, causing a blocking shortage error:

```shell
  curl --request POST
       --url 'https://example.booqable.com/api/4/order_status_transitions'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "type": "order_status_transitions",
           "attributes": {
             "order_id": "1911dd15-db4b-4cad-8a18-6ff0723bd1d0",
             "transition_from": "draft",
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
              "item_id": "2759b345-6595-442a-8a84-03f156100879",
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

> Reserve a draft Order, causing a shortage warning:

```shell
  curl --request POST
       --url 'https://example.booqable.com/api/4/order_status_transitions'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "type": "order_status_transitions",
           "attributes": {
             "order_id": "3b1ac92c-8d34-4b57-8578-40a3bf8834c7",
             "transition_from": "draft",
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
              "item_id": "4da5b0fd-58ca-4e60-8277-261000848262",
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

> Reserve a draft Order, and override the shortage warning:

```shell
  curl --request POST
       --url 'https://example.booqable.com/api/4/order_status_transitions'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "type": "order_status_transitions",
           "attributes": {
             "order_id": "1f2ef20f-c7d8-410c-89c2-9b5e8a2e037b",
             "transition_from": "draft",
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
      "id": "1b9ed0f6-277b-4cfd-85bd-2ea4f039dd5e",
      "type": "order_status_transitions",
      "attributes": {
        "order_id": "1f2ef20f-c7d8-410c-89c2-9b5e8a2e037b",
        "transition_from": "draft",
        "transition_to": "reserved",
        "revert": null,
        "confirm_shortage": true
      },
      "relationships": {}
    },
    "meta": {}
  }
```

> Reserve a draft Order, causing a stock item specified error:

```shell
  curl --request POST
       --url 'https://example.booqable.com/api/4/order_status_transitions'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "type": "order_status_transitions",
           "attributes": {
             "order_id": "5e038686-7768-4d36-8832-725442f49cc6",
             "transition_from": "draft",
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
              "item_id": "75bcb083-8a52-4212-814f-90b18421d198",
              "unavailable": [
                "c5c86b0e-7898-4c3d-8c33-425011f8ed0b"
              ],
              "available": [
                "c18a3863-071f-467f-8a25-d6b087473135"
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
  curl --request POST
       --url 'https://example.booqable.com/api/4/order_status_transitions'
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
  curl --request POST
       --url 'https://example.booqable.com/api/4/order_status_transitions'
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

> Revert a reserved Order to 'draft':

```shell
  curl --request POST
       --url 'https://example.booqable.com/api/4/order_status_transitions'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "type": "order_status_transitions",
           "attributes": {
             "order_id": "0c9cf30c-2afc-4972-8f6b-b1bc417fccb6",
             "transition_from": "reserved",
             "transition_to": "draft",
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
      "id": "9fa0c885-f33d-40d2-85f7-711a671cfe6a",
      "type": "order_status_transitions",
      "attributes": {
        "order_id": "0c9cf30c-2afc-4972-8f6b-b1bc417fccb6",
        "transition_from": "reserved",
        "transition_to": "draft",
        "revert": true,
        "confirm_shortage": null
      },
      "relationships": {}
    },
    "meta": {}
  }
```

### HTTP Request

`POST /api/4/order_status_transitions`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[order_status_transitions]=order_id,transition_from,transition_to`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=order`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][confirm_shortage]` | **boolean** <br>A value of `true` overrides shortage warnings. This is only possible when _reserving_ an [Order](#orders). 
`data[attributes][order_id]` | **uuid** <br>The [Order](#orders) whose status is changed. 
`data[attributes][revert]` | **boolean** <br>Indicates if this transition reverts the [Order](#orders) back to an earlier status. "Earlier status" does not require this specific [Order](#orders) to ever have been in that status (e.g. `concept` can have been skipped). "Earlier" means earlier in the conceptual progressing of statuses of [Orders](#orders) in general. 
`data[attributes][transition_from]` | **enum** <br>The current status of the [Order](#orders).<br><aside class="warning inline">   The <code>concept</code> status is deprecated and will be renamed to <code>draft</code> in the near future.   For a short while both values will be  accepted by this API, but the new value <code>draft</code> should be used as soon as possible. </aside><br> One of: `new`, `concept`, `reserved`, `started`, `stopped`, `archived`, `draft`.
`data[attributes][transition_to]` | **enum** <br>The new status of the [Order](#orders). It is only possible to transition to `started` or `stopped` in combination with `revert: true`.<br><aside class="warning inline">   The <code>concept</code> status is deprecated and will be renamed to <code>draft</code> in the near future.   For a short while both values will be  accepted by this API, but the new value <code>draft</code> should be used as soon as possible. </aside><br> One of: `concept`, `reserved`, `started`, `stopped`, `archived`, `canceled`, `draft`.


### Includes

This request accepts the following includes:

<ul>
  <li>
    <code>order</code>
    <ul>
      <li><code>plannings</code></li>
      <li><code>stock_item_plannings</code></li>
    </ul>
  </li>
</ul>

