# Documents

Documents hold financial and or legal information about an order.
There are three types of documents: `quote`, `contract`, `invoice`.

When creating quotes and contracts, the following data is copied
from the current state of the order:

- Customer information (when present)
- Pricing and deposit
- Lines

Quotes and contracts are always finalized; to make a revision,
archive the document, make changes to the order, and create a new one.

Invoices are automatically generated and updated based on changes made to an order.
When an invoice is finalized, and further changes are made to the order, a new invoice
is created with prorated changes.

The payment status of the invoice is automatically updated
when payments are made for the associated order.

## Relationships
Name | Description
-- | --
`coupon` | **[Coupon](#coupons)** `optional`<br>The associated coupon. 
`customer` | **[Customer](#customers)** `optional`<br>The associated customer. 
`lines` | **[Lines](#lines)** `hasmany`<br>The lines of this document. 
`order` | **[Order](#orders)** `required`<br>The order this document is for. 
`tax_region` | **[Tax region](#tax-regions)** `optional`<br>The associated tax region. 
`tax_values` | **[Tax values](#tax-values)** `hasmany`<br>The calculated taxes, one value for each applicable tax rate. 


Check matching attributes under [Fields](#documents-fields) to see which relations can be written.
<br/ >
Check each individual operation to see which relations can be included as a sideload.
## Fields

 Name | Description
-- | --
`address` | **string** <br>Customer Address. If left blank, automatically populated with the customer address of the associated order. 
`archived` | **boolean** `readonly`<br>Whether document is archived. 
`archived_at` | **datetime** `readonly` `nullable`<br>When the document was archived. 
`body` | **string** <br>Custom content displayed on a document, agreement details on a contract, for instance. Applicable to `quote` and `contract`. Populated with setting `{document_type}.body`, but can also be overridden for a specific document. 
`confirmed` | **boolean** <br>Whether document is confirmed, applies to `quote` and `contract`. 
`coupon_discount_in_cents` | **integer** `readonly`<br>Coupon discount (incl. or excl. taxes based on `tax_strategy`). 
`coupon_id` | **uuid** `nullable`<br>The associated coupon. 
`created_at` | **datetime** `readonly`<br>When the resource was created.
`customer_id` | **uuid** `nullable`<br>The associated customer. 
`date` | **date** <br>Date the document was finalized. 
`delivery_address` | **string** `readonly`<br>Delivery address. 
`delivery_carrier_name` | **string** `readonly`<br>Name of the delivery carrier. 
`delivery_label` | **string** `readonly`<br>Label for delivery. 
`delivery_price_in_cents` | **integer** `readonly`<br>Delivery price. 
`deposit_held_in_cents` | **integer** `readonly`<br>Amount of deposit held. 
`deposit_in_cents` | **integer** `readonly`<br>Deposit. 
`deposit_paid_in_cents` | **integer** `readonly`<br>How much of the deposit is paid. 
`deposit_refunded_in_cents` | **integer** `readonly`<br>How much of the deposit is refunded. 
`deposit_to_refund_in_cents` | **integer** `readonly`<br>Amount of deposit (still) to be refunded. 
`deposit_type` | **enum** `nullable`<br>Kind of deposit added.<br> One of: `none`, `percentage_total`, `percentage`, `fixed`.
`deposit_value` | **float** <br>The value to use for `deposit_type`. 
`discount_in_cents` | **integer** `readonly`<br>Discount (incl. or excl. taxes based on `tax_strategy`). 
`discount_percentage` | **float** <br>The discount percentage applied to this order. 
`document_type` | **enum** `readonly-after-create`<br>Type of document.<br> One of: `invoice`, `contract`, `quote`.
`due_date` | **date** <br>The latest date by which the invoice must be fully paid. 
`finalized` | **boolean** <br>Whether document is finalized (`quote` and `contract` are always finalized). 
`footer` | **string** <br>The footer of a document. Populated with setting `{document_type}.footer`, but can also be overridden for a specific document. 
`fulfillment_type` | **enum** `readonly-after-create` `nullable`<br>Type of fulfillment.<br> One of: `pickup`, `delivery`.
`grand_total_in_cents` | **integer** `readonly`<br>Total excl. taxes (excl. deposit). 
`grand_total_with_tax_in_cents` | **integer** `readonly`<br>Amount incl. taxes (excl. deposit). 
`id` | **uuid** `readonly`<br>Primary key.
`name` | **string** <br>Customer name. If left blank, automatically populated with the customer name of the associated order. 
`number` | **integer** <br>The document number, must be unique per type. Automatically generated if left blank. 
`order_id` | **uuid** `readonly-after-create`<br>The order this document is for. 
`paid_in_cents` | **integer** `readonly`<br>How much was paid. 
`prefix` | **string** <br>Add a prefix to document numbers to make it easier to identify different documents. You can add dynamic values (like a year or order number) and custom prefixes e.g. `{year}-{customer_number}`. 
`prefix_with_number` | **string** `readonly`<br>Rendered prefix with document number. 
`price_in_cents` | **integer** `readonly`<br>Subtotal excl. taxes (excl. deposit). 
`reference` | **string** <br>A project number or other reference. 
`revised` | **boolean** <br>Whether document is revised (applies only to `invoice`). 
`sent` | **boolean** <br>Whether document is sent (with Booqable). 
`signature_url` | **string** `readonly`<br>URL where the signature is stored. 
`status` | **enum** <br>Status (possible values depend on document type).<br> One of: `confirmed`, `unconfirmed`, `revised`, `partially_paid`, `payment_due`, `paid`, `process_deposit`, `overpaid`.
`tag_list` | **array** <br>Case insensitive tag list. 
`tax_in_cents` | **integer** `readonly`<br>Total tax. 
`tax_region_id` | **uuid** `nullable`<br>The associated tax region. 
`to_be_paid_in_cents` | **integer** `readonly`<br>Amount that (still) has to be paid. 
`total_discount_in_cents` | **integer** `readonly`<br>Total discount (incl. or excl. taxes based on `tax_strategy`). 
`updated_at` | **datetime** `readonly`<br>When the resource was last updated.


## List documents


> How to fetch a list of documents:

```shell
  curl --get 'https://example.booqable.com/api/boomerang/documents'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": [
      {
        "id": "a216b9f8-4f61-4eda-8672-3c6e94c9fbe2",
        "type": "documents",
        "attributes": {
          "created_at": "2027-05-20T13:53:01.000000+00:00",
          "updated_at": "2027-05-20T13:53:01.000000+00:00",
          "archived": false,
          "archived_at": null,
          "document_type": "invoice",
          "number": null,
          "prefix": null,
          "prefix_with_number": null,
          "date": null,
          "due_date": null,
          "name": "John Doe",
          "address": null,
          "body": null,
          "footer": "",
          "reference": null,
          "revised": false,
          "finalized": false,
          "sent": false,
          "confirmed": false,
          "status": "payment_due",
          "signature_url": null,
          "deposit_type": "percentage",
          "deposit_value": 10.0,
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
          "fulfillment_type": "pickup",
          "delivery_label": null,
          "delivery_price_in_cents": 0,
          "delivery_carrier_name": null,
          "delivery_address": null,
          "order_id": "e10da0d6-7881-4991-851f-ef302c712dea",
          "customer_id": "6b39f922-ebba-4e73-841c-563dd37107d7",
          "tax_region_id": null,
          "coupon_id": null
        },
        "relationships": {}
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
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[documents]=created_at,updated_at,archived`
`filter` | **hash** <br>The filters to apply `?filter[attribute][eq]=value`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=customer,order`
`meta` | **hash** <br>Metadata to send along. `?meta[total][]=count`
`page[number]` | **string** <br>The page to request.
`page[size]` | **string** <br>The amount of items per page.
`sort` | **string** <br>How to sort the data. `?sort=attribute1,-attribute2`


### Filters

This request can be filtered on:

Name | Description
-- | --
`address` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`archived` | **boolean** <br>`eq`
`archived_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`conditions` | **hash** <br>`eq`
`confirmed` | **boolean** <br>`eq`
`coupon_discount_in_cents` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`coupon_id` | **uuid** <br>`eq`, `not_eq`
`created_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`customer_id` | **uuid** <br>`eq`, `not_eq`
`date` | **date** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`date_or_created_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`, `between`
`deposit_held_in_cents` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`deposit_in_cents` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`deposit_paid_in_cents` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`deposit_refunded_in_cents` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`deposit_to_refund_in_cents` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`deposit_type` | **enum** <br>`eq`
`discount_in_cents` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`discount_percentage` | **float** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`document_type` | **enum** <br>`eq`, `not_eq`
`due_date` | **date** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`finalized` | **boolean** <br>`eq`
`fulfillment_type` | **enum** <br>`eq`
`grand_total_in_cents` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`grand_total_with_tax_in_cents` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`id` | **uuid** <br>`eq`, `not_eq`, `gt`
`name` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`number` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`order_id` | **uuid** <br>`eq`, `not_eq`
`paid_in_cents` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`prefix` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`prefix_with_number` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`price_in_cents` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`q` | **string** <br>`eq`
`revised` | **boolean** <br>`eq`
`sent` | **boolean** <br>`eq`
`status` | **enum** <br>`eq`
`tag_list` | **string** <br>`eq`
`tax_in_cents` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`tax_region_id` | **uuid** <br>`eq`, `not_eq`
`to_be_paid_in_cents` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`total_discount_in_cents` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`coupon_discount_in_cents` | **array** <br>`sum`, `maximum`, `minimum`, `average`
`currency` | **array** <br>`count`
`deposit_held_in_cents` | **array** <br>`sum`, `maximum`, `minimum`, `average`
`deposit_in_cents` | **array** <br>`sum`, `maximum`, `minimum`, `average`
`deposit_paid_in_cents` | **array** <br>`sum`, `maximum`, `minimum`, `average`
`deposit_refunded_in_cents` | **array** <br>`sum`, `maximum`, `minimum`, `average`
`deposit_to_refund_in_cents` | **array** <br>`sum`, `maximum`, `minimum`, `average`
`deposit_type` | **array** <br>`count`
`discount_in_cents` | **array** <br>`sum`, `maximum`, `minimum`, `average`
`discount_percentage` | **array** <br>`maximum`, `minimum`, `average`
`grand_total_in_cents` | **array** <br>`sum`, `maximum`, `minimum`, `average`
`grand_total_with_tax_in_cents` | **array** <br>`sum`, `maximum`, `minimum`, `average`
`paid_in_cents` | **array** <br>`sum`, `maximum`, `minimum`, `average`
`price_in_cents` | **array** <br>`sum`, `maximum`, `minimum`, `average`
`status` | **array** <br>`count`
`tag_list` | **array** <br>`count`
`tax_in_cents` | **array** <br>`sum`, `maximum`, `minimum`, `average`
`tax_strategy` | **array** <br>`count`
`to_be_paid_in_cents` | **array** <br>`sum`, `maximum`, `minimum`, `average`
`total` | **array** <br>`count`
`total_discount_in_cents` | **array** <br>`sum`, `maximum`, `minimum`, `average`


### Includes

This request accepts the following includes:

`customer`


`order`






## Search documents

Use advanced search to make logical filter groups with and/or operators.

> How to search for documents:

```shell
  curl --request POST
       --url 'https://example.booqable.com/api/boomerang/documents/search'
       --header 'content-type: application/json'
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
                       "gte": "2028-11-16T15:29:00.000000+00:00"
                     }
                   },
                   {
                     "date": {
                       "lte": "2028-11-22T15:29:00.000000+00:00"
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
        "id": "c9fa6121-84c0-4a28-893a-cceb9d2be169"
      },
      {
        "id": "3608f8e0-6ba6-4d67-81e0-800ee85ea024"
      }
    ]
  }
```

### HTTP Request

`POST api/boomerang/documents/search`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[documents]=created_at,updated_at,archived`
`filter` | **hash** <br>The filters to apply `?filter[attribute][eq]=value`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=customer,order`
`meta` | **hash** <br>Metadata to send along. `?meta[total][]=count`
`page[number]` | **string** <br>The page to request.
`page[size]` | **string** <br>The amount of items per page.
`sort` | **string** <br>How to sort the data. `?sort=attribute1,-attribute2`


### Filters

This request can be filtered on:

Name | Description
-- | --
`address` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`archived` | **boolean** <br>`eq`
`archived_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`conditions` | **hash** <br>`eq`
`confirmed` | **boolean** <br>`eq`
`coupon_discount_in_cents` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`coupon_id` | **uuid** <br>`eq`, `not_eq`
`created_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`customer_id` | **uuid** <br>`eq`, `not_eq`
`date` | **date** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`date_or_created_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`, `between`
`deposit_held_in_cents` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`deposit_in_cents` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`deposit_paid_in_cents` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`deposit_refunded_in_cents` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`deposit_to_refund_in_cents` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`deposit_type` | **enum** <br>`eq`
`discount_in_cents` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`discount_percentage` | **float** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`document_type` | **enum** <br>`eq`, `not_eq`
`due_date` | **date** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`finalized` | **boolean** <br>`eq`
`fulfillment_type` | **enum** <br>`eq`
`grand_total_in_cents` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`grand_total_with_tax_in_cents` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`id` | **uuid** <br>`eq`, `not_eq`, `gt`
`name` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`number` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`order_id` | **uuid** <br>`eq`, `not_eq`
`paid_in_cents` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`prefix` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`prefix_with_number` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`price_in_cents` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`q` | **string** <br>`eq`
`revised` | **boolean** <br>`eq`
`sent` | **boolean** <br>`eq`
`status` | **enum** <br>`eq`
`tag_list` | **string** <br>`eq`
`tax_in_cents` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`tax_region_id` | **uuid** <br>`eq`, `not_eq`
`to_be_paid_in_cents` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`total_discount_in_cents` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`coupon_discount_in_cents` | **array** <br>`sum`, `maximum`, `minimum`, `average`
`currency` | **array** <br>`count`
`deposit_held_in_cents` | **array** <br>`sum`, `maximum`, `minimum`, `average`
`deposit_in_cents` | **array** <br>`sum`, `maximum`, `minimum`, `average`
`deposit_paid_in_cents` | **array** <br>`sum`, `maximum`, `minimum`, `average`
`deposit_refunded_in_cents` | **array** <br>`sum`, `maximum`, `minimum`, `average`
`deposit_to_refund_in_cents` | **array** <br>`sum`, `maximum`, `minimum`, `average`
`deposit_type` | **array** <br>`count`
`discount_in_cents` | **array** <br>`sum`, `maximum`, `minimum`, `average`
`discount_percentage` | **array** <br>`maximum`, `minimum`, `average`
`grand_total_in_cents` | **array** <br>`sum`, `maximum`, `minimum`, `average`
`grand_total_with_tax_in_cents` | **array** <br>`sum`, `maximum`, `minimum`, `average`
`paid_in_cents` | **array** <br>`sum`, `maximum`, `minimum`, `average`
`price_in_cents` | **array** <br>`sum`, `maximum`, `minimum`, `average`
`status` | **array** <br>`count`
`tag_list` | **array** <br>`count`
`tax_in_cents` | **array** <br>`sum`, `maximum`, `minimum`, `average`
`tax_strategy` | **array** <br>`count`
`to_be_paid_in_cents` | **array** <br>`sum`, `maximum`, `minimum`, `average`
`total` | **array** <br>`count`
`total_discount_in_cents` | **array** <br>`sum`, `maximum`, `minimum`, `average`


### Includes

This request accepts the following includes:

`customer`


`order`






## Fetch a document


> How to fetch a documents:

```shell
  curl --get 'https://example.booqable.com/api/boomerang/documents/9c32036d-e60c-47b1-8ff2-7e28343dac1b'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "9c32036d-e60c-47b1-8ff2-7e28343dac1b",
      "type": "documents",
      "attributes": {
        "created_at": "2021-05-18T10:30:00.000000+00:00",
        "updated_at": "2021-05-18T10:30:00.000000+00:00",
        "archived": false,
        "archived_at": null,
        "document_type": "invoice",
        "number": null,
        "prefix": null,
        "prefix_with_number": null,
        "date": null,
        "due_date": null,
        "name": "John Doe",
        "address": null,
        "body": null,
        "footer": "",
        "reference": null,
        "revised": false,
        "finalized": false,
        "sent": false,
        "confirmed": false,
        "status": "payment_due",
        "signature_url": null,
        "deposit_type": "percentage",
        "deposit_value": 10.0,
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
        "fulfillment_type": "pickup",
        "delivery_label": null,
        "delivery_price_in_cents": 0,
        "delivery_carrier_name": null,
        "delivery_address": null,
        "order_id": "9c1a27c9-93ab-45fc-810c-ad69b9ab9617",
        "customer_id": "35578b5e-ed35-40b4-8e46-6d218d036c42",
        "tax_region_id": null,
        "coupon_id": null
      },
      "relationships": {}
    },
    "meta": {}
  }
```

### HTTP Request

`GET /api/boomerang/documents/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[documents]=created_at,updated_at,archived`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=customer,order,tax_region`


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






## Create a document


> How to create a contract:

```shell
  curl --request POST
       --url 'https://example.booqable.com/api/boomerang/documents'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "type": "documents",
           "attributes": {
             "document_type": "contract",
             "order_id": "c7d596a9-f29d-4dd8-8f81-dac3bef16c03"
           }
         }
       }'
```

> A 201 status response looks like this:

```json
  {
    "data": {
      "id": "33d005c3-65d8-4a49-80fa-5bc116112f39",
      "type": "documents",
      "attributes": {
        "created_at": "2022-10-18T11:28:01.000000+00:00",
        "updated_at": "2022-10-18T11:28:01.000000+00:00",
        "archived": false,
        "archived_at": null,
        "document_type": "contract",
        "number": 1,
        "prefix": null,
        "prefix_with_number": "1",
        "date": "2025-03-31",
        "due_date": null,
        "name": "John Doe",
        "address": null,
        "body": "",
        "footer": "",
        "reference": null,
        "revised": false,
        "finalized": true,
        "sent": false,
        "confirmed": false,
        "status": "unconfirmed",
        "signature_url": null,
        "deposit_type": "percentage",
        "deposit_value": 10.0,
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
        "fulfillment_type": "pickup",
        "delivery_label": null,
        "delivery_price_in_cents": 0,
        "delivery_carrier_name": null,
        "delivery_address": null,
        "order_id": "c7d596a9-f29d-4dd8-8f81-dac3bef16c03",
        "customer_id": "2f4f9473-239b-4b05-8bb3-e9f933d42d64",
        "tax_region_id": null,
        "coupon_id": null
      },
      "relationships": {}
    },
    "meta": {}
  }
```

### HTTP Request

`POST /api/boomerang/documents`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[documents]=created_at,updated_at,archived`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=customer,order,tax_region`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][address]` | **string** <br>Customer Address. If left blank, automatically populated with the customer address of the associated order. 
`data[attributes][body]` | **string** <br>Custom content displayed on a document, agreement details on a contract, for instance. Applicable to `quote` and `contract`. Populated with setting `{document_type}.body`, but can also be overridden for a specific document. 
`data[attributes][confirmed]` | **boolean** <br>Whether document is confirmed, applies to `quote` and `contract`. 
`data[attributes][coupon_id]` | **uuid** <br>The associated coupon. 
`data[attributes][customer_id]` | **uuid** <br>The associated customer. 
`data[attributes][date]` | **date** <br>Date the document was finalized. 
`data[attributes][deposit_type]` | **enum** <br>Kind of deposit added.<br> One of: `none`, `percentage_total`, `percentage`, `fixed`.
`data[attributes][deposit_value]` | **float** <br>The value to use for `deposit_type`. 
`data[attributes][discount_percentage]` | **float** <br>The discount percentage applied to this order. 
`data[attributes][document_type]` | **enum** <br>Type of document.<br> One of: `invoice`, `contract`, `quote`.
`data[attributes][due_date]` | **date** <br>The latest date by which the invoice must be fully paid. 
`data[attributes][finalized]` | **boolean** <br>Whether document is finalized (`quote` and `contract` are always finalized). 
`data[attributes][footer]` | **string** <br>The footer of a document. Populated with setting `{document_type}.footer`, but can also be overridden for a specific document. 
`data[attributes][fulfillment_type]` | **enum** <br>Type of fulfillment.<br> One of: `pickup`, `delivery`.
`data[attributes][name]` | **string** <br>Customer name. If left blank, automatically populated with the customer name of the associated order. 
`data[attributes][number]` | **integer** <br>The document number, must be unique per type. Automatically generated if left blank. 
`data[attributes][order_id]` | **uuid** <br>The order this document is for. 
`data[attributes][prefix]` | **string** <br>Add a prefix to document numbers to make it easier to identify different documents. You can add dynamic values (like a year or order number) and custom prefixes e.g. `{year}-{customer_number}`. 
`data[attributes][reference]` | **string** <br>A project number or other reference. 
`data[attributes][revised]` | **boolean** <br>Whether document is revised (applies only to `invoice`). 
`data[attributes][sent]` | **boolean** <br>Whether document is sent (with Booqable). 
`data[attributes][status]` | **enum** <br>Status (possible values depend on document type).<br> One of: `confirmed`, `unconfirmed`, `revised`, `partially_paid`, `payment_due`, `paid`, `process_deposit`, `overpaid`.
`data[attributes][tag_list][]` | **array** <br>Case insensitive tag list. 
`data[attributes][tax_region_id]` | **uuid** <br>The associated tax region. 


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






## Update a document


> How to update a document:

```shell
  curl --request PUT
       --url 'https://example.booqable.com/api/boomerang/documents/6b8e0c59-4b01-42e6-8477-bbfa4cea11f3'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "id": "6b8e0c59-4b01-42e6-8477-bbfa4cea11f3",
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
      "id": "6b8e0c59-4b01-42e6-8477-bbfa4cea11f3",
      "type": "documents",
      "attributes": {
        "created_at": "2016-09-18T03:33:01.000000+00:00",
        "updated_at": "2016-09-18T03:33:01.000000+00:00",
        "archived": false,
        "archived_at": null,
        "document_type": "invoice",
        "number": null,
        "prefix": null,
        "prefix_with_number": null,
        "date": null,
        "due_date": null,
        "name": "Jane Doe",
        "address": null,
        "body": null,
        "footer": "",
        "reference": null,
        "revised": false,
        "finalized": false,
        "sent": false,
        "confirmed": false,
        "status": "payment_due",
        "signature_url": null,
        "deposit_type": "percentage",
        "deposit_value": 10.0,
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
        "fulfillment_type": "pickup",
        "delivery_label": null,
        "delivery_price_in_cents": 0,
        "delivery_carrier_name": null,
        "delivery_address": null,
        "order_id": "6952ae61-0c41-4a20-8379-52f56e41884c",
        "customer_id": "da876af0-82ef-4a18-8e51-86680fba81bc",
        "tax_region_id": null,
        "coupon_id": null
      },
      "relationships": {}
    },
    "meta": {}
  }
```

### HTTP Request

`PUT /api/boomerang/documents/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[documents]=created_at,updated_at,archived`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=customer,order,tax_region`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][address]` | **string** <br>Customer Address. If left blank, automatically populated with the customer address of the associated order. 
`data[attributes][body]` | **string** <br>Custom content displayed on a document, agreement details on a contract, for instance. Applicable to `quote` and `contract`. Populated with setting `{document_type}.body`, but can also be overridden for a specific document. 
`data[attributes][confirmed]` | **boolean** <br>Whether document is confirmed, applies to `quote` and `contract`. 
`data[attributes][coupon_id]` | **uuid** <br>The associated coupon. 
`data[attributes][customer_id]` | **uuid** <br>The associated customer. 
`data[attributes][date]` | **date** <br>Date the document was finalized. 
`data[attributes][deposit_type]` | **enum** <br>Kind of deposit added.<br> One of: `none`, `percentage_total`, `percentage`, `fixed`.
`data[attributes][deposit_value]` | **float** <br>The value to use for `deposit_type`. 
`data[attributes][discount_percentage]` | **float** <br>The discount percentage applied to this order. 
`data[attributes][document_type]` | **enum** <br>Type of document.<br> One of: `invoice`, `contract`, `quote`.
`data[attributes][due_date]` | **date** <br>The latest date by which the invoice must be fully paid. 
`data[attributes][finalized]` | **boolean** <br>Whether document is finalized (`quote` and `contract` are always finalized). 
`data[attributes][footer]` | **string** <br>The footer of a document. Populated with setting `{document_type}.footer`, but can also be overridden for a specific document. 
`data[attributes][fulfillment_type]` | **enum** <br>Type of fulfillment.<br> One of: `pickup`, `delivery`.
`data[attributes][name]` | **string** <br>Customer name. If left blank, automatically populated with the customer name of the associated order. 
`data[attributes][number]` | **integer** <br>The document number, must be unique per type. Automatically generated if left blank. 
`data[attributes][order_id]` | **uuid** <br>The order this document is for. 
`data[attributes][prefix]` | **string** <br>Add a prefix to document numbers to make it easier to identify different documents. You can add dynamic values (like a year or order number) and custom prefixes e.g. `{year}-{customer_number}`. 
`data[attributes][reference]` | **string** <br>A project number or other reference. 
`data[attributes][revised]` | **boolean** <br>Whether document is revised (applies only to `invoice`). 
`data[attributes][sent]` | **boolean** <br>Whether document is sent (with Booqable). 
`data[attributes][status]` | **enum** <br>Status (possible values depend on document type).<br> One of: `confirmed`, `unconfirmed`, `revised`, `partially_paid`, `payment_due`, `paid`, `process_deposit`, `overpaid`.
`data[attributes][tag_list][]` | **array** <br>Case insensitive tag list. 
`data[attributes][tax_region_id]` | **uuid** <br>The associated tax region. 


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






## Archive a document

When archiving an invoice make sure `delete_invoices` permission is enabled.

> How to archive a document:

```shell
  curl --request DELETE
       --url 'https://example.booqable.com/api/boomerang/documents/e00df330-8241-466f-8706-d2db3d03494d'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "e00df330-8241-466f-8706-d2db3d03494d",
      "type": "documents",
      "attributes": {
        "created_at": "2018-05-06T00:22:02.000000+00:00",
        "updated_at": "2018-05-06T00:22:02.000000+00:00",
        "archived": true,
        "archived_at": "2018-05-06T00:22:02.000000+00:00",
        "document_type": "invoice",
        "number": null,
        "prefix": null,
        "prefix_with_number": null,
        "date": null,
        "due_date": null,
        "name": "John Doe",
        "address": null,
        "body": null,
        "footer": "",
        "reference": null,
        "revised": false,
        "finalized": false,
        "sent": false,
        "confirmed": false,
        "status": "payment_due",
        "signature_url": null,
        "deposit_type": "percentage",
        "deposit_value": 10.0,
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
        "fulfillment_type": "pickup",
        "delivery_label": null,
        "delivery_price_in_cents": 0,
        "delivery_carrier_name": null,
        "delivery_address": null,
        "order_id": "9253db70-5ed8-44a6-8d0b-f1af78e021fe",
        "customer_id": "3af62bd7-4635-4714-8680-79d8e23ec549",
        "tax_region_id": null,
        "coupon_id": null
      },
      "relationships": {}
    },
    "meta": {}
  }
```

### HTTP Request

`DELETE /api/boomerang/documents/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[documents]=created_at,updated_at,archived`


### Includes

This request does not accept any includes