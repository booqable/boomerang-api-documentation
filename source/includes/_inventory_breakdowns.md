# Inventory breakdowns

Fetch quantitive information about product inventory compared to the current time, broken down by:

- Location
- Product
- Type
- Mutation date(s)

**Useful for:**

- Examining what the current inventory looks, and will look, like for products
- Performing an inventory count (total in stock vs. out with a customer)

## Relationships
Name | Description
-- | --
`location` | **[Location](#locations)** `required`<br>The location to which this breakdown record applies.
`product` | **[Product](#products)** `required`<br>The product whose availability this breakdown record describes.


Check matching attributes under [Fields](#inventory-breakdowns-fields) to see which relations can be written.
<br/ >
Check each individual operation to see which relations can be included as a sideload.
## Fields

 Name | Description
-- | --
`from` | **datetime** <br>When the amount of items will be available (only for status `expected`).
`id` | **uuid** `readonly`<br>Primary key.
`inventory_breakdown_type` | **string** <br>One of `regular`, `temporary`.
`location_id` | **uuid** `readonly`<br>The location to which this breakdown record applies.
`product_id` | **uuid** `readonly`<br>The product whose availability this breakdown record describes.
`started` | **integer** <br>The amount if items that are started for product and location. Only rendered when applicable.
`status` | **string** <br>One of `expected`, `in_stock`, `expired`.
`stock_count` | **integer** <br>The total amount of stock for product and location.
`till` | **datetime** <br>When the amount of items will become unavailable (only for type `temporary` and/or status `expired`).


## Listing inventory breakdowns


> How to fetch a breakdown of all items in stock:

```shell
  curl --get 'https://example.booqable.com/api/boomerang/inventory_breakdowns'
       --header 'content-type: application/json'
       --data-urlencode 'filter[product_group_id]=fc4bfed6-545d-4ffe-8b66-81e8dbde9d4e'
       --data-urlencode 'filter[status]=in_stock'
       --data-urlencode 'stats[inventory_breakdown_type][]=sum'
       --data-urlencode 'stats[started][]=sum'
       --data-urlencode 'stats[status][]=sum'
       --data-urlencode 'stats[stock_count][]=sum'
```

> A 200 status response looks like this:

```json
  {
    "data": [
      {
        "id": "4d112455-70ef-47ab-8e13-317982d7a785",
        "type": "inventory_breakdowns",
        "attributes": {
          "stock_count": 100,
          "started": 50,
          "status": "in_stock",
          "inventory_breakdown_type": "regular",
          "location_id": "93539676-0eec-4298-8221-d37c766028c4",
          "product_id": "856d3a4c-8f1c-4392-8837-b1033d097162"
        },
        "relationships": {}
      },
      {
        "id": "cfc74ef9-ca0f-4337-8020-dc4ecddbde48",
        "type": "inventory_breakdowns",
        "attributes": {
          "till": "2020-08-15T02:26:01.000000+00:00",
          "stock_count": 5,
          "started": 0,
          "status": "in_stock",
          "inventory_breakdown_type": "temporary",
          "location_id": "93539676-0eec-4298-8221-d37c766028c4",
          "product_id": "856d3a4c-8f1c-4392-8837-b1033d097162"
        },
        "relationships": {}
      }
    ],
    "meta": {
      "stats": {
        "inventory_breakdown_type": {
          "sum": {
            "regular": 100,
            "temporary": 5
          }
        },
        "started": {
          "sum": 50
        },
        "status": {
          "sum": {
            "in_stock": 105,
            "expected": 17,
            "expired": 22
          }
        },
        "stock_count": {
          "sum": 105
        }
      }
    }
  }
```

> How to fetch a breakdown of all expected items:

```shell
  curl --get 'https://example.booqable.com/api/boomerang/inventory_breakdowns'
       --header 'content-type: application/json'
       --data-urlencode 'filter[product_group_id]=3142a9c7-40c2-4dff-8a3d-61aef93400cf'
       --data-urlencode 'filter[status]=expected'
       --data-urlencode 'stats[inventory_breakdown_type][]=sum'
       --data-urlencode 'stats[started][]=sum'
       --data-urlencode 'stats[status][]=sum'
       --data-urlencode 'stats[stock_count][]=sum'
```

> A 200 status response looks like this:

```json
  {
    "data": [
      {
        "id": "d6f88a18-89e5-409d-84ae-8e3e2af10659",
        "type": "inventory_breakdowns",
        "attributes": {
          "from": "2017-11-18T03:35:00.000000+00:00",
          "stock_count": 12,
          "status": "expected",
          "inventory_breakdown_type": "regular",
          "location_id": "53f12674-6a2f-4878-804c-eb4dd3aa204f",
          "product_id": "11b3f75f-518c-4e76-8979-2efbc4019818"
        },
        "relationships": {}
      },
      {
        "id": "7f3caf33-119d-43b7-8bd5-8c7bd5de639a",
        "type": "inventory_breakdowns",
        "attributes": {
          "from": "2017-11-18T03:35:00.000000+00:00",
          "till": "2017-12-19T03:35:00.000000+00:00",
          "stock_count": 5,
          "status": "expected",
          "inventory_breakdown_type": "temporary",
          "location_id": "53f12674-6a2f-4878-804c-eb4dd3aa204f",
          "product_id": "11b3f75f-518c-4e76-8979-2efbc4019818"
        },
        "relationships": {}
      }
    ],
    "meta": {
      "stats": {
        "inventory_breakdown_type": {
          "sum": {
            "regular": 12,
            "temporary": 5
          }
        },
        "started": {
          "sum": 0
        },
        "status": {
          "sum": {
            "in_stock": 105,
            "expected": 17,
            "expired": 22
          }
        },
        "stock_count": {
          "sum": 17
        }
      }
    }
  }
```

> How to fetch a breakdown of all expired items:

```shell
  curl --get 'https://example.booqable.com/api/boomerang/inventory_breakdowns'
       --header 'content-type: application/json'
       --data-urlencode 'filter[product_group_id]=8d1d8d66-b01e-4300-83da-7418f5acaaea'
       --data-urlencode 'filter[status]=expired'
       --data-urlencode 'stats[inventory_breakdown_type][]=sum'
       --data-urlencode 'stats[started][]=sum'
       --data-urlencode 'stats[status][]=sum'
       --data-urlencode 'stats[stock_count][]=sum'
```

> A 200 status response looks like this:

```json
  {
    "data": [
      {
        "id": "b5e5064e-831e-4883-8a71-2e612ddbb495",
        "type": "inventory_breakdowns",
        "attributes": {
          "till": "2022-08-20T18:59:00.000000+00:00",
          "stock_count": 22,
          "status": "expired",
          "inventory_breakdown_type": "temporary",
          "location_id": "8a5cbdf6-c713-419f-868e-14208fd6df91",
          "product_id": "243a8fd8-a17c-4b5e-878c-3e0646778c26"
        },
        "relationships": {}
      }
    ],
    "meta": {
      "stats": {
        "inventory_breakdown_type": {
          "sum": {
            "regular": 0,
            "temporary": 22
          }
        },
        "started": {
          "sum": 0
        },
        "status": {
          "sum": {
            "in_stock": 105,
            "expected": 17,
            "expired": 22
          }
        },
        "stock_count": {
          "sum": 22
        }
      }
    }
  }
```

### HTTP Request

`GET /api/boomerang/inventory_breakdowns`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma seperated fields to include `?fields[inventory_breakdowns]=from,till,stock_count`
`filter` | **hash** <br>The filters to apply `?filter[attribute][eq]=value`
`include` | **string** <br>List of comma seperated relationships `?include=location,product`
`meta` | **hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **string** <br>The page to request
`page[size]` | **string** <br>The amount of items per page (max 100)
`sort` | **string** <br>How to sort the data `?sort=attribute1,-attribute2`


### Filters

This request can be filtered on:

Name | Description
-- | --
`inventory_breakdown_type` | **string** <br>`eq`
`location_id` | **uuid** <br>`eq`
`product_group_id` | **uuid** <br>`eq`
`product_id` | **uuid** <br>`eq`
`status` | **string** `required`<br>`eq`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`inventory_breakdown_type` | **array** <br>`sum`
`started` | **array** <br>`sum`
`status` | **array** <br>`sum`
`stock_count` | **array** <br>`sum`, `count`
`total` | **array** <br>`count`


### Includes

This request accepts the following includes:

`location`


`product` => 
`photo`







