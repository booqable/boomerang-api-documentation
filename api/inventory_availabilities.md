# Inventory availabilities

Inventory availabilities tell you how many units of a product can be booked for an
exact period at a given location.

Unlike the [Availabilities](#availabilities) endpoint, which returns a calendar of
statuses (`available`, `partial`, `unavailable`) per day or time slot, this endpoint
answers a different question: how many units are available for a specific `from`/`till`
range. It is the recommended way to obtain quantity counts and replaces the deprecated
[Inventory levels](#inventory-levels) endpoint for that purpose.

Availability accounts for stock counts and existing reservations. Pass one or more
`item_id` values to check multiple products in a single request.

## Fields

 Name | Description
-- | --
`available` | **integer** `readonly`<br>The number of units available to book for the requested period and location. 
`id` | **uuid** `readonly`<br>Primary key.
`item_id` | **uuid** `readonly`<br>**Required.** The item to return availability for. Accepts a single ID, or an array of IDs to check multiple products in one request. Also returned on each record. 
`plannable` | **integer** `readonly`<br>The number of units that can be planned for the requested period and location. When shortage is allowed for the product, this can exceed `available` by the configured shortage limit. 


## Fetch availability for a product


> How to fetch availability for a product:

```shell
  curl --get 'https://example.booqable.com/api/4/inventory_availabilities'
       --header 'content-type: application/json'
       --data-urlencode 'filter[from]=2024-10-01 09:00:00'
       --data-urlencode 'filter[item_id]=2509b56a-90aa-4713-82ae-3494a102e48a'
       --data-urlencode 'filter[location_id]=e27b9b57-dc61-4fd7-8605-c0e7e763d985'
       --data-urlencode 'filter[till]=2024-10-02 09:00:00'
```

> A 200 status response looks like this:

```json
  {
    "data": [
      {
        "id": "5d48ab74-7603-4cc0-8b1b-6abdfd244419",
        "type": "inventory_availabilities",
        "attributes": {
          "item_id": "2509b56a-90aa-4713-82ae-3494a102e48a",
          "available": 2,
          "plannable": 2
        }
      }
    ],
    "meta": {}
  }
```

### HTTP Request

`GET /api/4/inventory_availabilities`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[inventory_availabilities]=item_id,available,plannable`
`filter` | **hash** <br>The filters to apply `?filter[attribute][eq]=value`
`meta` | **hash** <br>Metadata to send along. `?meta[total][]=count`
`page[number]` | **string** <br>The page to request.
`page[size]` | **string** <br>The amount of items per page.
`sort` | **string** <br>How to sort the data. `?sort=attribute1,-attribute2`


### Filters

This request can be filtered on:

Name | Description
-- | --
`configuration` | **hash** <br>`eq`
`from` | **datetime** `required`<br>`eq`
`item_id` | **uuid** `required`<br>`eq`
`location_id` | **uuid** `required`<br>`eq`
`till` | **datetime** `required`<br>`eq`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **array** <br>`count`


### Includes

This request does not accept any includes
## Fetch availability for a bundle


> How to fetch availability for a bundle using a configuration:

```shell
  curl --get 'https://example.booqable.com/api/4/inventory_availabilities'
       --header 'content-type: application/json'
       --data-urlencode 'filter[configuration][f44843a5-a88e-42f0-8367-813ef78e6655]=029c12e7-9185-4a6f-850a-3886a4e61c14'
       --data-urlencode 'filter[from]=2024-10-01 09:00:00'
       --data-urlencode 'filter[item_id]=7cb98cae-603f-4077-835a-9b2ff696942e'
       --data-urlencode 'filter[location_id]=98400282-2c37-44df-8002-831789622118'
       --data-urlencode 'filter[till]=2024-10-02 09:00:00'
```

> A 200 status response looks like this:

```json
  {
    "data": [
      {
        "id": "b45d219c-e452-4f3d-87e9-211dee3ae616",
        "type": "inventory_availabilities",
        "attributes": {
          "item_id": "7cb98cae-603f-4077-835a-9b2ff696942e",
          "available": 2,
          "plannable": 2
        }
      }
    ],
    "meta": {}
  }
```

### HTTP Request

`GET /api/4/inventory_availabilities`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[inventory_availabilities]=item_id,available,plannable`
`filter` | **hash** <br>The filters to apply `?filter[attribute][eq]=value`
`meta` | **hash** <br>Metadata to send along. `?meta[total][]=count`
`page[number]` | **string** <br>The page to request.
`page[size]` | **string** <br>The amount of items per page.
`sort` | **string** <br>How to sort the data. `?sort=attribute1,-attribute2`


### Filters

This request can be filtered on:

Name | Description
-- | --
`configuration` | **hash** <br>`eq`
`from` | **datetime** `required`<br>`eq`
`item_id` | **uuid** `required`<br>`eq`
`location_id` | **uuid** `required`<br>`eq`
`till` | **datetime** `required`<br>`eq`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **array** <br>`count`


### Includes

This request does not accept any includes