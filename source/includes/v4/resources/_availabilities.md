# Availabilities

Availabilities provide calendar-based information about when products, stock items, orders, carts, or downtimes
are available or unavailable. This resource displays availability calendars showing which dates and times
are available for booking or scheduling.

The availability endpoint returns a calendar view with detailed status information for each date or time
slot, including whether the period is available, partially available, or unavailable.

## Subject Types

- **order**: Check availability for rescheduling an order's start or stop date
- **cart**: Check availability for a cart
- **item**: View product availability across a period for booking
- **downtime**: Check availability for scheduling maintenance or repairs

## Time Granularity

Availability can be checked at different time granularities:

- **Daily**: Month views showing day-level availability
- **Hourly**: Day views showing interval-based availability (typically 15-minute intervals)

## Fields

 Name | Description
-- | --
`availabilities` | **array** `readonly`<br>An array of availability objects representing each date or time slot in the requested period. Each object contains:<br>- `type` - Either `date` for daily granularity or `time` for hourly granularity - `date` - The date being represented (for daily views) - `hour` - The hour component (for hourly views, 0-23) - `minute` - The minute component (for hourly views, typically 0, 15, 30, or 45) - `status` - One of `available`, `partial`, or `unavailable` - `available` - Boolean indicating availability (`true` for available, `false` for unavailable, `null` for partial) - `quantity` - For products, the number of items available (only when `subject_type` is `item`) 
`id` | **uuid** `readonly`<br>A unique identifier for this availability result generated based on the query parameters. 
`subject_id` | **uuid** `readonly`<br>The ID of the subject to check availability for. 
`subject_type` | **string** `readonly`<br>The type of subject being checked for availability.<br>One of: `order`, `cart`, `item`, `downtime`. 


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

> A 422 status response looks like this:

```json
  {
    "errors": [
      {
        "code": "unprocessable_entity",
        "status": "422",
        "title": "Unprocessable entity",
        "detail": "There are missing or incorrect values supplied.",
        "meta": null
      }
    ]
  }
```

### HTTP Request

`GET /api/4/availabilities`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[availabilities]=subject_type,subject_id,availabilities`
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
`month` | **integer** <br>`eq`
`starts_at` | **datetime** <br>`eq`
`subject_id` | **uuid** <br>`eq`
`subject_type` | **string** <br>`eq`
`type` | **string** <br>`eq`
`year` | **integer** <br>`eq`


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
       --data-urlencode 'filter[month]=10'
       --data-urlencode 'filter[start_location_id]=158d5e18-4cbe-4e0b-8bc7-647b95797e14'
       --data-urlencode 'filter[subject_id]=6774b37c-a832-4868-8ae9-b9c90cb5c75e'
       --data-urlencode 'filter[subject_type]=item'
       --data-urlencode 'filter[year]=2024'
```

> A 400 status response looks like this:

```json
  {
    "errors": [
      {
        "code": "bad_request",
        "status": "400",
        "title": "Request Error",
        "detail": "Tried to filter on attribute \"start_location_id\" but could not find an attribute with that name."
      }
    ]
  }
```

### HTTP Request

`GET /api/4/availabilities`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[availabilities]=subject_type,subject_id,availabilities`
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
`month` | **integer** <br>`eq`
`starts_at` | **datetime** <br>`eq`
`subject_id` | **uuid** <br>`eq`
`subject_type` | **string** <br>`eq`
`type` | **string** <br>`eq`
`year` | **integer** <br>`eq`


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

> A 422 status response looks like this:

```json
  {
    "errors": [
      {
        "code": "unprocessable_entity",
        "status": "422",
        "title": "Unprocessable entity",
        "detail": "There are missing or incorrect values supplied.",
        "meta": null
      }
    ]
  }
```

### HTTP Request

`GET /api/4/availabilities`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[availabilities]=subject_type,subject_id,availabilities`
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
`month` | **integer** <br>`eq`
`starts_at` | **datetime** <br>`eq`
`subject_id` | **uuid** <br>`eq`
`subject_type` | **string** <br>`eq`
`type` | **string** <br>`eq`
`year` | **integer** <br>`eq`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **array** <br>`count`


### Includes

This request does not accept any includes