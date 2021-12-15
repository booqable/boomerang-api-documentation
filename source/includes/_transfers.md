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
      "id": "7244cfa6-fe1f-4840-b5fb-984e0137c230",
      "type": "transfers",
      "attributes": {
        "created_at": "2021-12-15T11:45:47+00:00",
        "updated_at": "2021-12-15T11:45:47+00:00",
        "quantity": 1,
        "available_at": "2021-12-13T11:45:00+00:00",
        "finalized": false,
        "item_id": "2299831c-f29e-4e15-ad40-dcb02db98540",
        "order_id": "3a36202a-7f99-4dd0-97a4-94d653827ab9",
        "source_location_id": "fa3db3e5-0138-40e8-8643-61c68dcc64ea",
        "destination_location_id": "fa3db3e5-0138-40e8-8643-61c68dcc64ea"
      },
      "relationships": {
        "item": {
          "links": {
            "related": "api/boomerang/items/2299831c-f29e-4e15-ad40-dcb02db98540"
          }
        },
        "order": {
          "links": {
            "related": "api/boomerang/orders/3a36202a-7f99-4dd0-97a4-94d653827ab9"
          }
        },
        "source_location": {
          "links": {
            "related": "api/boomerang/locations/fa3db3e5-0138-40e8-8643-61c68dcc64ea"
          }
        },
        "destination_location": {
          "links": {
            "related": "api/boomerang/locations/fa3db3e5-0138-40e8-8643-61c68dcc64ea"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-12-15T11:43:16Z`
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





