# Availability breakdowns

Availability breakdowns explain where the units of a product went for an exact period at a
given location. Where [Inventory availabilities](#inventory-availabilities) answer *how many*
units can still be booked, this endpoint answers *why*: it splits the product's inventory into
the parts a merchant can act on, such as units planned on other orders, units in downtime, or
stock that has not arrived yet.

A breakdown is resolved for a single product with inventory (trackable or bulk). Pass `order_id` to split the
planned quantity into the order being viewed and all other orders.

The counters are not meant to add up to the stock count. `available_now` and the shortage
counters are derived from the lowest availability across the period, while the planning and
downtime counters are sums over the whole period.

## Fields

 Name | Description
-- | --
`available_now` | **integer** `readonly`<br>Units that can be booked for the period, excluding stock that has not arrived yet. Never negative. 
`expected` | **integer** `readonly`<br>Stock in transit: stock items with status `expected` at this location that arrive on or before `from` and stay for the whole period. 
`id` | **uuid** `readonly`<br>Primary key.
`in_downtime` | **integer** `readonly`<br>Number of stock items with a reserved or started downtime overlapping the period at this location. 
`in_other_orders` | **integer** `readonly`<br>Quantity planned on other orders that reduces availability. Concept and canceled orders are excluded. 
`in_this_order` | **integer** `readonly`<br>Quantity planned on the order given as `order_id`, regardless of the order's status. A concept order still reports its planned quantity here even though it does not reduce availability. 
`item_id` | **uuid** `readonly`<br>**Required.** The product to return a breakdown for. Must be a product with inventory (trackable or bulk); bundles and product groups are not accepted. Also returned on the record. 
`over_shortage_limit` | **integer** `readonly`<br>Overbooked quantity beyond the product's shortage limit. When shortage is not allowed for the product, the whole shortage is reported here. 
`within_shortage_limit` | **integer** `readonly`<br>Overbooked quantity that the product's shortage limit allows. 


## Fetch an availability breakdown for a product


> How to fetch an availability breakdown for a product:

```shell
  curl --get 'https://example.booqable.com/api/4/availability_breakdowns'
       --header 'content-type: application/json'
       --data-urlencode 'filter[from]=2024-10-01 09:00:00'
       --data-urlencode 'filter[item_id]=0a4c51dc-281c-4853-8967-d7eda4390e69'
       --data-urlencode 'filter[location_id]=adc4904e-9f2a-45ca-84f6-f2656a972aa1'
       --data-urlencode 'filter[till]=2024-10-02 09:00:00'
```

> A 200 status response looks like this:

```json
  {
    "data": [
      {
        "id": "5d37e9b8-370a-4c30-87ad-f47c7973c7e3",
        "type": "availability_breakdowns",
        "attributes": {
          "item_id": "0a4c51dc-281c-4853-8967-d7eda4390e69",
          "available_now": 3,
          "expected": 0,
          "in_this_order": 0,
          "in_other_orders": 2,
          "in_downtime": 0,
          "within_shortage_limit": 0,
          "over_shortage_limit": 0
        }
      }
    ],
    "meta": {}
  }
```

### HTTP Request

`GET /api/4/availability_breakdowns`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[availability_breakdowns]=item_id,available_now,expected`
`filter` | **hash** <br>The filters to apply `?filter[attribute][eq]=value`
`meta` | **hash** <br>Metadata to send along. `?meta[total][]=count`
`page[number]` | **string** <br>The page to request.
`page[size]` | **string** <br>The amount of items per page.
`sort` | **string** <br>How to sort the data. `?sort=attribute1,-attribute2`


### Filters

This request can be filtered on:

Name | Description
-- | --
`from` | **datetime** `required`<br>`eq`
`item_id` | **uuid** `required`<br>`eq`
`location_id` | **uuid** `required`<br>`eq`
`order_id` | **uuid** <br>`eq`
`till` | **datetime** `required`<br>`eq`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **array** <br>`count`


### Includes

This request does not accept any includes
## Fetch an availability breakdown for a product in an order


> How to split the breakdown between the order being viewed and other orders:

```shell
  curl --get 'https://example.booqable.com/api/4/availability_breakdowns'
       --header 'content-type: application/json'
       --data-urlencode 'filter[from]=2024-10-01 09:00:00 UTC'
       --data-urlencode 'filter[item_id]=8df0fde5-1e01-49e9-8efd-f8ced49d483a'
       --data-urlencode 'filter[location_id]=a9fa3896-99bd-4bc6-825f-9363ac528e48'
       --data-urlencode 'filter[order_id]=6ec38271-844b-40a0-8adf-82859b1f62fa'
       --data-urlencode 'filter[till]=2024-10-02 09:00:00 UTC'
```

> A 200 status response looks like this:

```json
  {
    "data": [
      {
        "id": "8a6a42bb-7eb4-4c97-85f9-253ceac9d61d",
        "type": "availability_breakdowns",
        "attributes": {
          "item_id": "8df0fde5-1e01-49e9-8efd-f8ced49d483a",
          "available_now": 2,
          "expected": 0,
          "in_this_order": 2,
          "in_other_orders": 1,
          "in_downtime": 0,
          "within_shortage_limit": 0,
          "over_shortage_limit": 0
        }
      }
    ],
    "meta": {}
  }
```

### HTTP Request

`GET /api/4/availability_breakdowns`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[availability_breakdowns]=item_id,available_now,expected`
`filter` | **hash** <br>The filters to apply `?filter[attribute][eq]=value`
`meta` | **hash** <br>Metadata to send along. `?meta[total][]=count`
`page[number]` | **string** <br>The page to request.
`page[size]` | **string** <br>The amount of items per page.
`sort` | **string** <br>How to sort the data. `?sort=attribute1,-attribute2`


### Filters

This request can be filtered on:

Name | Description
-- | --
`from` | **datetime** `required`<br>`eq`
`item_id` | **uuid** `required`<br>`eq`
`location_id` | **uuid** `required`<br>`eq`
`order_id` | **uuid** <br>`eq`
`till` | **datetime** `required`<br>`eq`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **array** <br>`count`


### Includes

This request does not accept any includes