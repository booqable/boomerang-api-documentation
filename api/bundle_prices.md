# Bundle prices

Calculates the aggregated price for one or more bundles, based on their nested
bundle items, for a given period.

Unlike `item_prices` with `bundle_id` (which returns one price per bundle item),
this returns a single aggregated price per bundle, and accepts multiple bundle
IDs in one request.

## Fields

 Name | Description
-- | --
`bundle_id` | **uuid** `readonly`<br>The bundle that this price is for. 
`bundle_ids` | **array** `writeonly`<br>The bundle IDs to calculate prices for. 
`charge_label` | **string** `readonly`<br>Label for the charge period. 
`from` | **datetime** `writeonly`<br>Start of charge period. 
`id` | **uuid** `readonly`<br>Primary key.
`price_each_in_cents` | **integer** `readonly`<br>Aggregated price for the bundle. 
`till` | **datetime** `writeonly`<br>End of charge period. 


## Calculate the aggregated price of one or more bundles


> How to calculate the price of bundles for a period:

```shell
  curl --get 'https://example.booqable.com/api/4/bundle_prices'
       --header 'content-type: application/json'
       --data-urlencode 'filter[bundle_ids][]=64e0648b-b025-4718-8e22-ff009bfcd4a1'
       --data-urlencode 'filter[from]=2030-01-01 12:00:00 UTC'
       --data-urlencode 'filter[till]=2030-01-10 12:00:00 UTC'
```

> A 200 status response looks like this:

```json
  {
    "data": [
      {
        "id": "54248d94-c610-409b-8d67-03c30770e4fc",
        "type": "bundle_prices",
        "attributes": {
          "bundle_id": "64e0648b-b025-4718-8e22-ff009bfcd4a1",
          "charge_label": "9 days",
          "price_each_in_cents": 90000
        }
      }
    ],
    "meta": {}
  }
```

### HTTP Request

`GET /api/4/bundle_prices`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[bundle_prices]=bundle_id,charge_label,price_each_in_cents`
`filter` | **hash** <br>The filters to apply `?filter[attribute][eq]=value`
`meta` | **hash** <br>Metadata to send along. `?meta[total][]=count`
`page[number]` | **string** <br>The page to request.
`page[size]` | **string** <br>The amount of items per page.
`sort` | **string** <br>How to sort the data. `?sort=attribute1,-attribute2`


### Filters

This request can be filtered on:

Name | Description
-- | --
`bundle_ids` | **array** <br>`eq`
`from` | **datetime** <br>`eq`
`till` | **datetime** <br>`eq`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **array** <br>`count`


### Includes

This request does not accept any includes