# Stock item suggestions

Use stock item suggestions to figure out which stock item can be booked,
started, or stopped.

The suggestions are sorted:
  1. Temporary stock items are sorted before permanent stock items.
  2. Available stock items are sorted before overdue, unavailable and already_booked stock items.
  3. Equally relevant stock items are sorted by the identifier.

## Relationships
Name | Description
-- | --
`item` | **[Item](#items)** `required`<br>The Product the suggested stock item belongs to. 
`stock_item` | **[Stock item](#stock-items)** `required`<br>The suggested stock item. 


Check matching attributes under [Fields](#stock-item-suggestions-fields) to see which relations can be written.
<br/ >
Check each individual operation to see which relations can be included as a sideload.
## Fields

 Name | Description
-- | --
`id` | **uuid** `readonly`<br>Primary key.
`item_id` | **uuid** `readonly`<br>The Product the suggested stock item belongs to. 
`status` | **enum** `readonly`<br>Status of the suggested stock item.<br> One of: `available_in_location`, `available_in_cluster`, `overdue`, `unavailable`, `already_booked`.
`stock_item_id` | **uuid** `readonly`<br>The suggested stock item. 


## Listing stock item suggestions


> Retrieve stock item suggestions for booking:

```shell
  curl --get 'https://example.booqable.com/api/boomerang/stock_item_suggestions'
       --header 'content-type: application/json'
       --data-urlencode 'filter[action]=book'
       --data-urlencode 'filter[item_id]=402fa5d1-ec05-46ad-85ee-c56564c66946'
       --data-urlencode 'filter[order_id]=38c7808b-99c9-4b0e-8dbe-dcf731d54ca9'
```

> A 200 status response looks like this:

```json
  {
    "data": [
      {
        "id": "8ce54731-3e9e-48fd-898a-42985159c79a",
        "type": "stock_item_suggestions",
        "attributes": {
          "status": "available_in_location",
          "item_id": "402fa5d1-ec05-46ad-85ee-c56564c66946",
          "stock_item_id": "e1ceaec8-5cd6-4097-87ec-77e8e1fe5381"
        },
        "relationships": {}
      },
      {
        "id": "484c2445-4864-4e9d-87f6-d37086fbae96",
        "type": "stock_item_suggestions",
        "attributes": {
          "status": "already_booked",
          "item_id": "402fa5d1-ec05-46ad-85ee-c56564c66946",
          "stock_item_id": "8d913ead-29f6-4cde-8a88-001222806991"
        },
        "relationships": {}
      }
    ],
    "meta": {}
  }
```

### HTTP Request

`GET /api/boomerang/stock_item_suggestions`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[stock_item_suggestions]=status,item_id,stock_item_id`
`filter` | **hash** <br>The filters to apply `?filter[attribute][eq]=value`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=stock_item`
`meta` | **hash** <br>Metadata to send along. `?meta[total][]=count`
`page[number]` | **string** <br>The page to request.
`page[size]` | **string** <br>The amount of items per page.
`sort` | **string** <br>How to sort the data. `?sort=attribute1,-attribute2`


### Filters

This request can be filtered on:

Name | Description
-- | --
`action` | **string_enum** `required`<br>`eq`
`from` | **datetime** <br>`eq`
`item_id` | **uuid** `required`<br>`eq`
`location_id` | **uuid** <br>`eq`
`order_id` | **uuid** `required`<br>`eq`
`q` | **string** <br>`eq`
`status` | **string_enum** <br>`eq`
`till` | **datetime** <br>`eq`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **array** <br>`count`


### Includes

This request accepts the following includes:

`stock_item`





