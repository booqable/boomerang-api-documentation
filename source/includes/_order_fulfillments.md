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
          "order_id": "938a1407-9280-454c-818b-df81f981d870",
          "actions": [
            {
              "action": "book_bundle",
              "bundle_id": "12f27bef-9998-4504-8287-4bdbffe2f596",
              "product_variations": [
                {
                  "bundle_item_id": "4e0aa8b3-6bbb-4ded-820a-20b01e99bfbf",
                  "product_id": "9f81d579-5f68-4908-82ca-aedcf8b34cdd"
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
    "id": "5491bab8-1313-506c-b3c1-55e42e3a5e72",
    "type": "order_fulfillments",
    "attributes": {
      "order_id": "938a1407-9280-454c-818b-df81f981d870"
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
          "order_id": "4c52c3a5-8643-4b0a-9446-36f629f098f5",
          "actions": [
            {
              "action": "stop_bulk",
              "product_id": "3f3fd69f-d220-4dde-afdb-8fb192a3b84a",
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
    "id": "56dcad07-30b5-5bc7-bedb-d7be148b0c26",
    "type": "order_fulfillments",
    "attributes": {
      "order_id": "4c52c3a5-8643-4b0a-9446-36f629f098f5"
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
          "order_id": "e83c25b8-90ab-4966-88f5-2debee72bc0e",
          "actions": [
            {
              "action": "stop_trackable",
              "product_id": "3f2c5d8c-c8f3-43fc-8ca9-6dda01259146",
              "planning_id": null,
              "stock_item_ids": [
                "002d89dd-8b31-417e-a30b-7c5ab1f082a4"
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
    "id": "a5c50527-c33a-588e-87b9-911bf7d32f7a",
    "type": "order_fulfillments",
    "attributes": {
      "order_id": "e83c25b8-90ab-4966-88f5-2debee72bc0e"
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