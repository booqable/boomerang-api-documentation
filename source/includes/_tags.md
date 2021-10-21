# Tags

Tags are designed to find specific resources faster. They can be added to the following resources by supplying a `tag_list`.

- `[Order](#order)
- `[Customer](#customer)
- `[Product group](#product_group)
- `[Bundle](#bundle)
- `[Document](#document)

## Endpoints
`GET /api/boomerang/tags`

## Fields
Every tag has the following fields:

Name | Description
- | -
`id` | **Uuid** `readonly`<br>
`for` | **String** `writeonly`<br>The resource to show the tag counts for. One of `Order`, `Customer`, `ProductGroup`, `Bundle`, `Document`
`name` | **String**<br>Name of the tag
`count` | **Integer**<br>Total count


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
      "id": "ce299b19-2b0c-49fd-83a8-76721d21a500",
      "type": "tags",
      "attributes": {
        "name": "vip",
        "count": 1
      }
    },
    {
      "id": "f7a6bb5a-508c-4947-9de2-f7cf618e6341",
      "type": "tags",
      "attributes": {
        "name": "webshop",
        "count": 3
      }
    }
  ],
  "links": {
    "self": "api/boomerang/tags?filter%5Bfor%5D=Order&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/tags?filter%5Bfor%5D=Order&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/tags?filter%5Bfor%5D=Order&page%5Bnumber%5D=&page%5Bsize%5D=25",
    "next": "api/boomerang/tags?filter%5Bfor%5D=Order&page%5Bnumber%5D=2&page%5Bsize%5D=25"
  },
  "meta": {}
}
```


### HTTP Request

`GET /api/boomerang/tags`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[tags]=id,created_at,updated_at`
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-10-21T11:39:21Z`
`sort` | **String**<br>How to sort the data `?sort=-created_at`
`meta` | **Hash**<br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String**<br>The page to request
`page[per]` | **String**<br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
`for` | **String**<br>`eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array**<br>`count`


### Includes

This request does not accept any includes