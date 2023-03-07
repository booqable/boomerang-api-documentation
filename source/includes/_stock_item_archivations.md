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
          "stock_item_id": "45b3dcc9-a5d0-4026-9898-b6e7e77e0e31"
        }
      }
    }'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "0c6900af-d355-5761-b020-82f77904804d",
    "type": "stock_item_archivations",
    "attributes": {
      "stock_item_id": "45b3dcc9-a5d0-4026-9898-b6e7e77e0e31"
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
          "stock_item_id": "774b9596-e8d9-4af8-a016-3ef56804ecfa"
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
          "stock_item_id": "3db2b62e-1588-4247-95fd-e842b73942d4"
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
              "55cf7db3-0367-4ddd-9c2d-171b754b0e29"
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
          "stock_item_id": "e211d858-95af-455f-b413-5aad743a3e91"
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
            "item_id": "9a1bbde7-ffb3-4a02-88e4-f681a3c4ae59",
            "mutation": -1,
            "order_ids": [
              "1b9583a5-7e25-455e-9e3b-e850d50423a4"
            ],
            "location_id": "033c57ad-4304-460f-bb4a-bcaa25386259",
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
          "stock_item_id": "c452c1a8-ef60-4fdf-af04-a13c9d2536dd"
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
            "item_id": "2e5cc6ad-494c-4ba7-b605-a61598520719",
            "mutation": -1,
            "order_ids": [
              "ed2184e3-9b4f-446a-ae60-9ac4f5370943"
            ],
            "location_id": "5722113e-8d01-4a2c-85df-be707c3b46cf",
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
          "stock_item_id": "40741855-5a7f-47a2-9116-22302773334c",
          "confirm_shortage": true
        }
      }
    }'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "2ba345ed-a027-57d4-b571-a2e42537a6de",
    "type": "stock_item_archivations",
    "attributes": {
      "stock_item_id": "40741855-5a7f-47a2-9116-22302773334c"
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





