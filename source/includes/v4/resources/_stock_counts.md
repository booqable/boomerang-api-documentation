# Stock counts

StockCounts represent individual stock mutations for a [Product](#products) at a
[Location](#locations). Each record tracks a quantity change — either an addition
(positive quantity) or a removal (negative quantity).

StockCounts are created through [StockAdjustments](#stock-adjustments) and cannot be
modified directly. This resource provides read-only access for listing and filtering
historical stock changes.

## Temporary vs regular stock

When `till` is set, the stock is considered temporary — it is only available within the
`from`/`till` date range. When `till` is `null`, the stock is regular and available
indefinitely.

When `from` is `null`, the stock has no specific start date and is available immediately.

## Relationships
Name | Description
-- | --
`location` | **[Location](#locations)** `required`<br>The [Location](#locations) where the stock change occurred. 
`product` | **[Product](#products)** `required`<br>The [Product](#products) whose stock was adjusted. 


Check matching attributes under [Fields](#stock-counts-fields) to see which relations can be written.
<br/ >
Check each individual operation to see which relations can be included as a sideload.
## Fields

 Name | Description
-- | --
`created_at` | **datetime** `readonly`<br>When this stock count was created. 
`from` | **datetime** `readonly`<br>The date from which the stock is available. When `null`, the stock has no specific start date and is available immediately. 
`id` | **uuid** `readonly`<br>Primary key.
`item_id` | **uuid** `readonly`<br>The ID of the [Product](#products) associated with this stock count. 
`location_id` | **uuid** `readonly`<br>The [Location](#locations) where the stock change occurred. 
`quantity` | **integer** `readonly`<br>The quantity change. Positive values represent stock added, negative values represent stock removed. 
`till` | **datetime** `readonly`<br>The date until which the stock is available. When `null`, the stock is available indefinitely. When set, the stock is temporary and only available within the `from`/`till` date range. 
`updated_at` | **datetime** `readonly`<br>When the resource was last updated.


## List stock counts


> List all stock counts for a product group:

```shell
  curl --get 'https://example.booqable.com/api/4/stock_counts'
       --header 'content-type: application/json'
       --data-urlencode 'filter[count_type]=inventory'
       --data-urlencode 'filter[product_group_id]=5647472c-93c0-42ec-8baa-0082a70b29eb'
       --data-urlencode 'include=product,location'
```

> A 200 status response looks like this:

```json
  {
    "data": [
      {
        "id": "93583c2b-348e-481b-8a40-f91cc12d3d4b",
        "created_at": "2015-10-09T09:43:01.000000+00:00",
        "updated_at": "2015-10-09T09:43:01.000000+00:00",
        "quantity": -3,
        "from": null,
        "till": null,
        "item_id": "480d5713-c9f2-42be-82df-091b67419717",
        "location_id": "dd6222d4-350d-45fd-88cb-8d72163b9abe",
        "product": {
          "id": "480d5713-c9f2-42be-82df-091b67419717",
          "created_at": "2015-10-09T09:43:01.000000+00:00",
          "updated_at": "2015-10-09T09:43:01.000000+00:00",
          "type": "products",
          "archived": false,
          "archived_at": null,
          "name": "Product 1000071",
          "group_name": "Product 1000071",
          "slug": "product-1000071",
          "sku": "PRODUCT 1000077",
          "buffer_time_before": 0,
          "buffer_time_after": 0,
          "product_type": "rental",
          "tracking_type": "bulk",
          "trackable": false,
          "has_variations": false,
          "variation": false,
          "extra_information": null,
          "photo_url": null,
          "description": null,
          "excerpt": null,
          "show_in_store": true,
          "sorting_weight": 1,
          "base_price_in_cents": 0,
          "price_type": "simple",
          "price_period": "hour",
          "deposit_in_cents": 0,
          "default_purchase_cost_in_cents": null,
          "discountable": true,
          "taxable": true,
          "seo_title": null,
          "seo_description": null,
          "tag_list": [],
          "properties": {},
          "photo_id": null,
          "tax_category_id": null,
          "price_ruleset_id": null,
          "price_structure_id": null,
          "allow_shortage": false,
          "shortage_limit": 0,
          "variation_values": [],
          "product_group_id": "5647472c-93c0-42ec-8baa-0082a70b29eb"
        },
        "location": {
          "id": "dd6222d4-350d-45fd-88cb-8d72163b9abe",
          "created_at": "2015-10-09T09:43:01.000000+00:00",
          "updated_at": "2015-10-09T09:43:01.000000+00:00",
          "archived": false,
          "archived_at": null,
          "name": "Location 1000072",
          "code": "LOC1000109",
          "location_type": "rental",
          "address_line_1": null,
          "address_line_2": null,
          "zipcode": null,
          "city": null,
          "region": null,
          "country": null,
          "cluster_ids": [],
          "pickup_enabled": true,
          "delivery_enabled": false,
          "fulfillment_capabilities": [
            "pickup"
          ],
          "main_address": null
        }
      },
      {
        "id": "1eea96ce-0704-4ea9-8997-4917adce3de9",
        "created_at": "2015-10-09T09:43:01.000000+00:00",
        "updated_at": "2015-10-09T09:43:01.000000+00:00",
        "quantity": 10,
        "from": null,
        "till": null,
        "item_id": "480d5713-c9f2-42be-82df-091b67419717",
        "location_id": "dd6222d4-350d-45fd-88cb-8d72163b9abe",
        "product": {
          "id": "480d5713-c9f2-42be-82df-091b67419717",
          "created_at": "2015-10-09T09:43:01.000000+00:00",
          "updated_at": "2015-10-09T09:43:01.000000+00:00",
          "type": "products",
          "archived": false,
          "archived_at": null,
          "name": "Product 1000071",
          "group_name": "Product 1000071",
          "slug": "product-1000071",
          "sku": "PRODUCT 1000077",
          "buffer_time_before": 0,
          "buffer_time_after": 0,
          "product_type": "rental",
          "tracking_type": "bulk",
          "trackable": false,
          "has_variations": false,
          "variation": false,
          "extra_information": null,
          "photo_url": null,
          "description": null,
          "excerpt": null,
          "show_in_store": true,
          "sorting_weight": 1,
          "base_price_in_cents": 0,
          "price_type": "simple",
          "price_period": "hour",
          "deposit_in_cents": 0,
          "default_purchase_cost_in_cents": null,
          "discountable": true,
          "taxable": true,
          "seo_title": null,
          "seo_description": null,
          "tag_list": [],
          "properties": {},
          "photo_id": null,
          "tax_category_id": null,
          "price_ruleset_id": null,
          "price_structure_id": null,
          "allow_shortage": false,
          "shortage_limit": 0,
          "variation_values": [],
          "product_group_id": "5647472c-93c0-42ec-8baa-0082a70b29eb"
        },
        "location": {
          "id": "dd6222d4-350d-45fd-88cb-8d72163b9abe",
          "created_at": "2015-10-09T09:43:01.000000+00:00",
          "updated_at": "2015-10-09T09:43:01.000000+00:00",
          "archived": false,
          "archived_at": null,
          "name": "Location 1000072",
          "code": "LOC1000109",
          "location_type": "rental",
          "address_line_1": null,
          "address_line_2": null,
          "zipcode": null,
          "city": null,
          "region": null,
          "country": null,
          "cluster_ids": [],
          "pickup_enabled": true,
          "delivery_enabled": false,
          "fulfillment_capabilities": [
            "pickup"
          ],
          "main_address": null
        }
      }
    ]
  }
```

### HTTP Request

`GET /api/4/stock_counts`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[stock_counts]=created_at,updated_at,quantity`
`filter` | **hash** <br>The filters to apply `?filter[attribute][eq]=value`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=product,location`
`meta` | **hash** <br>Metadata to send along. `?meta[total][]=count`
`page[number]` | **string** <br>The page to request.
`page[size]` | **string** <br>The amount of items per page.
`sort` | **string** <br>How to sort the data. `?sort=attribute1,-attribute2`


### Filters

This request can be filtered on:

Name | Description
-- | --
`count_type` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`created_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`from` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`id` | **uuid** <br>`eq`, `not_eq`
`item_id` | **uuid** <br>`eq`, `not_eq`
`location_id` | **uuid** <br>`eq`, `not_eq`
`product_group_id` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`quantity` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`till` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **array** <br>`count`


### Includes

This request accepts the following includes:

<ul>
  <li><code>location</code></li>
  <li><code>product</code></li>
</ul>

