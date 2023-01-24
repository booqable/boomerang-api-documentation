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
          "stock_item_id": "de7927c8-d29b-49f9-b1db-083078a53afc"
        }
      }
    }'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "a1266e69-43d6-543f-9663-2462d7224e1f",
    "type": "stock_item_archivations",
    "attributes": {
      "stock_item_id": "de7927c8-d29b-49f9-b1db-083078a53afc"
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
          "stock_item_id": "b889f2d5-b3e4-4cb1-9799-07c4af82097f"
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
          "stock_item_id": "51eb64ed-a43a-4211-8370-00f40ba62482"
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
              "77a65ae0-86c0-4452-9823-03e63687c4d1"
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
          "stock_item_id": "6df5b840-9874-4c81-ac19-cb46d4aa7cad"
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
            "item_id": "11e88128-273d-4bb4-88c9-7088338941c4",
            "mutation": -1,
            "order_ids": [
              "3ac6a829-44c2-4d9a-a085-c931298a5a86"
            ],
            "location_id": "788ced60-2dd3-4e39-bc9d-ad409c1a72f4",
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
          "stock_item_id": "02d9cb9c-532b-43c7-b357-8765ec493116"
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
            "item_id": "b6000806-9fc1-4915-b00f-764da821d8bf",
            "mutation": -1,
            "order_ids": [
              "60b68af9-ea20-4bb6-b905-7c29bf4bf2dd"
            ],
            "location_id": "30cb7b10-3fb8-4470-b221-db8beea773ca",
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
          "stock_item_id": "25488200-4c33-4024-9739-60988ee3abf7",
          "confirm_shortage": true
        }
      }
    }'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "f19a7f27-066e-5767-a269-da05ac77cafb",
    "type": "stock_item_archivations",
    "attributes": {
      "stock_item_id": "25488200-4c33-4024-9739-60988ee3abf7"
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





