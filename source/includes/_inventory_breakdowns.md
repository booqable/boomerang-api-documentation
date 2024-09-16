# Inventory breakdowns

Fetch quantitive information about product inventory compared to the current time, broken down by:

- Location
- Product
- Type
- Mutation date(s)

**Useful for:**

- Examining what the current inventory looks, and will look, like for products
- Performing an inventory count (total in stock vs. out with a customer)

## Fields
Every inventory breakdown has the following fields:

Name | Description
-- | --
`id` | **Uuid** `readonly`<br>
`from` | **Datetime** <br>When the amount of items will be available (only for status `expected`)
`till` | **Datetime** <br>When the amount of items will become unavailable (only for type `temporary` and/or status `expired`)
`stock_count` | **Integer** <br>The total amount of stock for product and location
`started` | **Integer** <br>The amount if items that are started for product and location. Only rendered when applicable
`status` | **String** <br>One of `expected`, `in_stock`, `expired`
`inventory_breakdown_type` | **String** <br>One of `regular`, `temporary`
`location_id` | **Uuid** <br>The associated Location
`product_id` | **Uuid** <br>The associated Product


## Relationships
Inventory breakdowns have the following relationships:

Name | Description
-- | --
`location` | **Locations** `readonly`<br>Associated Location
`product` | **Products** `readonly`<br>Associated Product


## Listing inventory breakdowns



> How to fetch a breakdown of all items in stock:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/inventory_breakdowns?filter%5Bproduct_group_id%5D=a5405ba5-1230-4850-9211-6aff62f8fa02&filter%5Bstatus%5D=in_stock&stats%5Binventory_breakdown_type%5D%5B%5D=sum&stats%5Bstarted%5D%5B%5D=sum&stats%5Bstatus%5D%5B%5D=sum&stats%5Bstock_count%5D%5B%5D=sum' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "f8353172-c991-4dca-be8f-9cd46ee8e4fb",
      "type": "inventory_breakdowns",
      "attributes": {
        "stock_count": 100,
        "started": 50,
        "status": "in_stock",
        "inventory_breakdown_type": "regular",
        "location_id": "3492761a-fe37-49ac-a4b7-7958d37d7f20",
        "product_id": "23c5e1f4-a895-417d-b05d-50f624ecd0d0"
      },
      "relationships": {}
    },
    {
      "id": "e1f24ee4-8da2-4b2c-8a5d-68c8ec9d4204",
      "type": "inventory_breakdowns",
      "attributes": {
        "till": "1988-09-11T20:00:00.000000+00:00",
        "stock_count": 5,
        "started": 0,
        "status": "in_stock",
        "inventory_breakdown_type": "temporary",
        "location_id": "3492761a-fe37-49ac-a4b7-7958d37d7f20",
        "product_id": "23c5e1f4-a895-417d-b05d-50f624ecd0d0"
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
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/inventory_breakdowns?filter%5Bproduct_group_id%5D=5b6251d0-4a50-4f13-8ea5-afa702397fad&filter%5Bstatus%5D=expected&stats%5Binventory_breakdown_type%5D%5B%5D=sum&stats%5Bstarted%5D%5B%5D=sum&stats%5Bstatus%5D%5B%5D=sum&stats%5Bstock_count%5D%5B%5D=sum' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "e05ca7ec-e0d3-40cc-a9d2-7a3a477f967e",
      "type": "inventory_breakdowns",
      "attributes": {
        "from": "1989-03-11T20:00:00.000000+00:00",
        "stock_count": 12,
        "status": "expected",
        "inventory_breakdown_type": "regular",
        "location_id": "7b80bea8-6212-4041-ba59-38501f294d91",
        "product_id": "5c19132c-1b68-4c51-8b8f-3f52884883af"
      },
      "relationships": {}
    },
    {
      "id": "588c4fd8-e27b-41b1-8a93-6f8098377f1b",
      "type": "inventory_breakdowns",
      "attributes": {
        "from": "1989-03-11T20:00:00.000000+00:00",
        "till": "1989-04-11T20:00:00.000000+00:00",
        "stock_count": 5,
        "status": "expected",
        "inventory_breakdown_type": "temporary",
        "location_id": "7b80bea8-6212-4041-ba59-38501f294d91",
        "product_id": "5c19132c-1b68-4c51-8b8f-3f52884883af"
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
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/inventory_breakdowns?filter%5Bproduct_group_id%5D=36eaee12-61e8-49c4-b41b-bf401d65e693&filter%5Bstatus%5D=expired&stats%5Binventory_breakdown_type%5D%5B%5D=sum&stats%5Bstarted%5D%5B%5D=sum&stats%5Bstatus%5D%5B%5D=sum&stats%5Bstock_count%5D%5B%5D=sum' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "601e886e-5af7-4bcf-b65c-c64640634644",
      "type": "inventory_breakdowns",
      "attributes": {
        "till": "1988-02-11T20:00:00.000000+00:00",
        "stock_count": 22,
        "status": "expired",
        "inventory_breakdown_type": "temporary",
        "location_id": "417511d9-0ec2-4522-a66e-4d537f48131e",
        "product_id": "bd3d00c0-d21a-4404-91a2-c49a2c82b288"
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
`include` | **String** <br>List of comma seperated relationships `?include=location,product`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[inventory_breakdowns]=from,till,stock_count`
`filter` | **Hash** <br>The filters to apply `?filter[attribute][eq]=value`
`sort` | **String** <br>How to sort the data `?sort=attribute1,-attribute2`
`meta` | **Hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String** <br>The page to request
`page[size]` | **String** <br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
-- | --
`status` | **String** `required`<br>`eq`
`inventory_breakdown_type` | **String** <br>`eq`
`location_id` | **Uuid** <br>`eq`
`product_id` | **Uuid** <br>`eq`
`product_group_id` | **Uuid** <br>`eq`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **Array** <br>`count`
`status` | **Array** <br>`sum`
`inventory_breakdown_type` | **Array** <br>`sum`
`stock_count` | **Array** <br>`sum`, `count`
`started` | **Array** <br>`sum`


### Includes

This request accepts the following includes:

`location`


`product` => 
`photo`







