# Transfers

When an order causes a shortage for a location and that shortage can be solved by the inventory in the cluster, one or multiple transfers are created.

## Fields
Every transfer has the following fields:

Name | Description
- | -
`id` | **Uuid** `readonly`<br>Primary key
`created_at` | **Datetime** `readonly`<br>When the resource was created
`updated_at` | **Datetime** `readonly`<br>When the resource was last updated
`quantity` | **Integer** `readonly`<br>Quantity of items being transfered
`available_at` | **Datetime** `readonly`<br>Date when item should be available at destination location
`finalized` | **Boolean** `readonly`<br>Whether or not the transfer has completed
`item_id` | **Uuid** `readonly`<br>The associated Item
`order_id` | **Uuid** `readonly`<br>The associated Order
`source_location_id` | **Uuid** `readonly`<br>The associated Source location
`destination_location_id` | **Uuid** `readonly`<br>The associated Destination location


## Relationships
Transfers have the following relationships:

Name | Description
- | -
`item` | **Items** `readonly`<br>Associated Item
`order` | **Orders** `readonly`<br>Associated Order
`source_location` | **Locations** `readonly`<br>Associated Source location
`destination_location` | **Locations** `readonly`<br>Associated Destination location


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
      "id": "e6e2cdb0-0097-47b0-87b6-4235ee6f1304",
      "type": "transfers",
      "attributes": {
        "created_at": "2022-01-05T12:41:21+00:00",
        "updated_at": "2022-01-05T12:41:21+00:00",
        "quantity": 1,
        "available_at": "2022-01-03T12:30:00+00:00",
        "finalized": false,
        "item_id": "83aeb20b-1ba7-47e4-90be-ebdd211ceb94",
        "order_id": "6bd9c264-471f-4916-a8cf-a4c5b6967bf7",
        "source_location_id": "62383975-fd8f-4fb5-9d59-125f781069fa",
        "destination_location_id": "62383975-fd8f-4fb5-9d59-125f781069fa"
      },
      "relationships": {
        "item": {
          "links": {
            "related": "api/boomerang/items/83aeb20b-1ba7-47e4-90be-ebdd211ceb94"
          }
        },
        "order": {
          "links": {
            "related": "api/boomerang/orders/6bd9c264-471f-4916-a8cf-a4c5b6967bf7"
          }
        },
        "source_location": {
          "links": {
            "related": "api/boomerang/locations/62383975-fd8f-4fb5-9d59-125f781069fa"
          }
        },
        "destination_location": {
          "links": {
            "related": "api/boomerang/locations/62383975-fd8f-4fb5-9d59-125f781069fa"
          }
        }
      }
    }
  ],
  "links": {
    "self": "api/boomerang/transfers?page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/transfers?page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/transfers?page%5Bnumber%5D=1&page%5Bsize%5D=25"
  },
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/transfers`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=item,order,source_location`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[transfers]=id,created_at,updated_at`
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-01-05T12:38:51Z`
`sort` | **String**<br>How to sort the data `?sort=-created_at`
`meta` | **Hash**<br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String**<br>The page to request
`page[size]` | **String**<br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
`id` | **Uuid**<br>`eq`, `not_eq`
`created_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`q` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`quantity` | **Integer**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`available_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`finalized` | **Boolean**<br>`eq`
`item_id` | **Uuid**<br>`eq`, `not_eq`
`order_id` | **Uuid**<br>`eq`, `not_eq`
`source_location_id` | **Uuid**<br>`eq`, `not_eq`
`destination_location_id` | **Uuid**<br>`eq`, `not_eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array**<br>`count`


### Includes

This request accepts the following includes:

`order`


`item` => 
`photo`




`source_location`


`destination_location`





