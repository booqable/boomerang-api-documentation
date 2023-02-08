# Documents

Documents hold financial and or legal information about an order. There are three types of documents: `quote`, `contract`, `invoice`.

When creating quotes and contracts, the following data is copied from the current state of the order:

- Customer information (when present)
- Pricing and deposit
- Lines

Quotes and contracts are always finalized; to make a revision, archive the document, make changes to the order, and create a new one.

Invoices are automatically generated and updated based on changes made to an order. When an invoice is finalized, and further changes are made to the order, a new invoice is created with prorated changes. The payment status of the invoice is automatically updated when payments are made for the associated order.

## Endpoints
`GET /api/boomerang/documents`

`POST api/boomerang/documents/search`

`GET /api/boomerang/documents/{id}`

`POST /api/boomerang/documents`

`PUT /api/boomerang/documents/{id}`

`DELETE /api/boomerang/documents/{id}`

## Fields
Every document has the following fields:

Name | Description
- | -
`id` | **Uuid** `readonly`<br>Primary key
`created_at` | **Datetime** `readonly`<br>When the resource was created
`updated_at` | **Datetime** `readonly`<br>When the resource was last updated
`archived` | **Boolean** `readonly`<br>Whether document is archived
`archived_at` | **Datetime** `nullable` `readonly`<br>When the document was archived
`document_type` | **String** <br>One of `invoice`, `contract`, `quote`
`number` | **Integer** <br>The document number, must be unique per type. Automatically generated if left blank.
`prefix` | **String** <br>Add a prefix to document numbers to make it easier to identify different documents. You can add dynamic values (like a year or order number) and custom prefixes e.g. `{year}-{customer_number}`.
`prefix_with_number` | **String** `readonly`<br>Rendered prefix with document number
`date` | **Date** <br>Date the document was finalized
`name` | **String** <br>Customer name. If left blank, automatically populated with the customer name of the associated order
`address` | **String** <br>Customer Address. If left blank, automatically populated with the customer address of the associated order
`reference` | **String** <br>A project number or other reference
`revised` | **Boolean** <br>Whether document is revised (applies only to `invoice`)
`finalized` | **Boolean** <br>Whether document is finalized (`quote` and `contract` are always finalized)
`sent` | **Boolean** <br>Whether document is sent (with Booqable)
`confirmed` | **Boolean** <br>Whether document is confirmed, applies to `quote` and `contract`
`status` | **String** <br>One of `confirmed`, `unconfirmed`, `revised`, `partially_paid`, `payment_due`, `paid`, `process_deposit`, `overpaid`
`signature_base64` | **String** `writeonly`<br>Base64 encoded signate, use this field to store a a signature
`signature_url` | **String** `readonly`<br>Url where the signature is stored
`deposit_type` | **String** `nullable`<br>One of `none`, `percentage_total`, `percentage`, `fixed`
`deposit_value` | **Integer** <br>The value to use for `deposit_type`
`tag_list` | **Array** <br>Case insensitive tag list
`price_in_cents` | **Integer** `readonly`<br>Subtotal excl. taxes (excl. deposit)
`grand_total_in_cents` | **Integer** `readonly`<br>Total excl. taxes (excl. deposit)
`grand_total_with_tax_in_cents` | **Integer** `readonly`<br>Amount incl. taxes (excl. deposit)
`discount_in_cents` | **Integer** `readonly`<br>Discount (incl. or excl. taxes based on `tax_strategy`
`coupon_discount_in_cents` | **Integer** `readonly`<br>Coupon discount (incl. or excl. taxes based on `tax_strategy`
`total_discount_in_cents` | **Integer** `readonly`<br>Total discount (incl. or excl. taxes based on `tax_strategy`
`deposit_in_cents` | **Integer** `readonly`<br>Deposit
`deposit_paid_in_cents` | **Integer** `readonly`<br>How much of the deposit is paid
`deposit_refunded_in_cents` | **Integer** `readonly`<br>How much of the deposit is refunded
`deposit_held_in_cents` | **Integer** `readonly`<br>Amount of deposit held
`deposit_to_refund_in_cents` | **Integer** `readonly`<br>Amount of deposit (still) to be refunded
`to_be_paid_in_cents` | **Integer** `readonly`<br>Amount that (still) has to be paid
`paid_in_cents` | **Integer** `readonly`<br>How much was paid
`tax_in_cents` | **Integer** `readonly`<br>Total tax
`discount_percentage` | **Float** <br>The discount percentage applied to this order
`order_id` | **Uuid** <br>The associated Order
`customer_id` | **Uuid** `nullable`<br>The associated Customer
`tax_region_id` | **Uuid** `nullable`<br>The associated Tax region
`coupon_id` | **Uuid** `nullable`<br>The associated Coupon
`body` | **String** `extra` `readonly`<br>Custom content displayed on a document, agreement details on a contract, for instance. Applicable to `quote` and `contract`. Populated with setting `{document_type}.body`, but can also be overridden for a specific document
`footer` | **String** `extra` `readonly`<br>The footer of a document. Populated with setting `{document_type}.footer`, but can also be overridden for a specific document


## Relationships
Documents have the following relationships:

Name | Description
- | -
`order` | **Orders**<br>Associated Order
`customer` | **Customers**<br>Associated Customer
`tax_region` | **Tax regions**<br>Associated Tax region
`coupon` | **Coupons**<br>Associated Coupon
`lines` | **Lines** `readonly`<br>Associated Lines
`tax_values` | **Tax values** `readonly`<br>Associated Tax values


## Listing documents



> How to fetch a list of documents:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/documents' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "b4e8b696-d881-498d-9e6b-0f5667c59760",
      "type": "documents",
      "attributes": {
        "created_at": "2023-02-08T13:00:42+00:00",
        "updated_at": "2023-02-08T13:00:42+00:00",
        "archived": false,
        "archived_at": null,
        "document_type": "invoice",
        "number": null,
        "prefix": null,
        "prefix_with_number": null,
        "date": null,
        "name": "John Doe",
        "address": null,
        "reference": null,
        "revised": false,
        "finalized": false,
        "sent": false,
        "confirmed": false,
        "status": "payment_due",
        "signature_url": null,
        "deposit_type": "percentage",
        "deposit_value": 10,
        "tag_list": [],
        "price_in_cents": 80250,
        "grand_total_in_cents": 72225,
        "grand_total_with_tax_in_cents": 87392,
        "discount_in_cents": 8025,
        "coupon_discount_in_cents": 0,
        "total_discount_in_cents": 8025,
        "deposit_in_cents": 10000,
        "deposit_paid_in_cents": 0,
        "deposit_refunded_in_cents": 0,
        "deposit_held_in_cents": 0,
        "deposit_to_refund_in_cents": 0,
        "to_be_paid_in_cents": 97392,
        "paid_in_cents": 0,
        "tax_in_cents": 15167,
        "discount_percentage": 10.0,
        "order_id": "dd193558-8b6a-4601-9711-8888f14eb126",
        "customer_id": "b5464694-0e7d-48d9-81bc-558e59504859",
        "tax_region_id": null,
        "coupon_id": null
      },
      "relationships": {
        "order": {
          "links": {
            "related": "api/boomerang/orders/dd193558-8b6a-4601-9711-8888f14eb126"
          }
        },
        "customer": {
          "links": {
            "related": "api/boomerang/customers/b5464694-0e7d-48d9-81bc-558e59504859"
          }
        },
        "tax_region": {
          "links": {
            "related": null
          }
        },
        "coupon": {
          "links": {
            "related": null
          }
        },
        "lines": {
          "links": {
            "related": "api/boomerang/lines?filter[owner_id]=b4e8b696-d881-498d-9e6b-0f5667c59760&filter[owner_type]=documents"
          }
        },
        "tax_values": {
          "links": {
            "related": "api/boomerang/tax_values?filter[owner_id]=b4e8b696-d881-498d-9e6b-0f5667c59760&filter[owner_type]=documents"
          }
        }
      }
    }
  ],
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/documents`

### Request params

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=order,customer,tax_region`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[documents]=id,created_at,updated_at`
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-08T12:59:53Z`
`sort` | **String** <br>How to sort the data `?sort=-created_at`
`meta` | **Hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String** <br>The page to request
`page[size]` | **String** <br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
`id` | **Uuid** <br>`eq`, `not_eq`
`created_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`archived` | **Boolean** <br>`eq`
`archived_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`document_type` | **String** <br>`eq`, `not_eq`
`number` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`prefix` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`prefix_with_number` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`date` | **Date** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`name` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`address` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`revised` | **Boolean** <br>`eq`
`finalized` | **Boolean** <br>`eq`
`sent` | **Boolean** <br>`eq`
`confirmed` | **Boolean** <br>`eq`
`status` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`deposit_type` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`tag_list` | **String** <br>`eq`
`price_in_cents` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`grand_total_in_cents` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`grand_total_with_tax_in_cents` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`discount_in_cents` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`coupon_discount_in_cents` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`total_discount_in_cents` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`deposit_in_cents` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`deposit_paid_in_cents` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`deposit_refunded_in_cents` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`deposit_held_in_cents` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`deposit_to_refund_in_cents` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`to_be_paid_in_cents` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`paid_in_cents` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`tax_in_cents` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`discount_percentage` | **Float** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`order_id` | **Uuid** <br>`eq`, `not_eq`
`customer_id` | **Uuid** <br>`eq`, `not_eq`
`tax_region_id` | **Uuid** <br>`eq`, `not_eq`
`coupon_id` | **Uuid** <br>`eq`, `not_eq`
`q` | **String** <br>`eq`
`conditions` | **Hash** <br>`eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array** <br>`count`
`status` | **Array** <br>`count`
`tag_list` | **Array** <br>`count`
`tax_strategy` | **Array** <br>`count`
`currency` | **Array** <br>`count`
`deposit_type` | **Array** <br>`count`
`price_in_cents` | **Array** <br>`sum`, `maximum`, `minimum`, `average`
`grand_total_in_cents` | **Array** <br>`sum`, `maximum`, `minimum`, `average`
`grand_total_with_tax_in_cents` | **Array** <br>`sum`, `maximum`, `minimum`, `average`
`discount_in_cents` | **Array** <br>`sum`, `maximum`, `minimum`, `average`
`coupon_discount_in_cents` | **Array** <br>`sum`, `maximum`, `minimum`, `average`
`total_discount_in_cents` | **Array** <br>`sum`, `maximum`, `minimum`, `average`
`deposit_in_cents` | **Array** <br>`sum`, `maximum`, `minimum`, `average`
`deposit_paid_in_cents` | **Array** <br>`sum`, `maximum`, `minimum`, `average`
`deposit_refunded_in_cents` | **Array** <br>`sum`, `maximum`, `minimum`, `average`
`deposit_held_in_cents` | **Array** <br>`sum`, `maximum`, `minimum`, `average`
`deposit_to_refund_in_cents` | **Array** <br>`sum`, `maximum`, `minimum`, `average`
`to_be_paid_in_cents` | **Array** <br>`sum`, `maximum`, `minimum`, `average`
`paid_in_cents` | **Array** <br>`sum`, `maximum`, `minimum`, `average`
`tax_in_cents` | **Array** <br>`sum`, `maximum`, `minimum`, `average`
`discount_percentage` | **Array** <br>`maximum`, `minimum`, `average`


### Includes

This request accepts the following includes:

`customer`


`order`






## Searching documents

Use advanced search to make logical filter groups with and/or operators.


> How to search for documents:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/documents/search' \
    --header 'content-type: application/json' \
    --data '{
      "fields": {
        "documents": "id"
      },
      "filter": {
        "conditions": {
          "operator": "and",
          "attributes": [
            {
              "operator": "or",
              "attributes": [
                {
                  "status": "paid"
                },
                {
                  "deposit_type": "none"
                }
              ]
            },
            {
              "operator": "and",
              "attributes": [
                {
                  "date": {
                    "gte": "2023-02-05T13:00:46.954Z"
                  }
                },
                {
                  "date": {
                    "lte": "2023-02-11T13:00:46.954Z"
                  }
                }
              ]
            }
          ]
        }
      }
    }'
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "d5b0a750-e471-4a5a-a447-f28018f973f9"
    },
    {
      "id": "d4294274-f71f-4a79-ae28-5902c64d7226"
    }
  ]
}
```

### HTTP Request

`POST api/boomerang/documents/search`

### Request params

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=order,customer,tax_region`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[documents]=id,created_at,updated_at`
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-08T12:59:53Z`
`sort` | **String** <br>How to sort the data `?sort=-created_at`
`meta` | **Hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String** <br>The page to request
`page[size]` | **String** <br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
`id` | **Uuid** <br>`eq`, `not_eq`
`created_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`archived` | **Boolean** <br>`eq`
`archived_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`document_type` | **String** <br>`eq`, `not_eq`
`number` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`prefix` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`prefix_with_number` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`date` | **Date** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`name` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`address` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`revised` | **Boolean** <br>`eq`
`finalized` | **Boolean** <br>`eq`
`sent` | **Boolean** <br>`eq`
`confirmed` | **Boolean** <br>`eq`
`status` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`deposit_type` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`tag_list` | **String** <br>`eq`
`price_in_cents` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`grand_total_in_cents` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`grand_total_with_tax_in_cents` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`discount_in_cents` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`coupon_discount_in_cents` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`total_discount_in_cents` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`deposit_in_cents` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`deposit_paid_in_cents` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`deposit_refunded_in_cents` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`deposit_held_in_cents` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`deposit_to_refund_in_cents` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`to_be_paid_in_cents` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`paid_in_cents` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`tax_in_cents` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`discount_percentage` | **Float** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`order_id` | **Uuid** <br>`eq`, `not_eq`
`customer_id` | **Uuid** <br>`eq`, `not_eq`
`tax_region_id` | **Uuid** <br>`eq`, `not_eq`
`coupon_id` | **Uuid** <br>`eq`, `not_eq`
`q` | **String** <br>`eq`
`conditions` | **Hash** <br>`eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array** <br>`count`
`status` | **Array** <br>`count`
`tag_list` | **Array** <br>`count`
`tax_strategy` | **Array** <br>`count`
`currency` | **Array** <br>`count`
`deposit_type` | **Array** <br>`count`
`price_in_cents` | **Array** <br>`sum`, `maximum`, `minimum`, `average`
`grand_total_in_cents` | **Array** <br>`sum`, `maximum`, `minimum`, `average`
`grand_total_with_tax_in_cents` | **Array** <br>`sum`, `maximum`, `minimum`, `average`
`discount_in_cents` | **Array** <br>`sum`, `maximum`, `minimum`, `average`
`coupon_discount_in_cents` | **Array** <br>`sum`, `maximum`, `minimum`, `average`
`total_discount_in_cents` | **Array** <br>`sum`, `maximum`, `minimum`, `average`
`deposit_in_cents` | **Array** <br>`sum`, `maximum`, `minimum`, `average`
`deposit_paid_in_cents` | **Array** <br>`sum`, `maximum`, `minimum`, `average`
`deposit_refunded_in_cents` | **Array** <br>`sum`, `maximum`, `minimum`, `average`
`deposit_held_in_cents` | **Array** <br>`sum`, `maximum`, `minimum`, `average`
`deposit_to_refund_in_cents` | **Array** <br>`sum`, `maximum`, `minimum`, `average`
`to_be_paid_in_cents` | **Array** <br>`sum`, `maximum`, `minimum`, `average`
`paid_in_cents` | **Array** <br>`sum`, `maximum`, `minimum`, `average`
`tax_in_cents` | **Array** <br>`sum`, `maximum`, `minimum`, `average`
`discount_percentage` | **Array** <br>`maximum`, `minimum`, `average`


### Includes

This request accepts the following includes:

`customer`


`order`






## Fetching a document



> How to fetch a documents:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/documents/aa24227f-cc8a-4655-8025-b86d6dfef9de' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "aa24227f-cc8a-4655-8025-b86d6dfef9de",
    "type": "documents",
    "attributes": {
      "created_at": "2023-02-08T13:00:47+00:00",
      "updated_at": "2023-02-08T13:00:48+00:00",
      "archived": false,
      "archived_at": null,
      "document_type": "invoice",
      "number": null,
      "prefix": null,
      "prefix_with_number": null,
      "date": null,
      "name": "John Doe",
      "address": null,
      "reference": null,
      "revised": false,
      "finalized": false,
      "sent": false,
      "confirmed": false,
      "status": "payment_due",
      "signature_url": null,
      "deposit_type": "percentage",
      "deposit_value": 10,
      "tag_list": [],
      "price_in_cents": 80250,
      "grand_total_in_cents": 72225,
      "grand_total_with_tax_in_cents": 87392,
      "discount_in_cents": 8025,
      "coupon_discount_in_cents": 0,
      "total_discount_in_cents": 8025,
      "deposit_in_cents": 10000,
      "deposit_paid_in_cents": 0,
      "deposit_refunded_in_cents": 0,
      "deposit_held_in_cents": 0,
      "deposit_to_refund_in_cents": 0,
      "to_be_paid_in_cents": 97392,
      "paid_in_cents": 0,
      "tax_in_cents": 15167,
      "discount_percentage": 10.0,
      "order_id": "d95d3239-a96d-4aa7-ae7c-2094c4f773cb",
      "customer_id": "8c3bef9e-62f4-48e5-b948-3109eeca6c27",
      "tax_region_id": null,
      "coupon_id": null
    },
    "relationships": {
      "order": {
        "links": {
          "related": "api/boomerang/orders/d95d3239-a96d-4aa7-ae7c-2094c4f773cb"
        }
      },
      "customer": {
        "links": {
          "related": "api/boomerang/customers/8c3bef9e-62f4-48e5-b948-3109eeca6c27"
        }
      },
      "tax_region": {
        "links": {
          "related": null
        }
      },
      "coupon": {
        "links": {
          "related": null
        }
      },
      "lines": {
        "links": {
          "related": "api/boomerang/lines?filter[owner_id]=aa24227f-cc8a-4655-8025-b86d6dfef9de&filter[owner_type]=documents"
        }
      },
      "tax_values": {
        "links": {
          "related": "api/boomerang/tax_values?filter[owner_id]=aa24227f-cc8a-4655-8025-b86d6dfef9de&filter[owner_type]=documents"
        }
      }
    }
  },
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/documents/{id}`

### Request params

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=order,customer,tax_region`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[documents]=id,created_at,updated_at`


### Includes

This request accepts the following includes:

`customer`


`order`


`tax_region`


`lines` => 
`item` => 
`photo`






`tax_values`


`coupon`






## Creating a document



> How to create a contract:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/documents' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "documents",
        "attributes": {
          "document_type": "contract",
          "order_id": "f567fdb9-7349-4614-b4d3-3a09f62441c4"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "fa2c7b27-b2f6-4952-a7b1-fad5b9d81f1d",
    "type": "documents",
    "attributes": {
      "created_at": "2023-02-08T13:00:49+00:00",
      "updated_at": "2023-02-08T13:00:49+00:00",
      "archived": false,
      "archived_at": null,
      "document_type": "contract",
      "number": 1,
      "prefix": null,
      "prefix_with_number": "1",
      "date": "2023-02-08",
      "name": "John Doe",
      "address": "",
      "reference": null,
      "revised": false,
      "finalized": true,
      "sent": false,
      "confirmed": false,
      "status": "unconfirmed",
      "signature_url": null,
      "deposit_type": "percentage",
      "deposit_value": 10,
      "tag_list": [],
      "price_in_cents": 80250,
      "grand_total_in_cents": 72225,
      "grand_total_with_tax_in_cents": 87392,
      "discount_in_cents": 8025,
      "coupon_discount_in_cents": 0,
      "total_discount_in_cents": 8025,
      "deposit_in_cents": 10000,
      "deposit_paid_in_cents": 0,
      "deposit_refunded_in_cents": 0,
      "deposit_held_in_cents": 0,
      "deposit_to_refund_in_cents": 0,
      "to_be_paid_in_cents": 0,
      "paid_in_cents": 0,
      "tax_in_cents": 15167,
      "discount_percentage": 10.0,
      "order_id": "f567fdb9-7349-4614-b4d3-3a09f62441c4",
      "customer_id": "34aeed7f-958c-48a7-b456-4f741a8a6864",
      "tax_region_id": null,
      "coupon_id": null
    },
    "relationships": {
      "order": {
        "meta": {
          "included": false
        }
      },
      "customer": {
        "meta": {
          "included": false
        }
      },
      "tax_region": {
        "meta": {
          "included": false
        }
      },
      "coupon": {
        "meta": {
          "included": false
        }
      },
      "lines": {
        "meta": {
          "included": false
        }
      },
      "tax_values": {
        "meta": {
          "included": false
        }
      }
    }
  },
  "meta": {}
}
```

### HTTP Request

`POST /api/boomerang/documents`

### Request params

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=order,customer,tax_region`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[documents]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][document_type]` | **String** <br>One of `invoice`, `contract`, `quote`
`data[attributes][number]` | **Integer** <br>The document number, must be unique per type. Automatically generated if left blank.
`data[attributes][prefix]` | **String** <br>Add a prefix to document numbers to make it easier to identify different documents. You can add dynamic values (like a year or order number) and custom prefixes e.g. `{year}-{customer_number}`.
`data[attributes][date]` | **Date** <br>Date the document was finalized
`data[attributes][name]` | **String** <br>Customer name. If left blank, automatically populated with the customer name of the associated order
`data[attributes][address]` | **String** <br>Customer Address. If left blank, automatically populated with the customer address of the associated order
`data[attributes][reference]` | **String** <br>A project number or other reference
`data[attributes][revised]` | **Boolean** <br>Whether document is revised (applies only to `invoice`)
`data[attributes][finalized]` | **Boolean** <br>Whether document is finalized (`quote` and `contract` are always finalized)
`data[attributes][sent]` | **Boolean** <br>Whether document is sent (with Booqable)
`data[attributes][confirmed]` | **Boolean** <br>Whether document is confirmed, applies to `quote` and `contract`
`data[attributes][status]` | **String** <br>One of `confirmed`, `unconfirmed`, `revised`, `partially_paid`, `payment_due`, `paid`, `process_deposit`, `overpaid`
`data[attributes][signature_base64]` | **String** <br>Base64 encoded signate, use this field to store a a signature
`data[attributes][deposit_type]` | **String** <br>One of `none`, `percentage_total`, `percentage`, `fixed`
`data[attributes][deposit_value]` | **Integer** <br>The value to use for `deposit_type`
`data[attributes][tag_list][]` | **Array** <br>Case insensitive tag list
`data[attributes][discount_percentage]` | **Float** <br>The discount percentage applied to this order
`data[attributes][order_id]` | **Uuid** <br>The associated Order
`data[attributes][customer_id]` | **Uuid** <br>The associated Customer
`data[attributes][tax_region_id]` | **Uuid** <br>The associated Tax region
`data[attributes][coupon_id]` | **Uuid** <br>The associated Coupon


### Includes

This request accepts the following includes:

`customer`


`order`


`tax_region`


`lines` => 
`item` => 
`photo`






`tax_values`


`coupon`






## Updating a document



> How to update a document:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/documents/bdd46115-07ee-40ef-a8c4-f6e6b3bc99c4' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "bdd46115-07ee-40ef-a8c4-f6e6b3bc99c4",
        "type": "documents",
        "attributes": {
          "name": "Jane Doe"
        }
      }
    }'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "bdd46115-07ee-40ef-a8c4-f6e6b3bc99c4",
    "type": "documents",
    "attributes": {
      "created_at": "2023-02-08T13:00:51+00:00",
      "updated_at": "2023-02-08T13:00:51+00:00",
      "archived": false,
      "archived_at": null,
      "document_type": "invoice",
      "number": null,
      "prefix": null,
      "prefix_with_number": null,
      "date": null,
      "name": "Jane Doe",
      "address": null,
      "reference": null,
      "revised": false,
      "finalized": false,
      "sent": false,
      "confirmed": false,
      "status": "payment_due",
      "signature_url": null,
      "deposit_type": "percentage",
      "deposit_value": 10,
      "tag_list": [],
      "price_in_cents": 80250,
      "grand_total_in_cents": 72225,
      "grand_total_with_tax_in_cents": 87392,
      "discount_in_cents": 8025,
      "coupon_discount_in_cents": 0,
      "total_discount_in_cents": 8025,
      "deposit_in_cents": 10000,
      "deposit_paid_in_cents": 0,
      "deposit_refunded_in_cents": 0,
      "deposit_held_in_cents": 0,
      "deposit_to_refund_in_cents": 0,
      "to_be_paid_in_cents": 97392,
      "paid_in_cents": 0,
      "tax_in_cents": 15167,
      "discount_percentage": 10.0,
      "order_id": "cef57519-5b99-4e53-b73e-c2710606cdb4",
      "customer_id": "1cee85a0-f4fb-4fb0-affc-f611a3aba1e2",
      "tax_region_id": null,
      "coupon_id": null
    },
    "relationships": {
      "order": {
        "meta": {
          "included": false
        }
      },
      "customer": {
        "meta": {
          "included": false
        }
      },
      "tax_region": {
        "meta": {
          "included": false
        }
      },
      "coupon": {
        "meta": {
          "included": false
        }
      },
      "lines": {
        "meta": {
          "included": false
        }
      },
      "tax_values": {
        "meta": {
          "included": false
        }
      }
    }
  },
  "meta": {}
}
```

### HTTP Request

`PUT /api/boomerang/documents/{id}`

### Request params

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=order,customer,tax_region`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[documents]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][document_type]` | **String** <br>One of `invoice`, `contract`, `quote`
`data[attributes][number]` | **Integer** <br>The document number, must be unique per type. Automatically generated if left blank.
`data[attributes][prefix]` | **String** <br>Add a prefix to document numbers to make it easier to identify different documents. You can add dynamic values (like a year or order number) and custom prefixes e.g. `{year}-{customer_number}`.
`data[attributes][date]` | **Date** <br>Date the document was finalized
`data[attributes][name]` | **String** <br>Customer name. If left blank, automatically populated with the customer name of the associated order
`data[attributes][address]` | **String** <br>Customer Address. If left blank, automatically populated with the customer address of the associated order
`data[attributes][reference]` | **String** <br>A project number or other reference
`data[attributes][revised]` | **Boolean** <br>Whether document is revised (applies only to `invoice`)
`data[attributes][finalized]` | **Boolean** <br>Whether document is finalized (`quote` and `contract` are always finalized)
`data[attributes][sent]` | **Boolean** <br>Whether document is sent (with Booqable)
`data[attributes][confirmed]` | **Boolean** <br>Whether document is confirmed, applies to `quote` and `contract`
`data[attributes][status]` | **String** <br>One of `confirmed`, `unconfirmed`, `revised`, `partially_paid`, `payment_due`, `paid`, `process_deposit`, `overpaid`
`data[attributes][signature_base64]` | **String** <br>Base64 encoded signate, use this field to store a a signature
`data[attributes][deposit_type]` | **String** <br>One of `none`, `percentage_total`, `percentage`, `fixed`
`data[attributes][deposit_value]` | **Integer** <br>The value to use for `deposit_type`
`data[attributes][tag_list][]` | **Array** <br>Case insensitive tag list
`data[attributes][discount_percentage]` | **Float** <br>The discount percentage applied to this order
`data[attributes][order_id]` | **Uuid** <br>The associated Order
`data[attributes][customer_id]` | **Uuid** <br>The associated Customer
`data[attributes][tax_region_id]` | **Uuid** <br>The associated Tax region
`data[attributes][coupon_id]` | **Uuid** <br>The associated Coupon


### Includes

This request accepts the following includes:

`customer`


`order`


`tax_region`


`lines` => 
`item` => 
`photo`






`tax_values`


`coupon`






## Archiving a document

When archiving an invoice make sure `delete_invoices` permission is enabled.


> How to archive a document:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/documents/33fcbf78-3d99-4aa9-aadb-895ee9bb1aef' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "meta": {}
}
```

### HTTP Request

`DELETE /api/boomerang/documents/{id}`

### Request params

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=order,customer,tax_region`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[documents]=id,created_at,updated_at`


### Includes

This request does not accept any includes