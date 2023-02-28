# Counts

Get the counts for resources in an account.

## Fields
Every count has the following fields:

Name | Description
- | -
`id` | **Uuid** `readonly`<br>
`product_group_count` | **Integer** <br>Amount of product groups in an account
`tax_rate_count` | **Integer** <br>Amount of tax rates in an account
`order_count` | **Integer** <br>Amount of active orders in an account
`note_count` | **Integer** <br>Amount of notes in an account


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
    "id": "virtual-f0e95b73-729d-5db0-8eef-7878819e6a23",
    "type": "counts",
    "attributes": {
      "product_group_count": 1,
      "tax_rate_count": 1,
      "order_count": 0,
      "note_count": 0
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
- | -
`include` | **String** <br>List of comma seperated relationships `?include=`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[counts]=id,created_at,updated_at`


### Includes

This request does not accept any includes