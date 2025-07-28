# Downtimes

Downtimes represent periods when bulk or tracked items are unavailable for rental due to maintenance,
repairs, or other operational reasons. This allows you to block item availability outside of regular
rental bookings, ensuring accurate inventory management and scheduling.

Use downtimes to:
- Schedule maintenance periods for equipment
- Mark items as temporarily unavailable due to repairs
- Handle missing or misplaced items
- Block availability for operational reasons

## Downtime Reasons

Each downtime must specify one of the following reasons:
- `maintenance`: Regular maintenance or servicing
- `repair`: Item requires repair work
- `missing`: Item is missing or misplaced

## Relationships
Name | Description
-- | --
`item` | **[Item](#items)** `required`<br>The bulk or tracked item that is unavailable during the downtime period. 


Check matching attributes under [Fields](#downtimes-fields) to see which relations can be written.
<br/ >
Check each individual operation to see which relations can be included as a sideload.
## Fields

 Name | Description
-- | --
`created_at` | **datetime** `readonly`<br>When the resource was created.
`downtime_reason` | **enum** <br>The reason why the item is unavailable. Must be one of: `maintenance`, `repair`, or `missing`. This helps categorize and track different types of operational issues.<br> One of: `maintenance`, `repair`, `missing`.
`from` | **datetime** <br>When the downtime period begins. The item becomes unavailable for rental from this date/time. 
`id` | **uuid** `readonly`<br>Primary key.
`item_id` | **uuid** `readonly`<br>The bulk or tracked item that is unavailable during the downtime period. 
`location_id` | **uuid** <br>The UUID of the [Location](#locations) where the downtime occurs. This helps track where maintenance or repairs are taking place. For simplicity, items remain at the same location throughout the downtime period. 
`till` | **datetime** <br>When the downtime period ends. The item becomes available for rental again after this date/time. 
`updated_at` | **datetime** `readonly`<br>When the resource was last updated.


## List downtimes


> How to fetch a list of downtimes:

```shell
  curl --get 'https://example.booqable.com/api/4/downtimes'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": [
      {
        "id": "f1f5276f-fc8b-4fc0-880b-6d7e0c715f2b",
        "type": "downtimes",
        "attributes": {
          "created_at": "2020-11-22T16:53:01.000000+00:00",
          "updated_at": "2020-11-22T16:53:01.000000+00:00",
          "downtime_reason": "maintenance",
          "from": "2020-11-24T16:53:01.000000+00:00",
          "till": "2020-11-27T16:53:01.000000+00:00",
          "location_id": "f10a87a6-8788-42b0-88db-615bf92db1f2",
          "item_id": "7deebeb2-e361-43f5-8209-64fb69710a8a"
        },
        "relationships": {}
      }
    ],
    "meta": {}
  }
```

### HTTP Request

`GET /api/4/downtimes`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[downtimes]=created_at,updated_at,downtime_reason`
`filter` | **hash** <br>The filters to apply `?filter[attribute][eq]=value`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=item`
`meta` | **hash** <br>Metadata to send along. `?meta[total][]=count`
`page[number]` | **string** <br>The page to request.
`page[size]` | **string** <br>The amount of items per page.
`sort` | **string** <br>How to sort the data. `?sort=attribute1,-attribute2`


### Filters

This request can be filtered on:

Name | Description
-- | --
`created_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`downtime_reason` | **enum** <br>`eq`
`from` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`id` | **uuid** <br>`eq`, `not_eq`
`item_id` | **uuid** <br>`eq`, `not_eq`
`location_id` | **uuid** <br>`eq`, `not_eq`
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
  <li>
    <code>item</code>
    <ul>
      <li><code>photo</code></li>
    </ul>
  </li>
</ul>

