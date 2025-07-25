# Payment authorizations

A payment authorization is a record of payment authorization that is used to track the authorization status and details.

## Relationships
Name | Description
-- | --
`cart` | **[Cart](#carts)** `required`<br>The associated cart. 
`customer` | **[Customer](#customers)** `required`<br>The associated [Customer](#customers). 
`employee` | **[Employee](#employees)** `required`<br>The associated [Employee](#employees). 
`order` | **[Order](#orders)** `required`<br>The associated [Order](#orders). 
`payment_charges` | **[Payment charges](#payment-charges)** `hasmany`<br>The associated [PaymentCharges](#payment-charges). 
`payment_method` | **[Payment method](#payment-methods)** `required`<br>The [PaymentMethod](#payment-methods). 


Check matching attributes under [Fields](#payment-authorizations-fields) to see which relations can be written.
<br/ >
Check each individual operation to see which relations can be included as a sideload.
## Fields

 Name | Description
-- | --
`amount_capturable_in_cents` | **integer** `readonly`<br>Capturable amount in cents. 
`amount_captured_in_cents` | **integer** `readonly`<br>Captured amount in cents. 
`amount_in_cents` | **integer** <br>Amount in cents. 
`canceled_at` | **datetime** `readonly`<br>When payment authorization was canceled. 
`capturable` | **boolean** `readonly`<br>Whether the authorization is capturable. 
`capture_before` | **datetime** `readonly`<br>When payment authorization needs to be captured before. 
`captured_at` | **datetime** `readonly`<br>When payment authorization was captured. 
`cart_id` | **uuid** `readonly-after-create`<br>The associated cart. 
`created_at` | **datetime** `readonly`<br>When the resource was created.
`currency` | **string** <br>Currency. 
`customer_id` | **uuid** `readonly-after-create`<br>The associated [Customer](#customers). 
`deposit_capturable_in_cents` | **integer** `readonly`<br>Capturable deposit in cents. 
`deposit_captured_in_cents` | **integer** `readonly`<br>Captured deposit in cents. 
`deposit_in_cents` | **integer** <br>Deposit in cents. 
`description` | **string** <br>Description. 
`employee_id` | **uuid** `readonly`<br>The associated [Employee](#employees). 
`expired_at` | **datetime** `readonly`<br>When payment authorization expired. 
`failed_at` | **datetime** `readonly`<br>When payment authorization failed. 
`id` | **uuid** `readonly`<br>Primary key.
`mode` | **enum** <br>Mode.<br> One of: `off_session`, `checkout`, `request`, `terminal`.
`order_id` | **uuid** `readonly-after-create`<br>The associated [Order](#orders). 
`payment_method_id` | **uuid** `readonly-after-create`<br>The [PaymentMethod](#payment-methods). 
`provider` | **enum** <br>Provider.<br> One of: `stripe`, `app`, `none`.
`provider_id` | **string** <br>External provider authorization identification. 
`provider_link` | **string** <br>Provider payment link. 
`provider_method` | **string** <br>Provider authorization method. For example: `credit_card`, `boleto`, `cash`, `bank`, etc. 
`provider_secret` | **string** <br>Provider authorization secret. 
`redirect_url` | **string** <br>Redirect URL to redirect to external payment provider. 
`status` | **enum** <br>Status.<br> One of: `created`, `started`, `action_required`, `succeeded`, `failed`, `canceled`, `expired`, `captured`.
`succeeded_at` | **datetime** <br>When payment authorization succeeded. 
`total_capturable_in_cents` | **integer** `readonly`<br>Total capturable amount in cents (`amount_capturable + deposit_capturable`). 
`total_captured_in_cents` | **integer** `readonly`<br>Total captured amount in cents (`amount_captured + deposit_captured`). 
`total_in_cents` | **integer** <br>Total amount in cents (amount + deposit). 
`type` | **string** `readonly`<br>Always `payment_authorizations`. 
`updated_at` | **datetime** `readonly`<br>When the resource was last updated.


## Create a payment authorization


> How to create a payment authorization:

```shell
  curl --request POST
       --url 'https://example.booqable.com/api/4/payment_authorizations'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "type": "payment_authorizations",
           "attributes": {
             "mode": "request",
             "amount_in_cents": 10000,
             "deposit_in_cents": 5000
           }
         }
       }'
```

> A 201 status response looks like this:

```json
  {
    "data": {
      "id": "8aaa4100-cf5f-4fa4-80ba-fe3f05745629",
      "type": "payment_authorizations",
      "attributes": {
        "created_at": "2018-07-05T22:55:03.000000+00:00",
        "updated_at": "2018-07-05T22:55:03.000000+00:00",
        "type": "payment_authorizations",
        "provider": null,
        "provider_id": null,
        "provider_method": null,
        "provider_secret": null,
        "provider_link": null,
        "amount_in_cents": 10000,
        "deposit_in_cents": 5000,
        "total_in_cents": 15000,
        "currency": "usd",
        "succeeded_at": null,
        "failed_at": null,
        "canceled_at": null,
        "expired_at": null,
        "cart_id": null,
        "order_id": null,
        "employee_id": "c6505e37-c8ba-4ebf-8345-3c74edbd6182",
        "customer_id": null,
        "status": "created",
        "mode": "request",
        "description": null,
        "redirect_url": null,
        "capturable": false,
        "amount_capturable_in_cents": 10000,
        "deposit_capturable_in_cents": 5000,
        "total_capturable_in_cents": 15000,
        "amount_captured_in_cents": 0,
        "deposit_captured_in_cents": 0,
        "total_captured_in_cents": 0,
        "captured_at": null,
        "capture_before": null,
        "payment_method_id": null
      },
      "relationships": {}
    },
    "meta": {}
  }
```

### HTTP Request

`POST /api/4/payment_authorizations`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[payment_authorizations]=created_at,updated_at,type`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=order,customer,employee`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][amount_in_cents]` | **integer** <br>Amount in cents. 
`data[attributes][cart_id]` | **uuid** <br>The associated cart. 
`data[attributes][currency]` | **string** <br>Currency. 
`data[attributes][customer_id]` | **uuid** <br>The associated [Customer](#customers). 
`data[attributes][deposit_in_cents]` | **integer** <br>Deposit in cents. 
`data[attributes][mode]` | **enum** <br>Mode.<br> One of: `off_session`, `checkout`, `request`, `terminal`.
`data[attributes][order_id]` | **uuid** <br>The associated [Order](#orders). 
`data[attributes][payment_method_id]` | **uuid** <br>The [PaymentMethod](#payment-methods). 
`data[attributes][provider]` | **enum** <br>Provider.<br> One of: `stripe`, `app`, `none`.
`data[attributes][provider_id]` | **string** <br>External provider authorization identification. 
`data[attributes][provider_link]` | **string** <br>Provider payment link. 
`data[attributes][provider_method]` | **string** <br>Provider authorization method. For example: `credit_card`, `boleto`, `cash`, `bank`, etc. 
`data[attributes][provider_secret]` | **string** <br>Provider authorization secret. 
`data[attributes][redirect_url]` | **string** <br>Redirect URL to redirect to external payment provider. 
`data[attributes][status]` | **enum** <br>Status.<br> One of: `created`, `started`, `action_required`, `succeeded`, `failed`, `canceled`, `expired`, `captured`.
`data[attributes][succeeded_at]` | **datetime** <br>When payment authorization succeeded. 
`data[attributes][total_in_cents]` | **integer** <br>Total amount in cents (amount + deposit). 


### Includes

This request accepts the following includes:

<ul>
  <li><code>customer</code></li>
  <li><code>employee</code></li>
  <li>
    <code>order</code>
    <ul>
      <li><code>payments</code></li>
    </ul>
  </li>
  <li><code>payment_charges</code></li>
  <li><code>payment_method</code></li>
</ul>


## Update a payment authorization


> How to update a payment authorization:

```shell
  curl --request PUT
       --url 'https://example.booqable.com/api/4/payment_authorizations/1ed150c8-95c1-4995-84f1-2d34064f48ed'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "id": "1ed150c8-95c1-4995-84f1-2d34064f48ed",
           "type": "payment_authorizations",
           "attributes": {
             "status": "started",
             "provider": "stripe",
             "provider_method": "card"
           }
         }
       }'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "1ed150c8-95c1-4995-84f1-2d34064f48ed",
      "type": "payment_authorizations",
      "attributes": {
        "created_at": "2018-11-07T01:48:04.000000+00:00",
        "updated_at": "2018-11-07T01:48:04.000000+00:00",
        "type": "payment_authorizations",
        "provider": "stripe",
        "provider_id": null,
        "provider_method": "card",
        "provider_secret": null,
        "provider_link": null,
        "amount_in_cents": 5000,
        "deposit_in_cents": 0,
        "total_in_cents": 5000,
        "currency": "usd",
        "succeeded_at": null,
        "failed_at": null,
        "canceled_at": null,
        "expired_at": null,
        "cart_id": null,
        "order_id": null,
        "employee_id": null,
        "customer_id": null,
        "status": "started",
        "mode": "request",
        "description": null,
        "redirect_url": null,
        "capturable": true,
        "amount_capturable_in_cents": 5000,
        "deposit_capturable_in_cents": 0,
        "total_capturable_in_cents": 5000,
        "amount_captured_in_cents": 0,
        "deposit_captured_in_cents": 0,
        "total_captured_in_cents": 0,
        "captured_at": null,
        "capture_before": null,
        "payment_method_id": null
      },
      "relationships": {}
    },
    "meta": {}
  }
```

### HTTP Request

`PUT /api/4/payment_authorizations/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[payment_authorizations]=created_at,updated_at,type`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=order,customer,employee`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][amount_in_cents]` | **integer** <br>Amount in cents. 
`data[attributes][cart_id]` | **uuid** <br>The associated cart. 
`data[attributes][currency]` | **string** <br>Currency. 
`data[attributes][customer_id]` | **uuid** <br>The associated [Customer](#customers). 
`data[attributes][deposit_in_cents]` | **integer** <br>Deposit in cents. 
`data[attributes][mode]` | **enum** <br>Mode.<br> One of: `off_session`, `checkout`, `request`, `terminal`.
`data[attributes][order_id]` | **uuid** <br>The associated [Order](#orders). 
`data[attributes][payment_method_id]` | **uuid** <br>The [PaymentMethod](#payment-methods). 
`data[attributes][provider]` | **enum** <br>Provider.<br> One of: `stripe`, `app`, `none`.
`data[attributes][provider_id]` | **string** <br>External provider authorization identification. 
`data[attributes][provider_link]` | **string** <br>Provider payment link. 
`data[attributes][provider_method]` | **string** <br>Provider authorization method. For example: `credit_card`, `boleto`, `cash`, `bank`, etc. 
`data[attributes][provider_secret]` | **string** <br>Provider authorization secret. 
`data[attributes][redirect_url]` | **string** <br>Redirect URL to redirect to external payment provider. 
`data[attributes][status]` | **enum** <br>Status.<br> One of: `created`, `started`, `action_required`, `succeeded`, `failed`, `canceled`, `expired`, `captured`.
`data[attributes][succeeded_at]` | **datetime** <br>When payment authorization succeeded. 
`data[attributes][total_in_cents]` | **integer** <br>Total amount in cents (amount + deposit). 


### Includes

This request accepts the following includes:

<ul>
  <li><code>customer</code></li>
  <li><code>employee</code></li>
  <li>
    <code>order</code>
    <ul>
      <li><code>payments</code></li>
    </ul>
  </li>
  <li><code>payment_charges</code></li>
  <li><code>payment_method</code></li>
</ul>

