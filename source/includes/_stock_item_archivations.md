# Stock item archivations

Archives a stock item.

Archivation is final and can not be undone.

**When the request fails, the `error.code` attribute can have the
following values:**

- `stock_item_archived`
  The stock item was already archived before.

- `stock_item_specified`
  The stock item has not been archived because this specific stock item
  has been planned for current or future orders.
  The orders to which this stock item has been planned are specified
  in the `meta.blocking[0].order_ids` field.

- `shortage`
  The stock item has not been archived because this would lead to
  an (un)acceptable shortage of the product for current or future orders.
  When the shortage is within the shortage limit of the product,
  a warning is returned. Otherwise a blocking error is returned.
  A warning can be overriden by setting `confirm_shortage` to `true`.
  The orders that would be affected by the shortage can be found in
  either `meta.blocking[0].order_ids` or `meta.warning[0].order_ids`.

## Fields
Every stock item archivation has the following fields:

Name | Description
- | -
`id` | **Uuid** `readonly`<br>
`confirm_shortage` | **Boolean** `writeonly`<br>A value of `true` overrides shortage warnings.
`stock_item_id` | **Uuid** <br>The associated Stock item


## Relationships
Stock item archivations have the following relationships:

Name | Description
- | -
`stock_item` | **Stock items**<br>Associated Stock item


## Archive



> When the StockItem is not used, it can be archived:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/stock_item_archivations' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "stock_item_archivations",
        "attributes": {
          "stock_item_id": "cdbadada-84c9-4192-87ac-d18abb7b2f6b"
        }
      }
    }'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "63ddc9a7-8b5a-5c76-9443-626d91301232",
    "type": "stock_item_archivations",
    "attributes": {
      "stock_item_id": "cdbadada-84c9-4192-87ac-d18abb7b2f6b"
    },
    "relationships": {
      "stock_item": {
        "meta": {
          "included": false
        }
      }
    }
  },
  "meta": {}
}
```


> When the StockItem was already archived:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/stock_item_archivations' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "stock_item_archivations",
        "attributes": {
          "stock_item_id": "6e535af7-9ed5-40bb-8194-885dff56ac45"
        }
      }
    }'
```

> A 422 status response looks like this:

```json
  {
  "errors": [
    {
      "code": "stock_item_archived",
      "status": "422",
      "title": "Stock item archived",
      "detail": "Stock item is already archived",
      "meta": null
    }
  ]
}
```


> When the StockItem is specified on a reserved Order:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/stock_item_archivations' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "stock_item_archivations",
        "attributes": {
          "stock_item_id": "17d7a63a-14dc-4ee9-80b7-22ca245f5517"
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
      "detail": "This stock item is specified on a current or future order",
      "meta": {
        "blocking": [
          {
            "order_ids": [
              "1b6daf4b-6e9b-4f9b-ad71-488cddb5e3eb"
            ]
          }
        ]
      }
    }
  ]
}
```


> When archival would create unallowed shortage:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/stock_item_archivations' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "stock_item_archivations",
        "attributes": {
          "stock_item_id": "a6a38af9-e981-42b7-9111-4ff3c1766fd0"
        }
      }
    }'
```

> A 422 status response looks like this:

```json
  {
  "errors": [
    {
      "code": "shortage",
      "status": "422",
      "title": "Shortage",
      "detail": "This will create shortage for running or future orders",
      "meta": {
        "warning": [],
        "blocking": [
          {
            "reason": "shortage",
            "shortage": 1,
            "item_id": "a9d712d5-a003-484d-abee-a1033b43fab1",
            "mutation": -1,
            "order_ids": [
              "44cc7e60-9ce1-4d41-899b-d0b5b0a23718"
            ],
            "location_id": "e3e61c35-78eb-4103-b1a3-51437bf820f7",
            "available": 0,
            "plannable": 0,
            "stock_count": 1,
            "planned": 1,
            "needed": 1,
            "cluster_available": 0,
            "cluster_plannable": 0,
            "cluster_stock_count": 1,
            "cluster_planned": 1,
            "cluster_needed": 1
          }
        ]
      }
    }
  ]
}
```


> When archival would create allowed shortage, but confirm_shortage is unspecified:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/stock_item_archivations' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "stock_item_archivations",
        "attributes": {
          "stock_item_id": "ce20078b-6978-4d1d-9fe1-db15df2f6578"
        }
      }
    }'
```

> A 422 status response looks like this:

```json
  {
  "errors": [
    {
      "code": "shortage",
      "status": "422",
      "title": "Shortage",
      "detail": "This will create shortage for running or future orders",
      "meta": {
        "warning": [
          {
            "reason": "shortage",
            "shortage": 1,
            "item_id": "1453f533-1499-4be7-8dc2-71535833ba8b",
            "mutation": -1,
            "order_ids": [
              "de2e9881-af36-4d8c-8cf7-627739a040a3"
            ],
            "location_id": "d969731e-81ba-4ae0-9cfc-1a5afa6db1d9",
            "available": 0,
            "plannable": 1,
            "stock_count": 1,
            "planned": 1,
            "needed": 1,
            "cluster_available": 0,
            "cluster_plannable": 1,
            "cluster_stock_count": 1,
            "cluster_planned": 1,
            "cluster_needed": 1
          }
        ],
        "blocking": []
      }
    }
  ]
}
```


> When archival would create allowed shortage, and confirm_shortage is true:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/stock_item_archivations' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "stock_item_archivations",
        "attributes": {
          "stock_item_id": "62adc8a5-98b0-4bbf-8805-70fd19c99eea",
          "confirm_shortage": true
        }
      }
    }'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "35253af3-2e84-52b9-ab5e-10c2bd3bf72d",
    "type": "stock_item_archivations",
    "attributes": {
      "stock_item_id": "62adc8a5-98b0-4bbf-8805-70fd19c99eea"
    },
    "relationships": {
      "stock_item": {
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

`POST /api/boomerang/stock_item_archivations`

### Request params

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=stock_item`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[stock_item_archivations]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][confirm_shortage]` | **Boolean** <br>A value of `true` overrides shortage warnings.
`data[attributes][stock_item_id]` | **Uuid** <br>The associated Stock item


### Includes

This request accepts the following includes:

`stock_item`





