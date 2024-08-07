# Counts

Get the counts for resources in an account.

## Fields
Every count has the following fields:

Name | Description
-- | --
`id` | **Uuid** `readonly`<br>
`product_group_count` | **Integer** <br>Amount of product groups in an account
`product_count` | **Integer** <br>Amount of products in an account
`tax_rate_count` | **Integer** <br>Amount of tax rates in an account
`note_count` | **Integer** <br>Amount of notes in an account
`location_count` | **Integer** <br>Amount of active locations in an account
`employee_count` | **Integer** <br>Amount of active employees in an account
`payment_profile_count` | **Integer** <br>Amount of active payment profiles in an account
`manual_order_count` | **Integer** <br>Amount of active orders in an account not attached to a cart
`manual_reserved_order_count` | **Integer** <br>Amount of orders not attached to a cart with the status reserved
`started_order_count` | **Integer** <br>Amount of orders with the status started
`stopped_order_count` | **Integer** <br>Amount of orders with the status stopped
`archived_order_count` | **Integer** <br>Amount of orders with the status archived
`webshop_order_count` | **Integer** <br>Amount of orders via the webshop


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
    "id": "9b5a8f19-ad45-4cb8-9d8c-3a037b06375a",
    "type": "counts",
    "attributes": {
      "product_group_count": 1,
      "product_count": 1,
      "tax_rate_count": 1,
      "note_count": 0,
      "location_count": 0,
      "employee_count": 1,
      "payment_profile_count": 0,
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
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[counts]=product_group_count,product_count,tax_rate_count`


### Includes

This request does not accept any includes