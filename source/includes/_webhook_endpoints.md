# Webhook endpoints

Webhook endpoints are used to notify your application when certain events
occur in your Booqable account. You can use these events to trigger actions
in your application, such as sending an email, updating a record, or creating
a new record.

## Fields

 Name | Description
-- | --
`created_at` | **datetime** `readonly`<br>When the webhook endpoint was first registered. 
`events` | **array[string]** <br>The events that will trigger the webhook. <br/> One or more from: `customer.created`, `customer.updated`, `customer.archived`, `product_group.created`, `product_group.updated`, `product_group.archived`, `product.created`, `invoice.created`, `invoice.finalized`, `invoice.updated`, `invoice.revised`, `invoice.archived`, `contract.created`, `contract.signed`, `contract.confirmed`, `contract.updated`, `contract.archived`, `quote.created`, `quote.signed`, `quote.confirmed`, `quote.updated`, `quote.archived`, `order.updated`, `order.saved_as_concept`, `order.reserved`, `order.started`, `order.stopped`, `payment.completed`, `cart.completed_checkout`, `app.installed`, `app.configured`, `app.plan_changed`, `app.uninstalled`'. 
`id` | **uuid** `readonly`<br>Primary key.
`updated_at` | **datetime** `readonly`<br>When the webhook endpoint was last updated. 
`url` | **string** <br>The URL that will receive the webhook payload. 


## Listing webhook endpoints


> How to fetch a list of webhook endpoints:

```shell
  curl --get 'https://example.booqable.com/api/boomerang/webhook_endpoints'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": [
      {
        "id": "cb0a7fbd-01d5-485d-82a4-11c5eae2e486",
        "created_at": "2020-05-19T04:30:06.000000+00:00",
        "updated_at": "2020-05-19T04:30:06.000000+00:00",
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
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[webhook_endpoints]=created_at,updated_at,url`
`filter` | **hash** <br>The filters to apply `?filter[attribute][eq]=value`
`meta` | **hash** <br>Metadata to send along. `?meta[total][]=count`
`page[number]` | **string** <br>The page to request.
`page[size]` | **string** <br>The amount of items per page.
`sort` | **string** <br>How to sort the data. `?sort=attribute1,-attribute2`


### Filters

This request can be filtered on:

Name | Description
-- | --
`created_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`id` | **uuid** <br>`eq`, `not_eq`
`updated_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`url` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **array** <br>`count`


### Includes

This request does not accept any includes
## Subscribing to webhook events


> How to subscribe to webhook events:

```shell
  curl --request POST
       --url 'https://example.booqable.com/api/boomerang/webhook_endpoints'
       --header 'content-type: application/json'
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
      "id": "f4855386-6094-4340-8096-0c6911a116cb",
      "type": "webhook_endpoints",
      "attributes": {
        "created_at": "2027-08-01T20:14:01.000000+00:00",
        "updated_at": "2027-08-01T20:14:01.000000+00:00",
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
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[webhook_endpoints]=created_at,updated_at,url`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][events]` | **array[string]** <br>The events that will trigger the webhook. <br/> One or more from: `customer.created`, `customer.updated`, `customer.archived`, `product_group.created`, `product_group.updated`, `product_group.archived`, `product.created`, `invoice.created`, `invoice.finalized`, `invoice.updated`, `invoice.revised`, `invoice.archived`, `contract.created`, `contract.signed`, `contract.confirmed`, `contract.updated`, `contract.archived`, `quote.created`, `quote.signed`, `quote.confirmed`, `quote.updated`, `quote.archived`, `order.updated`, `order.saved_as_concept`, `order.reserved`, `order.started`, `order.stopped`, `payment.completed`, `cart.completed_checkout`, `app.installed`, `app.configured`, `app.plan_changed`, `app.uninstalled`'. 
`data[attributes][url]` | **string** <br>The URL that will receive the webhook payload. 


### Includes

This request does not accept any includes
## Updating webhook events


> How to update webhook events:

```shell
  curl --request PUT
       --url 'https://example.booqable.com/api/boomerang/webhook_endpoints/a2f71717-53b5-45ba-85c6-3eadcf6cb09f'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "type": "webhook_endpoints",
           "id": "a2f71717-53b5-45ba-85c6-3eadcf6cb09f",
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
      "id": "a2f71717-53b5-45ba-85c6-3eadcf6cb09f",
      "type": "webhook_endpoints",
      "attributes": {
        "created_at": "2019-07-11T19:29:00.000000+00:00",
        "updated_at": "2019-07-11T19:29:00.000000+00:00",
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
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[webhook_endpoints]=created_at,updated_at,url`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][events]` | **array[string]** <br>The events that will trigger the webhook. <br/> One or more from: `customer.created`, `customer.updated`, `customer.archived`, `product_group.created`, `product_group.updated`, `product_group.archived`, `product.created`, `invoice.created`, `invoice.finalized`, `invoice.updated`, `invoice.revised`, `invoice.archived`, `contract.created`, `contract.signed`, `contract.confirmed`, `contract.updated`, `contract.archived`, `quote.created`, `quote.signed`, `quote.confirmed`, `quote.updated`, `quote.archived`, `order.updated`, `order.saved_as_concept`, `order.reserved`, `order.started`, `order.stopped`, `payment.completed`, `cart.completed_checkout`, `app.installed`, `app.configured`, `app.plan_changed`, `app.uninstalled`'. 
`data[attributes][url]` | **string** <br>The URL that will receive the webhook payload. 


### Includes

This request does not accept any includes
## Unsubscribing from webhook events


> How to unsubscribe from webhook events:

```shell
  curl --request DELETE
       --url 'https://example.booqable.com/api/boomerang/webhook_endpoints/fd2f4709-67d8-441e-8206-213a900ef683'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "fd2f4709-67d8-441e-8206-213a900ef683",
      "type": "webhook_endpoints",
      "attributes": {
        "created_at": "2020-12-01T19:32:01.000000+00:00",
        "updated_at": "2020-12-01T19:32:01.000000+00:00",
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
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[webhook_endpoints]=created_at,updated_at,url`


### Includes

This request does not accept any includes