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
          "order_id": "2cd1239d-f805-454d-92b5-cb8535b9f51e",
          "actions": [
            {
              "action": "book_bundle",
              "bundle_id": "49c45d69-da11-4b11-a5c4-4a7c00228aaa",
              "product_variations": [
                {
                  "bundle_item_id": "654dc688-a58d-42c7-8b42-d7c82ec76901",
                  "product_id": "9dd8f850-1d51-443d-89ac-1114251c246c"
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
    "id": "4f97263f-cd05-5d38-82e2-d94066b9db0c",
    "type": "order_fulfillments",
    "attributes": {
      "order_id": "2cd1239d-f805-454d-92b5-cb8535b9f51e"
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
          "order_id": "cf0ad037-285e-40f3-84c7-76f766cd2187",
          "actions": [
            {
              "action": "stop_bulk",
              "product_id": "0cc556a4-5d5a-4ab9-afad-95593dac78d9",
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
    "id": "3933984c-d172-5ebb-aae8-9fc20c603785",
    "type": "order_fulfillments",
    "attributes": {
      "order_id": "cf0ad037-285e-40f3-84c7-76f766cd2187"
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
          "order_id": "1e748bfd-98e0-4ff6-9947-0efadd1714ce",
          "actions": [
            {
              "action": "stop_trackable",
              "product_id": "f620fa62-0276-439a-8f26-c25489b1b2f2",
              "planning_id": null,
              "stock_item_ids": [
                "f56742d7-ad70-4baf-a4b1-c622e4d90c7c"
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
    "id": "798ddab8-2656-5907-b07a-11178ad2a0d5",
    "type": "order_fulfillments",
    "attributes": {
      "order_id": "1e748bfd-98e0-4ff6-9947-0efadd1714ce"
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