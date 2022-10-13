# Order fulfillments

Takes an Order through the fulfillment process.

## Actions

#### Book a Bundle

Books a Bundle on an Order. For each unspecified
BundleItem a Product variation needs to be selected.
Specified BundleItems are automatically booked. These
should not be included in the response.

```json
{
  "action": "book_bundle",
  "bundle_id": "<id>",
  "product_variations": [
    {
      "bundle_item_id": "<id>",
      "product_id": "<id>"
    },
    {
      "bundle_item_id": "<id>",
      "product_id": "<id>"
    }
  ]
}
```

#### Stop a bulk Product:

A quantity of a bulk product is returned. The
product needs to have started. The quantity can
be the same as the started quantity, or less when
a subset of items is returned.

```json
{
  "action": "stop_bulk",
  "product_id": "<id>",               // required
  "planning_id": "<id>",              // optional
  "quantity": N                       // required
}
```

#### Stop a trackable Product:

One or more stock items of a trackable product are returned.
Only stock items that have been started can be stopped.

```json
{
  "action": "stop_trackable",
  "product_id": "<id>",               // required
  "planning_id": "<id>",              // optional
  "stock_item_ids": ["<id>", "<id>"]  // at least one
}
```

## Endpoints
`POST /api/boomerang/order_fulfillments`

## Fields
Every order fulfillment has the following fields:

Name | Description
- | -
`id` | **Uuid** `readonly`<br>
`actions` | **Array** `writeonly`<br>Array of actions to be performed. The actions are executed atomically, and succeed as a whole, or fail as a whole. 
`confirm_shortage` | **Boolean** `writeonly`<br>A value of `true` overrides shortage warnings when booking products on a reserved or started Order. 
`order_id` | **Uuid** <br>The associated Order


## Relationships
Order fulfillments have the following relationships:

Name | Description
- | -
`order` | **Orders** `readonly`<br>Associated Order


## Book



> Book a Bundle:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/order_fulfillments' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "order_fulfillments",
        "attributes": {
          "order_id": "73ef6eae-dfe8-47ef-be76-234882064ed2",
          "actions": [
            {
              "action": "book_bundle",
              "bundle_id": "db42eee7-237e-4760-9675-0c08d594d002",
              "product_variations": [
                {
                  "bundle_item_id": "b6b7737b-a448-4db1-82ab-a37af2cfa4c3",
                  "product_id": "7ceaa39f-e4a6-4e13-82dd-b942d10f0145"
                }
              ]
            }
          ]
        }
      }
    }'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "79f39539-c0b4-5ada-983c-b738e1797777",
    "type": "order_fulfillments",
    "attributes": {
      "order_id": "73ef6eae-dfe8-47ef-be76-234882064ed2"
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

`POST /api/boomerang/order_fulfillments`

### Request params

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=order`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[order_fulfillments]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][actions][]` | **Array** <br>Array of actions to be performed. The actions are executed atomically, and succeed as a whole, or fail as a whole. 
`data[attributes][confirm_shortage]` | **Boolean** <br>A value of `true` overrides shortage warnings when booking products on a reserved or started Order. 
`data[attributes][order_id]` | **Uuid** <br>The associated Order


### Includes

This request does not accept any includes
## Stop



> Stop a bulk Product:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/order_fulfillments' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "order_fulfillments",
        "attributes": {
          "order_id": "e5525efc-e76b-4a88-9647-e4ddcd509c63",
          "actions": [
            {
              "action": "stop_bulk",
              "product_id": "b5f07bd2-069e-42bc-88c9-235d2c918779",
              "planning_id": null,
              "quantity": 1
            }
          ]
        }
      }
    }'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "5b6811d1-d34f-51f8-933b-950685486f87",
    "type": "order_fulfillments",
    "attributes": {
      "order_id": "e5525efc-e76b-4a88-9647-e4ddcd509c63"
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


> Stop a trackable Product:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/order_fulfillments' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "order_fulfillments",
        "attributes": {
          "order_id": "d4ff0774-ff17-46fa-b643-3cecb414ced8",
          "actions": [
            {
              "action": "stop_trackable",
              "product_id": "4b88e067-be0b-41c3-9b5e-0cfcf601b87c",
              "planning_id": null,
              "stock_item_ids": [
                "547db4c0-62f5-40b6-b89c-c16ae2699981"
              ]
            }
          ]
        }
      }
    }'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "dfc946ee-16e5-5e97-971b-2efa5d0af816",
    "type": "order_fulfillments",
    "attributes": {
      "order_id": "d4ff0774-ff17-46fa-b643-3cecb414ced8"
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

`POST /api/boomerang/order_fulfillments`

### Request params

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=order`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[order_fulfillments]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][actions][]` | **Array** <br>Array of actions to be performed. The actions are executed atomically, and succeed as a whole, or fail as a whole. 
`data[attributes][confirm_shortage]` | **Boolean** <br>A value of `true` overrides shortage warnings when booking products on a reserved or started Order. 
`data[attributes][order_id]` | **Uuid** <br>The associated Order


### Includes

This request does not accept any includes