# Orders

Orders are the heart of every rental operation. They hold configuration and information about:

- The customer
- Pricing and taxes
- Deposits
- Rental period and location
- Shortages
- (Payment) status
- Additional information

**An order can have multiple of the following statuses:**

- `new` Means it's in new state.
- `concept` Does not influence availability.
- `reserved` Items on the order will be reserved and not available for other orders.
- `started` Meanse that the rental has started. In most cases this means items our out with a customer.
- `stopped` Items are available for other rentals again.
- `canceled` The order is canceled. Items will be available for other rentals.
- `archived` The order won't show up in default search results.

The actual status of items and stock items can be found in their respective resource (Planning, StockItemPlanning).

**When assigning a customer to an order the following settings will be persisted to the order:**

- `tax_region_id`
- `deposit_type`
- `deposit_value`

**Changing one of the following values can lead to shortages:**

- `starts_at`
- `stops_at`
- `start_location_id`
- `stop_location_id`

A shortage error can be confirmed by setting the `confirm_shortage` attribute to `true`. Only if the shortage is within the limit configured in the product group(s). See the Product group resource for more information.

## Endpoints
`GET api/boomerang/orders`

`GET api/boomerang/orders/new`

`GET api/boomerang/orders/{id}`

`POST /api/boomerang/orders`

`PUT api/boomerang/orders/{id}`

## Fields
Every order has the following fields:

Name | Description
- | -
`id` | **Uuid** `readonly`<br>Primary key
`created_at` | **Datetime** `readonly`<br>When the resource was created
`updated_at` | **Datetime** `readonly`<br>When the resource was last updated
`number` | **Integer** `readonly`<br>The unique order number
`status` | **String** `readonly`<br>One of `new`, `concept`, `reserved`, `started`, `stopped`, `archived`, `canceled`
`statuses` | **Array** `readonly`<br>Status(es) of planned products
`status_counts` | **Hash** `readonly`<br>An object containing the status counts of planned products `{ "concept": 0, "reserved": 2, "started": 5, "stopped": 10 }`
`starts_at` | **Datetime** `nullable`<br>When the items on the order become unavailable
`stops_at` | **Datetime** `nullable`<br>When the items on the order become available again
`deposit_type` | **String** `nullable`<br>One of `none`, `percentage_total`, `percentage`, `fixed`
`deposit_value` | **Integer**<br>The value to use for `deposit_type`
`entirely_started` | **Boolean** `readonly`<br>Whether all items on the order are started
`entirely_stopped` | **Boolean** `readonly`<br>Whether all items on the order are stopped
`location_shortage` | **Boolean** `readonly`<br>Whether there is a shortage on the pickup location
`shortage` | **Boolean** `readonly`<br>Whether there is a shortage for this order
`payment_status` | **String** `readonly`<br>One of `paid`, `partially_paid`, `overpaid`, `payment_due`, `process_deposit`
`confirm_shortage` | **Boolean** `writeonly`<br>Confirm shortage on update
`tag_list` | **Array** `readonly`<br>Case insensitive tag list
`properties` | **Hash** `readonly`<br>A hash containing all basic property values (include properties if you need more detailed information about properties)
`price_in_cents` | **Integer** `readonly`<br>Subtotal excl. taxes (excl. deposit)
`grand_total_in_cents` | **Integer** `readonly`<br>Total excl. taxes (excl. deposit)
`grand_total_with_tax_in_cents` | **Integer** `readonly`<br>Amount incl. taxes (excl. deposit)
`tax_in_cents` | **Integer** `readonly`<br>Total tax
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
`discount_percentage` | **Float**<br>The discount percentage applied to this order
`customer_id` | **Uuid** `nullable`<br>The associated Customer
`tax_region_id` | **Uuid** `nullable`<br>The associated Tax region
`coupon_id` | **Uuid** `nullable`<br>The associated Coupon
`start_location_id` | **Uuid**<br>The associated Start location
`stop_location_id` | **Uuid**<br>The associated Stop location


## Relationships
Orders have the following relationships:

Name | Description
- | -
`customer` | **Customers**<br>The associated customer
`tax_region` | **Tax regions**<br>Associated Tax region
`coupon` | **Coupons**<br>Associated Coupon
`barcode` | **Barcodes**<br>Associated Barcode
`start_location` | **Locations** `readonly`<br>Associated Start location
`stop_location` | **Locations** `readonly`<br>Associated Stop location


## Listing orders

A description about listing orders


> How to fetch a list of orders:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/orders' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "5eccc49c-8cb1-4efc-be89-e5696c4eeea9",
      "type": "orders",
      "attributes": {
        "number": 1,
        "status": "concept",
        "statuses": [
          "concept"
        ],
        "status_counts": {
          "concept": 1,
          "new": 0,
          "reserved": 0,
          "started": 0,
          "stopped": 0
        },
        "starts_at": "2021-11-07T16:15:00+00:00",
        "stops_at": "2021-11-08T16:15:00+00:00",
        "deposit_type": "percentage",
        "deposit_value": 10,
        "entirely_started": false,
        "entirely_stopped": false,
        "location_shortage": false,
        "shortage": false,
        "payment_status": "payment_due",
        "tag_list": [
          "webshop"
        ],
        "properties": {},
        "price_in_cents": 1000,
        "grand_total_in_cents": 900,
        "grand_total_with_tax_in_cents": 1089,
        "tax_in_cents": 189,
        "discount_in_cents": 100,
        "coupon_discount_in_cents": 0,
        "total_discount_in_cents": 100,
        "deposit_in_cents": 5000,
        "deposit_paid_in_cents": 0,
        "deposit_refunded_in_cents": 0,
        "deposit_held_in_cents": 0,
        "deposit_to_refund_in_cents": 0,
        "to_be_paid_in_cents": 6089,
        "paid_in_cents": 0,
        "discount_percentage": 10.0,
        "customer_id": "0f18434c-1c2f-4c82-99f8-df87f1538406",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "1e18efbe-4868-4eef-b9b7-198a03236dda",
        "stop_location_id": "1e18efbe-4868-4eef-b9b7-198a03236dda"
      },
      "relationships": {
        "customer": {
          "links": {
            "related": "api/boomerang/customers/0f18434c-1c2f-4c82-99f8-df87f1538406"
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
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=5eccc49c-8cb1-4efc-be89-e5696c4eeea9"
          }
        },
        "start_location": {
          "links": {
            "related": "api/boomerang/locations/1e18efbe-4868-4eef-b9b7-198a03236dda"
          }
        },
        "stop_location": {
          "links": {
            "related": "api/boomerang/locations/1e18efbe-4868-4eef-b9b7-198a03236dda"
          }
        }
      }
    }
  ],
  "links": {
    "self": "api/boomerang/orders?page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/orders?page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/orders?page%5Bnumber%5D=1&page%5Bsize%5D=25"
  },
  "meta": {}
}
```

### HTTP Request

`GET api/boomerang/orders`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=customer,tax_region,coupon`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[orders]=id,created_at,updated_at`
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-11-04T16:17:06Z`
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
`number` | **Integer**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`status_counts` | **Hash**<br>`eq`
`starts_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`stops_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`customer_id` | **Uuid**<br>`eq`, `not_eq`
`tax_region_id` | **Uuid**<br>`eq`, `not_eq`
`coupon_id` | **Uuid**<br>`eq`, `not_eq`
`start_location_id` | **Uuid**<br>`eq`, `not_eq`
`stop_location_id` | **Uuid**<br>`eq`, `not_eq`
`q` | **String**<br>`eq`, `not_eq`, `prefix`, `match`


### Meta

Results can be aggregated on:

Name | Description
- | -
`status` | **Array**<br>`count`
`statuses` | **Array**<br>`count`
`deposit_type` | **Array**<br>`count`
`location_shortage` | **Array**<br>`count`
`shortage` | **Array**<br>`count`
`payment_status` | **Array**<br>`count`
`tag_list` | **Array**<br>`count`
`price_in_cents` | **Array**<br>`sum`, `maximum`, `minimum`, `average`
`grand_total_in_cents` | **Array**<br>`sum`, `maximum`, `minimum`, `average`
`grand_total_with_tax_in_cents` | **Array**<br>`sum`, `maximum`, `minimum`, `average`
`tax_in_cents` | **Array**<br>`sum`, `maximum`, `minimum`, `average`
`discount_in_cents` | **Array**<br>`sum`, `maximum`, `minimum`, `average`
`coupon_discount_in_cents` | **Array**<br>`sum`, `maximum`, `minimum`, `average`
`total_discount_in_cents` | **Array**<br>`sum`, `maximum`, `minimum`, `average`
`deposit_in_cents` | **Array**<br>`sum`, `maximum`, `minimum`, `average`
`deposit_paid_in_cents` | **Array**<br>`sum`, `maximum`, `minimum`, `average`
`deposit_refunded_in_cents` | **Array**<br>`sum`, `maximum`, `minimum`, `average`
`deposit_held_in_cents` | **Array**<br>`sum`, `maximum`, `minimum`, `average`
`deposit_to_refund_in_cents` | **Array**<br>`sum`, `maximum`, `minimum`, `average`
`to_be_paid_in_cents` | **Array**<br>`sum`, `maximum`, `minimum`, `average`
`paid_in_cents` | **Array**<br>`sum`, `maximum`, `minimum`, `average`
`discount_percentage` | **Array**<br>`maximum`, `minimum`, `average`
`total` | **Array**<br>`count`
`tax_strategy` | **Array**<br>`count`
`currency` | **Array**<br>`count`


### Includes

This request accepts the following includes:

`customer`






## New order

Returns an existing or new order for the current employee.


> How to fetch a new order:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/orders/new' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "5aab92ae-a438-4bfc-b708-f2d756cabcae",
    "type": "orders",
    "attributes": {
      "number": null,
      "status": "new",
      "statuses": [
        "new"
      ],
      "status_counts": {},
      "starts_at": null,
      "stops_at": null,
      "deposit_type": "percentage",
      "deposit_value": 100,
      "entirely_started": false,
      "entirely_stopped": false,
      "location_shortage": false,
      "shortage": false,
      "payment_status": "paid",
      "tag_list": [],
      "properties": {},
      "price_in_cents": 0,
      "grand_total_in_cents": 0,
      "grand_total_with_tax_in_cents": 0,
      "tax_in_cents": 0,
      "discount_in_cents": 0,
      "coupon_discount_in_cents": 0,
      "total_discount_in_cents": 0,
      "deposit_in_cents": 0,
      "deposit_paid_in_cents": 0,
      "deposit_refunded_in_cents": 0,
      "deposit_held_in_cents": 0,
      "deposit_to_refund_in_cents": 0,
      "to_be_paid_in_cents": 0,
      "paid_in_cents": 0,
      "discount_percentage": 0.0,
      "customer_id": null,
      "tax_region_id": null,
      "coupon_id": null,
      "start_location_id": "ea102ccb-3850-4cef-b195-3f2b500fc2e8",
      "stop_location_id": "ea102ccb-3850-4cef-b195-3f2b500fc2e8"
    },
    "relationships": {
      "customer": {
        "links": {
          "related": null
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
      "barcode": {
        "links": {
          "related": "api/boomerang/barcodes?filter[owner_id]=5aab92ae-a438-4bfc-b708-f2d756cabcae"
        }
      },
      "start_location": {
        "links": {
          "related": "api/boomerang/locations/ea102ccb-3850-4cef-b195-3f2b500fc2e8"
        }
      },
      "stop_location": {
        "links": {
          "related": "api/boomerang/locations/ea102ccb-3850-4cef-b195-3f2b500fc2e8"
        }
      }
    }
  },
  "meta": {}
}
```

### HTTP Request

`GET api/boomerang/orders/new`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=customer,tax_region,coupon`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[orders]=id,created_at,updated_at`


### Includes

This request accepts the following includes:

`customer`


`coupon`


`barcode`


`tax_region`


`start_location`


`stop_location`






## Fetching an order



> How to fetch an order:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/orders/5f2fc928-455d-442d-bbb4-65501fa5b826' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "5f2fc928-455d-442d-bbb4-65501fa5b826",
    "type": "orders",
    "attributes": {
      "number": 1,
      "status": "concept",
      "statuses": [
        "concept"
      ],
      "status_counts": {
        "concept": 1,
        "new": 0,
        "reserved": 0,
        "started": 0,
        "stopped": 0
      },
      "starts_at": "2021-11-07T16:15:00+00:00",
      "stops_at": "2021-11-08T16:15:00+00:00",
      "deposit_type": "percentage",
      "deposit_value": 10,
      "entirely_started": false,
      "entirely_stopped": false,
      "location_shortage": false,
      "shortage": false,
      "payment_status": "payment_due",
      "tag_list": [
        "webshop"
      ],
      "properties": {},
      "price_in_cents": 1000,
      "grand_total_in_cents": 900,
      "grand_total_with_tax_in_cents": 1089,
      "tax_in_cents": 189,
      "discount_in_cents": 100,
      "coupon_discount_in_cents": 0,
      "total_discount_in_cents": 100,
      "deposit_in_cents": 5000,
      "deposit_paid_in_cents": 0,
      "deposit_refunded_in_cents": 0,
      "deposit_held_in_cents": 0,
      "deposit_to_refund_in_cents": 0,
      "to_be_paid_in_cents": 6089,
      "paid_in_cents": 0,
      "discount_percentage": 10.0,
      "customer_id": "f9178b9a-8809-438f-97ee-515501c2d42f",
      "tax_region_id": null,
      "coupon_id": null,
      "start_location_id": "3310da82-011e-467a-8676-497c551a77b3",
      "stop_location_id": "3310da82-011e-467a-8676-497c551a77b3"
    },
    "relationships": {
      "customer": {
        "links": {
          "related": "api/boomerang/customers/f9178b9a-8809-438f-97ee-515501c2d42f"
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
      "barcode": {
        "links": {
          "related": "api/boomerang/barcodes?filter[owner_id]=5f2fc928-455d-442d-bbb4-65501fa5b826"
        }
      },
      "start_location": {
        "links": {
          "related": "api/boomerang/locations/3310da82-011e-467a-8676-497c551a77b3"
        }
      },
      "stop_location": {
        "links": {
          "related": "api/boomerang/locations/3310da82-011e-467a-8676-497c551a77b3"
        }
      }
    }
  },
  "meta": {}
}
```

### HTTP Request

`GET api/boomerang/orders/{id}`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=customer,tax_region,coupon`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[orders]=id,created_at,updated_at`


### Includes

This request accepts the following includes:

`customer`


`coupon`


`barcode`


`tax_region`


`start_location`


`stop_location`






## Creating an order

When creating an order, and the following fields are left blank, a sensible default will be picked:

- `deposit_type` Default deposit type configured in settings.
- `deposit_value` Default deposit value configured in settings.
- `start_location_id` First location in account.
- `stop_location_id` First location in account.


> How to create an order:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/orders' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "customers",
        "attributes": {
          "starts_at": "2021-11-07T16:17:57.967Z",
          "stops_at": "2021-12-16T16:17:57.967Z"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "a11559e5-b0ea-40c6-a4c6-1b35820ec926",
    "type": "orders",
    "attributes": {
      "number": null,
      "status": "new",
      "statuses": [
        "new"
      ],
      "status_counts": {},
      "starts_at": "2021-11-07T16:15:00+00:00",
      "stops_at": "2021-12-16T16:15:00+00:00",
      "deposit_type": "percentage",
      "deposit_value": 100,
      "entirely_started": false,
      "entirely_stopped": false,
      "location_shortage": false,
      "shortage": false,
      "payment_status": "paid",
      "tag_list": [],
      "properties": {},
      "price_in_cents": 0,
      "grand_total_in_cents": 0,
      "grand_total_with_tax_in_cents": 0,
      "tax_in_cents": 0,
      "discount_in_cents": 0,
      "coupon_discount_in_cents": 0,
      "total_discount_in_cents": 0,
      "deposit_in_cents": 0,
      "deposit_paid_in_cents": 0,
      "deposit_refunded_in_cents": 0,
      "deposit_held_in_cents": 0,
      "deposit_to_refund_in_cents": 0,
      "to_be_paid_in_cents": 0,
      "paid_in_cents": 0,
      "discount_percentage": 0.0,
      "customer_id": null,
      "tax_region_id": null,
      "coupon_id": null,
      "start_location_id": "96cbdcce-ee2e-4b48-8a2a-b63f003d7d5e",
      "stop_location_id": "96cbdcce-ee2e-4b48-8a2a-b63f003d7d5e"
    },
    "relationships": {
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
      "barcode": {
        "meta": {
          "included": false
        }
      },
      "start_location": {
        "meta": {
          "included": false
        }
      },
      "stop_location": {
        "meta": {
          "included": false
        }
      }
    }
  },
  "links": {
    "self": "api/boomerang/orders?data%5Battributes%5D%5Bstarts_at%5D=2021-11-07T16%3A17%3A57.967Z&data%5Battributes%5D%5Bstops_at%5D=2021-12-16T16%3A17%3A57.967Z&data%5Btype%5D=customers&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/orders?data%5Battributes%5D%5Bstarts_at%5D=2021-11-07T16%3A17%3A57.967Z&data%5Battributes%5D%5Bstops_at%5D=2021-12-16T16%3A17%3A57.967Z&data%5Btype%5D=customers&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/orders?data%5Battributes%5D%5Bstarts_at%5D=2021-11-07T16%3A17%3A57.967Z&data%5Battributes%5D%5Bstops_at%5D=2021-12-16T16%3A17%3A57.967Z&data%5Btype%5D=customers&page%5Bnumber%5D=1&page%5Bsize%5D=25"
  },
  "meta": {}
}
```

### HTTP Request

`POST /api/boomerang/orders`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=customer,tax_region,coupon`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[orders]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][starts_at]` | **Datetime**<br>When the items on the order become unavailable
`data[attributes][stops_at]` | **Datetime**<br>When the items on the order become available again
`data[attributes][deposit_type]` | **String**<br>One of `none`, `percentage_total`, `percentage`, `fixed`
`data[attributes][deposit_value]` | **Integer**<br>The value to use for `deposit_type`
`data[attributes][confirm_shortage]` | **Boolean**<br>Confirm shortage on update
`data[attributes][discount_percentage]` | **Float**<br>The discount percentage applied to this order
`data[attributes][customer_id]` | **Uuid**<br>The associated Customer
`data[attributes][tax_region_id]` | **Uuid**<br>The associated Tax region
`data[attributes][coupon_id]` | **Uuid**<br>The associated Coupon
`data[attributes][start_location_id]` | **Uuid**<br>The associated Start location
`data[attributes][stop_location_id]` | **Uuid**<br>The associated Stop location


### Includes

This request accepts the following includes:

`customer`


`coupon`


`barcode`


`tax_region`


`start_location`


`stop_location`






## Updating an order

When updating a customer on an order the following settings will be applied and prices will be calculated accordingly:

- `discount_percentage`
- `deposit_type`
- `deposit_value`
- `tax_region_id`


> How to assign a (new) customer to an order:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/orders/7d9cc708-38ff-4148-a3dd-3254073fe488' \
    --header 'content-type: application/json' \
    --data '{
      "fields": {
        "orders": "customer_id,tax_region_id,price_in_cents,grand_total_with_tax_in_cents,to_be_paid_in_cents"
      },
      "data": {
        "id": "7d9cc708-38ff-4148-a3dd-3254073fe488",
        "type": "orders",
        "attributes": {
          "customer_id": "0d4b0cbd-f3c1-4d39-a962-ac2b695c3b4f"
        }
      }
    }'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "7d9cc708-38ff-4148-a3dd-3254073fe488",
    "type": "orders",
    "attributes": {
      "price_in_cents": 1000,
      "grand_total_with_tax_in_cents": 1210,
      "to_be_paid_in_cents": 51210,
      "customer_id": "0d4b0cbd-f3c1-4d39-a962-ac2b695c3b4f",
      "tax_region_id": null
    },
    "relationships": {
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
      "barcode": {
        "meta": {
          "included": false
        }
      },
      "start_location": {
        "meta": {
          "included": false
        }
      },
      "stop_location": {
        "meta": {
          "included": false
        }
      }
    }
  },
  "meta": {}
}
```


> How to update the deposit_type:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/orders/09c3811b-0292-4372-9735-8462f5d04c3a' \
    --header 'content-type: application/json' \
    --data '{
      "fields": {
        "orders": "deposit_type,deposit_in_cents,to_be_paid_in_cents,deposit_paid_in_cents"
      },
      "data": {
        "id": "09c3811b-0292-4372-9735-8462f5d04c3a",
        "type": "orders",
        "attributes": {
          "deposit_type": "percentage"
        }
      }
    }'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "09c3811b-0292-4372-9735-8462f5d04c3a",
    "type": "orders",
    "attributes": {
      "deposit_type": "percentage",
      "deposit_in_cents": 5000,
      "deposit_paid_in_cents": 0,
      "to_be_paid_in_cents": 6089
    },
    "relationships": {
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
      "barcode": {
        "meta": {
          "included": false
        }
      },
      "start_location": {
        "meta": {
          "included": false
        }
      },
      "stop_location": {
        "meta": {
          "included": false
        }
      }
    }
  },
  "meta": {}
}
```


> Updating stops_at resulting in a shortage:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/orders/167f46c5-4249-4bcc-8e87-779fecbdbd6d' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "167f46c5-4249-4bcc-8e87-779fecbdbd6d",
        "type": "orders",
        "attributes": {
          "stops_at": "2021-11-10T16:18:02.930Z"
        }
      }
    }'
```

> A 422 status response looks like this:

```json
  {
  "errors": [
    {
      "code": "items_not_available",
      "status": "422",
      "title": "Items not available",
      "detail": "One or more items are not available",
      "meta": {
        "warning": [],
        "blocking": [
          {
            "reason": "shortage",
            "item_id": "07171d14-beb2-4635-8ee7-547625c39798",
            "stock_count": 1,
            "reserved": 1,
            "needed": 1,
            "shortage": 1
          }
        ]
      }
    }
  ]
}
```

### HTTP Request

`PUT api/boomerang/orders/{id}`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=customer,tax_region,coupon`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[orders]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][starts_at]` | **Datetime**<br>When items become unavailable, changing this value may result in shortages
`data[attributes][stops_at]` | **Datetime**<br>When items become available, changing this value may result in shortages
`data[attributes][deposit_type]` | **String**<br>One of `none`, `percentage_total`, `percentage`, `fixed`
`data[attributes][deposit_value]` | **Integer**<br>The value to use for `deposit_type`
`data[attributes][confirm_shortage]` | **Boolean**<br>Confirm shortage on update
`data[attributes][discount_percentage]` | **Float**<br>The discount percentage applied to this order
`data[attributes][customer_id]` | **Uuid**<br>The associated Customer
`data[attributes][tax_region_id]` | **Uuid**<br>The associated Tax region
`data[attributes][coupon_id]` | **Uuid**<br>The associated Coupon
`data[attributes][start_location_id]` | **Uuid**<br>The associated Start location
`data[attributes][stop_location_id]` | **Uuid**<br>The associated Stop location


### Includes

This request accepts the following includes:

`customer`


`coupon`


`barcode`


`tax_region`


`start_location`


`stop_location`




