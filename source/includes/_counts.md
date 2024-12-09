# Counts

Get the counts for resources in an account.

## Fields

 Name | Description
-- | --
`archived_order_count` | **integer** `readonly`<br>Amount of orders with the status archived. 
`created_at` | **datetime** `readonly`<br>The time at which the resources were counted. 
`employee_count` | **integer** `readonly`<br>Amount of active employees in an account. 
`id` | **uuid** `readonly`<br>A random UUID, unrelated to the content and different for every call. 
`location_count` | **integer** `readonly`<br>Amount of active locations in an account. 
`manual_order_count` | **integer** `readonly`<br>Amount of active orders in an account not attached to a cart. 
`manual_reserved_order_count` | **integer** `readonly`<br>Amount of orders not attached to a cart with the status reserved. 
`note_count` | **integer** `readonly`<br>Amount of notes in an account. 
`overdue_invoice_count` | **integer** `readonly`<br>Amount of overdue invoices in an account. These are the invoices for the company from Booqable, not those for the customers of the company. 
`payment_profile_count` | **integer** `readonly`<br>Amount of active payment profiles in an account. 
`product_count` | **integer** `readonly`<br>Amount of products in an account. 
`product_group_count` | **integer** `readonly`<br>Amount of product groups in an account. 
`started_order_count` | **integer** `readonly`<br>Amount of orders with the status started. 
`stopped_order_count` | **integer** `readonly`<br>Amount of orders with the status stopped. 
`tax_rate_count` | **integer** `readonly`<br>Amount of tax rates in an account. 
`webshop_order_count` | **integer** `readonly`<br>Amount of orders via the webshop. 


## Fetching counts


> How to fetch counts for an account:

```shell
  curl --get 'https://example.booqable.com/api/boomerang/counts/current'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "4651bb45-1e0e-4a0d-8f2b-12f4a4c8d236",
      "type": "counts",
      "attributes": {
        "created_at": "2016-06-24T02:24:02.000000+00:00",
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
`fields[]` | **array** <br>List of comma seperated fields to include `?fields[counts]=created_at,product_group_count,product_count`


### Includes

This request does not accept any includes