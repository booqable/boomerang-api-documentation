# Report consumables

Report on how consumable products are performing. The report is filterable by date and can be requested by one of the following turnover types: `invoices`, `orders`.

## Fields
Every report consumable has the following fields:

Name | Description
-- | --
`id` | **Uuid** `readonly`<br>
`created_at` | **Datetime** <br>
`q` | **String** `writeonly`<br>Query for a specific product
`name` | **String** <br>Product name
`sold` | **Integer** <br>Amount of times the product was sold
`turnover_in_cents` | **Integer** <br>Turnover during period
`product_id` | **Uuid** <br>The associated Product


## Relationships
Report consumables have the following relationships:

Name | Description
-- | --
`product` | **Products** `readonly`<br>Associated Product


## Listing performance for consumables products



> How to fetch performance for consumables:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/report_consumables?filter%5Bfrom%5D=2024-06-26+00%3A00%3A00+UTC&filter%5Btill%5D=2024-07-01+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "d1b7006a-c13b-4e7f-991b-28b89d92e4ab",
      "type": "report_consumables",
      "attributes": {
        "created_at": "2024-07-01T09:28:06.777773+00:00",
        "name": "Product 1000030",
        "sold": 2,
        "turnover_in_cents": 0,
        "product_id": "d1b7006a-c13b-4e7f-991b-28b89d92e4ab"
      },
      "relationships": {}
    }
  ],
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/report_consumables`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=product`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[report_consumables]=created_at,name,sold`
`filter` | **Hash** <br>The filters to apply `?filter[attribute][eq]=value`
`sort` | **String** <br>How to sort the data `?sort=attribute1,-attribute2`
`meta` | **Hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String** <br>The page to request
`page[size]` | **String** <br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
-- | --
`q` | **String** <br>`eq`
`product_id` | **Uuid** <br>`eq`
`from` | **Datetime** <br>`eq`
`till` | **Datetime** <br>`eq`
`turnover_type` | **String** <br>`eq`
`tag_list` | **Array** <br>`eq`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **Array** <br>`count`
`tag_list` | **Array** <br>`count`


### Includes

This request accepts the following includes:

`product` => 
`photo`







