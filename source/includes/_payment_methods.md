# Payment methods

Re-usable payment methods stored on file.

## Endpoints
`GET /api/boomerang/payment_methods`

`POST /api/boomerang/payment_methods`

`DELETE /api/boomerang/payment_methods/{id}`

## Fields
Every payment method has the following fields:

Name | Description
-- | --
`id` | **Uuid** `readonly`<br>Primary key
`created_at` | **Datetime** `readonly`<br>When the resource was created
`updated_at` | **Datetime** `readonly`<br>When the resource was last updated
`label` | **String** <br>Label of the payment method
`provider` | **String** <br>Provider of the payment method. Can be one of `stripe`, `app`, `none`
`identifier` | **String** <br>Provider identifier of the payment method
`method_type` | **String** <br>Provider method type
`details` | **Hash** <br>Method details
`customer_id` | **Uuid** <br>The associated Customer


## Relationships
Payment methods have the following relationships:

Name | Description
-- | --
`customer` | **Customers** `readonly`<br>Associated Customer


## Listing payment methods



> How to fetch a list of payment methods:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/payment_methods' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "a7829f41-120e-47e8-b1b5-791f92dcfdf0",
      "type": "payment_methods",
      "attributes": {
        "created_at": "2024-11-11T09:27:34.292753+00:00",
        "updated_at": "2024-11-11T09:27:34.292753+00:00",
        "label": "Visa XXX1234",
        "provider": "stripe",
        "identifier": "pm_1234567890",
        "method_type": null,
        "details": {},
        "customer_id": "6735ddd9-0daf-4bf9-8702-a70d71c79333"
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
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[payment_methods]=created_at,updated_at,label`
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
`label` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`provider` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`identifier` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`method_type` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`customer_id` | **Uuid** <br>`eq`, `not_eq`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **Array** <br>`count`


### Includes

This request does not accept any includes
## Creating a payment method



> How to create a payment method:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/payment_methods' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "payment_methods",
        "attributes": {
          "provider": "stripe",
          "identifier": "pm_123",
          "customer_id": "7f33cd99-be52-4f2d-b3a2-e68b6d2464a3",
          "label": "Test card"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "ff18f8a2-5a16-4741-ad13-fb4711490c29",
    "type": "payment_methods",
    "attributes": {
      "created_at": "2024-11-11T09:27:36.076090+00:00",
      "updated_at": "2024-11-11T09:27:36.076090+00:00",
      "label": "Test card",
      "provider": "stripe",
      "identifier": "pm_123",
      "method_type": null,
      "details": {},
      "customer_id": "7f33cd99-be52-4f2d-b3a2-e68b6d2464a3"
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
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[payment_methods]=created_at,updated_at,label`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][label]` | **String** <br>Label of the payment method
`data[attributes][provider]` | **String** <br>Provider of the payment method. Can be one of `stripe`, `app`, `none`
`data[attributes][identifier]` | **String** <br>Provider identifier of the payment method
`data[attributes][method_type]` | **String** <br>Provider method type
`data[attributes][details]` | **Hash** <br>Method details
`data[attributes][customer_id]` | **Uuid** <br>The associated Customer


### Includes

This request does not accept any includes
## Detach a payment method



> How to detach a payment method from customer:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/payment_methods/6a75c377-f0cb-420a-ba2d-8b3511a5692a' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "6a75c377-f0cb-420a-ba2d-8b3511a5692a",
    "type": "payment_methods",
    "attributes": {
      "created_at": "2024-11-11T09:27:34.820073+00:00",
      "updated_at": "2024-11-11T09:27:34.882498+00:00",
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
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[payment_methods]=created_at,updated_at,label`


### Includes

This request does not accept any includes