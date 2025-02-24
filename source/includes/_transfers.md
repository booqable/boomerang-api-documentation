# Transfers

When an order causes a shortage for a location and that shortage can be
solved by the inventory in the cluster, one or multiple transfers are created.

## Relationships
Name | Description
-- | --
`destination_location` | **[Location](#locations)** `required`<br>Location to which the product need to be transfered to.
`item` | **[Item](#items)** `required`<br>The product that needs to be transferred.
`order` | **[Order](#orders)** `required`<br>The order for which the product is required.
`source_location` | **[Location](#locations)** `required`<br>Location from which the product needs to be transfered.


Check matching attributes under [Fields](#transfers-fields) to see which relations can be written.
<br/ >
Check each individual operation to see which relations can be included as a sideload.
## Fields

 Name | Description
-- | --
`available_at` | **datetime** <br>Date when item should be available at destination location.
`created_at` | **datetime** `readonly`<br>When the resource was created.
`destination_location_id` | **uuid** `readonly`<br>Location to which the product need to be transfered to.
`finalized` | **boolean** <br>Whether or not the transfer has completed.
`id` | **uuid** `readonly`<br>Primary key.
`item_id` | **uuid** `readonly`<br>The product that needs to be transferred.
`order_id` | **uuid** `readonly`<br>The order for which the product is required.
`quantity` | **integer** <br>Quantity of items being transfered.
`source_location_id` | **uuid** `readonly`<br>Location from which the product needs to be transfered.
`updated_at` | **datetime** `readonly`<br>When the resource was last updated.


## List transfers


> How to fetch a list of transfers:

```shell
  curl --get 'https://example.booqable.com/api/boomerang/transfers'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": [
      {
        "id": "6f5d421b-37d1-4f12-8170-d8bb4b8ce0b8",
        "type": "transfers",
        "attributes": {
          "created_at": "2028-08-08T18:28:00.000000+00:00",
          "updated_at": "2028-08-08T18:28:00.000000+00:00",
          "quantity": 1,
          "available_at": "2028-08-06T18:14:00.000000+00:00",
          "finalized": false,
          "item_id": "672d6735-92fa-4198-8145-116e1191847d",
          "order_id": "058a8f0f-d1ac-4363-8778-a6c4476ee292",
          "source_location_id": "1773d662-6eb3-4dae-8736-31948f79df75",
          "destination_location_id": "1773d662-6eb3-4dae-8736-31948f79df75"
        },
        "relationships": {}
      }
    ],
    "meta": {}
  }
```

### HTTP Request

`GET /api/boomerang/transfers`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[transfers]=created_at,updated_at,quantity`
`filter` | **hash** <br>The filters to apply `?filter[attribute][eq]=value`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=order,item,source_location`
`meta` | **hash** <br>Metadata to send along. `?meta[total][]=count`
`page[number]` | **string** <br>The page to request.
`page[size]` | **string** <br>The amount of items per page.
`sort` | **string** <br>How to sort the data. `?sort=attribute1,-attribute2`


### Filters

This request can be filtered on:

Name | Description
-- | --
`available_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`created_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`destination_location_id` | **uuid** <br>`eq`, `not_eq`
`finalized` | **boolean** <br>`eq`
`id` | **uuid** <br>`eq`, `not_eq`
`item_id` | **uuid** <br>`eq`, `not_eq`
`order_id` | **uuid** <br>`eq`, `not_eq`
`q` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`quantity` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`source_location_id` | **uuid** <br>`eq`, `not_eq`
`updated_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **array** <br>`count`


### Includes

This request accepts the following includes:

`order`


`item` => 
`photo`




`source_location`


`destination_location`





