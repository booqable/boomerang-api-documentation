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
          "order_id": "b5582237-6f89-48f7-ae9a-5d3bc46ccecb",
          "actions": [
            {
              "action": "book_bundle",
              "bundle_id": "5431318f-0905-4165-b863-7d674366a0a7",
              "product_variations": [
                {
                  "bundle_item_id": "a2c12569-e1d3-406d-a7a7-4efcb6e0a657",
                  "product_id": "569bb4bb-9619-4301-ba19-22622616f418"
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
    "id": "db79a70b-0bb1-5a91-bed0-9bacfc2ab985",
    "type": "order_fulfillments",
    "attributes": {
      "order_id": "b5582237-6f89-48f7-ae9a-5d3bc46ccecb"
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
          "order_id": "3352e592-e705-4fc2-9646-362b62a32182",
          "actions": [
            {
              "action": "stop_bulk",
              "product_id": "c02135e0-d75f-420c-9a08-5c10044c0c96",
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
    "id": "c00651e1-8da5-5ccf-a7be-1ebe649702f7",
    "type": "order_fulfillments",
    "attributes": {
      "order_id": "3352e592-e705-4fc2-9646-362b62a32182"
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
          "order_id": "a2de4866-33cf-4998-acd0-103a682b74d1",
          "actions": [
            {
              "action": "stop_trackable",
              "product_id": "abf023c3-5bfd-4b4f-9591-9503e3ff4363",
              "planning_id": null,
              "stock_item_ids": [
                "0e4738a0-8232-4a90-af76-6d3f66e84b69"
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
    "id": "fb296c44-d727-5a28-a028-50d2f75ab605",
    "type": "order_fulfillments",
    "attributes": {
      "order_id": "a2de4866-33cf-4998-acd0-103a682b74d1"
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