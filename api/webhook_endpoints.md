# Webhook endpoints

Webhook endpoints are used to notify your application when certain events
occur in your Booqable account. You can use these events to trigger actions
in your application, such as sending an email, updating a record, or creating
a new record.

### Version 1 (default)

```js
// v1 payload
{
  "id": "550e8400-e29b-41d4-a716-446655440000",
  "created_at": "2021-01-01T00:00:00Z",
  "event": "customer.created",
  "object": "Customer",
  "data": {
    // same attributes and relations as returned by /api/1/customers/:id
  }
}
```

Resources included in the payload are delivered in the same format as
the resource's v1 JSON format. Documentation for this format can be
found at [https://boomerang.booqable.com/v1.html](https://boomerang.booqable.com/v1.html).

The content-type of the payload for v1 webhooks is `application/x-www-form-urlencoded`.

### Version 4 (opt-in)

```js
// v4 payload
{
  "id": "550e8400-e29b-41d4-a716-446655440000",
  "created_at": "2021-01-01T00:00:00Z",
  "event": "customer.created",
  "resource_type": "customers",
  "data": {
    // same attributes as returned by /api/4/customers/:id,
    // plus a subset of the relations as nested JSON objects
  }
}
```

The content-type of the payload for v4 webhooks is `application/json`.

### Included Resources

Resources included in the payload are delivered in the same format as
the resource's v4 (aka Boomerang) JSON format. This is the documentation
you are looking at.

Note that the payload is in JSON format, not JSON API format. Relations of the
resource are delivered as nested JSON objects, not as JSON API relationships.

The table below shows which relations are included in the payload for each resource.
The included relations are always the same for a resource and do not depend on the
event. Includes are not recursive (ie. `bundle.updated` will NOT include `bundle_item.product.barcode`).

| Resource | Relations included in webhook payload |
| -- | -- |
| `bundles` | `bundle_items`, `bundle_items.product`, `bundle_items.product_group` |
| `bundle_items` | `bundle`, `product`, `product_group` |
| `cart` | `customer`, `lines`, `lines.item`, `order` |
| `contract`/`invoice`/`quote` | `coupon`, `customer`, `lines`, `order`, `tax_values` |
| `customer` | `barcode`, `tax_region` |
| `order` | `barcode`, `coupon`, `customer`, `lines`, `notes`, `plannings`, `properties`, `start_location`, `stop_location`, `tax_values` |
| `product_group` | `photo`, `price_ruleset`, `price_structure`, `tax_category` |
| `product` | `barcode` |

## Fields

 Name | Description
-- | --
`created_at` | **datetime** `readonly`<br>When the webhook endpoint was first registered. 
`events` | **array[string]** <br>The events that will trigger the webhook. <br/> One or more from: `app.configured`, `app.installed`, `app.plan_changed`, `app.uninstalled`, `bundle.archived`, `bundle.created`, `bundle.updated`, `bundle_item.archived`, `bundle_item.created`, `bundle_item.updated`, `cart.completed_checkout`, `company.destroyed`, `contract.archived`, `contract.confirmed`, `contract.created`, `contract.signed`, `contract.updated`, `customer.archived`, `customer.created`, `customer.updated`, `invoice.archived`, `invoice.created`, `invoice.finalized`, `invoice.revised`, `invoice.updated`, `order.archived`, `order.canceled`, `order.reserved`, `order.saved_as_concept`, `order.saved_as_draft`, `order.started`, `order.stopped`, `order.updated`, `payment.completed`, `product.created`, `product_group.archived`, `product_group.created`, `product_group.updated`, `quote.archived`, `quote.confirmed`, `quote.created`, `quote.signed`, `quote.updated`. 
`id` | **uuid** `readonly`<br>Primary key.
`updated_at` | **datetime** `readonly`<br>When the webhook endpoint was last updated. 
`url` | **string** <br>The URL that will receive the webhook payload. 
`version` | **enum** <br>The version of the webhook payload.<br> One of: `1`, `4`.


## List webhook endpoints


> How to fetch a list of webhook endpoints:

```shell
  curl --get 'https://example.booqable.com/api/4/webhook_endpoints'
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
        ],
        "version": 1
      }
    ]
  }
```

### HTTP Request

`GET /api/4/webhook_endpoints`

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
`version` | **enum** <br>`eq`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **array** <br>`count`


### Includes

This request does not accept any includes
## Subscribe to webhook events


> How to subscribe to webhook events and receive v1 payloads:

```shell
  curl --request POST
       --url 'https://example.booqable.com/api/4/webhook_endpoints'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "type": "webhook_endpoints",
           "attributes": {
             "url": "https://example.com/hooks",
             "version": 1,
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
      "id": "bd50478f-3de1-4432-847f-f7da90859fde",
      "type": "webhook_endpoints",
      "attributes": {
        "created_at": "2019-07-24T05:22:00.000000+00:00",
        "updated_at": "2019-07-24T05:22:00.000000+00:00",
        "url": "https://example.com/hooks",
        "events": [
          "customer.created",
          "customer.updated"
        ],
        "version": 1
      }
    },
    "meta": {}
  }
```

> How to subscribe to webhook events and receive v4 payloads:

```shell
  curl --request POST
       --url 'https://example.booqable.com/api/4/webhook_endpoints'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "type": "webhook_endpoints",
           "attributes": {
             "url": "https://example.com/hooks",
             "version": 4,
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
      "id": "be43f04f-01e8-44d9-86ae-1fc1376bdea0",
      "type": "webhook_endpoints",
      "attributes": {
        "created_at": "2021-11-16T09:32:00.000000+00:00",
        "updated_at": "2021-11-16T09:32:00.000000+00:00",
        "url": "https://example.com/hooks",
        "events": [
          "customer.created",
          "customer.updated"
        ],
        "version": 4
      }
    },
    "meta": {}
  }
```

### HTTP Request

`POST /api/4/webhook_endpoints`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[webhook_endpoints]=created_at,updated_at,url`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][events]` | **array[string]** <br>The events that will trigger the webhook. <br/> One or more from: `app.configured`, `app.installed`, `app.plan_changed`, `app.uninstalled`, `bundle.archived`, `bundle.created`, `bundle.updated`, `bundle_item.archived`, `bundle_item.created`, `bundle_item.updated`, `cart.completed_checkout`, `company.destroyed`, `contract.archived`, `contract.confirmed`, `contract.created`, `contract.signed`, `contract.updated`, `customer.archived`, `customer.created`, `customer.updated`, `invoice.archived`, `invoice.created`, `invoice.finalized`, `invoice.revised`, `invoice.updated`, `order.archived`, `order.canceled`, `order.reserved`, `order.saved_as_concept`, `order.saved_as_draft`, `order.started`, `order.stopped`, `order.updated`, `payment.completed`, `product.created`, `product_group.archived`, `product_group.created`, `product_group.updated`, `quote.archived`, `quote.confirmed`, `quote.created`, `quote.signed`, `quote.updated`. 
`data[attributes][url]` | **string** <br>The URL that will receive the webhook payload. 
`data[attributes][version]` | **enum** <br>The version of the webhook payload.<br> One of: `1`, `4`.


### Includes

This request does not accept any includes
## Update webhook events


> How to update webhook events:

```shell
  curl --request PUT
       --url 'https://example.booqable.com/api/4/webhook_endpoints/a2f71717-53b5-45ba-85c6-3eadcf6cb09f'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "type": "webhook_endpoints",
           "id": "a2f71717-53b5-45ba-85c6-3eadcf6cb09f",
           "attributes": {
             "url": "https://example.com/hooks",
             "version": 4,
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
        ],
        "version": 4
      }
    },
    "meta": {}
  }
```

### HTTP Request

`PUT /api/4/webhook_endpoints/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[webhook_endpoints]=created_at,updated_at,url`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][events]` | **array[string]** <br>The events that will trigger the webhook. <br/> One or more from: `app.configured`, `app.installed`, `app.plan_changed`, `app.uninstalled`, `bundle.archived`, `bundle.created`, `bundle.updated`, `bundle_item.archived`, `bundle_item.created`, `bundle_item.updated`, `cart.completed_checkout`, `company.destroyed`, `contract.archived`, `contract.confirmed`, `contract.created`, `contract.signed`, `contract.updated`, `customer.archived`, `customer.created`, `customer.updated`, `invoice.archived`, `invoice.created`, `invoice.finalized`, `invoice.revised`, `invoice.updated`, `order.archived`, `order.canceled`, `order.reserved`, `order.saved_as_concept`, `order.saved_as_draft`, `order.started`, `order.stopped`, `order.updated`, `payment.completed`, `product.created`, `product_group.archived`, `product_group.created`, `product_group.updated`, `quote.archived`, `quote.confirmed`, `quote.created`, `quote.signed`, `quote.updated`. 
`data[attributes][url]` | **string** <br>The URL that will receive the webhook payload. 
`data[attributes][version]` | **enum** <br>The version of the webhook payload.<br> One of: `1`, `4`.


### Includes

This request does not accept any includes
## Unsubscribe from webhook events


> How to unsubscribe from webhook events:

```shell
  curl --request DELETE
       --url 'https://example.booqable.com/api/4/webhook_endpoints/fd2f4709-67d8-441e-8206-213a900ef683'
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
        "events": [],
        "version": 1
      }
    },
    "meta": {}
  }
```

### HTTP Request

`DELETE /api/4/webhook_endpoints/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[webhook_endpoints]=created_at,updated_at,url`


### Includes

This request does not accept any includes