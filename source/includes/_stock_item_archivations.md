# Stock item archivations

Archives a stock item.

Archivation is final and can not be undone.

## Errors

When the request fails, the `error.code` attribute can have the
following values:

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

## Relationships
Name | Description
-- | --
`stock_item` | **[Stock item](#stock-items)** `required`<br>The stock item that needs to be archived.


Check matching attributes under [Fields](#stock-item-archivations-fields) to see which relations can be written.
<br/ >
Check each individual operation to see which relations can be included as a sideload.
## Fields

 Name | Description
-- | --
`confirm_shortage` | **boolean** `writeonly`<br>A value of `true` overrides shortage warnings.
`id` | **uuid** `readonly`<br>Primary key.
`stock_item_id` | **uuid** `readonly-after-create`<br>The stock item that needs to be archived.


## Archive


> When the StockItem is not used, it can be archived:

```shell
  curl --request POST
       --url 'https://example.booqable.com/api/boomerang/stock_item_archivations'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "type": "stock_item_archivations",
           "attributes": {
             "stock_item_id": "37f0c3fc-b2bf-4966-8eb5-d78dd973ed78"
           }
         }
       }'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "16f1d062-5ca2-4e3d-86ef-07d906b31fcf",
      "type": "stock_item_archivations",
      "attributes": {
        "stock_item_id": "37f0c3fc-b2bf-4966-8eb5-d78dd973ed78"
      },
      "relationships": {}
    },
    "meta": {}
  }
```

> When the StockItem was already archived:

```shell
  curl --request POST
       --url 'https://example.booqable.com/api/boomerang/stock_item_archivations'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "type": "stock_item_archivations",
           "attributes": {
             "stock_item_id": "3ff5774c-b38f-47e3-87b2-c514df491708"
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
  curl --request POST
       --url 'https://example.booqable.com/api/boomerang/stock_item_archivations'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "type": "stock_item_archivations",
           "attributes": {
             "stock_item_id": "00fb3418-f6cc-403c-8a08-25489ba726a0"
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
                "809e9c77-25f8-4f0e-8a50-7c1e884681d5"
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
  curl --request POST
       --url 'https://example.booqable.com/api/boomerang/stock_item_archivations'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "type": "stock_item_archivations",
           "attributes": {
             "stock_item_id": "b4e06e4a-63ed-4e5d-8e4e-f6594bac9ab9"
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
              "item_id": "f5273ac1-25df-4451-82dd-a11908f80b33",
              "mutation": -1,
              "order_ids": [
                "48e3654d-1bd3-4805-8dc4-28a9702fd4be"
              ],
              "location_id": "a850b1a1-8829-4508-8ce1-2fa8e886fce6",
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
  curl --request POST
       --url 'https://example.booqable.com/api/boomerang/stock_item_archivations'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "type": "stock_item_archivations",
           "attributes": {
             "stock_item_id": "d4f5dbfe-e53b-4fae-8d91-56dbd8ec1f0a"
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
              "item_id": "56a2701d-0c44-442b-881b-2332c08e358c",
              "mutation": -1,
              "order_ids": [
                "9ab41c24-253e-4ca3-8714-4e2ae2dbcaeb"
              ],
              "location_id": "bffaaa23-5b23-494f-8775-986f7429fbae",
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
  curl --request POST
       --url 'https://example.booqable.com/api/boomerang/stock_item_archivations'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "type": "stock_item_archivations",
           "attributes": {
             "stock_item_id": "b899b3e7-5c23-4e22-8859-325956852bea",
             "confirm_shortage": true
           }
         }
       }'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "2adbd074-8788-4a4c-85e1-3043bd4d878a",
      "type": "stock_item_archivations",
      "attributes": {
        "stock_item_id": "b899b3e7-5c23-4e22-8859-325956852bea"
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
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[stock_item_archivations]=stock_item_id`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=stock_item`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][confirm_shortage]` | **boolean** <br>A value of `true` overrides shortage warnings.
`data[attributes][stock_item_id]` | **uuid** <br>The stock item that needs to be archived.


### Includes

This request accepts the following includes:

`stock_item`





