# Report consumables

Report on how consumable products are performing. The report is filterable by date and can be requested by one of the following turnover types: `invoices`, `orders`.

## Fields
Every report consumable has the following fields:

Name | Description
- | -
`id` | **Uuid** `readonly`<br>
`created_at` | **Datetime** <br>
`q` | **String** `writeonly`<br>Query for a specific product
`name` | **String** <br>Product name
`sold` | **Integer** <br>Amount of times the product was sold
`returned` | **Integer** <br>Amount of times the product got sent back
`turnover_in_cents` | **Integer** <br>Turnover during period
`returned_in_cents` | **Integer** <br>Refunds during period
`product_id` | **Uuid** <br>The associated Product


## Relationships
Report consumables have the following relationships:

Name | Description
- | -
`product` | **Products** `readonly`<br>Associated Product


## Listing performance for consumables products



> How to fetch performance for consumables:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/report_consumables?filter%5Bfrom%5D=2023-03-02+00%3A00%3A00+UTC&filter%5Btill%5D=2023-03-07+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "d4a1133a-271d-4c10-a4fd-c1d0e1f06b69",
      "type": "report_consumables",
      "attributes": {
        "created_at": "2023-03-07T08:12:06+00:00",
        "name": "Product 58",
        "sold": 2,
        "returned": 0,
        "turnover_in_cents": 0,
        "returned_in_cents": 0,
        "product_id": "d4a1133a-271d-4c10-a4fd-c1d0e1f06b69"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/d4a1133a-271d-4c10-a4fd-c1d0e1f06b69"
          }
        }
      }
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
- | -
`include` | **String** <br>List of comma seperated relationships `?include=product`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[report_consumables]=id,created_at,updated_at`
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-03-07T08:07:14Z`
`sort` | **String** <br>How to sort the data `?sort=-created_at`
`meta` | **Hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String** <br>The page to request
`page[size]` | **String** <br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
`q` | **String** <br>`eq`
`product_id` | **Uuid** <br>`eq`
`from` | **Datetime** <br>`eq`
`till` | **Datetime** <br>`eq`
`turnover_type` | **String** <br>`eq`
`tag_list` | **Array** <br>`eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array** <br>`count`
`tag_list` | **Array** <br>`count`


### Includes

This request accepts the following includes:

`product` => 
`photo`







