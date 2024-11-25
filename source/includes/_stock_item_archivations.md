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
-- | --
`id` | **Uuid** `readonly`<br>Primary key
`confirm_shortage` | **Boolean** `writeonly`<br>A value of `true` overrides shortage warnings.
`stock_item_id` | **Uuid** <br>ID of the stock item that needs to be archived.


## Relationships
Stock item archivations have the following relationships:

Name | Description
-- | --
`stock_item` | **Stock items** <br>Associated Stock item


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
          "stock_item_id": "a4fd9859-470c-4bb1-95c3-238f47d80dfe"
        }
      }
    }'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "c83bd932-6ed0-5527-826a-e96a23e9fbf2",
    "type": "stock_item_archivations",
    "attributes": {
      "stock_item_id": "a4fd9859-470c-4bb1-95c3-238f47d80dfe"
    },
    "relationships": {}
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
          "stock_item_id": "5309b570-30f4-4419-a4a6-811556662ff5"
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
          "stock_item_id": "50621aeb-a4fc-454f-9989-18409564a9d6"
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
              "341b18ac-c5a2-497d-89c4-82e8342aea68"
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
          "stock_item_id": "7aaaa24b-f3fe-483b-ae9d-a3be05a63c78"
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
            "item_id": "87505a5a-b58b-46ac-b98f-337023459fd0",
            "mutation": -1,
            "order_ids": [
              "0666f894-fcc2-4599-a9fd-80e4cf8d7636"
            ],
            "location_id": "d3201564-9180-448f-80ce-e116b8644e53",
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
          "stock_item_id": "41cf50a8-b148-4d40-a212-ea739dd6f160"
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
            "item_id": "94045f27-722a-4a6e-b82a-cd3e1e5c1fca",
            "mutation": -1,
            "order_ids": [
              "b166350a-d90e-4d64-a191-804c0cb2f1b4"
            ],
            "location_id": "5dce7516-d4ee-4377-8819-f7ffb880f12a",
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
          "stock_item_id": "f87c536a-3a6a-48c9-9331-a0dda819d1ef",
          "confirm_shortage": true
        }
      }
    }'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "7f115f1c-c05d-5762-bc3e-705651ac3e10",
    "type": "stock_item_archivations",
    "attributes": {
      "stock_item_id": "f87c536a-3a6a-48c9-9331-a0dda819d1ef"
    },
    "relationships": {}
  },
  "meta": {}
}
```

### HTTP Request

`POST /api/boomerang/stock_item_archivations`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=stock_item`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[stock_item_archivations]=stock_item_id`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][confirm_shortage]` | **Boolean** <br>A value of `true` overrides shortage warnings.
`data[attributes][stock_item_id]` | **Uuid** <br>ID of the stock item that needs to be archived.


### Includes

This request accepts the following includes:

`stock_item`





