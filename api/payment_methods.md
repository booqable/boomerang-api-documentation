# Payment methods

PaymentMethods represent stored payment details that can be used for charging customers. They store
tokenized payment information from providers like Stripe, enabling secure off-session payments without
requiring customers to re-enter payment details.

PaymentMethods are typically created when customers save their payment information during checkout or
through payment provider flows. They maintain a secure reference to the actual payment details stored
with the payment provider, never storing sensitive card numbers or bank details directly.

## Provider Integration

PaymentMethods work with different payment providers:

- **Stripe**: Tokenized cards and other Stripe payment methods
- **App**: Internal payment methods managed by the application (not currently supported)

Each PaymentMethod stores provider-specific details and identifiers that allow Booqable to charge
the payment method through the provider's API.

## Status Management

PaymentMethods have a status indicating their readiness:

- `created`: Initial state when first created
- `ready`: Verified and ready for use in payments

The status typically transitions to `ready` after provider verification or when explicitly marked
as ready by the payment flow.

## Customer Association

PaymentMethods belong to [Customers](#customers) and represent payment options available for that
specific customer. A customer can have multiple PaymentMethods, allowing them to choose between
different cards or payment options when paying.

## Labels and Display

PaymentMethods include customizable labels:

- `label_primary`: Main display label (e.g., "Visa ending in 4242")
- `label_secondary`: Additional information (e.g., "Expires 12/2025")

These labels help customers identify their saved payment methods in the interface. If not provided,
they may be automatically generated based on the payment method details.

## Relationships
Name | Description
-- | --
`customer` | **[Customer](#customers)** `optional`<br>The [Customer](#customers) who owns this payment method. PaymentMethods must belong to a customer to be created (required for Stripe payment methods).<br>When a PaymentMethod is detached (via DELETE endpoint), this relationship is removed, effectively disabling the payment method for future use while preserving the historical record.<br>The customer relationship can only be set during creation and can only be removed through the detach operation. 


Check matching attributes under [Fields](#payment-methods-fields) to see which relations can be written.
<br/ >
Check each individual operation to see which relations can be included as a sideload.
## Fields

 Name | Description
-- | --
`created_at` | **datetime** `readonly`<br>When the resource was created.
`customer_id` | **uuid** `readonly-after-create` `nullable`<br>The [Customer](#customers) who owns this payment method. PaymentMethods must belong to a customer to be created (required for Stripe payment methods).<br>When a PaymentMethod is detached (via DELETE endpoint), this relationship is removed, effectively disabling the payment method for future use while preserving the historical record.<br>The customer relationship can only be set during creation and can only be removed through the detach operation. 
`details` | **hash** `readonly-after-create`<br>Provider-specific details about the payment method stored as a JSON object. The structure and contents vary by provider and method type. For cards, this might include card brand, last four digits, expiration date, and card network metadata.<br>This data is typically populated automatically from provider webhooks or API responses and provides additional context about the payment method without containing sensitive data. 
`id` | **uuid** `readonly`<br>Primary key.
`identifier` | **string** `readonly-after-create`<br>Unique identifier for the payment method from the provider's system. For Stripe, this would be the Stripe payment method ID (e.g., "pm_1234567890"). For app payment methods, this could be an internal reference.<br>This identifier is used to reference the actual payment details stored securely with the provider and cannot be changed after creation. 
`label_primary` | **string** <br>Primary label for displaying the payment method to customers. This is typically the card brand and last four digits (e.g., "Visa •••• 4242") or a custom name given by the customer.<br>If not provided during creation, this may be automatically generated based on the payment method details from the provider. Can be updated after creation to provide custom labeling. 
`label_secondary` | **string** <br>Secondary label providing additional information about the payment method. Often contains the expiration date for cards (e.g., "Expires 12/2025") or other relevant details.<br>Like the primary label, this can be automatically generated or customized. Useful for helping customers distinguish between multiple similar payment methods. 
`method_type` | **string** `readonly-after-create`<br>The type of payment method, indicating what kind of payment instrument this represents. Common values include `card` for credit/debit cards, though the specific values depend on the provider's supported payment types.<br>This helps determine what kind of payment flow and validations apply. Cannot be changed after creation as it represents the fundamental type of the payment instrument. 
`provider` | **enum** `readonly-after-create`<br>The payment service provider for this payment method. Determines how the payment method will be processed and which provider-specific features are available.<br>One of: `stripe`, `app`, `none`.<br>`stripe` - Stripe payment method using tokenized card or bank details<br>`app` - Internal application-managed payment method<br>`none` - No provider, used for manual payment tracking<br>This value cannot be changed after creation as it fundamentally determines how the payment method integrates with external services. 
`status` | **enum** <br>Current status of the payment method indicating its readiness for use.<br>One of: `created`, `ready`.<br>`created` - Initial state when the payment method is first created<br>`ready` - Payment method is verified and can be used for charges<br>The status typically changes to `ready` after successful provider verification or when the payment method is confirmed through the payment flow. 
`updated_at` | **datetime** `readonly`<br>When the resource was last updated.


## List payment methods


> How to fetch a list of payment methods:

```shell
  curl --get 'https://example.booqable.com/api/4/payment_methods'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": [
      {
        "id": "eb25bad2-c1b1-45c1-8526-2085a293c457",
        "type": "payment_methods",
        "attributes": {
          "created_at": "2017-06-03T16:17:00.000000+00:00",
          "updated_at": "2017-06-03T16:17:00.000000+00:00",
          "label_primary": "Visa XXXX1234",
          "label_secondary": "12/25",
          "status": "created",
          "provider": "stripe",
          "identifier": "pm_1234567890",
          "method_type": null,
          "details": {},
          "customer_id": "b0815afc-9d5d-405b-8ef8-fd5373dad3e5"
        },
        "relationships": {}
      }
    ],
    "meta": {}
  }
```

### HTTP Request

`GET /api/4/payment_methods`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[payment_methods]=created_at,updated_at,label_primary`
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
`customer_id` | **uuid** <br>`eq`, `not_eq`
`id` | **uuid** <br>`eq`, `not_eq`
`identifier` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`label_primary` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`label_secondary` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`method_type` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`provider` | **enum** <br>`eq`
`status` | **enum** <br>`eq`
`updated_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **array** <br>`count`


### Includes

This request does not accept any includes
## Create a payment method


> How to create a payment method:

```shell
  curl --request POST
       --url 'https://example.booqable.com/api/4/payment_methods'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "type": "payment_methods",
           "attributes": {
             "provider": "app",
             "identifier": "pm_123",
             "customer_id": "e1f17238-83d4-4660-8f3b-5e95b67094df",
             "label_primary": "Test card",
             "status": "ready"
           }
         }
       }'
```

> A 201 status response looks like this:

```json
  {
    "data": {
      "id": "395900e5-12f7-4449-8212-a7dc4c52edf3",
      "type": "payment_methods",
      "attributes": {
        "created_at": "2019-01-15T14:37:00.000000+00:00",
        "updated_at": "2019-01-15T14:37:00.000000+00:00",
        "label_primary": "Test card",
        "label_secondary": null,
        "status": "ready",
        "provider": "app",
        "identifier": "pm_123",
        "method_type": null,
        "details": {},
        "customer_id": "e1f17238-83d4-4660-8f3b-5e95b67094df"
      },
      "relationships": {}
    },
    "meta": {}
  }
```

### HTTP Request

`POST /api/4/payment_methods`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[payment_methods]=created_at,updated_at,label_primary`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][customer_id]` | **uuid** <br>The [Customer](#customers) who owns this payment method. PaymentMethods must belong to a customer to be created (required for Stripe payment methods).<br>When a PaymentMethod is detached (via DELETE endpoint), this relationship is removed, effectively disabling the payment method for future use while preserving the historical record.<br>The customer relationship can only be set during creation and can only be removed through the detach operation. 
`data[attributes][details]` | **hash** <br>Provider-specific details about the payment method stored as a JSON object. The structure and contents vary by provider and method type. For cards, this might include card brand, last four digits, expiration date, and card network metadata.<br>This data is typically populated automatically from provider webhooks or API responses and provides additional context about the payment method without containing sensitive data. 
`data[attributes][identifier]` | **string** <br>Unique identifier for the payment method from the provider's system. For Stripe, this would be the Stripe payment method ID (e.g., "pm_1234567890"). For app payment methods, this could be an internal reference.<br>This identifier is used to reference the actual payment details stored securely with the provider and cannot be changed after creation. 
`data[attributes][label_primary]` | **string** <br>Primary label for displaying the payment method to customers. This is typically the card brand and last four digits (e.g., "Visa •••• 4242") or a custom name given by the customer.<br>If not provided during creation, this may be automatically generated based on the payment method details from the provider. Can be updated after creation to provide custom labeling. 
`data[attributes][label_secondary]` | **string** <br>Secondary label providing additional information about the payment method. Often contains the expiration date for cards (e.g., "Expires 12/2025") or other relevant details.<br>Like the primary label, this can be automatically generated or customized. Useful for helping customers distinguish between multiple similar payment methods. 
`data[attributes][method_type]` | **string** <br>The type of payment method, indicating what kind of payment instrument this represents. Common values include `card` for credit/debit cards, though the specific values depend on the provider's supported payment types.<br>This helps determine what kind of payment flow and validations apply. Cannot be changed after creation as it represents the fundamental type of the payment instrument. 
`data[attributes][provider]` | **enum** <br>The payment service provider for this payment method. Determines how the payment method will be processed and which provider-specific features are available.<br>One of: `stripe`, `app`, `none`.<br>`stripe` - Stripe payment method using tokenized card or bank details<br>`app` - Internal application-managed payment method<br>`none` - No provider, used for manual payment tracking<br>This value cannot be changed after creation as it fundamentally determines how the payment method integrates with external services. 
`data[attributes][status]` | **enum** <br>Current status of the payment method indicating its readiness for use.<br>One of: `created`, `ready`.<br>`created` - Initial state when the payment method is first created<br>`ready` - Payment method is verified and can be used for charges<br>The status typically changes to `ready` after successful provider verification or when the payment method is confirmed through the payment flow. 


### Includes

This request does not accept any includes
## Detach a payment method


> How to detach a payment method from customer:

```shell
  curl --request DELETE
       --url 'https://example.booqable.com/api/4/payment_methods/116b5701-21a0-41af-8a36-ca8d5e8767d6'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "116b5701-21a0-41af-8a36-ca8d5e8767d6",
      "type": "payment_methods",
      "attributes": {
        "created_at": "2016-08-19T20:26:00.000000+00:00",
        "updated_at": "2016-08-19T20:26:00.000000+00:00",
        "label_primary": "Visa XXXX1234",
        "label_secondary": "12/25",
        "status": "created",
        "provider": "stripe",
        "identifier": "pm_1234567890",
        "method_type": null,
        "details": {},
        "customer_id": null
      },
      "relationships": {}
    },
    "meta": {}
  }
```

### HTTP Request

`DELETE /api/4/payment_methods/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[payment_methods]=created_at,updated_at,label_primary`


### Includes

This request does not accept any includes