# Payment methods

Re-usable payment methods stored on file.

## Endpoints
`GET /api/boomerang/payment_methods`

`DELETE /api/boomerang/payment_methods/{id}`

## Fields
Every payment method has the following fields:

Name | Description
- | -
`id` | **Uuid** `readonly`<br>Primary key
`created_at` | **Datetime** `readonly`<br>When the resource was created
`updated_at` | **Datetime** `readonly`<br>When the resource was last updated
`data` | **Hash** `readonly`<br>Information about the payment method
`payment_method_type` | **String** `readonly`<br>Payment method type. One of `creditcard`
`customer_id` | **Uuid** `readonly`<br>The associated Customer


## Relationships
Payment methods have the following relationships:

Name | Description
- | -
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
      "id": "26d5da48-27bb-411d-92f1-93cf9012359e",
      "type": "payment_methods",
      "attributes": {
        "created_at": "2022-04-08T18:21:00+00:00",
        "updated_at": "2022-04-08T18:21:00+00:00",
        "data": {
          "name": null,
          "brand": null,
          "exp_month": null,
          "exp_year": null,
          "last4": null
        },
        "payment_method_type": "creditcard",
        "customer_id": null
      },
      "relationships": {
        "customer": {
          "links": {
            "related": null
          }
        }
      }
    }
  ],
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/payment_methods`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=customer`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[payment_methods]=id,created_at,updated_at`
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-04-08T18:19:12Z`
`sort` | **String**<br>How to sort the data `?sort=-created_at`
`meta` | **Hash**<br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String**<br>The page to request
`page[size]` | **String**<br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
`id` | **Uuid**<br>`eq`, `not_eq`
`created_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`data` | **Hash**<br>`eq`
`customer_id` | **Uuid**<br>`eq`, `not_eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array**<br>`count`


### Includes

This request does not accept any includes
## Archiving a payment method



> How to archive a payment method:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/payment_methods/25f397cd-9ade-4274-a89e-ccb85e3884a5' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "meta": {}
}
```

### HTTP Request

`DELETE /api/boomerang/payment_methods/{id}`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=customer`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[payment_methods]=id,created_at,updated_at`


### Includes

This request does not accept any includes