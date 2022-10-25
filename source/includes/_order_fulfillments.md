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
          "order_id": "0b53900f-ea05-4061-bb56-0a5154a0d3b4",
          "actions": [
            {
              "action": "book_bundle",
              "bundle_id": "72e81313-10eb-4347-9169-a0e4c141d39d",
              "product_variations": [
                {
                  "bundle_item_id": "e95b54bd-673e-4181-9ef7-38fdc6896f76",
                  "product_id": "9f30982c-4e53-4d60-b023-ea30de236e5a"
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
    "id": "ff7db6ea-1964-5d7e-830c-c9ef5e17eac6",
    "type": "order_fulfillments",
    "attributes": {
      "order_id": "0b53900f-ea05-4061-bb56-0a5154a0d3b4"
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
          "order_id": "0d5245a5-7681-45b7-82d8-2c77e4e5db4d",
          "actions": [
            {
              "action": "stop_bulk",
              "product_id": "2f09e7d4-16e2-4818-81cc-1cc152f1c19c",
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
    "id": "aa843c61-e37d-5d41-a00d-6cff012ed083",
    "type": "order_fulfillments",
    "attributes": {
      "order_id": "0d5245a5-7681-45b7-82d8-2c77e4e5db4d"
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
          "order_id": "352a8c06-c319-4867-b639-d7b441a92664",
          "actions": [
            {
              "action": "stop_trackable",
              "product_id": "0817a5c9-f3c8-47dd-b338-350f83ed1245",
              "planning_id": null,
              "stock_item_ids": [
                "1df093d0-c3e9-4abc-9829-73e9d759f6d7"
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
    "id": "1bc292d8-a0ae-5c9b-8259-a93b4deec82b",
    "type": "order_fulfillments",
    "attributes": {
      "order_id": "352a8c06-c319-4867-b639-d7b441a92664"
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