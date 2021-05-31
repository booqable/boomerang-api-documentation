# Orders

Orders are the heart of your operation

## Endpoints
`GET api/3/orders`

`GET api/3/orders/{id}`

`PUT api/3/orders/{id}`

## Fields
Every Order response includes the following fields:

Name | Description
- | -
`number` | **String** `nullable` `readonly`<br>The unique order number
`status` | **String** `readonly`<br>One of `new`, `concept`, `reserved`, `started`, `stopped`
`statuses` | **Array** `readonly`<br>Status(es) of planned products
`status_counts` | **Object** `readonly`<br>An object containing the status counts of planned products `{ "concept": 0, "reserved": 2, "started": 5, "stopped": 10 }`
`payment_status` | **String** `readonly`<br>One of `partially_paid`, `paid`, `partially_paid`, `overpaid`, `payment_due`, `process_deposit`
`starts_at` | **String**<br>When the items on the order become unavailable
`stops_at` | **String**<br>When the items on the order become available again
`entirely_started` | **Boolean**<br>Whether all items on the order are started
`entirely_stopped` | **Boolean**<br>Whether all items on the order are stopped
`shortage` | **Boolean**<br>Whether there is a shortage for this order
`location_shortage` | **Boolean**<br>Whether there is a shortage on the pickup location
`tags` | **Array**<br>List of tags
`currency` | **String**<br>The currency
`tax_strategy` | **String**<br>One of `inclusive`, `exclusive`
`deposit_type` | **String** `nullable`<br>One of `percentage_total`, `percentage`, `fixed`
`deposit_value` | **Number**<br>The value to use for `deposit_type`
`discount_percentage` | **String**<br>The discount percentage applied to this order
`price_in_cents` | **String**<br>Subtotal excl. taxes (excl. deposit)
`discount_in_cents` | **String**<br>Discount (incl. or excl. taxes based on `tag_strategy`
`coupon_discount_in_cents` | **String**<br>Coupon discount (incl. or excl. taxes based on `tag_strategy`
`total_discount_in_cents` | **String**<br>Total discount (incl. or excl. taxes based on `tag_strategy`
`total_tax_in_cents` | **String**<br>Sum of all taxes
`grand_total_in_cents` | **String**<br>Total excl. taxes (excl. deposit)
`grand_total_with_tax_in_cents` | **String**<br>Amount incl. taxes (excl. deposit)
`deposit_in_cents` | **String**<br>Deposit
`deposit_paid_in_cents` | **String**<br>How much of the deposit is paid
`deposit_refunded_in_cents` | **String**<br>How much of the deposit is refunded
`deposit_held_in_cents` | **String**<br>Amount of deposit held
`deposit_to_refund_in_cents` | **String**<br>Amount of deposit (still) to be refunded
`to_be_paid_in_cents` | **String**<br>Amount that (still) has to be paid
`paid_in_cents` | **String**<br>How much was paid
`created_at` | **String** `readonly`<br>When the resource was created
`updated_at` | **String** `readonly`<br>When the resource was last updated


## Relationships
For Orders you can include the following relationships:

Name | Description
- | -
`customer` | **Customer** `nullable`<br>Associated Customer
`coupon` | **Coupon** `nullable`<br>Associated Coupon
`barcode` | **Barcode** `readonly`<br>Associated Barcode
`start_location` | **Location** `nullable`<br>Associated Start location
`stop_location` | **Location** `nullable`<br>Associated Stop location
`tax_region` | **TaxRegion** `nullable`<br>Associated Tax region
`lines` | **Line**<br>Associated Lines
`plannings` | **Planning**<br>Associated Plannings
`properties` | **Property**<br>Associated Properties
`tax_values` | **TaxValue** `readonly`<br>Associated Tax values
`notes` | **Note**<br>Associated Notes
`transfers` | **Transfer** `readonly`<br>Associated Transfers


## Listing orders

> How to fetch a list of orders:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/3/orders' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "9ae63092-8857-4f3c-86d4-89fb4ce51a87",
      "type": "order",
      "attributes": {
        "created_at": "2021-05-31T20:15:24.766Z",
        "updated_at": "2021-05-31T20:15:24.766Z",
        "price_in_cents": 0,
        "grand_total_in_cents": 0,
        "grand_total_with_tax_in_cents": 0,
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
        "number": 1,
        "status": "concept",
        "starts_at": "2021-05-29T20:15:00.000Z",
        "stops_at": "2021-06-02T20:15:00.000Z",
        "customer_id": null,
        "deposit_type": null,
        "deposit_value": 0.0,
        "tax_region_id": null,
        "entirely_started": true,
        "entirely_stopped": true,
        "coupon_id": null,
        "location_shortage": false,
        "shortage": false,
        "payment_status": "Paid",
        "start_location_id": "7a2fa26e-edb3-49da-a691-884892ddce08",
        "stop_location_id": "7a2fa26e-edb3-49da-a691-884892ddce08",
        "statuses": [
          "concept"
        ],
        "status_counts": {},
        "tags": [],
        "discount_percentage": 0.0,
        "total_tax_in_cents": 0,
        "currency": "usd",
        "tax_strategy": "exclusive"
      },
      "relationships": {
        "customer": {},
        "coupon": {},
        "barcode": {},
        "start_location": {},
        "stop_location": {},
        "tax_region": {},
        "lines": {},
        "plannings": {},
        "properties": {},
        "tax_values": {},
        "notes": {},
        "transfers": {}
      }
    }
  ],
  "meta": {
    "total_count": 1,
    "tag_list": {},
    "payment_status": {
      "paid": 1
    },
    "statuses": {
      "concept": 1
    },
    "sum_item_count": 0.0,
    "status": {
      "concept": 1
    }
  },
  "links": {
    "self": "http://test.host/api/3/orders",
    "first": "http://test.host/api/3/orders?page[number]=1",
    "prev": null,
    "next": null,
    "last": "http://test.host/api/3/orders?page[number]=1"
  }
}
```

A description about listing orders

### HTTP Request

`GET api/3/orders`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[orders]=number,grand_total_in_cents`
`page[number]` | **String**<br>The page to request
`page[per]` | **String**<br>The amount of items per page (max 100)
`filters[q]` | **String**<br>
`filters[customer_id]` | **String**<br>
`filters[starts_at]` | **Object**<br>Query starts_at
`filters[starts_at][gte]` | **String**<br>Greater than given date
`filters[starts_at][lte]` | **String**<br>
`filters[starts_at][qt]` | **String**<br>
`filters[starts_at][lt]` | **String**<br>
`filters[stops_at]` | **String**<br>
`filters[stops_at][gte]` | **String**<br>
`filters[stops_at][lte]` | **String**<br>
`filters[stops_at][qt]` | **String**<br>
`filters[stops_at][lt]` | **String**<br>
`filters[start_location_id]` | **String**<br>
`filters[stop_location_id]` | **String**<br>
`filters[shortage]` | **String**<br>
`filters[payment_status]` | **String**<br>
`filters[date]` | **String**<br>
`filters[date][from]` | **String**<br>
`filters[date][till]` | **String**<br>
`filters[tag_list]` | **String**<br>


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][starts_at]` | **String**<br>When items become unavailable, changing this value may result in shortages
`data[attributes][stops_at]` | **String**<br>When items become available, changing this value may result in shortages
`data[attributes][tax_region_id]` | **String**<br>Assign a (new) tax region
`data[attributes][discount_percentage]` | **Integer**<br>The discount percentage
`data[attributes][deposit_type]` | **String**<br>Update the deposit type
`data[attributes][deposit_value]` | **Number**<br>Deposit value to use for `deposit_type`
`data[attributes][customer_id]` | **String**<br>Assign a (new) customer to the order
`data[attributes][coupon_id]` | **String**<br>Apply a coupon
`data[attributes][start_location_id]` | **String**<br>Where items are picked up, changing this value may result in shortages and transfers being created
`data[attributes][stop_location_id]` | **String**<br>Where items are returned, changing this value may result in shortages and transfers being created
`data[relationships][tax_region][data][id]` | **String**<br>Id of the tax region


## Fetching an order

> How to fetch an order:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/3/orders/669f8109-7ace-451e-8e4e-d103215b7a44' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "669f8109-7ace-451e-8e4e-d103215b7a44",
    "type": "order",
    "attributes": {
      "created_at": "2021-05-31T20:15:26.177Z",
      "updated_at": "2021-05-31T20:15:26.177Z",
      "price_in_cents": 0,
      "grand_total_in_cents": 0,
      "grand_total_with_tax_in_cents": 0,
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
      "number": 1,
      "status": "concept",
      "starts_at": "2021-05-29T20:15:00.000Z",
      "stops_at": "2021-06-02T20:15:00.000Z",
      "customer_id": null,
      "deposit_type": null,
      "deposit_value": 0.0,
      "tax_region_id": null,
      "entirely_started": true,
      "entirely_stopped": true,
      "coupon_id": null,
      "location_shortage": false,
      "shortage": false,
      "payment_status": "Paid",
      "start_location_id": "d961e151-7b4c-4b87-b1f7-0b522601ce87",
      "stop_location_id": "d961e151-7b4c-4b87-b1f7-0b522601ce87",
      "statuses": [
        "concept"
      ],
      "status_counts": {},
      "tags": [],
      "discount_percentage": 0.0,
      "total_tax_in_cents": 0,
      "currency": "usd",
      "tax_strategy": "exclusive"
    },
    "relationships": {
      "customer": {},
      "coupon": {},
      "barcode": {},
      "start_location": {},
      "stop_location": {},
      "tax_region": {},
      "lines": {},
      "plannings": {},
      "properties": {},
      "tax_values": {},
      "notes": {},
      "transfers": {}
    }
  },
  "links": {
    "self": "http://test.host/api/3/orders/669f8109-7ace-451e-8e4e-d103215b7a44"
  }
}
```

A description about creating orders

### HTTP Request

`GET api/3/orders/{id}`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[orders]=number,grand_total_in_cents`
`page[number]` | **String**<br>The page to request
`page[per]` | **String**<br>The amount of items per page (max 100)
`filters[q]` | **String**<br>
`filters[customer_id]` | **String**<br>
`filters[starts_at]` | **Object**<br>Query starts_at
`filters[starts_at][gte]` | **String**<br>Greater than given date
`filters[starts_at][lte]` | **String**<br>
`filters[starts_at][qt]` | **String**<br>
`filters[starts_at][lt]` | **String**<br>
`filters[stops_at]` | **String**<br>
`filters[stops_at][gte]` | **String**<br>
`filters[stops_at][lte]` | **String**<br>
`filters[stops_at][qt]` | **String**<br>
`filters[stops_at][lt]` | **String**<br>
`filters[start_location_id]` | **String**<br>
`filters[stop_location_id]` | **String**<br>
`filters[shortage]` | **String**<br>
`filters[payment_status]` | **String**<br>
`filters[date]` | **String**<br>
`filters[date][from]` | **String**<br>
`filters[date][till]` | **String**<br>
`filters[tag_list]` | **String**<br>


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][starts_at]` | **String**<br>When items become unavailable, changing this value may result in shortages
`data[attributes][stops_at]` | **String**<br>When items become available, changing this value may result in shortages
`data[attributes][tax_region_id]` | **String**<br>Assign a (new) tax region
`data[attributes][discount_percentage]` | **Integer**<br>The discount percentage
`data[attributes][deposit_type]` | **String**<br>Update the deposit type
`data[attributes][deposit_value]` | **Number**<br>Deposit value to use for `deposit_type`
`data[attributes][customer_id]` | **String**<br>Assign a (new) customer to the order
`data[attributes][coupon_id]` | **String**<br>Apply a coupon
`data[attributes][start_location_id]` | **String**<br>Where items are picked up, changing this value may result in shortages and transfers being created
`data[attributes][stop_location_id]` | **String**<br>Where items are returned, changing this value may result in shortages and transfers being created
`data[relationships][tax_region][data][id]` | **String**<br>Id of the tax region


## Updating an order

> How to assign a (new) customer to an order:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/3/orders/ae835fd0-f072-4d9d-b3a4-4f51cca2830c' \
    --header 'content-type: application/json' \
    --data '{
      "fields": {
        "orders": "customer_id,tax_region_id,price_in_cents,grand_total_with_tax_in_cents,to_be_paid_in_cents"
      },
      "data": {
        "type": "order",
        "attributes": {
          "customer_id": "08910a1c-396e-488a-bac2-56fbbf950e1c"
        }
      }
    }'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "ae835fd0-f072-4d9d-b3a4-4f51cca2830c",
    "type": "order",
    "attributes": {
      "customer_id": "08910a1c-396e-488a-bac2-56fbbf950e1c",
      "tax_region_id": null,
      "price_in_cents": 0,
      "grand_total_with_tax_in_cents": 0,
      "to_be_paid_in_cents": 0
    },
    "relationships": {}
  },
  "links": {
    "self": "http://test.host/api/3/orders/ae835fd0-f072-4d9d-b3a4-4f51cca2830c?data[attributes][customer_id]=08910a1c-396e-488a-bac2-56fbbf950e1c&data[type]=order&fields[orders]=customer_id,tax_region_id,price_in_cents,grand_total_with_tax_in_cents,to_be_paid_in_cents"
  }
}
```


> How to update the deposit_type:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/3/orders/545ad1b6-dc87-4a56-8792-8a2c1b897666' \
    --header 'content-type: application/json' \
    --data '{
      "fields": {
        "orders": "deposit_type,deposit_in_cents,to_be_paid_in_cents,deposit_paid_in_cents"
      },
      "data": {
        "type": "order",
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
    "id": "545ad1b6-dc87-4a56-8792-8a2c1b897666",
    "type": "order",
    "attributes": {
      "deposit_type": "percentage",
      "deposit_in_cents": 0,
      "to_be_paid_in_cents": 0,
      "deposit_paid_in_cents": 0
    },
    "relationships": {}
  },
  "links": {
    "self": "http://test.host/api/3/orders/545ad1b6-dc87-4a56-8792-8a2c1b897666?data[attributes][deposit_type]=percentage&data[type]=order&fields[orders]=deposit_type,deposit_in_cents,to_be_paid_in_cents,deposit_paid_in_cents"
  }
}
```

When updating a customer on an order the following settings will be applied and prices will be calculated accordingly:

- `discount_percentage`
- `deposit_type`
- `deposit_value`
- `tax_region_id`

### HTTP Request

`PUT api/3/orders/{id}`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[orders]=number,grand_total_in_cents`
`page[number]` | **String**<br>The page to request
`page[per]` | **String**<br>The amount of items per page (max 100)
`filters[q]` | **String**<br>
`filters[customer_id]` | **String**<br>
`filters[starts_at]` | **Object**<br>Query starts_at
`filters[starts_at][gte]` | **String**<br>Greater than given date
`filters[starts_at][lte]` | **String**<br>
`filters[starts_at][qt]` | **String**<br>
`filters[starts_at][lt]` | **String**<br>
`filters[stops_at]` | **String**<br>
`filters[stops_at][gte]` | **String**<br>
`filters[stops_at][lte]` | **String**<br>
`filters[stops_at][qt]` | **String**<br>
`filters[stops_at][lt]` | **String**<br>
`filters[start_location_id]` | **String**<br>
`filters[stop_location_id]` | **String**<br>
`filters[shortage]` | **String**<br>
`filters[payment_status]` | **String**<br>
`filters[date]` | **String**<br>
`filters[date][from]` | **String**<br>
`filters[date][till]` | **String**<br>
`filters[tag_list]` | **String**<br>


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][starts_at]` | **String**<br>When items become unavailable, changing this value may result in shortages
`data[attributes][stops_at]` | **String**<br>When items become available, changing this value may result in shortages
`data[attributes][tax_region_id]` | **String**<br>Assign a (new) tax region
`data[attributes][discount_percentage]` | **Integer**<br>The discount percentage
`data[attributes][deposit_type]` | **String**<br>Update the deposit type
`data[attributes][deposit_value]` | **Number**<br>Deposit value to use for `deposit_type`
`data[attributes][customer_id]` | **String**<br>Assign a (new) customer to the order
`data[attributes][coupon_id]` | **String**<br>Apply a coupon
`data[attributes][start_location_id]` | **String**<br>Where items are picked up, changing this value may result in shortages and transfers being created
`data[attributes][stop_location_id]` | **String**<br>Where items are returned, changing this value may result in shortages and transfers being created
`data[relationships][tax_region][data][id]` | **String**<br>Id of the tax region

