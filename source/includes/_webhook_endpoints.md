# Webhook endpoints

Webhook endpoints are used to notify your application when certain events occur in your Booqable account. You can use these events to trigger actions in your application, such as sending an email, updating a record, or creating a new record.

You can listen to the following events:

- `customer.created`
- `customer.updated`
- `customer.archived`
- `product_group.created`
- `product_group.updated`
- `product_group.archived`
- `product.created`
- `invoice.created`
- `invoice.finalized`
- `invoice.updated`
- `invoice.revised`
- `invoice.archived`
- `contract.created`
- `contract.signed`
- `contract.confirmed`
- `contract.updated`
- `contract.archived`
- `quote.created`
- `quote.signed`
- `quote.confirmed`
- `quote.updated`
- `quote.archived`
- `order.updated`
- `order.saved_as_concept`
- `order.reserved`
- `order.started`
- `order.stopped`
- `payment.completed`
- `cart.completed_checkout`

## Endpoints
`PUT /api/boomerang/webhook_endpoints/{id}`

`POST /api/boomerang/webhook_endpoints`

`DELETE /api/boomerang/webhook_endpoints/{id}`

`GET /api/boomerang/webhook_endpoints`

## Fields
Every webhook endpoint has the following fields:

Name | Description
-- | --
`id` | **Uuid** `readonly`<br>Primary key
`created_at` | **Datetime** `readonly`<br>When the resource was created
`updated_at` | **Datetime** `readonly`<br>When the resource was last updated
`url` | **String** <br>The URL that will receive the webhook payload
`events` | **Array** <br>The events that will trigger the webhook, any of `customer.created`, `customer.updated`, `customer.archived`, `product_group.created`, `product_group.updated`, `product_group.archived`, `product.created`, `invoice.created`, `invoice.finalized`, `invoice.updated`, `invoice.revised`, `invoice.archived`, `contract.created`, `contract.signed`, `contract.confirmed`, `contract.updated`, `contract.archived`, `quote.created`, `quote.signed`, `quote.confirmed`, `quote.updated`, `quote.archived`, `order.updated`, `order.saved_as_concept`, `order.reserved`, `order.started`, `order.stopped`, `payment.completed`, `cart.completed_checkout`


## Updating webhook events



> How to update webhook events:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/webhook_endpoints/ea074189-f829-4fe8-b7bf-0d0d73232d17' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "webhook_endpoints",
        "id": "ea074189-f829-4fe8-b7bf-0d0d73232d17",
        "attributes": {
          "url": "https://example.com/hooks",
          "events": [
            "customer.created"
          ]
        }
      }
    }'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "ea074189-f829-4fe8-b7bf-0d0d73232d17",
    "type": "webhook_endpoints",
    "attributes": {
      "created_at": "2024-03-11T09:18:08+00:00",
      "updated_at": "2024-03-11T09:18:08+00:00",
      "url": "https://example.com/hooks",
      "events": [
        "customer.created"
      ]
    }
  },
  "meta": {}
}
```

### HTTP Request

`PUT /api/boomerang/webhook_endpoints/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[webhook_endpoints]=created_at,updated_at,url`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][url]` | **String** <br>The URL that will receive the webhook payload
`data[attributes][events][]` | **Array** <br>The events that will trigger the webhook, any of `customer.created`, `customer.updated`, `customer.archived`, `product_group.created`, `product_group.updated`, `product_group.archived`, `product.created`, `invoice.created`, `invoice.finalized`, `invoice.updated`, `invoice.revised`, `invoice.archived`, `contract.created`, `contract.signed`, `contract.confirmed`, `contract.updated`, `contract.archived`, `quote.created`, `quote.signed`, `quote.confirmed`, `quote.updated`, `quote.archived`, `order.updated`, `order.saved_as_concept`, `order.reserved`, `order.started`, `order.stopped`, `payment.completed`, `cart.completed_checkout`


### Includes

This request does not accept any includes
## Subscribing to webhook events



> How to subscribe to webhook events:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/webhook_endpoints' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "webhook_endpoints",
        "attributes": {
          "url": "https://example.com/hooks",
          "events": [
            "customer.created",
            "customer.updated"
          ]
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "1fb7b8e6-8129-4f3d-90bf-98d6d65231a0",
    "type": "webhook_endpoints",
    "attributes": {
      "created_at": "2024-03-11T09:18:09+00:00",
      "updated_at": "2024-03-11T09:18:09+00:00",
      "url": "https://example.com/hooks",
      "events": [
        "customer.created",
        "customer.updated"
      ]
    }
  },
  "meta": {}
}
```

### HTTP Request

`POST /api/boomerang/webhook_endpoints`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[webhook_endpoints]=created_at,updated_at,url`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][url]` | **String** <br>The URL that will receive the webhook payload
`data[attributes][events][]` | **Array** <br>The events that will trigger the webhook, any of `customer.created`, `customer.updated`, `customer.archived`, `product_group.created`, `product_group.updated`, `product_group.archived`, `product.created`, `invoice.created`, `invoice.finalized`, `invoice.updated`, `invoice.revised`, `invoice.archived`, `contract.created`, `contract.signed`, `contract.confirmed`, `contract.updated`, `contract.archived`, `quote.created`, `quote.signed`, `quote.confirmed`, `quote.updated`, `quote.archived`, `order.updated`, `order.saved_as_concept`, `order.reserved`, `order.started`, `order.stopped`, `payment.completed`, `cart.completed_checkout`


### Includes

This request does not accept any includes
## Unsubscribing from webhook events



> How to unsubscribe from webhook events:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/webhook_endpoints/31078f61-0469-4a68-a93d-6e463a50af0c' \
    --header 'content-type: application/json' \
    --data '{}'
```

> A 200 status response looks like this:

```json
  {
  "meta": {}
}
```

### HTTP Request

`DELETE /api/boomerang/webhook_endpoints/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[webhook_endpoints]=created_at,updated_at,url`


### Includes

This request does not accept any includes
## Listing webhook endpoints



> How to fetch a list of webhook endpoints:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/webhook_endpoints' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "c58a364e-4671-4ec6-a84c-4e64c4dd1f02",
      "created_at": "2024-03-11T09:18:10+00:00",
      "updated_at": "2024-03-11T09:18:10+00:00",
      "url": "https://example.com/hooks",
      "events": [
        "invoice.finalized"
      ]
    }
  ]
}
```

### HTTP Request

`GET /api/boomerang/webhook_endpoints`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[webhook_endpoints]=created_at,updated_at,url`
`filter` | **Hash** <br>The filters to apply `?filter[attribute][eq]=value`
`sort` | **String** <br>How to sort the data `?sort=attribute1,-attribute2`
`meta` | **Hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String** <br>The page to request
`page[size]` | **String** <br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
-- | --
`id` | **Uuid** <br>`eq`, `not_eq`
`created_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`url` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **Array** <br>`count`


### Includes

This request does not accept any includes