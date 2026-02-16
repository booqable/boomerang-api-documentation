# Availabilities

Availabilities is the primary endpoint for checking whether products can be booked for specific dates and times.
It provides calendar-based information about when products, orders, carts, or downtimes
are available or unavailable, accounting for business rules like buffer times and existing reservations.

The availability endpoint returns individual availability records as a standard JSON:API collection, where
each record includes detailed status information for a specific date or time interval.

**Note:** For raw inventory data (stock counts, planned quantities) for reporting purposes,
see the [Inventory levels](#inventory-levels) and [Inventory level intervals](#inventory-level-intervals) endpoints.

## Subject Types

- **order**: Check availability for rescheduling an order's start or stop date
- **cart**: Check availability for a cart
- **item**: View product availability across a period for booking
- **downtime**: Check availability for scheduling maintenance or repairs

## Time Granularity

Availability can be checked at different time granularities:

- **Daily**: Month views showing day-level availability (when only `year` and `month` are provided)
- **Hourly**: Day views showing interval-based availability (when `day`, `starts_at`, and `duration_period` are provided)

## Fields

 Name | Description
-- | --
`available` | **boolean** `readonly`<br>Boolean indicating clear availability status.<br>- `true` when status is `available` - `false` when status is `unavailable` - `null` when status is `partial`<br>This field provides a simple true/false check for full availability, with `null` indicating ambiguous availability that requires checking the `status` field. 
`date` | **string** `readonly`<br>The date this availability record represents, in YYYY-MM-DD format.<br>Present for both daily and hourly availability records. 
`hour` | **string** `readonly`<br>The hour component (0-23) for time-based availability.<br>Only present when `type` is `time`. For daily availability records, this will be `null`. 
`id` | **string** `readonly`<br>A unique identifier for this availability record, generated based on the subject, date/time, and interval. 
`minute` | **string** `readonly`<br>The minute component (typically 0, 15, 30, or 45) for time-based availability.<br>Only present when `type` is `time`. The specific values depend on the `interval` parameter. For daily availability records, this will be `null`. 
`status` | **string** `readonly`<br>The availability status for this date or time slot.<br>One of: `available`, `partial`, `unavailable`.<br>`available` - Fully available for booking<br>`partial` - Partially available (some items available but not all requested)<br>`unavailable` - Not available for booking 
`subject_id` | **uuid** `readonly`<br>The ID of the subject this availability record is for. 
`subject_type` | **string** `readonly`<br>The type of subject this availability record is for.<br>One of: `order`, `cart`, `item`, `downtime`. 
`type` | **string** `readonly`<br>**Dual-purpose attribute** - Meaning depends on context:<br>**As a response attribute** (output): Indicates the granularity level of this availability record.<br>One of: `date`, `time`.<br>`date` - Daily availability (returned for monthly queries)<br>`time` - Hourly/interval availability (returned for daily queries with intervals)<br>**As a filter parameter** (input): Required for orders and carts. Specifies whether checking availability for the start or stop date.<br>One of: `start`, `stop`. 


## Fetch availability for an order


> Check availability calendar for an order:

```shell
  curl --get 'https://example.booqable.com/api/4/availabilities'
       --header 'content-type: application/json'
       --data-urlencode 'filter[month]=10'
       --data-urlencode 'filter[subject_id]=1f146c7a-442f-4f04-8afc-d1ab5ffdef32'
       --data-urlencode 'filter[subject_type]=order'
       --data-urlencode 'filter[type]=start'
       --data-urlencode 'filter[year]=2024'
```

> A 200 status response looks like this:

```json
  {
    "data": [],
    "meta": {}
  }
```

### HTTP Request

`GET /api/4/availabilities`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[availabilities]=subject_type,subject_id,hour`
`filter` | **hash** <br>The filters to apply `?filter[attribute][eq]=value`
`meta` | **hash** <br>Metadata to send along. `?meta[total][]=count`
`page[number]` | **string** <br>The page to request.
`page[size]` | **string** <br>The amount of items per page.
`sort` | **string** <br>How to sort the data. `?sort=attribute1,-attribute2`


### Filters

This request can be filtered on:

Name | Description
-- | --
`day` | **integer** <br>`eq`
`duration_period` | **string** <br>`eq`
`interval` | **integer** <br>`eq`
`location_id` | **uuid** <br>`eq`
`month` | **integer** `required`<br>`eq`
`starts_at` | **datetime** <br>`eq`
`subject_id` | **uuid** `required`<br>`eq`
`subject_type` | **string** `required`<br>`eq`
`type` | **string** <br>`eq`
`year` | **integer** `required`<br>`eq`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **array** <br>`count`


### Includes

This request does not accept any includes
## Fetch availability for a product


> Check availability calendar for a product:

```shell
  curl --get 'https://example.booqable.com/api/4/availabilities'
       --header 'content-type: application/json'
       --data-urlencode 'filter[location_id]=158d5e18-4cbe-4e0b-8bc7-647b95797e14'
       --data-urlencode 'filter[month]=10'
       --data-urlencode 'filter[subject_id]=6774b37c-a832-4868-8ae9-b9c90cb5c75e'
       --data-urlencode 'filter[subject_type]=item'
       --data-urlencode 'filter[year]=2024'
```

> A 200 status response looks like this:

```json
  {
    "data": [
      {
        "id": "b69b559d-2277-4539-808e-0ac1cd40f0ad",
        "type": "availabilities",
        "attributes": {
          "subject_type": "item",
          "subject_id": "6774b37c-a832-4868-8ae9-b9c90cb5c75e",
          "hour": null,
          "minute": null,
          "date": "2027-02-09",
          "status": "unavailable",
          "available": false,
          "type": "date"
        }
      },
      {
        "id": "d3f42650-8c92-4413-8e59-59e9e4ff5dc8",
        "type": "availabilities",
        "attributes": {
          "subject_type": "item",
          "subject_id": "6774b37c-a832-4868-8ae9-b9c90cb5c75e",
          "hour": null,
          "minute": null,
          "date": "2027-02-10",
          "status": "unavailable",
          "available": false,
          "type": "date"
        }
      },
      {
        "id": "4fd56978-9027-4083-8600-1eda8b761f3f",
        "type": "availabilities",
        "attributes": {
          "subject_type": "item",
          "subject_id": "6774b37c-a832-4868-8ae9-b9c90cb5c75e",
          "hour": null,
          "minute": null,
          "date": "2027-02-11",
          "status": "unavailable",
          "available": false,
          "type": "date"
        }
      },
      {
        "id": "2eeb148c-d729-4a18-87b6-11fe8d9ebd6f",
        "type": "availabilities",
        "attributes": {
          "subject_type": "item",
          "subject_id": "6774b37c-a832-4868-8ae9-b9c90cb5c75e",
          "hour": null,
          "minute": null,
          "date": "2027-02-12",
          "status": "unavailable",
          "available": false,
          "type": "date"
        }
      },
      {
        "id": "212ee328-f39b-4a41-8bab-639b52e2eb74",
        "type": "availabilities",
        "attributes": {
          "subject_type": "item",
          "subject_id": "6774b37c-a832-4868-8ae9-b9c90cb5c75e",
          "hour": null,
          "minute": null,
          "date": "2027-02-13",
          "status": "unavailable",
          "available": false,
          "type": "date"
        }
      },
      {
        "id": "50376cd5-fe9b-450c-8b92-f076df49d9b4",
        "type": "availabilities",
        "attributes": {
          "subject_type": "item",
          "subject_id": "6774b37c-a832-4868-8ae9-b9c90cb5c75e",
          "hour": null,
          "minute": null,
          "date": "2027-02-14",
          "status": "unavailable",
          "available": false,
          "type": "date"
        }
      },
      {
        "id": "f0d3a93b-ce27-44b3-8f44-48e9838cc128",
        "type": "availabilities",
        "attributes": {
          "subject_type": "item",
          "subject_id": "6774b37c-a832-4868-8ae9-b9c90cb5c75e",
          "hour": null,
          "minute": null,
          "date": "2027-02-15",
          "status": "unavailable",
          "available": false,
          "type": "date"
        }
      },
      {
        "id": "c7134942-aca9-4fec-8af6-2b53b90873a2",
        "type": "availabilities",
        "attributes": {
          "subject_type": "item",
          "subject_id": "6774b37c-a832-4868-8ae9-b9c90cb5c75e",
          "hour": null,
          "minute": null,
          "date": "2027-02-16",
          "status": "unavailable",
          "available": false,
          "type": "date"
        }
      },
      {
        "id": "132b8d7c-e219-45cf-8f4e-b13779354e11",
        "type": "availabilities",
        "attributes": {
          "subject_type": "item",
          "subject_id": "6774b37c-a832-4868-8ae9-b9c90cb5c75e",
          "hour": null,
          "minute": null,
          "date": "2027-02-17",
          "status": "unavailable",
          "available": false,
          "type": "date"
        }
      },
      {
        "id": "2c35bc38-781c-40fc-894b-c48dc7a7dc2d",
        "type": "availabilities",
        "attributes": {
          "subject_type": "item",
          "subject_id": "6774b37c-a832-4868-8ae9-b9c90cb5c75e",
          "hour": null,
          "minute": null,
          "date": "2027-02-18",
          "status": "unavailable",
          "available": false,
          "type": "date"
        }
      },
      {
        "id": "8232a00b-735e-4efc-8d18-c22f4fbc9782",
        "type": "availabilities",
        "attributes": {
          "subject_type": "item",
          "subject_id": "6774b37c-a832-4868-8ae9-b9c90cb5c75e",
          "hour": null,
          "minute": null,
          "date": "2027-02-19",
          "status": "unavailable",
          "available": false,
          "type": "date"
        }
      },
      {
        "id": "220f983a-3259-497a-8b1d-276fdf7398da",
        "type": "availabilities",
        "attributes": {
          "subject_type": "item",
          "subject_id": "6774b37c-a832-4868-8ae9-b9c90cb5c75e",
          "hour": null,
          "minute": null,
          "date": "2027-02-20",
          "status": "unavailable",
          "available": false,
          "type": "date"
        }
      },
      {
        "id": "706f54a5-7a87-414d-8649-ceec8ab5de6a",
        "type": "availabilities",
        "attributes": {
          "subject_type": "item",
          "subject_id": "6774b37c-a832-4868-8ae9-b9c90cb5c75e",
          "hour": null,
          "minute": null,
          "date": "2027-02-21",
          "status": "unavailable",
          "available": false,
          "type": "date"
        }
      },
      {
        "id": "d0cc8e8c-a5e4-4ce0-827b-f8131c50623d",
        "type": "availabilities",
        "attributes": {
          "subject_type": "item",
          "subject_id": "6774b37c-a832-4868-8ae9-b9c90cb5c75e",
          "hour": null,
          "minute": null,
          "date": "2027-02-22",
          "status": "unavailable",
          "available": false,
          "type": "date"
        }
      },
      {
        "id": "9edf69ca-5d51-4e6b-850a-5bab4573e361",
        "type": "availabilities",
        "attributes": {
          "subject_type": "item",
          "subject_id": "6774b37c-a832-4868-8ae9-b9c90cb5c75e",
          "hour": null,
          "minute": null,
          "date": "2027-02-23",
          "status": "unavailable",
          "available": false,
          "type": "date"
        }
      },
      {
        "id": "3202a694-a7b1-4c87-8434-9ac63e2bf92d",
        "type": "availabilities",
        "attributes": {
          "subject_type": "item",
          "subject_id": "6774b37c-a832-4868-8ae9-b9c90cb5c75e",
          "hour": null,
          "minute": null,
          "date": "2027-02-24",
          "status": "unavailable",
          "available": false,
          "type": "date"
        }
      },
      {
        "id": "e39dec87-0876-485d-85a1-154740055371",
        "type": "availabilities",
        "attributes": {
          "subject_type": "item",
          "subject_id": "6774b37c-a832-4868-8ae9-b9c90cb5c75e",
          "hour": null,
          "minute": null,
          "date": "2027-02-25",
          "status": "unavailable",
          "available": false,
          "type": "date"
        }
      },
      {
        "id": "f718eea9-31cb-46a8-8a18-9536d4a7c089",
        "type": "availabilities",
        "attributes": {
          "subject_type": "item",
          "subject_id": "6774b37c-a832-4868-8ae9-b9c90cb5c75e",
          "hour": null,
          "minute": null,
          "date": "2027-02-26",
          "status": "unavailable",
          "available": false,
          "type": "date"
        }
      },
      {
        "id": "e5c23530-55b7-497b-8b66-f5253c9f2606",
        "type": "availabilities",
        "attributes": {
          "subject_type": "item",
          "subject_id": "6774b37c-a832-4868-8ae9-b9c90cb5c75e",
          "hour": null,
          "minute": null,
          "date": "2027-02-27",
          "status": "unavailable",
          "available": false,
          "type": "date"
        }
      },
      {
        "id": "05b6ae78-e895-4ffa-888c-62659285ab46",
        "type": "availabilities",
        "attributes": {
          "subject_type": "item",
          "subject_id": "6774b37c-a832-4868-8ae9-b9c90cb5c75e",
          "hour": null,
          "minute": null,
          "date": "2027-02-28",
          "status": "unavailable",
          "available": false,
          "type": "date"
        }
      },
      {
        "id": "6a528aff-4680-4562-8055-d4762f91b436",
        "type": "availabilities",
        "attributes": {
          "subject_type": "item",
          "subject_id": "6774b37c-a832-4868-8ae9-b9c90cb5c75e",
          "hour": null,
          "minute": null,
          "date": "2027-03-01",
          "status": "unavailable",
          "available": false,
          "type": "date"
        }
      },
      {
        "id": "989d5caa-f0e9-473d-8ee1-568848d0fef3",
        "type": "availabilities",
        "attributes": {
          "subject_type": "item",
          "subject_id": "6774b37c-a832-4868-8ae9-b9c90cb5c75e",
          "hour": null,
          "minute": null,
          "date": "2027-03-02",
          "status": "unavailable",
          "available": false,
          "type": "date"
        }
      },
      {
        "id": "8714e74d-7cd0-4b9b-8311-04f3cd7659f1",
        "type": "availabilities",
        "attributes": {
          "subject_type": "item",
          "subject_id": "6774b37c-a832-4868-8ae9-b9c90cb5c75e",
          "hour": null,
          "minute": null,
          "date": "2027-03-03",
          "status": "unavailable",
          "available": false,
          "type": "date"
        }
      },
      {
        "id": "76b1d06e-0d90-4e79-84ec-96d3179a3fa4",
        "type": "availabilities",
        "attributes": {
          "subject_type": "item",
          "subject_id": "6774b37c-a832-4868-8ae9-b9c90cb5c75e",
          "hour": null,
          "minute": null,
          "date": "2027-03-04",
          "status": "unavailable",
          "available": false,
          "type": "date"
        }
      },
      {
        "id": "98e41614-8415-4661-8c57-b5d13a2091cf",
        "type": "availabilities",
        "attributes": {
          "subject_type": "item",
          "subject_id": "6774b37c-a832-4868-8ae9-b9c90cb5c75e",
          "hour": null,
          "minute": null,
          "date": "2027-03-05",
          "status": "unavailable",
          "available": false,
          "type": "date"
        }
      },
      {
        "id": "4acf24b2-2cc9-4684-89b4-7d4a2a6b69a4",
        "type": "availabilities",
        "attributes": {
          "subject_type": "item",
          "subject_id": "6774b37c-a832-4868-8ae9-b9c90cb5c75e",
          "hour": null,
          "minute": null,
          "date": "2027-03-06",
          "status": "unavailable",
          "available": false,
          "type": "date"
        }
      },
      {
        "id": "68f1973e-2cd2-43c1-82cf-37acc8a89d5b",
        "type": "availabilities",
        "attributes": {
          "subject_type": "item",
          "subject_id": "6774b37c-a832-4868-8ae9-b9c90cb5c75e",
          "hour": null,
          "minute": null,
          "date": "2027-03-07",
          "status": "unavailable",
          "available": false,
          "type": "date"
        }
      },
      {
        "id": "b0138410-4db6-4cb9-89fc-f234fb5dcce2",
        "type": "availabilities",
        "attributes": {
          "subject_type": "item",
          "subject_id": "6774b37c-a832-4868-8ae9-b9c90cb5c75e",
          "hour": null,
          "minute": null,
          "date": "2027-03-08",
          "status": "unavailable",
          "available": false,
          "type": "date"
        }
      },
      {
        "id": "715cb57a-1e98-4856-82b5-1b3ef456d71f",
        "type": "availabilities",
        "attributes": {
          "subject_type": "item",
          "subject_id": "6774b37c-a832-4868-8ae9-b9c90cb5c75e",
          "hour": null,
          "minute": null,
          "date": "2027-03-09",
          "status": "unavailable",
          "available": false,
          "type": "date"
        }
      },
      {
        "id": "a0df3e95-3799-474e-89e4-a809f7c5f346",
        "type": "availabilities",
        "attributes": {
          "subject_type": "item",
          "subject_id": "6774b37c-a832-4868-8ae9-b9c90cb5c75e",
          "hour": null,
          "minute": null,
          "date": "2027-03-10",
          "status": "unavailable",
          "available": false,
          "type": "date"
        }
      },
      {
        "id": "ad7da3f9-c37f-425c-8736-d5c98b449a3e",
        "type": "availabilities",
        "attributes": {
          "subject_type": "item",
          "subject_id": "6774b37c-a832-4868-8ae9-b9c90cb5c75e",
          "hour": null,
          "minute": null,
          "date": "2027-03-11",
          "status": "unavailable",
          "available": false,
          "type": "date"
        }
      },
      {
        "id": "ff038afe-22e5-48b4-8af2-d5431e3b90cf",
        "type": "availabilities",
        "attributes": {
          "subject_type": "item",
          "subject_id": "6774b37c-a832-4868-8ae9-b9c90cb5c75e",
          "hour": null,
          "minute": null,
          "date": "2027-03-12",
          "status": "unavailable",
          "available": false,
          "type": "date"
        }
      },
      {
        "id": "c96a9ec6-f467-4a2f-8289-583a45619b9f",
        "type": "availabilities",
        "attributes": {
          "subject_type": "item",
          "subject_id": "6774b37c-a832-4868-8ae9-b9c90cb5c75e",
          "hour": null,
          "minute": null,
          "date": "2027-03-13",
          "status": "unavailable",
          "available": false,
          "type": "date"
        }
      },
      {
        "id": "b5e512af-3b74-4940-886c-1f7b13883989",
        "type": "availabilities",
        "attributes": {
          "subject_type": "item",
          "subject_id": "6774b37c-a832-4868-8ae9-b9c90cb5c75e",
          "hour": null,
          "minute": null,
          "date": "2027-03-14",
          "status": "unavailable",
          "available": false,
          "type": "date"
        }
      },
      {
        "id": "3dc49052-3939-4e91-8955-d05264627c9d",
        "type": "availabilities",
        "attributes": {
          "subject_type": "item",
          "subject_id": "6774b37c-a832-4868-8ae9-b9c90cb5c75e",
          "hour": null,
          "minute": null,
          "date": "2027-03-15",
          "status": "unavailable",
          "available": false,
          "type": "date"
        }
      },
      {
        "id": "55cdfdfa-0257-4509-85b1-42a4cfd43342",
        "type": "availabilities",
        "attributes": {
          "subject_type": "item",
          "subject_id": "6774b37c-a832-4868-8ae9-b9c90cb5c75e",
          "hour": null,
          "minute": null,
          "date": "2027-03-16",
          "status": "unavailable",
          "available": false,
          "type": "date"
        }
      },
      {
        "id": "c9f5584d-7158-459e-8137-0ddbdf03a3ff",
        "type": "availabilities",
        "attributes": {
          "subject_type": "item",
          "subject_id": "6774b37c-a832-4868-8ae9-b9c90cb5c75e",
          "hour": null,
          "minute": null,
          "date": "2027-03-17",
          "status": "unavailable",
          "available": false,
          "type": "date"
        }
      },
      {
        "id": "df2df99d-5517-4e11-8646-76902ade4b6b",
        "type": "availabilities",
        "attributes": {
          "subject_type": "item",
          "subject_id": "6774b37c-a832-4868-8ae9-b9c90cb5c75e",
          "hour": null,
          "minute": null,
          "date": "2027-03-18",
          "status": "unavailable",
          "available": false,
          "type": "date"
        }
      },
      {
        "id": "36d218c8-d39f-4552-8679-7b5519460f50",
        "type": "availabilities",
        "attributes": {
          "subject_type": "item",
          "subject_id": "6774b37c-a832-4868-8ae9-b9c90cb5c75e",
          "hour": null,
          "minute": null,
          "date": "2027-03-19",
          "status": "unavailable",
          "available": false,
          "type": "date"
        }
      },
      {
        "id": "8279af66-8c89-4e09-8f33-482998e53479",
        "type": "availabilities",
        "attributes": {
          "subject_type": "item",
          "subject_id": "6774b37c-a832-4868-8ae9-b9c90cb5c75e",
          "hour": null,
          "minute": null,
          "date": "2027-03-20",
          "status": "unavailable",
          "available": false,
          "type": "date"
        }
      },
      {
        "id": "52f29dc0-eeba-44ee-8c7b-f39e16dbca08",
        "type": "availabilities",
        "attributes": {
          "subject_type": "item",
          "subject_id": "6774b37c-a832-4868-8ae9-b9c90cb5c75e",
          "hour": null,
          "minute": null,
          "date": "2027-03-21",
          "status": "unavailable",
          "available": false,
          "type": "date"
        }
      },
      {
        "id": "b5da8a88-3fd4-40e2-853a-a5b7253c76fc",
        "type": "availabilities",
        "attributes": {
          "subject_type": "item",
          "subject_id": "6774b37c-a832-4868-8ae9-b9c90cb5c75e",
          "hour": null,
          "minute": null,
          "date": "2027-03-22",
          "status": "unavailable",
          "available": false,
          "type": "date"
        }
      },
      {
        "id": "5373eeac-a22b-4626-86e8-3aa91de1ede0",
        "type": "availabilities",
        "attributes": {
          "subject_type": "item",
          "subject_id": "6774b37c-a832-4868-8ae9-b9c90cb5c75e",
          "hour": null,
          "minute": null,
          "date": "2027-03-23",
          "status": "unavailable",
          "available": false,
          "type": "date"
        }
      },
      {
        "id": "3547fb0b-cd21-4244-8902-6380e77c63a0",
        "type": "availabilities",
        "attributes": {
          "subject_type": "item",
          "subject_id": "6774b37c-a832-4868-8ae9-b9c90cb5c75e",
          "hour": null,
          "minute": null,
          "date": "2027-03-24",
          "status": "unavailable",
          "available": false,
          "type": "date"
        }
      },
      {
        "id": "08109d94-2db9-4e3e-836b-c2e15435a4ab",
        "type": "availabilities",
        "attributes": {
          "subject_type": "item",
          "subject_id": "6774b37c-a832-4868-8ae9-b9c90cb5c75e",
          "hour": null,
          "minute": null,
          "date": "2027-03-25",
          "status": "unavailable",
          "available": false,
          "type": "date"
        }
      },
      {
        "id": "e3bd1c3a-5c77-4628-8761-3fdf705529c6",
        "type": "availabilities",
        "attributes": {
          "subject_type": "item",
          "subject_id": "6774b37c-a832-4868-8ae9-b9c90cb5c75e",
          "hour": null,
          "minute": null,
          "date": "2027-03-26",
          "status": "unavailable",
          "available": false,
          "type": "date"
        }
      },
      {
        "id": "6468165a-1065-4e52-80c1-a67f70164611",
        "type": "availabilities",
        "attributes": {
          "subject_type": "item",
          "subject_id": "6774b37c-a832-4868-8ae9-b9c90cb5c75e",
          "hour": null,
          "minute": null,
          "date": "2027-03-27",
          "status": "unavailable",
          "available": false,
          "type": "date"
        }
      },
      {
        "id": "876d937e-71d6-4cf8-89a5-8b7322f24afb",
        "type": "availabilities",
        "attributes": {
          "subject_type": "item",
          "subject_id": "6774b37c-a832-4868-8ae9-b9c90cb5c75e",
          "hour": null,
          "minute": null,
          "date": "2027-03-28",
          "status": "unavailable",
          "available": false,
          "type": "date"
        }
      },
      {
        "id": "039ec1da-e815-4864-8c2b-d934ac091f50",
        "type": "availabilities",
        "attributes": {
          "subject_type": "item",
          "subject_id": "6774b37c-a832-4868-8ae9-b9c90cb5c75e",
          "hour": null,
          "minute": null,
          "date": "2027-03-29",
          "status": "unavailable",
          "available": false,
          "type": "date"
        }
      },
      {
        "id": "aed1a517-d777-47fb-8390-e2b492834210",
        "type": "availabilities",
        "attributes": {
          "subject_type": "item",
          "subject_id": "6774b37c-a832-4868-8ae9-b9c90cb5c75e",
          "hour": null,
          "minute": null,
          "date": "2027-03-30",
          "status": "unavailable",
          "available": false,
          "type": "date"
        }
      }
    ],
    "meta": {}
  }
```

### HTTP Request

`GET /api/4/availabilities`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[availabilities]=subject_type,subject_id,hour`
`filter` | **hash** <br>The filters to apply `?filter[attribute][eq]=value`
`meta` | **hash** <br>Metadata to send along. `?meta[total][]=count`
`page[number]` | **string** <br>The page to request.
`page[size]` | **string** <br>The amount of items per page.
`sort` | **string** <br>How to sort the data. `?sort=attribute1,-attribute2`


### Filters

This request can be filtered on:

Name | Description
-- | --
`day` | **integer** <br>`eq`
`duration_period` | **string** <br>`eq`
`interval` | **integer** <br>`eq`
`location_id` | **uuid** <br>`eq`
`month` | **integer** `required`<br>`eq`
`starts_at` | **datetime** <br>`eq`
`subject_id` | **uuid** `required`<br>`eq`
`subject_type` | **string** `required`<br>`eq`
`type` | **string** <br>`eq`
`year` | **integer** `required`<br>`eq`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **array** <br>`count`


### Includes

This request does not accept any includes
## Fetch time-based availability for a downtime


> Check hourly availability for downtime scheduling:

```shell
  curl --get 'https://example.booqable.com/api/4/availabilities'
       --header 'content-type: application/json'
       --data-urlencode 'filter[day]=5'
       --data-urlencode 'filter[duration_period]=day'
       --data-urlencode 'filter[month]=10'
       --data-urlencode 'filter[starts_at]=2024-10-05 08:00:00'
       --data-urlencode 'filter[subject_id]=63836de4-14a2-4da9-858b-a33f8e574a0d'
       --data-urlencode 'filter[subject_type]=downtime'
       --data-urlencode 'filter[year]=2024'
```

> A 200 status response looks like this:

```json
  {
    "data": [
      {
        "id": "8c6db243-caaa-4c97-829a-deae2ba08068",
        "type": "availabilities",
        "attributes": {
          "subject_type": "downtime",
          "subject_id": "63836de4-14a2-4da9-858b-a33f8e574a0d",
          "hour": "00",
          "minute": "00",
          "date": "2016-02-14",
          "status": "available",
          "available": true,
          "type": "time"
        }
      },
      {
        "id": "70219bae-aab1-459a-88c7-ae7ec5277192",
        "type": "availabilities",
        "attributes": {
          "subject_type": "downtime",
          "subject_id": "63836de4-14a2-4da9-858b-a33f8e574a0d",
          "hour": "00",
          "minute": "15",
          "date": "2016-02-14",
          "status": "available",
          "available": true,
          "type": "time"
        }
      },
      {
        "id": "011a8fd0-63cd-4e83-8372-ac80d18d8262",
        "type": "availabilities",
        "attributes": {
          "subject_type": "downtime",
          "subject_id": "63836de4-14a2-4da9-858b-a33f8e574a0d",
          "hour": "00",
          "minute": "30",
          "date": "2016-02-14",
          "status": "available",
          "available": true,
          "type": "time"
        }
      },
      {
        "id": "0433e55d-144c-450c-8103-9869b158452f",
        "type": "availabilities",
        "attributes": {
          "subject_type": "downtime",
          "subject_id": "63836de4-14a2-4da9-858b-a33f8e574a0d",
          "hour": "00",
          "minute": "45",
          "date": "2016-02-14",
          "status": "available",
          "available": true,
          "type": "time"
        }
      },
      {
        "id": "3d478edd-6ac9-4e1f-83f7-b6bf9867e686",
        "type": "availabilities",
        "attributes": {
          "subject_type": "downtime",
          "subject_id": "63836de4-14a2-4da9-858b-a33f8e574a0d",
          "hour": "01",
          "minute": "00",
          "date": "2016-02-14",
          "status": "available",
          "available": true,
          "type": "time"
        }
      },
      {
        "id": "ebdfe2b3-e023-4ca2-8848-0231ed3a52a5",
        "type": "availabilities",
        "attributes": {
          "subject_type": "downtime",
          "subject_id": "63836de4-14a2-4da9-858b-a33f8e574a0d",
          "hour": "01",
          "minute": "15",
          "date": "2016-02-14",
          "status": "available",
          "available": true,
          "type": "time"
        }
      },
      {
        "id": "47938620-28c9-424b-893c-d73997b86802",
        "type": "availabilities",
        "attributes": {
          "subject_type": "downtime",
          "subject_id": "63836de4-14a2-4da9-858b-a33f8e574a0d",
          "hour": "01",
          "minute": "30",
          "date": "2016-02-14",
          "status": "available",
          "available": true,
          "type": "time"
        }
      },
      {
        "id": "3273ea51-b9fa-4855-832b-e5a8f8b72077",
        "type": "availabilities",
        "attributes": {
          "subject_type": "downtime",
          "subject_id": "63836de4-14a2-4da9-858b-a33f8e574a0d",
          "hour": "01",
          "minute": "45",
          "date": "2016-02-14",
          "status": "available",
          "available": true,
          "type": "time"
        }
      },
      {
        "id": "b6b05258-5c04-4541-8f52-ac13605a252b",
        "type": "availabilities",
        "attributes": {
          "subject_type": "downtime",
          "subject_id": "63836de4-14a2-4da9-858b-a33f8e574a0d",
          "hour": "02",
          "minute": "00",
          "date": "2016-02-14",
          "status": "available",
          "available": true,
          "type": "time"
        }
      },
      {
        "id": "cedb82b0-4c32-4620-80d7-5348453d6062",
        "type": "availabilities",
        "attributes": {
          "subject_type": "downtime",
          "subject_id": "63836de4-14a2-4da9-858b-a33f8e574a0d",
          "hour": "02",
          "minute": "15",
          "date": "2016-02-14",
          "status": "available",
          "available": true,
          "type": "time"
        }
      },
      {
        "id": "21d6b766-04ba-465f-86c9-4f6b54e34487",
        "type": "availabilities",
        "attributes": {
          "subject_type": "downtime",
          "subject_id": "63836de4-14a2-4da9-858b-a33f8e574a0d",
          "hour": "02",
          "minute": "30",
          "date": "2016-02-14",
          "status": "available",
          "available": true,
          "type": "time"
        }
      },
      {
        "id": "605741e4-cbca-48bc-8eaa-1d78951bdc93",
        "type": "availabilities",
        "attributes": {
          "subject_type": "downtime",
          "subject_id": "63836de4-14a2-4da9-858b-a33f8e574a0d",
          "hour": "02",
          "minute": "45",
          "date": "2016-02-14",
          "status": "available",
          "available": true,
          "type": "time"
        }
      },
      {
        "id": "7093d2fb-b36a-4e29-8537-1a34ae00d186",
        "type": "availabilities",
        "attributes": {
          "subject_type": "downtime",
          "subject_id": "63836de4-14a2-4da9-858b-a33f8e574a0d",
          "hour": "03",
          "minute": "00",
          "date": "2016-02-14",
          "status": "available",
          "available": true,
          "type": "time"
        }
      },
      {
        "id": "d8cfc7fb-649c-4048-8bae-5eb1b5590a7f",
        "type": "availabilities",
        "attributes": {
          "subject_type": "downtime",
          "subject_id": "63836de4-14a2-4da9-858b-a33f8e574a0d",
          "hour": "03",
          "minute": "15",
          "date": "2016-02-14",
          "status": "available",
          "available": true,
          "type": "time"
        }
      },
      {
        "id": "f96f8140-df6c-45b4-8c58-996eb5463842",
        "type": "availabilities",
        "attributes": {
          "subject_type": "downtime",
          "subject_id": "63836de4-14a2-4da9-858b-a33f8e574a0d",
          "hour": "03",
          "minute": "30",
          "date": "2016-02-14",
          "status": "available",
          "available": true,
          "type": "time"
        }
      },
      {
        "id": "71a8aefb-f9eb-44f8-8ec5-41ea25e472bb",
        "type": "availabilities",
        "attributes": {
          "subject_type": "downtime",
          "subject_id": "63836de4-14a2-4da9-858b-a33f8e574a0d",
          "hour": "03",
          "minute": "45",
          "date": "2016-02-14",
          "status": "available",
          "available": true,
          "type": "time"
        }
      },
      {
        "id": "986e9f32-a059-4ac5-87ca-4cd5ec7ebcd6",
        "type": "availabilities",
        "attributes": {
          "subject_type": "downtime",
          "subject_id": "63836de4-14a2-4da9-858b-a33f8e574a0d",
          "hour": "04",
          "minute": "00",
          "date": "2016-02-14",
          "status": "available",
          "available": true,
          "type": "time"
        }
      },
      {
        "id": "8e93f1ef-1954-47a2-8951-3e70a998a463",
        "type": "availabilities",
        "attributes": {
          "subject_type": "downtime",
          "subject_id": "63836de4-14a2-4da9-858b-a33f8e574a0d",
          "hour": "04",
          "minute": "15",
          "date": "2016-02-14",
          "status": "available",
          "available": true,
          "type": "time"
        }
      },
      {
        "id": "1193c4d6-0834-478a-89ee-12f4a5ae1c43",
        "type": "availabilities",
        "attributes": {
          "subject_type": "downtime",
          "subject_id": "63836de4-14a2-4da9-858b-a33f8e574a0d",
          "hour": "04",
          "minute": "30",
          "date": "2016-02-14",
          "status": "available",
          "available": true,
          "type": "time"
        }
      },
      {
        "id": "26eace4e-52a1-4083-87a9-75524f8b5fab",
        "type": "availabilities",
        "attributes": {
          "subject_type": "downtime",
          "subject_id": "63836de4-14a2-4da9-858b-a33f8e574a0d",
          "hour": "04",
          "minute": "45",
          "date": "2016-02-14",
          "status": "available",
          "available": true,
          "type": "time"
        }
      },
      {
        "id": "4fcfbdc1-39f8-44cc-8d2a-5ca0d568c00c",
        "type": "availabilities",
        "attributes": {
          "subject_type": "downtime",
          "subject_id": "63836de4-14a2-4da9-858b-a33f8e574a0d",
          "hour": "05",
          "minute": "00",
          "date": "2016-02-14",
          "status": "available",
          "available": true,
          "type": "time"
        }
      },
      {
        "id": "5b762409-d012-48f7-8ba5-506f4a6a4ea1",
        "type": "availabilities",
        "attributes": {
          "subject_type": "downtime",
          "subject_id": "63836de4-14a2-4da9-858b-a33f8e574a0d",
          "hour": "05",
          "minute": "15",
          "date": "2016-02-14",
          "status": "available",
          "available": true,
          "type": "time"
        }
      },
      {
        "id": "31b9a110-055d-4848-81cc-cac0ec5abcde",
        "type": "availabilities",
        "attributes": {
          "subject_type": "downtime",
          "subject_id": "63836de4-14a2-4da9-858b-a33f8e574a0d",
          "hour": "05",
          "minute": "30",
          "date": "2016-02-14",
          "status": "available",
          "available": true,
          "type": "time"
        }
      },
      {
        "id": "35f111ed-40fd-48a5-8632-de8d59210194",
        "type": "availabilities",
        "attributes": {
          "subject_type": "downtime",
          "subject_id": "63836de4-14a2-4da9-858b-a33f8e574a0d",
          "hour": "05",
          "minute": "45",
          "date": "2016-02-14",
          "status": "available",
          "available": true,
          "type": "time"
        }
      },
      {
        "id": "cbffca54-9eeb-4e26-8eb2-178dadcc0dd5",
        "type": "availabilities",
        "attributes": {
          "subject_type": "downtime",
          "subject_id": "63836de4-14a2-4da9-858b-a33f8e574a0d",
          "hour": "06",
          "minute": "00",
          "date": "2016-02-14",
          "status": "available",
          "available": true,
          "type": "time"
        }
      },
      {
        "id": "de6533b3-43dd-4f62-818a-e25f75965499",
        "type": "availabilities",
        "attributes": {
          "subject_type": "downtime",
          "subject_id": "63836de4-14a2-4da9-858b-a33f8e574a0d",
          "hour": "06",
          "minute": "15",
          "date": "2016-02-14",
          "status": "available",
          "available": true,
          "type": "time"
        }
      },
      {
        "id": "fcaf359d-01e9-4c37-8d52-c2b7a5c54be1",
        "type": "availabilities",
        "attributes": {
          "subject_type": "downtime",
          "subject_id": "63836de4-14a2-4da9-858b-a33f8e574a0d",
          "hour": "06",
          "minute": "30",
          "date": "2016-02-14",
          "status": "available",
          "available": true,
          "type": "time"
        }
      },
      {
        "id": "18b4a377-b59e-4a3b-8e15-9543c34305d6",
        "type": "availabilities",
        "attributes": {
          "subject_type": "downtime",
          "subject_id": "63836de4-14a2-4da9-858b-a33f8e574a0d",
          "hour": "06",
          "minute": "45",
          "date": "2016-02-14",
          "status": "available",
          "available": true,
          "type": "time"
        }
      },
      {
        "id": "f5f570cd-0cca-4cb5-8e77-088ee453ccb9",
        "type": "availabilities",
        "attributes": {
          "subject_type": "downtime",
          "subject_id": "63836de4-14a2-4da9-858b-a33f8e574a0d",
          "hour": "07",
          "minute": "00",
          "date": "2016-02-14",
          "status": "available",
          "available": true,
          "type": "time"
        }
      },
      {
        "id": "3eebf564-d835-436b-8318-974ea453698a",
        "type": "availabilities",
        "attributes": {
          "subject_type": "downtime",
          "subject_id": "63836de4-14a2-4da9-858b-a33f8e574a0d",
          "hour": "07",
          "minute": "15",
          "date": "2016-02-14",
          "status": "available",
          "available": true,
          "type": "time"
        }
      },
      {
        "id": "0d6712ab-ed7d-42e5-8def-0687044a1d8b",
        "type": "availabilities",
        "attributes": {
          "subject_type": "downtime",
          "subject_id": "63836de4-14a2-4da9-858b-a33f8e574a0d",
          "hour": "07",
          "minute": "30",
          "date": "2016-02-14",
          "status": "available",
          "available": true,
          "type": "time"
        }
      },
      {
        "id": "3dcbebe9-e715-436b-8e02-71a1061ec75a",
        "type": "availabilities",
        "attributes": {
          "subject_type": "downtime",
          "subject_id": "63836de4-14a2-4da9-858b-a33f8e574a0d",
          "hour": "07",
          "minute": "45",
          "date": "2016-02-14",
          "status": "available",
          "available": true,
          "type": "time"
        }
      },
      {
        "id": "2a37cd80-0f17-46a1-8efb-5e83b755a2dd",
        "type": "availabilities",
        "attributes": {
          "subject_type": "downtime",
          "subject_id": "63836de4-14a2-4da9-858b-a33f8e574a0d",
          "hour": "08",
          "minute": "00",
          "date": "2016-02-14",
          "status": "available",
          "available": true,
          "type": "time"
        }
      },
      {
        "id": "7b823412-3837-4a12-8bee-abc2d73323b8",
        "type": "availabilities",
        "attributes": {
          "subject_type": "downtime",
          "subject_id": "63836de4-14a2-4da9-858b-a33f8e574a0d",
          "hour": "08",
          "minute": "15",
          "date": "2016-02-14",
          "status": "available",
          "available": true,
          "type": "time"
        }
      },
      {
        "id": "a13fe603-7081-4420-843c-029cf54d1217",
        "type": "availabilities",
        "attributes": {
          "subject_type": "downtime",
          "subject_id": "63836de4-14a2-4da9-858b-a33f8e574a0d",
          "hour": "08",
          "minute": "30",
          "date": "2016-02-14",
          "status": "available",
          "available": true,
          "type": "time"
        }
      },
      {
        "id": "ca74de1a-2eab-4ea1-83c8-4ac3bbbff27c",
        "type": "availabilities",
        "attributes": {
          "subject_type": "downtime",
          "subject_id": "63836de4-14a2-4da9-858b-a33f8e574a0d",
          "hour": "08",
          "minute": "45",
          "date": "2016-02-14",
          "status": "available",
          "available": true,
          "type": "time"
        }
      },
      {
        "id": "e75ea1d9-69d5-4567-8b43-0f88fa2f4506",
        "type": "availabilities",
        "attributes": {
          "subject_type": "downtime",
          "subject_id": "63836de4-14a2-4da9-858b-a33f8e574a0d",
          "hour": "09",
          "minute": "00",
          "date": "2016-02-14",
          "status": "available",
          "available": true,
          "type": "time"
        }
      },
      {
        "id": "50aaf2d7-1618-48d8-890b-d114626f280a",
        "type": "availabilities",
        "attributes": {
          "subject_type": "downtime",
          "subject_id": "63836de4-14a2-4da9-858b-a33f8e574a0d",
          "hour": "09",
          "minute": "15",
          "date": "2016-02-14",
          "status": "available",
          "available": true,
          "type": "time"
        }
      },
      {
        "id": "a18105c3-49ff-4f97-8d5a-271173b9d8d9",
        "type": "availabilities",
        "attributes": {
          "subject_type": "downtime",
          "subject_id": "63836de4-14a2-4da9-858b-a33f8e574a0d",
          "hour": "09",
          "minute": "30",
          "date": "2016-02-14",
          "status": "available",
          "available": true,
          "type": "time"
        }
      },
      {
        "id": "30d8c37c-2e4a-4c0d-8eeb-91fd03d133aa",
        "type": "availabilities",
        "attributes": {
          "subject_type": "downtime",
          "subject_id": "63836de4-14a2-4da9-858b-a33f8e574a0d",
          "hour": "09",
          "minute": "45",
          "date": "2016-02-14",
          "status": "available",
          "available": true,
          "type": "time"
        }
      },
      {
        "id": "9b5c27e0-666d-41d2-84cf-a96c77fcb819",
        "type": "availabilities",
        "attributes": {
          "subject_type": "downtime",
          "subject_id": "63836de4-14a2-4da9-858b-a33f8e574a0d",
          "hour": "10",
          "minute": "00",
          "date": "2016-02-14",
          "status": "available",
          "available": true,
          "type": "time"
        }
      },
      {
        "id": "3e4eef78-f03e-4171-86dc-f3a6986bc958",
        "type": "availabilities",
        "attributes": {
          "subject_type": "downtime",
          "subject_id": "63836de4-14a2-4da9-858b-a33f8e574a0d",
          "hour": "10",
          "minute": "15",
          "date": "2016-02-14",
          "status": "available",
          "available": true,
          "type": "time"
        }
      },
      {
        "id": "91226fe4-b2ce-4f34-8fc2-687eea746309",
        "type": "availabilities",
        "attributes": {
          "subject_type": "downtime",
          "subject_id": "63836de4-14a2-4da9-858b-a33f8e574a0d",
          "hour": "10",
          "minute": "30",
          "date": "2016-02-14",
          "status": "available",
          "available": true,
          "type": "time"
        }
      },
      {
        "id": "5e1327c8-77ba-4670-8560-5d5fdb9ab0b0",
        "type": "availabilities",
        "attributes": {
          "subject_type": "downtime",
          "subject_id": "63836de4-14a2-4da9-858b-a33f8e574a0d",
          "hour": "10",
          "minute": "45",
          "date": "2016-02-14",
          "status": "available",
          "available": true,
          "type": "time"
        }
      },
      {
        "id": "7bde32c8-8364-403a-88b3-ed4b99239d56",
        "type": "availabilities",
        "attributes": {
          "subject_type": "downtime",
          "subject_id": "63836de4-14a2-4da9-858b-a33f8e574a0d",
          "hour": "11",
          "minute": "00",
          "date": "2016-02-14",
          "status": "available",
          "available": true,
          "type": "time"
        }
      },
      {
        "id": "8c9039b6-b596-48d9-8e00-a9e9a7a2627f",
        "type": "availabilities",
        "attributes": {
          "subject_type": "downtime",
          "subject_id": "63836de4-14a2-4da9-858b-a33f8e574a0d",
          "hour": "11",
          "minute": "15",
          "date": "2016-02-14",
          "status": "available",
          "available": true,
          "type": "time"
        }
      },
      {
        "id": "cbca68fa-4204-4801-8d10-44b64e9bc75f",
        "type": "availabilities",
        "attributes": {
          "subject_type": "downtime",
          "subject_id": "63836de4-14a2-4da9-858b-a33f8e574a0d",
          "hour": "11",
          "minute": "30",
          "date": "2016-02-14",
          "status": "available",
          "available": true,
          "type": "time"
        }
      },
      {
        "id": "02015389-8078-4353-8121-daf404bb9f51",
        "type": "availabilities",
        "attributes": {
          "subject_type": "downtime",
          "subject_id": "63836de4-14a2-4da9-858b-a33f8e574a0d",
          "hour": "11",
          "minute": "45",
          "date": "2016-02-14",
          "status": "available",
          "available": true,
          "type": "time"
        }
      },
      {
        "id": "cd21352b-9acc-4331-8591-c9c37fb3a475",
        "type": "availabilities",
        "attributes": {
          "subject_type": "downtime",
          "subject_id": "63836de4-14a2-4da9-858b-a33f8e574a0d",
          "hour": "12",
          "minute": "00",
          "date": "2016-02-14",
          "status": "available",
          "available": true,
          "type": "time"
        }
      },
      {
        "id": "7fe1a772-cbde-4eec-85ac-76dac384a8a0",
        "type": "availabilities",
        "attributes": {
          "subject_type": "downtime",
          "subject_id": "63836de4-14a2-4da9-858b-a33f8e574a0d",
          "hour": "12",
          "minute": "15",
          "date": "2016-02-14",
          "status": "available",
          "available": true,
          "type": "time"
        }
      },
      {
        "id": "30916e8c-f272-4dc9-8080-b7f0fa84a3bf",
        "type": "availabilities",
        "attributes": {
          "subject_type": "downtime",
          "subject_id": "63836de4-14a2-4da9-858b-a33f8e574a0d",
          "hour": "12",
          "minute": "30",
          "date": "2016-02-14",
          "status": "available",
          "available": true,
          "type": "time"
        }
      },
      {
        "id": "a383d691-52de-4fc5-8854-1459167bdcca",
        "type": "availabilities",
        "attributes": {
          "subject_type": "downtime",
          "subject_id": "63836de4-14a2-4da9-858b-a33f8e574a0d",
          "hour": "12",
          "minute": "45",
          "date": "2016-02-14",
          "status": "available",
          "available": true,
          "type": "time"
        }
      },
      {
        "id": "8e396ca2-ad13-4bff-89a4-7948bd63c395",
        "type": "availabilities",
        "attributes": {
          "subject_type": "downtime",
          "subject_id": "63836de4-14a2-4da9-858b-a33f8e574a0d",
          "hour": "13",
          "minute": "00",
          "date": "2016-02-14",
          "status": "available",
          "available": true,
          "type": "time"
        }
      },
      {
        "id": "2c53fd68-e81f-4ba4-81ca-32dd418ed903",
        "type": "availabilities",
        "attributes": {
          "subject_type": "downtime",
          "subject_id": "63836de4-14a2-4da9-858b-a33f8e574a0d",
          "hour": "13",
          "minute": "15",
          "date": "2016-02-14",
          "status": "available",
          "available": true,
          "type": "time"
        }
      },
      {
        "id": "976741e7-068b-4cea-84e7-6efb845b981c",
        "type": "availabilities",
        "attributes": {
          "subject_type": "downtime",
          "subject_id": "63836de4-14a2-4da9-858b-a33f8e574a0d",
          "hour": "13",
          "minute": "30",
          "date": "2016-02-14",
          "status": "available",
          "available": true,
          "type": "time"
        }
      },
      {
        "id": "164f25a2-c8e7-4396-8e41-bdab8c23f2e1",
        "type": "availabilities",
        "attributes": {
          "subject_type": "downtime",
          "subject_id": "63836de4-14a2-4da9-858b-a33f8e574a0d",
          "hour": "13",
          "minute": "45",
          "date": "2016-02-14",
          "status": "available",
          "available": true,
          "type": "time"
        }
      },
      {
        "id": "7e36f3e6-634f-4e9f-8243-cd4511314bfd",
        "type": "availabilities",
        "attributes": {
          "subject_type": "downtime",
          "subject_id": "63836de4-14a2-4da9-858b-a33f8e574a0d",
          "hour": "14",
          "minute": "00",
          "date": "2016-02-14",
          "status": "available",
          "available": true,
          "type": "time"
        }
      },
      {
        "id": "b103a7f5-955b-4b72-82ce-11a5164ae013",
        "type": "availabilities",
        "attributes": {
          "subject_type": "downtime",
          "subject_id": "63836de4-14a2-4da9-858b-a33f8e574a0d",
          "hour": "14",
          "minute": "15",
          "date": "2016-02-14",
          "status": "available",
          "available": true,
          "type": "time"
        }
      },
      {
        "id": "c82eb967-83a9-4b02-80af-1e0dfce4b8c4",
        "type": "availabilities",
        "attributes": {
          "subject_type": "downtime",
          "subject_id": "63836de4-14a2-4da9-858b-a33f8e574a0d",
          "hour": "14",
          "minute": "30",
          "date": "2016-02-14",
          "status": "available",
          "available": true,
          "type": "time"
        }
      },
      {
        "id": "b2c0ead9-d6fc-4be0-82e6-206f3842ea77",
        "type": "availabilities",
        "attributes": {
          "subject_type": "downtime",
          "subject_id": "63836de4-14a2-4da9-858b-a33f8e574a0d",
          "hour": "14",
          "minute": "45",
          "date": "2016-02-14",
          "status": "available",
          "available": true,
          "type": "time"
        }
      },
      {
        "id": "3643425a-7b56-423b-8c1f-ab2a4f3bbda3",
        "type": "availabilities",
        "attributes": {
          "subject_type": "downtime",
          "subject_id": "63836de4-14a2-4da9-858b-a33f8e574a0d",
          "hour": "15",
          "minute": "00",
          "date": "2016-02-14",
          "status": "available",
          "available": true,
          "type": "time"
        }
      },
      {
        "id": "60db9212-2aea-4991-8c08-cded4d87a8e0",
        "type": "availabilities",
        "attributes": {
          "subject_type": "downtime",
          "subject_id": "63836de4-14a2-4da9-858b-a33f8e574a0d",
          "hour": "15",
          "minute": "15",
          "date": "2016-02-14",
          "status": "available",
          "available": true,
          "type": "time"
        }
      },
      {
        "id": "2b96dd82-e2d6-433c-8b13-c4c9091e67ce",
        "type": "availabilities",
        "attributes": {
          "subject_type": "downtime",
          "subject_id": "63836de4-14a2-4da9-858b-a33f8e574a0d",
          "hour": "15",
          "minute": "30",
          "date": "2016-02-14",
          "status": "available",
          "available": true,
          "type": "time"
        }
      },
      {
        "id": "470c0369-3c5d-4011-8087-5f3546850696",
        "type": "availabilities",
        "attributes": {
          "subject_type": "downtime",
          "subject_id": "63836de4-14a2-4da9-858b-a33f8e574a0d",
          "hour": "15",
          "minute": "45",
          "date": "2016-02-14",
          "status": "available",
          "available": true,
          "type": "time"
        }
      },
      {
        "id": "2b42e5e2-dac4-45c8-8454-b4d0a00d1583",
        "type": "availabilities",
        "attributes": {
          "subject_type": "downtime",
          "subject_id": "63836de4-14a2-4da9-858b-a33f8e574a0d",
          "hour": "16",
          "minute": "00",
          "date": "2016-02-14",
          "status": "available",
          "available": true,
          "type": "time"
        }
      },
      {
        "id": "bafadebf-2b32-4f55-8cd1-e13f8b86e938",
        "type": "availabilities",
        "attributes": {
          "subject_type": "downtime",
          "subject_id": "63836de4-14a2-4da9-858b-a33f8e574a0d",
          "hour": "16",
          "minute": "15",
          "date": "2016-02-14",
          "status": "available",
          "available": true,
          "type": "time"
        }
      },
      {
        "id": "671f0179-2d76-4454-83db-93cc508dd244",
        "type": "availabilities",
        "attributes": {
          "subject_type": "downtime",
          "subject_id": "63836de4-14a2-4da9-858b-a33f8e574a0d",
          "hour": "16",
          "minute": "30",
          "date": "2016-02-14",
          "status": "available",
          "available": true,
          "type": "time"
        }
      },
      {
        "id": "a88fe05d-2e6d-468b-8398-620103aef7ef",
        "type": "availabilities",
        "attributes": {
          "subject_type": "downtime",
          "subject_id": "63836de4-14a2-4da9-858b-a33f8e574a0d",
          "hour": "16",
          "minute": "45",
          "date": "2016-02-14",
          "status": "available",
          "available": true,
          "type": "time"
        }
      },
      {
        "id": "75d18356-f07b-45c8-81f7-ab1a55ec7b4c",
        "type": "availabilities",
        "attributes": {
          "subject_type": "downtime",
          "subject_id": "63836de4-14a2-4da9-858b-a33f8e574a0d",
          "hour": "17",
          "minute": "00",
          "date": "2016-02-14",
          "status": "available",
          "available": true,
          "type": "time"
        }
      },
      {
        "id": "6b53e741-d2b6-4219-857e-d6da5758f7c8",
        "type": "availabilities",
        "attributes": {
          "subject_type": "downtime",
          "subject_id": "63836de4-14a2-4da9-858b-a33f8e574a0d",
          "hour": "17",
          "minute": "15",
          "date": "2016-02-14",
          "status": "available",
          "available": true,
          "type": "time"
        }
      },
      {
        "id": "de218434-f026-41b3-8c36-80abcbf93690",
        "type": "availabilities",
        "attributes": {
          "subject_type": "downtime",
          "subject_id": "63836de4-14a2-4da9-858b-a33f8e574a0d",
          "hour": "17",
          "minute": "30",
          "date": "2016-02-14",
          "status": "available",
          "available": true,
          "type": "time"
        }
      },
      {
        "id": "8489cfe8-4ad9-4909-892b-2ca7ddb1bd54",
        "type": "availabilities",
        "attributes": {
          "subject_type": "downtime",
          "subject_id": "63836de4-14a2-4da9-858b-a33f8e574a0d",
          "hour": "17",
          "minute": "45",
          "date": "2016-02-14",
          "status": "available",
          "available": true,
          "type": "time"
        }
      },
      {
        "id": "f53544c5-459b-4893-8f80-1c718e647136",
        "type": "availabilities",
        "attributes": {
          "subject_type": "downtime",
          "subject_id": "63836de4-14a2-4da9-858b-a33f8e574a0d",
          "hour": "18",
          "minute": "00",
          "date": "2016-02-14",
          "status": "available",
          "available": true,
          "type": "time"
        }
      },
      {
        "id": "941ef618-3abd-4523-88de-1384fabe5f2e",
        "type": "availabilities",
        "attributes": {
          "subject_type": "downtime",
          "subject_id": "63836de4-14a2-4da9-858b-a33f8e574a0d",
          "hour": "18",
          "minute": "15",
          "date": "2016-02-14",
          "status": "available",
          "available": true,
          "type": "time"
        }
      },
      {
        "id": "03b10e5f-f127-432b-8636-9a8b58c82497",
        "type": "availabilities",
        "attributes": {
          "subject_type": "downtime",
          "subject_id": "63836de4-14a2-4da9-858b-a33f8e574a0d",
          "hour": "18",
          "minute": "30",
          "date": "2016-02-14",
          "status": "available",
          "available": true,
          "type": "time"
        }
      },
      {
        "id": "782a5934-6d93-42a4-814b-34440e39e099",
        "type": "availabilities",
        "attributes": {
          "subject_type": "downtime",
          "subject_id": "63836de4-14a2-4da9-858b-a33f8e574a0d",
          "hour": "18",
          "minute": "45",
          "date": "2016-02-14",
          "status": "available",
          "available": true,
          "type": "time"
        }
      },
      {
        "id": "7f0a201b-8a7e-4e71-854a-55fac779941f",
        "type": "availabilities",
        "attributes": {
          "subject_type": "downtime",
          "subject_id": "63836de4-14a2-4da9-858b-a33f8e574a0d",
          "hour": "19",
          "minute": "00",
          "date": "2016-02-14",
          "status": "available",
          "available": true,
          "type": "time"
        }
      },
      {
        "id": "8a5f6f3a-64ee-4a01-89a0-c0569e9b9766",
        "type": "availabilities",
        "attributes": {
          "subject_type": "downtime",
          "subject_id": "63836de4-14a2-4da9-858b-a33f8e574a0d",
          "hour": "19",
          "minute": "15",
          "date": "2016-02-14",
          "status": "available",
          "available": true,
          "type": "time"
        }
      },
      {
        "id": "464e4397-ef45-4818-8209-fc3464714c0c",
        "type": "availabilities",
        "attributes": {
          "subject_type": "downtime",
          "subject_id": "63836de4-14a2-4da9-858b-a33f8e574a0d",
          "hour": "19",
          "minute": "30",
          "date": "2016-02-14",
          "status": "available",
          "available": true,
          "type": "time"
        }
      },
      {
        "id": "7807ef6b-0a68-412f-8bcd-9903b10f143a",
        "type": "availabilities",
        "attributes": {
          "subject_type": "downtime",
          "subject_id": "63836de4-14a2-4da9-858b-a33f8e574a0d",
          "hour": "19",
          "minute": "45",
          "date": "2016-02-14",
          "status": "available",
          "available": true,
          "type": "time"
        }
      },
      {
        "id": "2e8ad221-cb73-47b9-8a36-db4b6d8e42e8",
        "type": "availabilities",
        "attributes": {
          "subject_type": "downtime",
          "subject_id": "63836de4-14a2-4da9-858b-a33f8e574a0d",
          "hour": "20",
          "minute": "00",
          "date": "2016-02-14",
          "status": "available",
          "available": true,
          "type": "time"
        }
      },
      {
        "id": "cb0e5df6-eb83-47f9-879f-19983196ec82",
        "type": "availabilities",
        "attributes": {
          "subject_type": "downtime",
          "subject_id": "63836de4-14a2-4da9-858b-a33f8e574a0d",
          "hour": "20",
          "minute": "15",
          "date": "2016-02-14",
          "status": "available",
          "available": true,
          "type": "time"
        }
      },
      {
        "id": "ed9e770f-cc63-4eb0-8229-94743b0cf796",
        "type": "availabilities",
        "attributes": {
          "subject_type": "downtime",
          "subject_id": "63836de4-14a2-4da9-858b-a33f8e574a0d",
          "hour": "20",
          "minute": "30",
          "date": "2016-02-14",
          "status": "available",
          "available": true,
          "type": "time"
        }
      },
      {
        "id": "19bf6705-89d5-4136-8b14-c4484995e957",
        "type": "availabilities",
        "attributes": {
          "subject_type": "downtime",
          "subject_id": "63836de4-14a2-4da9-858b-a33f8e574a0d",
          "hour": "20",
          "minute": "45",
          "date": "2016-02-14",
          "status": "available",
          "available": true,
          "type": "time"
        }
      },
      {
        "id": "3ace5637-e427-485e-89d5-f1a203e63f9d",
        "type": "availabilities",
        "attributes": {
          "subject_type": "downtime",
          "subject_id": "63836de4-14a2-4da9-858b-a33f8e574a0d",
          "hour": "21",
          "minute": "00",
          "date": "2016-02-14",
          "status": "available",
          "available": true,
          "type": "time"
        }
      },
      {
        "id": "764ecb2c-58a8-4b84-872e-34f1659ffbdd",
        "type": "availabilities",
        "attributes": {
          "subject_type": "downtime",
          "subject_id": "63836de4-14a2-4da9-858b-a33f8e574a0d",
          "hour": "21",
          "minute": "15",
          "date": "2016-02-14",
          "status": "available",
          "available": true,
          "type": "time"
        }
      },
      {
        "id": "1a1e2fba-13c3-46b0-8e9e-1bdbc24d6d99",
        "type": "availabilities",
        "attributes": {
          "subject_type": "downtime",
          "subject_id": "63836de4-14a2-4da9-858b-a33f8e574a0d",
          "hour": "21",
          "minute": "30",
          "date": "2016-02-14",
          "status": "available",
          "available": true,
          "type": "time"
        }
      },
      {
        "id": "9b9c4279-0ae7-4be3-8ffc-f498b9f20095",
        "type": "availabilities",
        "attributes": {
          "subject_type": "downtime",
          "subject_id": "63836de4-14a2-4da9-858b-a33f8e574a0d",
          "hour": "21",
          "minute": "45",
          "date": "2016-02-14",
          "status": "available",
          "available": true,
          "type": "time"
        }
      },
      {
        "id": "8476ff02-723c-4f1f-846d-4a7b016576cf",
        "type": "availabilities",
        "attributes": {
          "subject_type": "downtime",
          "subject_id": "63836de4-14a2-4da9-858b-a33f8e574a0d",
          "hour": "22",
          "minute": "00",
          "date": "2016-02-14",
          "status": "available",
          "available": true,
          "type": "time"
        }
      },
      {
        "id": "2c2f7634-cc74-4c8d-8080-e1aad867f41c",
        "type": "availabilities",
        "attributes": {
          "subject_type": "downtime",
          "subject_id": "63836de4-14a2-4da9-858b-a33f8e574a0d",
          "hour": "22",
          "minute": "15",
          "date": "2016-02-14",
          "status": "available",
          "available": true,
          "type": "time"
        }
      },
      {
        "id": "ff52df24-1309-4476-8d26-113ed157dc5c",
        "type": "availabilities",
        "attributes": {
          "subject_type": "downtime",
          "subject_id": "63836de4-14a2-4da9-858b-a33f8e574a0d",
          "hour": "22",
          "minute": "30",
          "date": "2016-02-14",
          "status": "available",
          "available": true,
          "type": "time"
        }
      },
      {
        "id": "827aad30-e932-48c7-8989-77b3133fdefc",
        "type": "availabilities",
        "attributes": {
          "subject_type": "downtime",
          "subject_id": "63836de4-14a2-4da9-858b-a33f8e574a0d",
          "hour": "22",
          "minute": "45",
          "date": "2016-02-14",
          "status": "available",
          "available": true,
          "type": "time"
        }
      },
      {
        "id": "47ad53b5-3ad8-41e9-88e8-bc47a557d344",
        "type": "availabilities",
        "attributes": {
          "subject_type": "downtime",
          "subject_id": "63836de4-14a2-4da9-858b-a33f8e574a0d",
          "hour": "23",
          "minute": "00",
          "date": "2016-02-14",
          "status": "available",
          "available": true,
          "type": "time"
        }
      },
      {
        "id": "a1b507f0-066d-43e9-857a-2d38738c311b",
        "type": "availabilities",
        "attributes": {
          "subject_type": "downtime",
          "subject_id": "63836de4-14a2-4da9-858b-a33f8e574a0d",
          "hour": "23",
          "minute": "15",
          "date": "2016-02-14",
          "status": "available",
          "available": true,
          "type": "time"
        }
      },
      {
        "id": "69287dbb-0939-42ad-870e-420846dd6b88",
        "type": "availabilities",
        "attributes": {
          "subject_type": "downtime",
          "subject_id": "63836de4-14a2-4da9-858b-a33f8e574a0d",
          "hour": "23",
          "minute": "30",
          "date": "2016-02-14",
          "status": "available",
          "available": true,
          "type": "time"
        }
      },
      {
        "id": "9d9ddd6b-3e88-4b66-83b9-ad78412903f4",
        "type": "availabilities",
        "attributes": {
          "subject_type": "downtime",
          "subject_id": "63836de4-14a2-4da9-858b-a33f8e574a0d",
          "hour": "23",
          "minute": "45",
          "date": "2016-02-14",
          "status": "available",
          "available": true,
          "type": "time"
        }
      }
    ],
    "meta": {}
  }
```

### HTTP Request

`GET /api/4/availabilities`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[availabilities]=subject_type,subject_id,hour`
`filter` | **hash** <br>The filters to apply `?filter[attribute][eq]=value`
`meta` | **hash** <br>Metadata to send along. `?meta[total][]=count`
`page[number]` | **string** <br>The page to request.
`page[size]` | **string** <br>The amount of items per page.
`sort` | **string** <br>How to sort the data. `?sort=attribute1,-attribute2`


### Filters

This request can be filtered on:

Name | Description
-- | --
`day` | **integer** <br>`eq`
`duration_period` | **string** <br>`eq`
`interval` | **integer** <br>`eq`
`location_id` | **uuid** <br>`eq`
`month` | **integer** `required`<br>`eq`
`starts_at` | **datetime** <br>`eq`
`subject_id` | **uuid** `required`<br>`eq`
`subject_type` | **string** `required`<br>`eq`
`type` | **string** <br>`eq`
`year` | **integer** `required`<br>`eq`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **array** <br>`count`


### Includes

This request does not accept any includes