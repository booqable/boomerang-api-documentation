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
      "id": "5a856592-481e-444d-9553-d7f6d64075fa",
      "type": "transfers",
      "attributes": {
        "created_at": "2023-02-08T09:48:31+00:00",
        "updated_at": "2023-02-08T09:48:31+00:00",
        "quantity": 1,
        "available_at": "2023-02-06T09:45:00+00:00",
        "finalized": false,
        "item_id": "802c0c26-7b7d-41c6-b017-8ef48c66f4d5",
        "order_id": "102090ad-2081-477f-b8ba-13a786406dce",
        "source_location_id": "8612065f-063b-4cb8-9d04-edb7f4e0597f",
        "destination_location_id": "8612065f-063b-4cb8-9d04-edb7f4e0597f"
      },
      "relationships": {
        "item": {
          "links": {
            "related": "api/boomerang/items/802c0c26-7b7d-41c6-b017-8ef48c66f4d5"
          }
        },
        "order": {
          "links": {
            "related": "api/boomerang/orders/102090ad-2081-477f-b8ba-13a786406dce"
          }
        },
        "source_location": {
          "links": {
            "related": "api/boomerang/locations/8612065f-063b-4cb8-9d04-edb7f4e0597f"
          }
        },
        "destination_location": {
          "links": {
            "related": "api/boomerang/locations/8612065f-063b-4cb8-9d04-edb7f4e0597f"
          }
        }
      }
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
- | -
`include` | **String** <br>List of comma seperated relationships `?include=item,order,source_location`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[transfers]=id,created_at,updated_at`
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-08T09:43:44Z`
`sort` | **String** <br>How to sort the data `?sort=-created_at`
`meta` | **Hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String** <br>The page to request
`page[size]` | **String** <br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
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
- | -
`total` | **Array** <br>`count`


### Includes

This request accepts the following includes:

`order`


`item` => 
`photo`




`source_location`


`destination_location`





