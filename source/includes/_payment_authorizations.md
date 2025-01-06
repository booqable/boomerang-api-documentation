# Payment authorizations

A PaymentAuthorization is a record of payment authorization that is used to track the authorization status and details.

## Relationships
Name | Description
-- | --
`customer` | **[Customer](#customers)** `required`<br>The associated customer. 
`employee` | **[Employee](#employees)** `required`<br>The employee who created this payment authorization. 
`order` | **[Order](#orders)** `required`<br>The associated order. 
`payment` | **[Payment](#payments)** `optional`<br>The payment. 
`payment_charges` | **[Payment charges](#payment-charges)** `hasmany`<br>The associated charges. 
`payment_method` | **[Payment method](#payment-methods)** `required`<br>The payment method. 


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
`created_at` | **datetime** `readonly`<br>When the resource was created.
`currency` | **string** <br>Currency. 
`customer_id` | **uuid** `readonly-after-create`<br>The associated customer. 
`deposit_capturable_in_cents` | **integer** `readonly`<br>Capturable deposit in cents. 
`deposit_captured_in_cents` | **integer** `readonly`<br>Captured deposit in cents. 
`deposit_in_cents` | **integer** <br>Deposit in cents. 
`description` | **string** <br>Description. 
`employee_id` | **uuid** `readonly`<br>The employee who created this payment authorization. 
`expired_at` | **datetime** `readonly`<br>When payment authorization expired. 
`failed_at` | **datetime** `readonly`<br>When payment authorization failed. 
`id` | **uuid** `readonly`<br>Primary key.
`mode` | **enum** <br>Mode.<br> One of: `off_session`, `checkout`, `request`, `terminal`.
`order_id` | **uuid** `readonly-after-create`<br>The associated order. 
`payment_method_id` | **uuid** `readonly-after-create`<br>The payment method. 
`possible_actions` | **array** `readonly`<br>Possible actions to be taken on the payment charge. 
`provider` | **enum** <br>Provider.<br> One of: `stripe`, `app`.
`provider_id` | **string** <br>External provider authorization identification. 
`provider_method` | **string** <br>Provider authorization method. Ex: credit_card, boleto, cash, bank, etc... 
`provider_secret` | **string** <br>Provider authorization secret. 
`redirect_url` | **string** <br>Redirect URL to redirect to external payment provider. 
`status` | **enum** <br>Status.<br> One of: `created`, `started`, `action_required`, `succeeded`, `failed`, `canceled`, `expired`, `captured`.
`succeeded_at` | **datetime** `readonly`<br>When payment authorization succeeded. 
`total_capturable_in_cents` | **integer** `readonly`<br>Total capturable amount in cents (`amount_capturable + deposit_capturable`). 
`total_captured_in_cents` | **integer** `readonly`<br>Total captured amount in cents (`amount_captured + deposit_captured`). 
`total_in_cents` | **integer** `readonly`<br>Total amount in cents (amount + deposit). 
`updated_at` | **datetime** `readonly`<br>When the resource was last updated.


## List payment authorizations


> How to fetch a list of payment authorizations:

```shell
  curl --get 'https://example.booqable.com/api/boomerang/payment_authorizations'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": [
      {
        "id": "66874981-e62c-43f2-802e-344df90b6097",
        "type": "payment_authorizations",
        "attributes": {
          "created_at": "2016-01-06T17:46:00.000000+00:00",
          "updated_at": "2016-01-06T17:46:00.000000+00:00",
          "status": "created",
          "amount_in_cents": 100,
          "deposit_in_cents": 0,
          "total_in_cents": 100,
          "currency": "usd",
          "mode": "request",
          "description": null,
          "redirect_url": null,
          "provider": "stripe",
          "provider_id": null,
          "provider_method": null,
          "provider_secret": null,
          "capturable": true,
          "amount_capturable_in_cents": 100,
          "deposit_capturable_in_cents": 0,
          "total_capturable_in_cents": 100,
          "amount_captured_in_cents": 0,
          "deposit_captured_in_cents": 0,
          "total_captured_in_cents": 0,
          "captured_at": null,
          "capture_before": null,
          "succeeded_at": null,
          "failed_at": null,
          "canceled_at": null,
          "expired_at": null,
          "possible_actions": [
            "cancel"
          ],
          "employee_id": null,
          "order_id": null,
          "customer_id": null,
          "payment_method_id": null
        },
        "relationships": {}
      }
    ],
    "meta": {}
  }
```

### HTTP Request

`GET /api/boomerang/payment_authorizations`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[payment_authorizations]=created_at,updated_at,status`
`filter` | **hash** <br>The filters to apply `?filter[attribute][eq]=value`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=order,customer,payment_method`
`meta` | **hash** <br>Metadata to send along. `?meta[total][]=count`
`page[number]` | **string** <br>The page to request.
`page[size]` | **string** <br>The amount of items per page.
`sort` | **string** <br>How to sort the data. `?sort=attribute1,-attribute2`


### Filters

This request can be filtered on:

Name | Description
-- | --
`amount_capturable_in_cents` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`amount_captured_in_cents` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`amount_in_cents` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`canceled_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`capturable` | **boolean** <br>`eq`
`capture_before` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`captured_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`created_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`currency` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`customer_id` | **uuid** <br>`eq`, `not_eq`
`deposit_capturable_in_cents` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`deposit_captured_in_cents` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`deposit_in_cents` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`description` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`employee_id` | **uuid** <br>`eq`, `not_eq`
`expired_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`failed_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`id` | **uuid** <br>`eq`, `not_eq`
`mode` | **string_enum** <br>`eq`
`order_id` | **uuid** <br>`eq`, `not_eq`
`payment_method_id` | **uuid** <br>`eq`, `not_eq`
`provider` | **string_enum** <br>`eq`
`provider_id` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`provider_method` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`provider_secret` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`redirect_url` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`status` | **string_enum** <br>`eq`
`succeeded_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`total_capturable_in_cents` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`total_captured_in_cents` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`total_in_cents` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`amount_in_cents` | **array** <br>`sum`
`deposit_in_cents` | **array** <br>`sum`
`total` | **array** <br>`count`
`total_in_cents` | **array** <br>`sum`


### Includes

This request accepts the following includes:

`order`


`customer`


`payment_method`






## Fetch a payment authorization


> How to fetch a payment authorization:

```shell
  curl --get 'https://example.booqable.com/api/boomerang/payment_authorizations/8123994b-ac75-49a5-89d9-e375e3a3df3f'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "8123994b-ac75-49a5-89d9-e375e3a3df3f",
      "type": "payment_authorizations",
      "attributes": {
        "created_at": "2027-10-07T00:59:00.000000+00:00",
        "updated_at": "2027-10-07T00:59:00.000000+00:00",
        "status": "created",
        "amount_in_cents": 100,
        "deposit_in_cents": 0,
        "total_in_cents": 100,
        "currency": "usd",
        "mode": "request",
        "description": null,
        "redirect_url": null,
        "provider": "stripe",
        "provider_id": null,
        "provider_method": null,
        "provider_secret": null,
        "capturable": true,
        "amount_capturable_in_cents": 100,
        "deposit_capturable_in_cents": 0,
        "total_capturable_in_cents": 100,
        "amount_captured_in_cents": 0,
        "deposit_captured_in_cents": 0,
        "total_captured_in_cents": 0,
        "captured_at": null,
        "capture_before": null,
        "succeeded_at": null,
        "failed_at": null,
        "canceled_at": null,
        "expired_at": null,
        "possible_actions": [
          "cancel"
        ],
        "employee_id": null,
        "order_id": null,
        "customer_id": null,
        "payment_method_id": null
      },
      "relationships": {}
    },
    "meta": {}
  }
```

### HTTP Request

`GET /api/boomerang/payment_authorizations/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[payment_authorizations]=created_at,updated_at,status`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=order,customer,payment_method`


### Includes

This request accepts the following includes:

`order`


`customer`


`payment_method`






## Create a payment authorization


> How to create a payment authorization:

```shell
  curl --request POST
       --url 'https://example.booqable.com/api/boomerang/payment_authorizations'
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
        "status": "created",
        "amount_in_cents": 10000,
        "deposit_in_cents": 5000,
        "total_in_cents": 15000,
        "currency": "usd",
        "mode": "request",
        "description": null,
        "redirect_url": null,
        "provider": null,
        "provider_id": null,
        "provider_method": null,
        "provider_secret": null,
        "capturable": false,
        "amount_capturable_in_cents": 10000,
        "deposit_capturable_in_cents": 5000,
        "total_capturable_in_cents": 15000,
        "amount_captured_in_cents": 0,
        "deposit_captured_in_cents": 0,
        "total_captured_in_cents": 0,
        "captured_at": null,
        "capture_before": null,
        "succeeded_at": null,
        "failed_at": null,
        "canceled_at": null,
        "expired_at": null,
        "possible_actions": [
          "cancel"
        ],
        "employee_id": "c6505e37-c8ba-4ebf-8345-3c74edbd6182",
        "order_id": null,
        "customer_id": null,
        "payment_method_id": null
      },
      "relationships": {}
    },
    "meta": {}
  }
```

### HTTP Request

`POST /api/boomerang/payment_authorizations`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[payment_authorizations]=created_at,updated_at,status`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=order,customer,payment_method`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][amount_in_cents]` | **integer** <br>Amount in cents. 
`data[attributes][currency]` | **string** <br>Currency. 
`data[attributes][customer_id]` | **uuid** <br>The associated customer. 
`data[attributes][deposit_in_cents]` | **integer** <br>Deposit in cents. 
`data[attributes][mode]` | **enum** <br>Mode.<br> One of: `off_session`, `checkout`, `request`, `terminal`.
`data[attributes][order_id]` | **uuid** <br>The associated order. 
`data[attributes][payment_method_id]` | **uuid** <br>The payment method. 
`data[attributes][provider]` | **enum** <br>Provider.<br> One of: `stripe`, `app`.
`data[attributes][provider_id]` | **string** <br>External provider authorization identification. 
`data[attributes][provider_method]` | **string** <br>Provider authorization method. Ex: credit_card, boleto, cash, bank, etc... 
`data[attributes][provider_secret]` | **string** <br>Provider authorization secret. 
`data[attributes][redirect_url]` | **string** <br>Redirect URL to redirect to external payment provider. 
`data[attributes][status]` | **enum** <br>Status.<br> One of: `created`, `started`, `action_required`, `succeeded`, `failed`, `canceled`, `expired`, `captured`.


### Includes

This request accepts the following includes:

`order`


`customer`


`payment_method`






## Update a payment authorization


> How to update a payment authorization:

```shell
  curl --request PUT
       --url 'https://example.booqable.com/api/boomerang/payment_authorizations/1ed150c8-95c1-4995-84f1-2d34064f48ed'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "id": "1ed150c8-95c1-4995-84f1-2d34064f48ed",
           "type": "payment_authorizations",
           "attributes": {
             "status": "started"
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
        "status": "started",
        "amount_in_cents": 100,
        "deposit_in_cents": 0,
        "total_in_cents": 100,
        "currency": "usd",
        "mode": "request",
        "description": null,
        "redirect_url": null,
        "provider": "stripe",
        "provider_id": null,
        "provider_method": null,
        "provider_secret": null,
        "capturable": true,
        "amount_capturable_in_cents": 100,
        "deposit_capturable_in_cents": 0,
        "total_capturable_in_cents": 100,
        "amount_captured_in_cents": 0,
        "deposit_captured_in_cents": 0,
        "total_captured_in_cents": 0,
        "captured_at": null,
        "capture_before": null,
        "succeeded_at": null,
        "failed_at": null,
        "canceled_at": null,
        "expired_at": null,
        "possible_actions": [],
        "employee_id": null,
        "order_id": null,
        "customer_id": null,
        "payment_method_id": null
      },
      "relationships": {}
    },
    "meta": {}
  }
```

### HTTP Request

`PUT /api/boomerang/payment_authorizations/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[payment_authorizations]=created_at,updated_at,status`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=order,customer,payment_method`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][amount_in_cents]` | **integer** <br>Amount in cents. 
`data[attributes][currency]` | **string** <br>Currency. 
`data[attributes][customer_id]` | **uuid** <br>The associated customer. 
`data[attributes][deposit_in_cents]` | **integer** <br>Deposit in cents. 
`data[attributes][mode]` | **enum** <br>Mode.<br> One of: `off_session`, `checkout`, `request`, `terminal`.
`data[attributes][order_id]` | **uuid** <br>The associated order. 
`data[attributes][payment_method_id]` | **uuid** <br>The payment method. 
`data[attributes][provider]` | **enum** <br>Provider.<br> One of: `stripe`, `app`.
`data[attributes][provider_id]` | **string** <br>External provider authorization identification. 
`data[attributes][provider_method]` | **string** <br>Provider authorization method. Ex: credit_card, boleto, cash, bank, etc... 
`data[attributes][provider_secret]` | **string** <br>Provider authorization secret. 
`data[attributes][redirect_url]` | **string** <br>Redirect URL to redirect to external payment provider. 
`data[attributes][status]` | **enum** <br>Status.<br> One of: `created`, `started`, `action_required`, `succeeded`, `failed`, `canceled`, `expired`, `captured`.


### Includes

This request accepts the following includes:

`order`


`customer`


`payment_method`





