# Tags

Tags are designed to find specific resources faster. They can be added to the following resources by supplying a `tag_list`.

- [Order](#orders)
- [Customer](#customers)
- [Product group](#product_groups)
- [Bundle](#bundles)
- [Document](#documents)

## Fields
Every tag has the following fields:

Name | Description
- | -
`id` | **Uuid** `readonly`<br>
`for` | **String** `writeonly`<br>The resource to show the tag counts for. One of `Order`, `Customer`, `ProductGroup`, `Bundle`, `Document`
`name` | **String** <br>Name of the tag
`count` | **Integer** <br>Total count


## Listing tags



> How to fetch a list of tags with their counts:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/tags?filter%5Bfor%5D=Order' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "1e1192dc-fa98-4e15-9d8f-eb6bbc4b4d7f",
      "type": "tags",
      "attributes": {
        "name": "vip",
        "count": 1
      }
    },
    {
      "id": "97e65e40-c257-41e9-ba9a-a627264134a7",
      "type": "tags",
      "attributes": {
        "name": "webshop",
        "count": 3
      }
    }
  ],
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/tags`

### Request params

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[tags]=id,created_at,updated_at`
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-03-06T08:22:20Z`
`sort` | **String** <br>How to sort the data `?sort=-created_at`
`meta` | **Hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String** <br>The page to request
`page[size]` | **String** <br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
`for` | **String** <br>`eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array** <br>`count`


### Includes

This request does not accept any includes