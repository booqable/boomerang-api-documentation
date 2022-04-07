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
`properties` | **Properties** `readonly`<br>Associated Properties
`start_location` | **Locations** `readonly`<br>Associated Start location
`stop_location` | **Locations** `readonly`<br>Associated Stop location
`tax_values` | **Tax values** `readonly`<br>Associated Tax values
`lines` | **Lines** `readonly`<br>Associated Lines
`stock_item_plannings` | **Stock item plannings** `readonly`<br>Associated Stock item plannings


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
      "id": "6fce1a00-1aad-451f-8df7-2c0dae80efa4",
      "type": "orders",
      "attributes": {
        "created_at": "2022-04-07T10:05:38+00:00",
        "updated_at": "2022-04-07T10:05:39+00:00",
        "number": 1,
        "status": "reserved",
        "statuses": [
          "reserved"
        ],
        "status_counts": {
          "concept": 0,
          "new": 0,
          "reserved": 1,
          "started": 0,
          "stopped": 0
        },
        "starts_at": "1980-04-01T12:00:00+00:00",
        "stops_at": "1980-05-01T12:00:00+00:00",
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
        "price_in_cents": 80250,
        "grand_total_in_cents": 72225,
        "grand_total_with_tax_in_cents": 87392,
        "tax_in_cents": 15167,
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
        "discount_percentage": 10.0,
        "customer_id": "2527506f-4eff-4d35-98e7-8683047e7fad",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "0cc2c6d3-cc09-46f8-b937-d5cd859bbcfb",
        "stop_location_id": "0cc2c6d3-cc09-46f8-b937-d5cd859bbcfb"
      },
      "relationships": {
        "customer": {
          "links": {
            "related": "api/boomerang/customers/2527506f-4eff-4d35-98e7-8683047e7fad"
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
            "related": "api/boomerang/barcodes?filter[owner_id]=6fce1a00-1aad-451f-8df7-2c0dae80efa4&filter[owner_type]=orders"
          }
        },
        "properties": {
          "links": {
            "related": "api/boomerang/properties?filter[owner_id]=6fce1a00-1aad-451f-8df7-2c0dae80efa4&filter[owner_type]=orders"
          }
        },
        "start_location": {
          "links": {
            "related": "api/boomerang/locations/0cc2c6d3-cc09-46f8-b937-d5cd859bbcfb"
          }
        },
        "stop_location": {
          "links": {
            "related": "api/boomerang/locations/0cc2c6d3-cc09-46f8-b937-d5cd859bbcfb"
          }
        },
        "tax_values": {
          "links": {
            "related": "api/boomerang/tax_values?filter[owner_id]=6fce1a00-1aad-451f-8df7-2c0dae80efa4"
          }
        },
        "lines": {
          "links": {
            "related": "api/boomerang/lines?filter[owner_id]=6fce1a00-1aad-451f-8df7-2c0dae80efa4&filter[owner_type]=orders"
          }
        },
        "stock_item_plannings": {
          "links": {
            "related": "api/boomerang/stock_item_plannings?filter[order_id]=6fce1a00-1aad-451f-8df7-2c0dae80efa4"
          }
        }
      }
    }
  ],
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-04-07T10:04:07Z`
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
`status` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`statuses` | **Array**<br>`eq`
`status_counts` | **Hash**<br>`eq`
`starts_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`stops_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`deposit_type` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`location_shortage` | **Boolean**<br>`eq`
`shortage` | **Boolean**<br>`eq`
`payment_status` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`tag_list` | **String**<br>`eq`
`price_in_cents` | **Integer**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`grand_total_in_cents` | **Integer**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`grand_total_with_tax_in_cents` | **Integer**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`tax_in_cents` | **Integer**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`discount_in_cents` | **Integer**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`coupon_discount_in_cents` | **Integer**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`total_discount_in_cents` | **Integer**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`deposit_in_cents` | **Integer**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`deposit_paid_in_cents` | **Integer**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`deposit_refunded_in_cents` | **Integer**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`deposit_held_in_cents` | **Integer**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`deposit_to_refund_in_cents` | **Integer**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`to_be_paid_in_cents` | **Integer**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`paid_in_cents` | **Integer**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`discount_percentage` | **Float**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`customer_id` | **Uuid**<br>`eq`, `not_eq`
`tax_region_id` | **Uuid**<br>`eq`, `not_eq`
`coupon_id` | **Uuid**<br>`eq`, `not_eq`
`start_location_id` | **Uuid**<br>`eq`, `not_eq`
`stop_location_id` | **Uuid**<br>`eq`, `not_eq`
`q` | **String**<br>`eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array**<br>`count`
`payment_status` | **Array**<br>`count`
`tag_list` | **Array**<br>`count`
`status` | **Array**<br>`count`
`statuses` | **Array**<br>`count`
`shortage` | **Array**<br>`count`
`location_shortage` | **Array**<br>`count`
`deposit_type` | **Array**<br>`count`
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


### Includes

This request accepts the following includes:

`customer`


`start_location`


`stop_location`


`properties`






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
    "id": "cf2b4e5b-e1e9-4fd3-aec3-d24eb3e528a7",
    "type": "orders",
    "attributes": {
      "created_at": "2022-04-07T10:05:41+00:00",
      "updated_at": "2022-04-07T10:05:41+00:00",
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
      "start_location_id": "797ab7b0-aa68-48e3-a3d3-c5ef9915ec56",
      "stop_location_id": "797ab7b0-aa68-48e3-a3d3-c5ef9915ec56"
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
          "related": "api/boomerang/barcodes?filter[owner_id]=cf2b4e5b-e1e9-4fd3-aec3-d24eb3e528a7&filter[owner_type]=orders"
        }
      },
      "properties": {
        "links": {
          "related": "api/boomerang/properties?filter[owner_id]=cf2b4e5b-e1e9-4fd3-aec3-d24eb3e528a7&filter[owner_type]=orders"
        }
      },
      "start_location": {
        "links": {
          "related": "api/boomerang/locations/797ab7b0-aa68-48e3-a3d3-c5ef9915ec56"
        }
      },
      "stop_location": {
        "links": {
          "related": "api/boomerang/locations/797ab7b0-aa68-48e3-a3d3-c5ef9915ec56"
        }
      },
      "tax_values": {
        "links": {
          "related": "api/boomerang/tax_values?filter[owner_id]=cf2b4e5b-e1e9-4fd3-aec3-d24eb3e528a7"
        }
      },
      "lines": {
        "links": {
          "related": "api/boomerang/lines?filter[owner_id]=cf2b4e5b-e1e9-4fd3-aec3-d24eb3e528a7&filter[owner_type]=orders"
        }
      },
      "stock_item_plannings": {
        "links": {
          "related": "api/boomerang/stock_item_plannings?filter[order_id]=cf2b4e5b-e1e9-4fd3-aec3-d24eb3e528a7"
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


`lines`


`tax_values`


`properties`






## Fetching an order



> How to fetch an order:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/orders/ac3af737-23f4-4958-b97e-623bc31bd6f6' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "ac3af737-23f4-4958-b97e-623bc31bd6f6",
    "type": "orders",
    "attributes": {
      "created_at": "2022-04-07T10:05:42+00:00",
      "updated_at": "2022-04-07T10:05:43+00:00",
      "number": 1,
      "status": "reserved",
      "statuses": [
        "reserved"
      ],
      "status_counts": {
        "concept": 0,
        "new": 0,
        "reserved": 1,
        "started": 0,
        "stopped": 0
      },
      "starts_at": "1980-04-01T12:00:00+00:00",
      "stops_at": "1980-05-01T12:00:00+00:00",
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
      "price_in_cents": 80250,
      "grand_total_in_cents": 72225,
      "grand_total_with_tax_in_cents": 87392,
      "tax_in_cents": 15167,
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
      "discount_percentage": 10.0,
      "customer_id": "aef10ad6-ddfb-4bd3-82b6-37222eddc1b6",
      "tax_region_id": null,
      "coupon_id": null,
      "start_location_id": "3c06abd0-cd16-49de-99a9-8cda744db41f",
      "stop_location_id": "3c06abd0-cd16-49de-99a9-8cda744db41f"
    },
    "relationships": {
      "customer": {
        "links": {
          "related": "api/boomerang/customers/aef10ad6-ddfb-4bd3-82b6-37222eddc1b6"
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
          "related": "api/boomerang/barcodes?filter[owner_id]=ac3af737-23f4-4958-b97e-623bc31bd6f6&filter[owner_type]=orders"
        }
      },
      "properties": {
        "links": {
          "related": "api/boomerang/properties?filter[owner_id]=ac3af737-23f4-4958-b97e-623bc31bd6f6&filter[owner_type]=orders"
        }
      },
      "start_location": {
        "links": {
          "related": "api/boomerang/locations/3c06abd0-cd16-49de-99a9-8cda744db41f"
        }
      },
      "stop_location": {
        "links": {
          "related": "api/boomerang/locations/3c06abd0-cd16-49de-99a9-8cda744db41f"
        }
      },
      "tax_values": {
        "links": {
          "related": "api/boomerang/tax_values?filter[owner_id]=ac3af737-23f4-4958-b97e-623bc31bd6f6"
        }
      },
      "lines": {
        "links": {
          "related": "api/boomerang/lines?filter[owner_id]=ac3af737-23f4-4958-b97e-623bc31bd6f6&filter[owner_type]=orders"
        }
      },
      "stock_item_plannings": {
        "links": {
          "related": "api/boomerang/stock_item_plannings?filter[order_id]=ac3af737-23f4-4958-b97e-623bc31bd6f6"
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


`lines`


`tax_values`


`properties`






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
          "starts_at": "2022-04-10T10:05:45.407Z",
          "stops_at": "2022-05-19T10:05:45.407Z"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "35f9bb70-67a5-4839-baf7-c0f6538e6c99",
    "type": "orders",
    "attributes": {
      "created_at": "2022-04-07T10:05:45+00:00",
      "updated_at": "2022-04-07T10:05:45+00:00",
      "number": null,
      "status": "new",
      "statuses": [
        "new"
      ],
      "status_counts": {},
      "starts_at": "2022-04-10T10:00:00+00:00",
      "stops_at": "2022-05-19T10:00:00+00:00",
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
      "start_location_id": "02ebc6c7-56c1-4826-8faf-0fb3a70228aa",
      "stop_location_id": "02ebc6c7-56c1-4826-8faf-0fb3a70228aa"
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
      "properties": {
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
      },
      "tax_values": {
        "meta": {
          "included": false
        }
      },
      "lines": {
        "meta": {
          "included": false
        }
      },
      "stock_item_plannings": {
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


`properties`






## Updating an order

When updating a customer on an order the following settings will be applied and prices will be calculated accordingly:

- `discount_percentage`
- `deposit_type`
- `deposit_value`
- `tax_region_id`


> How to assign a (new) customer to an order:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/orders/e1b70e1b-8be0-4e22-9013-e23a769ac86b' \
    --header 'content-type: application/json' \
    --data '{
      "fields": {
        "orders": "customer_id,tax_region_id,price_in_cents,grand_total_with_tax_in_cents,to_be_paid_in_cents"
      },
      "data": {
        "id": "e1b70e1b-8be0-4e22-9013-e23a769ac86b",
        "type": "orders",
        "attributes": {
          "customer_id": "a428868f-8d0d-4626-8c40-fa92b0d8a576"
        }
      }
    }'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "e1b70e1b-8be0-4e22-9013-e23a769ac86b",
    "type": "orders",
    "attributes": {
      "price_in_cents": 80250,
      "grand_total_with_tax_in_cents": 97103,
      "to_be_paid_in_cents": 197103,
      "customer_id": "a428868f-8d0d-4626-8c40-fa92b0d8a576",
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
      "properties": {
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
      },
      "tax_values": {
        "meta": {
          "included": false
        }
      },
      "lines": {
        "meta": {
          "included": false
        }
      },
      "stock_item_plannings": {
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
    --url 'https://example.booqable.com/api/boomerang/orders/733e61ac-a32e-40ef-8605-3bff40563e99' \
    --header 'content-type: application/json' \
    --data '{
      "fields": {
        "orders": "deposit_type,deposit_in_cents,to_be_paid_in_cents,deposit_paid_in_cents"
      },
      "data": {
        "id": "733e61ac-a32e-40ef-8605-3bff40563e99",
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
    "id": "733e61ac-a32e-40ef-8605-3bff40563e99",
    "type": "orders",
    "attributes": {
      "deposit_type": "percentage",
      "deposit_in_cents": 10000,
      "deposit_paid_in_cents": 0,
      "to_be_paid_in_cents": 97392
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
      "properties": {
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
      },
      "tax_values": {
        "meta": {
          "included": false
        }
      },
      "lines": {
        "meta": {
          "included": false
        }
      },
      "stock_item_plannings": {
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
    --url 'https://example.booqable.com/api/boomerang/orders/13c58e70-1a18-4144-aa02-a22b2ada1c26' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "13c58e70-1a18-4144-aa02-a22b2ada1c26",
        "type": "orders",
        "attributes": {
          "stops_at": "1980-05-04T12:00:00.000Z"
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
            "reason": "stock_item_specified",
            "item_id": "7505a11a-6d00-44c5-ad9e-6fa83d9ccfc0",
            "unavailable": [
              "8cd22bee-c656-453d-bea3-c8046232d430"
            ],
            "available": [
              "ffaf45fd-53cf-4688-99a9-2104cd808a35"
            ]
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


`lines`


`tax_values`


`properties`





