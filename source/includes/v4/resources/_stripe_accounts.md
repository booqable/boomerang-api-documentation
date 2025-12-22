# Stripe accounts

StripeAccounts represent Stripe Connect account configurations for a company. Each account contains the necessary
credentials and settings to process payments through Stripe's payment infrastructure.

StripeAccounts are automatically created when connecting a Stripe account through the Stripe Connect OAuth flow.
They store encrypted API keys and publishable keys needed to interact with Stripe's API, along with account identifiers
and domain information for payment method domains.

A company can maintain multiple StripeAccounts if needed, but typically only one account is active at any time.
When an account is disconnected, it's removed from API access while preserving all historical payment data and
maintaining referential integrity with existing payment records.

## Fields

 Name | Description
-- | --
`account_id` | **string** <br>The Stripe account ID for this account. This is the unique identifier provided by Stripe when the account is connected via Stripe Connect. The ID always starts with `acct_` and is immutable once set.<br>This ID is used to identify the account when making API calls to Stripe and is required for all Stripe operations. 
`created_at` | **datetime** `readonly`<br>When the resource was created.
`domain_id` | **string** `nullable`<br>The Stripe payment method domain ID for this account. Payment method domains allow Stripe to securely handle payment methods for your domain. The ID always starts with `pmd_` when present.<br>This field may be `null` if no payment method domain has been registered for this account. 
`domain_name` | **string** `nullable`<br>The domain name associated with the payment method domain. This is the domain where Stripe payment methods will be available.<br>This field may be `null` if no payment method domain has been registered. 
`email` | **string** `nullable`<br>The email address associated with the Stripe account. This is typically the email of the Stripe account owner or the business contact for the Stripe account.<br>This field may be `null` if the email was not provided during the connection process. 
`id` | **uuid** `readonly`<br>Primary key.
`publishable_key` | **string** <br>The Stripe publishable key for this account. This key is safe to expose in client-side code and is used to initialize Stripe.js and other Stripe client libraries. It's encrypted in the database but returned in plain text via the API since it's designed to be public.<br>The publishable key always starts with `pk_test_` for test mode or `pk_live_` for live mode. 
`updated_at` | **datetime** `readonly`<br>When the resource was last updated.


## List stripe accounts

Fetches a list of active (unarchived) Stripe accounts for the company. Only active accounts are returned.
> How to fetch a list of stripe accounts:

```shell
  curl --get 'https://example.booqable.com/api/4/stripe_accounts'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": [
      {
        "id": "4db106da-7aa5-4a91-8cc1-3dc98999bebd",
        "type": "stripe_accounts",
        "attributes": {
          "created_at": "2018-04-02T22:03:02.000000+00:00",
          "updated_at": "2018-04-02T22:03:02.000000+00:00",
          "account_id": "acct_1234567890",
          "email": "stripe@example.com",
          "domain_id": "pmd_1234567890_#<#<Class:0x00007f3ab2f944c8>:0x00007f3ad83d4158>",
          "domain_name": "example#<#<Class:0x00007f3ab2f944c8>:0x00007f3ad83d4158>.com",
          "publishable_key": "pk_test_12345"
        }
      }
    ],
    "meta": {}
  }
```

### HTTP Request

`GET /api/4/stripe_accounts`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[stripe_accounts]=created_at,updated_at,account_id`
`filter` | **hash** <br>The filters to apply `?filter[attribute][eq]=value`
`meta` | **hash** <br>Metadata to send along. `?meta[total][]=count`
`page[number]` | **string** <br>The page to request.
`page[size]` | **string** <br>The amount of items per page.
`sort` | **string** <br>How to sort the data. `?sort=attribute1,-attribute2`


### Filters

This request can be filtered on:

Name | Description
-- | --
`account_id` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`created_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`domain_id` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`domain_name` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`email` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`id` | **uuid** <br>`eq`, `not_eq`
`publishable_key` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`updated_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **array** <br>`count`


### Includes

This request does not accept any includes
## Fetch a stripe account

Fetches a single Stripe account by its ID. Only active (unarchived) accounts can be accessed.
> How to fetch a single stripe account:

```shell
  curl --get 'https://example.booqable.com/api/4/stripe_accounts/163defbc-9071-4951-829d-7ffcbaacc82c'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "163defbc-9071-4951-829d-7ffcbaacc82c",
      "type": "stripe_accounts",
      "attributes": {
        "created_at": "2017-11-15T08:20:00.000000+00:00",
        "updated_at": "2017-11-15T08:20:00.000000+00:00",
        "account_id": "acct_1234567890",
        "email": "stripe@example.com",
        "domain_id": "pmd_1234567890_#<#<Class:0x00007f3ab2f944c8>:0x00007f3aab0fda38>",
        "domain_name": "example#<#<Class:0x00007f3ab2f944c8>:0x00007f3aab0fda38>.com",
        "publishable_key": "pk_test_12345"
      }
    },
    "meta": {}
  }
```

### HTTP Request

`GET /api/4/stripe_accounts/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[stripe_accounts]=created_at,updated_at,account_id`


### Includes

This request does not accept any includes
## Disconnect a stripe account

Disconnects a Stripe account. This prevents it from being used for new payments while preserving historical records. Expires all employee sessions and dispatches a disconnected event.
> How to disconnect a stripe account:

```shell
  curl --request DELETE
       --url 'https://example.booqable.com/api/4/stripe_accounts/2d16169e-13da-4d18-81c8-78ea74e93a93'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "2d16169e-13da-4d18-81c8-78ea74e93a93",
      "type": "stripe_accounts",
      "attributes": {
        "created_at": "2026-03-06T20:52:03.000000+00:00",
        "updated_at": "2026-03-06T20:52:03.000000+00:00",
        "account_id": "acct_1234567890_#<#<Class:0x00007f3ab2f944c8>:0x00007f3aab5d3df0>",
        "email": "stripe_#<#<Class:0x00007f3ab2f944c8>:0x00007f3aab5d3df0>@example.com",
        "domain_id": "pmd_1234567890_#<#<Class:0x00007f3ab2f944c8>:0x00007f3aab5d3df0>",
        "domain_name": "example#<#<Class:0x00007f3ab2f944c8>:0x00007f3aab5d3df0>.com",
        "publishable_key": "pk_test_1234567890_#<#<Class:0x00007f3ab2f944c8>:0x00007f3aab5d3df0>"
      }
    },
    "meta": {}
  }
```

### HTTP Request

`DELETE /api/4/stripe_accounts/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[stripe_accounts]=created_at,updated_at,account_id`


### Includes

This request does not accept any includes