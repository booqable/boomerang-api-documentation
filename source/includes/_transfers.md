# Transfers

When an order causes a shortage for a location and that shortage can be solved by the inventory in the cluster, one or multiple transfers are created.

## Fields
Every transfer has the following fields:

Name | Description
-- | --
`id` | **Uuid** `readonly`<br>Primary key
`created_at` | **Datetime** `readonly`<br>When the resource was created
`updated_at` | **Datetime** `readonly`<br>When the resource was last updated
`quantity` | **Integer** <br>Quantity of items being transfered
`available_at` | **Datetime** <br>Date when item should be available at destination location
`finalized` | **Boolean** <br>Whether or not the transfer has completed
`item_id` | **Uuid** <br>ID of the product being transfered
`order_id` | **Uuid** <br>Order the item is being transfered for
`source_location_id` | **Uuid** <br>Location item is being transfered from
`destination_location_id` | **Uuid** <br>Location item is being transfered to


## Relationships
Transfers have the following relationships:

Name | Description
-- | --
`destination_location` | **[Location](#locations)** <br>Associated Destination location
`item` | **[Item](#items)** <br>Associated Item
`order` | **[Order](#orders)** <br>Associated Order
`source_location` | **[Location](#locations)** <br>Associated Source location


## Listing transfers



> How to fetch a list of transfers:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/transfers' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "60f017b7-312b-4bc9-bcb5-af05463750e4",
      "type": "transfers",
      "attributes": {
        "created_at": "2024-12-02T09:22:17.772834+00:00",
        "updated_at": "2024-12-02T09:22:17.772834+00:00",
        "quantity": 1,
        "available_at": "2024-11-30T09:15:00.000000+00:00",
        "finalized": false,
        "item_id": "8dc2dab4-75cf-4fda-ba84-786de7681e22",
        "order_id": "70b47165-2614-42ea-8c51-f6c445870959",
        "source_location_id": "2977f369-6c8a-46f2-bca5-0f96625787fd",
        "destination_location_id": "2977f369-6c8a-46f2-bca5-0f96625787fd"
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
`include` | **String** <br>List of comma seperated relationships `?include=order,item,source_location`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[transfers]=created_at,updated_at,quantity`
`filter` | **Hash** <br>The filters to apply `?filter[attribute][eq]=value`
`sort` | **String** <br>How to sort the data `?sort=attribute1,-attribute2`
`meta` | **Hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String** <br>The page to request
`page[size]` | **String** <br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
-- | --
`id` | **Uuid** <br>`eq`, `not_eq`
`created_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`q` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`quantity` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`available_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`finalized` | **Boolean** <br>`eq`
`item_id` | **Uuid** <br>`eq`, `not_eq`
`order_id` | **Uuid** <br>`eq`, `not_eq`
`source_location_id` | **Uuid** <br>`eq`, `not_eq`
`destination_location_id` | **Uuid** <br>`eq`, `not_eq`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **Array** <br>`count`


### Includes

This request accepts the following includes:

`order`


`item` => 
`photo`




`source_location`


`destination_location`





