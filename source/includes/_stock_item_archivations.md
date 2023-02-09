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
          "stock_item_id": "1d11204b-9ca5-4172-93cf-90e8e6f1fe76"
        }
      }
    }'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "1ed4d6e9-92be-55a1-9a5a-a07d0399bfd9",
    "type": "stock_item_archivations",
    "attributes": {
      "stock_item_id": "1d11204b-9ca5-4172-93cf-90e8e6f1fe76"
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
          "stock_item_id": "4940af36-60de-4db3-b8cb-3da8823566e6"
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
          "stock_item_id": "9b0b1e95-f241-4fcc-a0f3-e676952623c4"
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
              "08809b46-c957-4e74-8a8a-f086c74beadb"
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
          "stock_item_id": "f3e3fb3a-e386-4de9-a84d-c016ae641a71"
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
            "item_id": "348f9372-c959-4d15-88a1-37dc7bf6a41d",
            "mutation": -1,
            "order_ids": [
              "a39ff117-80fc-4eda-b10b-d1e86856e23e"
            ],
            "location_id": "75e0c4e5-f053-4ca1-abc5-886edb29cd3a",
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
          "stock_item_id": "7fc89dcc-dd21-46dd-8430-288bb4cd356b"
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
            "item_id": "1ccc7c2c-1b1a-4dcd-81c2-e04df90205fe",
            "mutation": -1,
            "order_ids": [
              "a73d1d0b-eb1f-423a-b31f-35aaf71cf573"
            ],
            "location_id": "e2848592-e0d4-4d59-a1db-117a9820e487",
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
          "stock_item_id": "cfc9c0e3-442f-4a33-a57c-9504c65a6914",
          "confirm_shortage": true
        }
      }
    }'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "19471b4a-1e43-5faa-8ed7-408d107f7c6b",
    "type": "stock_item_archivations",
    "attributes": {
      "stock_item_id": "cfc9c0e3-442f-4a33-a57c-9504c65a6914"
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





