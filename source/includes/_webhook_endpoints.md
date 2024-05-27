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
`GET /api/boomerang/webhook_endpoints`

`DELETE /api/boomerang/webhook_endpoints/{id}`

`PUT /api/boomerang/webhook_endpoints/{id}`

`POST /api/boomerang/webhook_endpoints`

## Fields
Every webhook endpoint has the following fields:

Name | Description
-- | --
`id` | **Uuid** `readonly`<br>Primary key
`created_at` | **Datetime** `readonly`<br>When the resource was created
`updated_at` | **Datetime** `readonly`<br>When the resource was last updated
`url` | **String** <br>The URL that will receive the webhook payload
`events` | **Array** <br>The events that will trigger the webhook, any of `customer.created`, `customer.updated`, `customer.archived`, `product_group.created`, `product_group.updated`, `product_group.archived`, `product.created`, `invoice.created`, `invoice.finalized`, `invoice.updated`, `invoice.revised`, `invoice.archived`, `contract.created`, `contract.signed`, `contract.confirmed`, `contract.updated`, `contract.archived`, `quote.created`, `quote.signed`, `quote.confirmed`, `quote.updated`, `quote.archived`, `order.updated`, `order.saved_as_concept`, `order.reserved`, `order.started`, `order.stopped`, `payment.completed`, `cart.completed_checkout`


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
      "id": "a2a2d36c-0516-46ad-b87d-50b196d7cce3",
      "created_at": "2024-05-27T09:24:43.049050+00:00",
      "updated_at": "2024-05-27T09:24:43.049050+00:00",
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
## Unsubscribing from webhook events



> How to unsubscribe from webhook events:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/webhook_endpoints/c277711e-80b2-4e0b-9fc3-4e352f4d4345' \
    --header 'content-type: application/json' \
    --data '{}'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "c277711e-80b2-4e0b-9fc3-4e352f4d4345",
    "type": "webhook_endpoints",
    "attributes": {
      "created_at": "2024-05-27T09:24:44.025229+00:00",
      "updated_at": "2024-05-27T09:24:44.025229+00:00",
      "url": "https://example.com/hooks",
      "events": []
    }
  },
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
## Updating webhook events



> How to update webhook events:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/webhook_endpoints/eba1122c-9bbe-4ebd-a3d4-3c8dad7618c3' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "webhook_endpoints",
        "id": "eba1122c-9bbe-4ebd-a3d4-3c8dad7618c3",
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
    "id": "eba1122c-9bbe-4ebd-a3d4-3c8dad7618c3",
    "type": "webhook_endpoints",
    "attributes": {
      "created_at": "2024-05-27T09:24:44.757928+00:00",
      "updated_at": "2024-05-27T09:24:44.757928+00:00",
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
    "id": "a14a65d1-0685-42d0-83ab-be7145037801",
    "type": "webhook_endpoints",
    "attributes": {
      "created_at": "2024-05-27T09:24:45.443827+00:00",
      "updated_at": "2024-05-27T09:24:45.443827+00:00",
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