# Tags

Tags allow users to label and quickly identify customers, orders and products.

Tags are assigned by writing the `tag_list` attribute on resources that support tags.

The Tag resource allows to gather names and usage counts of tags that are being used.

## Fields

 Name | Description
-- | --
`count` | **integer** <br>How often this tag is used.
`for` | **enum** `writeonly`<br>The resource to show the tag counts for.<br>One of: `Order`, `Customer`, `ProductGroup`, `Bundle`, `Document`.
`id` | **uuid** `readonly`<br>Primary key.
`name` | **string** <br>Name of the tag.


## List tags


> How to fetch a list of tags with their counts:

```shell
  curl --get 'https://example.booqable.com/api/boomerang/tags'
       --header 'content-type: application/json'
       --data-urlencode 'filter[for]=Order'
```

> A 200 status response looks like this:

```json
  {
    "data": [
      {
        "id": "9ab5867e-6bcc-497d-800a-17a81435dca3",
        "type": "tags",
        "attributes": {
          "name": "vip",
          "count": 1
        }
      },
      {
        "id": "e15b75d1-c447-4d47-87a5-24e44dfac6a4",
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
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[tags]=name,count`
`filter` | **hash** <br>The filters to apply `?filter[attribute][eq]=value`
`meta` | **hash** <br>Metadata to send along. `?meta[total][]=count`
`page[number]` | **string** <br>The page to request.
`page[size]` | **string** <br>The amount of items per page.
`sort` | **string** <br>How to sort the data. `?sort=attribute1,-attribute2`


### Filters

This request can be filtered on:

Name | Description
-- | --
`for` | **enum** `required`<br>`eq`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **array** <br>`count`


### Includes

This request does not accept any includes