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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-05-05+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=891896b1-a21e-4a0c-8d3e-4fc7208ce683&filter%5Btill%5D=2023-05-14+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-41ecb70b-3e0d-5053-9f75-6fcd9b3a51e3",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-05-05",
        "rented_count": 0,
        "interval": "day",
        "product_id": "891896b1-a21e-4a0c-8d3e-4fc7208ce683"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/891896b1-a21e-4a0c-8d3e-4fc7208ce683"
          }
        }
      }
    },
    {
      "id": "virtual-4193a003-b539-504d-9839-552fd8e2a125",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-05-06",
        "rented_count": 0,
        "interval": "day",
        "product_id": "891896b1-a21e-4a0c-8d3e-4fc7208ce683"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/891896b1-a21e-4a0c-8d3e-4fc7208ce683"
          }
        }
      }
    },
    {
      "id": "virtual-78e81f1f-46b9-53c3-8afe-c5a936f8078e",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-05-07",
        "rented_count": 0,
        "interval": "day",
        "product_id": "891896b1-a21e-4a0c-8d3e-4fc7208ce683"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/891896b1-a21e-4a0c-8d3e-4fc7208ce683"
          }
        }
      }
    },
    {
      "id": "virtual-b866da20-cdc1-563f-9158-88050cb96566",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-05-08",
        "rented_count": 0,
        "interval": "day",
        "product_id": "891896b1-a21e-4a0c-8d3e-4fc7208ce683"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/891896b1-a21e-4a0c-8d3e-4fc7208ce683"
          }
        }
      }
    },
    {
      "id": "virtual-4da061ac-15ce-5b4f-bdc1-5e3ec8ca04ac",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-05-09",
        "rented_count": 1,
        "interval": "day",
        "product_id": "891896b1-a21e-4a0c-8d3e-4fc7208ce683"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/891896b1-a21e-4a0c-8d3e-4fc7208ce683"
          }
        }
      }
    },
    {
      "id": "virtual-736ee0ad-df6d-52b7-884a-46ee5e239a4a",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-05-10",
        "rented_count": 0,
        "interval": "day",
        "product_id": "891896b1-a21e-4a0c-8d3e-4fc7208ce683"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/891896b1-a21e-4a0c-8d3e-4fc7208ce683"
          }
        }
      }
    },
    {
      "id": "virtual-2fa5fcc1-628d-50e8-b84c-b8d9044517b9",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-05-11",
        "rented_count": 1,
        "interval": "day",
        "product_id": "891896b1-a21e-4a0c-8d3e-4fc7208ce683"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/891896b1-a21e-4a0c-8d3e-4fc7208ce683"
          }
        }
      }
    },
    {
      "id": "virtual-ff17ce3d-476b-5577-8dfc-d9166602eb90",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-05-12",
        "rented_count": 0,
        "interval": "day",
        "product_id": "891896b1-a21e-4a0c-8d3e-4fc7208ce683"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/891896b1-a21e-4a0c-8d3e-4fc7208ce683"
          }
        }
      }
    },
    {
      "id": "virtual-f4ec3afb-30bb-560c-bf2e-ffd1926741ea",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-05-13",
        "rented_count": 1,
        "interval": "day",
        "product_id": "891896b1-a21e-4a0c-8d3e-4fc7208ce683"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/891896b1-a21e-4a0c-8d3e-4fc7208ce683"
          }
        }
      }
    },
    {
      "id": "virtual-539f81c4-1b35-5457-b75a-a5269255173f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-05-14",
        "rented_count": 0,
        "interval": "day",
        "product_id": "891896b1-a21e-4a0c-8d3e-4fc7208ce683"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/891896b1-a21e-4a0c-8d3e-4fc7208ce683"
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







