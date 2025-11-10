# Order planning availabilities

OrderPlanningAvailabilities provide real-time availability information for all
plannings within an order. This resource calculates how many items are available
for each planning, taking into account current stock levels and other reservations.

The availability data helps determine if an order can be fulfilled and identifies
which items may have shortages. For each planning, it provides availability
information at the location level and cluster level.

This resource is particularly useful for:
- Checking availability before confirming an order
- Identifying potential stock shortages
- Understanding the impact of order changes on availability

## Fields

 Name | Description
-- | --
`available` | **hash** `readonly`<br>A hash containing availability information for each planning in the order, keyed by planning ID. Each planning's availability includes location and cluster level data with stock counts, current availability, and plannable quantities.<br>For products, the availability shows: - `stock_count`: Total items in stock at the location or cluster - `available`: Currently available items (stock minus existing reservations) - `plannable`: Items that can be planned (same as available)<br>For bundles, the availability is calculated based on the most constraining component. If a bundle requires 2 chairs and 1 table, the bundle availability is limited by whichever component has fewer available sets.<br>Untracked items (those with tracking_type "none") are excluded from the availability calculations. Only active plannings and their archived nested plannings (where the parent is active) are included in the response. 
`id` | **uuid** `readonly`<br>Primary key.
`order_id` | **uuid** `readonly`<br>The unique identifier of the [Order](#orders) to check availability for. This parameter is required and must reference an existing order. 


## Get availability information for an order


> Get availability for order with product:

```shell
  curl --get 'https://example.booqable.com/api/4/order_planning_availabilities'
       --header 'content-type: application/json'
       --data-urlencode 'filter[order_id]=c4a20067-f418-4f6b-878b-dc836a1be672'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "c4a20067-f418-4f6b-878b-dc836a1be672",
      "type": "order_planning_availabilities",
      "attributes": {
        "order_id": "c4a20067-f418-4f6b-878b-dc836a1be672",
        "available": {
          "578fab68-900d-4de2-8087-050726faf188": {
            "location": {
              "stock_count": 10,
              "available": 8,
              "plannable": 8
            },
            "cluster": {
              "stock_count": 10,
              "available": 8,
              "plannable": 8
            }
          }
        }
      }
    },
    "meta": {}
  }
```

> Get availability for order with bundle:

```shell
  curl --get 'https://example.booqable.com/api/4/order_planning_availabilities'
       --header 'content-type: application/json'
       --data-urlencode 'filter[order_id]=86cf4f6c-e110-4f4c-864b-bd56a15df8cb'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "86cf4f6c-e110-4f4c-864b-bd56a15df8cb",
      "type": "order_planning_availabilities",
      "attributes": {
        "order_id": "86cf4f6c-e110-4f4c-864b-bd56a15df8cb",
        "available": {
          "aa3ed5fb-c746-4f03-8f07-4ef053626745": {
            "location": {
              "stock_count": 5,
              "available": 4,
              "plannable": 4
            },
            "cluster": {
              "stock_count": 5,
              "available": 4,
              "plannable": 4
            }
          },
          "d2dfb182-9417-4d6d-8c84-6e49e5cbc505": {
            "location": {
              "stock_count": 10,
              "available": 8,
              "plannable": 8
            },
            "cluster": {
              "stock_count": 10,
              "available": 8,
              "plannable": 8
            }
          }
        }
      }
    },
    "meta": {}
  }
```

> Get availability for order without plannings:

```shell
  curl --get 'https://example.booqable.com/api/4/order_planning_availabilities'
       --header 'content-type: application/json'
       --data-urlencode 'filter[order_id]=6ffeda8c-b0af-4303-8b84-2e55b397ab9a'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "6ffeda8c-b0af-4303-8b84-2e55b397ab9a",
      "type": "order_planning_availabilities",
      "attributes": {
        "order_id": "6ffeda8c-b0af-4303-8b84-2e55b397ab9a",
        "available": {}
      }
    },
    "meta": {}
  }
```

### HTTP Request

`GET /api/4/order_planning_availabilities`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[order_planning_availabilities]=order_id,available`
`filter` | **hash** <br>The filters to apply `?filter[attribute][eq]=value`
`meta` | **hash** <br>Metadata to send along. `?meta[total][]=count`
`page[number]` | **string** <br>The page to request.
`page[size]` | **string** <br>The amount of items per page.
`sort` | **string** <br>How to sort the data. `?sort=attribute1,-attribute2`


### Filters

This request can be filtered on:

Name | Description
-- | --
`order_id` | **uuid** <br>`eq`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **array** <br>`count`


### Includes

This request does not accept any includes