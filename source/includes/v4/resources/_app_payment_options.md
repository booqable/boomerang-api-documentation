# App payment options

AppPaymentOptions represent payment methods available through third-party payment apps integrated
with Booqable. These options are provided by external payment applications that extend Booqable's
payment capabilities beyond the built-in Stripe integration.

For more information about payment apps see [the Apps documentation](/apps.html#capabilities-payment-options).

## Relationships
Name | Description
-- | --
`app_subscription` | **[App subscription](#app-subscriptions)** `required`<br>The [AppSubscription](#app-subscriptions) that provides this payment option. 


Check matching attributes under [Fields](#app-payment-options-fields) to see which relations can be written.
<br/ >
Check each individual operation to see which relations can be included as a sideload.
## Fields

 Name | Description
-- | --
`app_subscription_id` | **uuid** `readonly`<br>The [AppSubscription](#app-subscriptions) that provides this payment option. 
`authorization_url` | **string** `readonly`<br>API endpoint for creating payment authorization for deposit/capture flows. 
`cancel_charge_url` | **string** `readonly`<br>API endpoint for canceling a payment charge. 
`capture_authorization_url` | **string** `readonly`<br>API endpoint for capturing funds from a previous authorization. 
`charge_url` | **string** `readonly`<br>API endpoint for processing payment charges. 
`created_at` | **datetime** `readonly`<br>When the resource was created.
`id` | **uuid** `readonly`<br>Primary key.
`identifier` | **string** `readonly`<br>Unique identifier for this payment option. 
`name` | **string** `readonly`<br>Human-readable display name for this payment option. 
`refund_url` | **string** `readonly`<br>API endpoint for processing payment refunds. 
`updated_at` | **datetime** `readonly`<br>When the resource was last updated.
`void_authorization_url` | **string** `readonly`<br>API endpoint for voiding/canceling a payment authorization. 


## List app payment options


> How to fetch a list of app payment options:

```shell
  curl --get 'https://example.booqable.com/api/4/app_payment_options'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": [
      {
        "id": "acc05ce7-a5cc-4bd5-851c-975119830032",
        "type": "app_payment_options",
        "attributes": {
          "created_at": "2017-12-28T01:01:01.000000+00:00",
          "updated_at": "2017-12-28T01:01:01.000000+00:00",
          "name": "Payment Option 1",
          "identifier": "payment_option_1",
          "charge_url": "https://example.com/charge",
          "authorization_url": "https://example.com/authorize",
          "refund_url": "https://example.com/refund",
          "cancel_charge_url": null,
          "capture_authorization_url": null,
          "void_authorization_url": null,
          "app_subscription_id": "64206567-0594-458d-8253-8a9119e7e100"
        },
        "relationships": {}
      }
    ],
    "meta": {}
  }
```

### HTTP Request

`GET /api/4/app_payment_options`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[app_payment_options]=created_at,updated_at,name`
`filter` | **hash** <br>The filters to apply `?filter[attribute][eq]=value`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=app_subscription`
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


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **array** <br>`count`


### Includes

This request accepts the following includes:

<ul>
  <li><code>app_subscription</code></li>
</ul>


## Fetch an app payment option


> How to fetch an app payment option:

```shell
  curl --get 'https://example.booqable.com/api/4/app_payment_options/a2a19063-15d5-467b-862e-14d019be14da'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "a2a19063-15d5-467b-862e-14d019be14da",
      "type": "app_payment_options",
      "attributes": {
        "created_at": "2028-12-22T10:47:02.000000+00:00",
        "updated_at": "2028-12-22T10:47:02.000000+00:00",
        "name": "Payment Option 2",
        "identifier": "payment_option_2",
        "charge_url": "https://example.com/charge",
        "authorization_url": "https://example.com/authorize",
        "refund_url": "https://example.com/refund",
        "cancel_charge_url": null,
        "capture_authorization_url": null,
        "void_authorization_url": null,
        "app_subscription_id": "84997b55-9943-4525-8429-126a29b47fd3"
      },
      "relationships": {}
    },
    "meta": {}
  }
```

### HTTP Request

`GET /api/4/app_payment_options/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[app_payment_options]=created_at,updated_at,name`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=app_subscription`


### Includes

This request accepts the following includes:

<ul>
  <li><code>app_subscription</code></li>
</ul>


## Create an app payment option

App payment options are typically created by third-party apps through the Booqable Apps API.

The name, identifier, and payment operation routes are automatically copied from the app's meta.json
configuration when the payment option is created if they are not provided in the attributes
of the POST request body.

The payment option will be available for use in checkout flows once created.

> How to create an app payment option:

```shell
  curl --request POST
       --url 'https://example.booqable.com/api/4/app_payment_options'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "type": "app_payment_options",
           "attributes": {}
         }
       }'
```

> A 201 status response looks like this:

```json
  {
    "data": {
      "id": "480cd4d8-51bf-412c-8f8c-9700781a11f8",
      "type": "app_payment_options",
      "attributes": {
        "created_at": "2021-12-18T20:37:00.000000+00:00",
        "updated_at": "2021-12-18T20:37:00.000000+00:00",
        "name": "Mailchimp",
        "identifier": "mypay-express",
        "charge_url": null,
        "authorization_url": null,
        "refund_url": null,
        "cancel_charge_url": null,
        "capture_authorization_url": null,
        "void_authorization_url": null,
        "app_subscription_id": "602e8f3e-5561-4715-8f86-327c5798f16a"
      },
      "relationships": {}
    },
    "meta": {}
  }
```

### HTTP Request

`POST /api/4/app_payment_options`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[app_payment_options]=created_at,updated_at,name`
`authorization_url` | **string** <br>API endpoint for creating payment authorization for deposit/capture flows. 
`charge_url` | **string** <br>API endpoint for processing payment charges. 
`identifier` | **string** <br>Unique identifier for this payment option. 
`name` | **string** <br>Human-readable display name for this payment option. 


### Includes

This request does not accept any includes
## Delete an app payment option

Deleting an app payment option removes it from the available payment methods.
This action is typically performed by the app that created the payment option.

Once deleted, the payment option will no longer appear in checkout flows
and cannot be used for new payments.

> How to delete an app payment option:

```shell
  curl --request DELETE
       --url 'https://example.booqable.com/api/4/app_payment_options/a9252fdf-79ec-4ae6-82ea-8efdd117d845'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "a9252fdf-79ec-4ae6-82ea-8efdd117d845",
      "type": "app_payment_options",
      "attributes": {
        "created_at": "2027-02-15T23:56:01.000000+00:00",
        "updated_at": "2027-02-15T23:56:01.000000+00:00",
        "name": "Payment Option 4",
        "identifier": "payment_option_4",
        "charge_url": "https://example.com/charge",
        "authorization_url": "https://example.com/authorize",
        "refund_url": "https://example.com/refund",
        "cancel_charge_url": null,
        "capture_authorization_url": null,
        "void_authorization_url": null,
        "app_subscription_id": "fc24b32a-1edd-4fb8-8f1a-ed416f9b7227"
      },
      "relationships": {}
    },
    "meta": {}
  }
```

### HTTP Request

`DELETE /api/4/app_payment_options/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[app_payment_options]=created_at,updated_at,name`


### Includes

This request does not accept any includes
