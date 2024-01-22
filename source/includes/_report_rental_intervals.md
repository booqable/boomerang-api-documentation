# Report rental intervals

Breakdown of how many times a product was rented during a specific period.

## Fields
Every report rental interval has the following fields:

Name | Description
-- | --
`id` | **Uuid** `readonly`<br>
`date` | **Date** <br>Interval date
`rented_count` | **Integer** <br>Times the product was rented
`interval` | **String** <br>The interval of the breakdown
`product_id` | **Uuid** <br>The associated Product


## Relationships
Report rental intervals have the following relationships:

Name | Description
-- | --
`product` | **Products** `readonly`<br>Associated Product


## Listing performance for a rental product per interval



> How to fetch performance per interval for a product:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2024-01-12+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=3a1bc13f-03c5-4ffc-8e34-10db93c22711&filter%5Btill%5D=2024-01-21+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "9dd51b1b-1143-4ec5-9cae-707b40a81729",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-01-12",
        "rented_count": 0,
        "interval": "day",
        "product_id": "3a1bc13f-03c5-4ffc-8e34-10db93c22711"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/3a1bc13f-03c5-4ffc-8e34-10db93c22711"
          }
        }
      }
    },
    {
      "id": "d9f0b253-6677-482e-ba39-cb1f2dfa2312",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-01-13",
        "rented_count": 0,
        "interval": "day",
        "product_id": "3a1bc13f-03c5-4ffc-8e34-10db93c22711"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/3a1bc13f-03c5-4ffc-8e34-10db93c22711"
          }
        }
      }
    },
    {
      "id": "84d09149-c233-411e-b95a-604545d9ba16",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-01-14",
        "rented_count": 0,
        "interval": "day",
        "product_id": "3a1bc13f-03c5-4ffc-8e34-10db93c22711"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/3a1bc13f-03c5-4ffc-8e34-10db93c22711"
          }
        }
      }
    },
    {
      "id": "667fa6c9-4e40-4474-89c8-2b540ef599d2",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-01-15",
        "rented_count": 0,
        "interval": "day",
        "product_id": "3a1bc13f-03c5-4ffc-8e34-10db93c22711"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/3a1bc13f-03c5-4ffc-8e34-10db93c22711"
          }
        }
      }
    },
    {
      "id": "951e3e74-ebff-41bf-aed5-e8f3dab46004",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-01-16",
        "rented_count": 1,
        "interval": "day",
        "product_id": "3a1bc13f-03c5-4ffc-8e34-10db93c22711"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/3a1bc13f-03c5-4ffc-8e34-10db93c22711"
          }
        }
      }
    },
    {
      "id": "e98e9319-8e29-4920-9a9b-19370a0c0fb4",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-01-17",
        "rented_count": 0,
        "interval": "day",
        "product_id": "3a1bc13f-03c5-4ffc-8e34-10db93c22711"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/3a1bc13f-03c5-4ffc-8e34-10db93c22711"
          }
        }
      }
    },
    {
      "id": "5c1d3152-4889-40dd-b811-96c2786bc1bd",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-01-18",
        "rented_count": 1,
        "interval": "day",
        "product_id": "3a1bc13f-03c5-4ffc-8e34-10db93c22711"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/3a1bc13f-03c5-4ffc-8e34-10db93c22711"
          }
        }
      }
    },
    {
      "id": "29b1296f-edcc-4b5e-9e71-7850d182c5ff",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-01-19",
        "rented_count": 0,
        "interval": "day",
        "product_id": "3a1bc13f-03c5-4ffc-8e34-10db93c22711"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/3a1bc13f-03c5-4ffc-8e34-10db93c22711"
          }
        }
      }
    },
    {
      "id": "2de603fc-1904-4001-8dfd-9355685d76d4",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-01-20",
        "rented_count": 1,
        "interval": "day",
        "product_id": "3a1bc13f-03c5-4ffc-8e34-10db93c22711"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/3a1bc13f-03c5-4ffc-8e34-10db93c22711"
          }
        }
      }
    },
    {
      "id": "07b43168-5b6f-48b7-8d18-417c0ee619c6",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-01-21",
        "rented_count": 0,
        "interval": "day",
        "product_id": "3a1bc13f-03c5-4ffc-8e34-10db93c22711"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/3a1bc13f-03c5-4ffc-8e34-10db93c22711"
          }
        }
      }
    }
  ],
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/report_rental_intervals`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=product`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[report_rental_intervals]=date,rented_count,interval`
`filter` | **Hash** <br>The filters to apply `?filter[attribute][eq]=value`
`sort` | **String** <br>How to sort the data `?sort=attribute1,-attribute2`
`meta` | **Hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String** <br>The page to request
`page[size]` | **String** <br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
-- | --
`product_id` | **Uuid** `required`<br>`eq`
`from` | **Datetime** <br>`eq`
`till` | **Datetime** <br>`eq`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **Array** <br>`count`


### Includes

This request accepts the following includes:

`product` => 
`photo`







