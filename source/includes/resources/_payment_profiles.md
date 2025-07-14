# Payment profiles

Represents a connection to a payment provider configured for the company.
## Fields

 Name | Description
-- | --
`active` | **boolean** <br>Whether this payment profile is currently active and can be used for payments.
`config` | **hash** <br>Provider-specific configuration details. Contents vary by provider.
`created_at` | **datetime** `readonly`<br>When the resource was created.
`id` | **uuid** `readonly`<br>Primary key.
`provider` | **string** <br>The name of the payment provider (e.g., 'stripe', 'paypal').
`updated_at` | **datetime** `readonly`<br>When the resource was last updated.


## List payment profiles

Fetches a list of active payment profiles for the company. Only active profiles are returned.
> How to fetch a list of payment profiles:

```shell
  curl --get 'https://example.booqable.com/api/4/payment_profiles'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": [
      {
        "id": "c92283ac-65bc-45e5-8709-a32b3480cf53",
        "type": "payment_profiles",
        "attributes": {
          "created_at": "2018-05-27T23:17:00.000000+00:00",
          "updated_at": "2018-05-27T23:17:00.000000+00:00",
          "provider": "stripe",
          "active": true,
          "config": {
            "email": "pp@example.com",
            "uid": "acct_EXAMPLE",
            "api_key": "sk_test_EXAMPLE",
            "publishable_key": "pk_test_EXAMPLE"
          }
        }
      }
    ],
    "meta": {}
  }
```

### HTTP Request

`GET /api/4/payment_profiles`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[payment_profiles]=created_at,updated_at,provider`
`filter` | **hash** <br>The filters to apply `?filter[attribute][eq]=value`
`meta` | **hash** <br>Metadata to send along. `?meta[total][]=count`
`page[number]` | **string** <br>The page to request.
`page[size]` | **string** <br>The amount of items per page.
`sort` | **string** <br>How to sort the data. `?sort=attribute1,-attribute2`


### Filters

This request can be filtered on:

Name | Description
-- | --
`active` | **boolean** <br>`eq`
`created_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`id` | **uuid** <br>`eq`, `not_eq`
`provider` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`updated_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **array** <br>`count`


### Includes

This request does not accept any includes
## Fetch a payment profile

Fetches a single payment profile by its ID. Returns both active and inactive profiles.
> How to fetch a single payment profile:

```shell
  curl --get 'https://example.booqable.com/api/4/payment_profiles/db3c5cb5-41b1-4006-8aef-4944ecc4cb29'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "db3c5cb5-41b1-4006-8aef-4944ecc4cb29",
      "type": "payment_profiles",
      "attributes": {
        "created_at": "2023-10-02T16:16:00.000000+00:00",
        "updated_at": "2023-10-02T16:16:00.000000+00:00",
        "provider": "stripe",
        "active": true,
        "config": {
          "email": "pp@example.com",
          "uid": "acct_EXAMPLE",
          "api_key": "sk_test_EXAMPLE",
          "publishable_key": "pk_test_EXAMPLE"
        }
      }
    },
    "meta": {}
  }
```

### HTTP Request

`GET /api/4/payment_profiles/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[payment_profiles]=created_at,updated_at,provider`


### Includes

This request does not accept any includes
## Disconnect a payment profile

Disconnects (archives) a payment profile by marking it as inactive. This prevents it from being used for new payments while preserving historical records.
> How to disconnect a payment profile:

```shell
  curl --request DELETE
       --url 'https://example.booqable.com/api/4/payment_profiles/9ee71cf4-4c07-49ac-8529-a845dcbfaffe'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "9ee71cf4-4c07-49ac-8529-a845dcbfaffe",
      "type": "payment_profiles",
      "attributes": {
        "created_at": "2022-07-16T07:18:05.000000+00:00",
        "updated_at": "2022-07-16T07:18:05.000000+00:00",
        "provider": "stripe",
        "active": false,
        "config": {
          "email": "pp@example.com",
          "uid": "acct_EXAMPLE",
          "api_key": "sk_test_EXAMPLE",
          "publishable_key": "pk_test_EXAMPLE"
        }
      }
    },
    "meta": {}
  }
```

### HTTP Request

`DELETE /api/4/payment_profiles/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[payment_profiles]=created_at,updated_at,provider`


### Includes

This request does not accept any includes