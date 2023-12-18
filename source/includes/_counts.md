# Counts

Get the counts for resources in an account.

## Fields
Every count has the following fields:

Name | Description
-- | --
`id` | **Uuid** `readonly`<br>
`product_group_count` | **Integer** <br>Amount of product groups in an account
`tax_rate_count` | **Integer** <br>Amount of tax rates in an account
`order_count` | **Integer** <br>Amount of active orders in an account
`note_count` | **Integer** <br>Amount of notes in an account
`location_count` | **Integer** <br>Amount of active locations in an account
`employee_count` | **Integer** <br>Amount of active employees in an account
`product_count` | **Integer** <br>Amount of products in an account
`customer_count` | **Integer** <br>Amount of customers in an account


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
    "id": "5736d57c-fd1b-4019-ae59-116b2555f923",
    "type": "counts",
    "attributes": {
      "product_group_count": 1,
      "tax_rate_count": 1,
      "order_count": 0,
      "note_count": 0,
      "location_count": 0,
      "employee_count": 1,
      "product_count": 1,
      "customer_count": 0
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
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[counts]=product_group_count,tax_rate_count,order_count`


### Includes

This request does not accept any includes