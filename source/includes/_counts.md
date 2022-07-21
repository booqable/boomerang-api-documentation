# Counts

Get the counts for resources in an account.

## Fields
Every count has the following fields:

Name | Description
- | -
`id` | **Uuid** `readonly`<br>
`product_group_count` | **Integer**<br>Amount of product groups in an account
`tax_rate_count` | **Integer**<br>Amount of tax rates in an account


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
    "id": "virtual-c50e1a58-230d-5130-bf65-60781017ae98",
    "type": "counts",
    "attributes": {
      "product_group_count": 1,
      "tax_rate_count": 1
    }
  },
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/counts/current`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[counts]=id,created_at,updated_at`


### Includes

This request does not accept any includes