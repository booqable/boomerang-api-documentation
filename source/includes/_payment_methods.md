# Payment methods

Re-usable payment methods stored on file.

## Relationships
Name | Description
-- | --
`customer` | **[Customer](#customers)** `optional`<br>The customer who owns this payment method. Becomes `null` after detaching a payment method.


Check matching attributes under [Fields](#payment-methods-fields) to see which relations can be written.
<br/ >
Check each individual operation to see which relations can be included as a sideload.
## Fields

 Name | Description
-- | --
`created_at` | **datetime** `readonly`<br>When the resource was created.
`customer_id` | **uuid** `readonly-after-create` `nullable`<br>The customer who owns this payment method. Becomes `null` after detaching a payment method.
`details` | **hash** `readonly-after-create`<br>Method details. 
`id` | **uuid** `readonly`<br>Primary key.
`identifier` | **string** `readonly-after-create`<br>Provider identifier of the payment method. 
`label` | **string** `readonly-after-create`<br>Label of the payment method. 
`method_type` | **string** `readonly-after-create`<br>Provider method type. 
`provider` | **enum** `readonly-after-create`<br>Provider of the payment method.<br> One of: `stripe`, `app`, `none`.
`updated_at` | **datetime** `readonly`<br>When the resource was last updated.


## Listing payment methods


> How to fetch a list of payment methods:

```shell
  curl --get 'https://example.booqable.com/api/boomerang/payment_methods'
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
          "label": "Visa XXX1234",
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

`GET /api/boomerang/payment_methods`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[payment_methods]=created_at,updated_at,label`
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
`label` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`method_type` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`provider` | **string_enum** <br>`eq`
`updated_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **array** <br>`count`


### Includes

This request does not accept any includes
## Creating a payment method


> How to create a payment method:

```shell
  curl --request POST
       --url 'https://example.booqable.com/api/boomerang/payment_methods'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "type": "payment_methods",
           "attributes": {
             "provider": "stripe",
             "identifier": "pm_123",
             "customer_id": "e1f17238-83d4-4660-8f3b-5e95b67094df",
             "label": "Test card"
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
        "label": "Test card",
        "provider": "stripe",
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

`POST /api/boomerang/payment_methods`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[payment_methods]=created_at,updated_at,label`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][customer_id]` | **uuid** <br>The customer who owns this payment method. Becomes `null` after detaching a payment method.
`data[attributes][details]` | **hash** <br>Method details. 
`data[attributes][identifier]` | **string** <br>Provider identifier of the payment method. 
`data[attributes][label]` | **string** <br>Label of the payment method. 
`data[attributes][method_type]` | **string** <br>Provider method type. 
`data[attributes][provider]` | **enum** <br>Provider of the payment method.<br> One of: `stripe`, `app`, `none`.


### Includes

This request does not accept any includes
## Detach a payment method


> How to detach a payment method from customer:

```shell
  curl --request DELETE
       --url 'https://example.booqable.com/api/boomerang/payment_methods/116b5701-21a0-41af-8a36-ca8d5e8767d6'
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
        "label": "Visa XXX1234",
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

`DELETE /api/boomerang/payment_methods/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[payment_methods]=created_at,updated_at,label`


### Includes

This request does not accept any includes