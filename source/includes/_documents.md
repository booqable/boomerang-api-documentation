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
      "id": "d98701ab-53b2-4155-a0ba-049e7da23f6f",
      "type": "documents",
      "attributes": {
        "created_at": "2022-11-22T16:35:02+00:00",
        "updated_at": "2022-11-22T16:35:02+00:00",
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
        "order_id": "846c546d-908a-45e3-9d61-73ae5a76e9f9",
        "customer_id": "b1321b90-a545-4352-a484-20ef7baf5ee4",
        "tax_region_id": null,
        "coupon_id": null
      },
      "relationships": {
        "order": {
          "links": {
            "related": "api/boomerang/orders/846c546d-908a-45e3-9d61-73ae5a76e9f9"
          }
        },
        "customer": {
          "links": {
            "related": "api/boomerang/customers/b1321b90-a545-4352-a484-20ef7baf5ee4"
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
            "related": "api/boomerang/lines?filter[owner_id]=d98701ab-53b2-4155-a0ba-049e7da23f6f&filter[owner_type]=documents"
          }
        },
        "tax_values": {
          "links": {
            "related": "api/boomerang/tax_values?filter[owner_id]=d98701ab-53b2-4155-a0ba-049e7da23f6f&filter[owner_type]=documents"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-11-22T16:34:24Z`
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
                    "gte": "2022-11-19T16:35:06.332Z"
                  }
                },
                {
                  "date": {
                    "lte": "2022-11-25T16:35:06.332Z"
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
      "id": "535d5fcd-c2fb-4e43-85a6-e85fc5d6dcd5"
    },
    {
      "id": "0541a20e-f1f1-472c-8d18-ba596b0cf36e"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-11-22T16:34:24Z`
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
    --url 'https://example.booqable.com/api/boomerang/documents/be7de767-9ff6-44b6-81bd-0c33009e2d43' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "be7de767-9ff6-44b6-81bd-0c33009e2d43",
    "type": "documents",
    "attributes": {
      "created_at": "2022-11-22T16:35:07+00:00",
      "updated_at": "2022-11-22T16:35:07+00:00",
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
      "order_id": "b068246d-5bbf-4ae5-b00c-1d9a927e7345",
      "customer_id": "70bf3b0b-72aa-47d1-b9a3-48eb1404ee4c",
      "tax_region_id": null,
      "coupon_id": null
    },
    "relationships": {
      "order": {
        "links": {
          "related": "api/boomerang/orders/b068246d-5bbf-4ae5-b00c-1d9a927e7345"
        }
      },
      "customer": {
        "links": {
          "related": "api/boomerang/customers/70bf3b0b-72aa-47d1-b9a3-48eb1404ee4c"
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
          "related": "api/boomerang/lines?filter[owner_id]=be7de767-9ff6-44b6-81bd-0c33009e2d43&filter[owner_type]=documents"
        }
      },
      "tax_values": {
        "links": {
          "related": "api/boomerang/tax_values?filter[owner_id]=be7de767-9ff6-44b6-81bd-0c33009e2d43&filter[owner_type]=documents"
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
          "order_id": "e9b2f401-80d4-4308-9f93-6df9520f7e8e"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "24bebc19-015d-47ee-8007-4f71e7e8a2ac",
    "type": "documents",
    "attributes": {
      "created_at": "2022-11-22T16:35:08+00:00",
      "updated_at": "2022-11-22T16:35:08+00:00",
      "archived": false,
      "archived_at": null,
      "document_type": "contract",
      "number": 1,
      "prefix": null,
      "prefix_with_number": "1",
      "date": "2022-11-22",
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
      "order_id": "e9b2f401-80d4-4308-9f93-6df9520f7e8e",
      "customer_id": "3dba5502-ea15-4837-9f01-ca00b2fdb0f4",
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
    --url 'https://example.booqable.com/api/boomerang/documents/3df35678-916e-4d86-b425-4d3bd25b55e7' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "3df35678-916e-4d86-b425-4d3bd25b55e7",
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
    "id": "3df35678-916e-4d86-b425-4d3bd25b55e7",
    "type": "documents",
    "attributes": {
      "created_at": "2022-11-22T16:35:09+00:00",
      "updated_at": "2022-11-22T16:35:10+00:00",
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
      "order_id": "eddf694b-b5bc-43f5-acf3-36515cf79b42",
      "customer_id": "bfd01e46-4d99-4172-a4e7-47d71ffa8244",
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
    --url 'https://example.booqable.com/api/boomerang/documents/58b6883c-c3a2-47aa-a242-2300d6f81cd1' \
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