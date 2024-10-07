# Counts

Get the counts for resources in an account.

## Fields
Every count has the following fields:

Name | Description
-- | --
`id` | **Uuid** `readonly`<br>A random UUID, unrelated to the content and different for every call.
`created_at` | **Datetime** `readonly`<br>The time at which the resources were counted.
`product_group_count` | **Integer** `readonly`<br>Amount of product groups in an account
`product_count` | **Integer** `readonly`<br>Amount of products in an account
`tax_rate_count` | **Integer** `readonly`<br>Amount of tax rates in an account
`note_count` | **Integer** `readonly`<br>Amount of notes in an account
`location_count` | **Integer** `readonly`<br>Amount of active locations in an account
`employee_count` | **Integer** `readonly`<br>Amount of active employees in an account
`payment_profile_count` | **Integer** `readonly`<br>Amount of active payment profiles in an account
`overdue_invoice_count` | **Integer** `readonly`<br>Amount of overdue invoices in an account. These are the invoices for the company from Booqable, not those for the customers.
`manual_order_count` | **Integer** `readonly`<br>Amount of active orders in an account not attached to a cart
`manual_reserved_order_count` | **Integer** `readonly`<br>Amount of orders not attached to a cart with the status reserved
`started_order_count` | **Integer** `readonly`<br>Amount of orders with the status started
`stopped_order_count` | **Integer** `readonly`<br>Amount of orders with the status stopped
`archived_order_count` | **Integer** `readonly`<br>Amount of orders with the status archived
`webshop_order_count` | **Integer** `readonly`<br>Amount of orders via the webshop


## Fetching counts



> How to fetch counts for an account:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/counts/current' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "09a510b0-365a-4b11-8ccb-68a09eb09e79",
    "type": "counts",
    "attributes": {
      "created_at": "2024-10-07T09:31:39.330683+00:00",
      "product_group_count": 1,
      "product_count": 1,
      "tax_rate_count": 1,
      "note_count": 0,
      "location_count": 0,
      "employee_count": 1,
      "payment_profile_count": 0,
      "overdue_invoice_count": 0,
      "manual_order_count": 0,
      "manual_reserved_order_count": 0,
      "started_order_count": 0,
      "stopped_order_count": 0,
      "archived_order_count": 0,
      "webshop_order_count": 0
    }
  },
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/counts/current`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[counts]=created_at,product_group_count,product_count`


### Includes

This request does not accept any includes