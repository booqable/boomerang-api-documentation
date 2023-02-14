# Report rental intervals

Breakdown of how many times a product was rented during a specific period.

## Fields
Every report rental interval has the following fields:

Name | Description
- | -
`id` | **Uuid** `readonly`<br>
`date` | **Date** <br>Interval date
`rented_count` | **Integer** <br>Times the product was rented
`interval` | **String** <br>The interval of the breakdown
`product_id` | **Uuid** <br>The associated Product


## Relationships
Report rental intervals have the following relationships:

Name | Description
- | -
`product` | **Products** `readonly`<br>Associated Product


## Listing performance for a rental product per interval



> How to fetch performance per interval for a product:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-02-04+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=fb821d4c-9318-4a90-bb53-8eca1cc234bd&filter%5Btill%5D=2023-02-13+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-98e76894-edbe-518c-a541-765dbeeadef6",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-04",
        "rented_count": 0,
        "interval": "day",
        "product_id": "fb821d4c-9318-4a90-bb53-8eca1cc234bd"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/fb821d4c-9318-4a90-bb53-8eca1cc234bd"
          }
        }
      }
    },
    {
      "id": "virtual-ca0e6778-69e2-5cc4-a255-811a9baab538",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-05",
        "rented_count": 0,
        "interval": "day",
        "product_id": "fb821d4c-9318-4a90-bb53-8eca1cc234bd"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/fb821d4c-9318-4a90-bb53-8eca1cc234bd"
          }
        }
      }
    },
    {
      "id": "virtual-ec0e87fa-77f3-51a1-b5a9-511eeed4ca35",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-06",
        "rented_count": 0,
        "interval": "day",
        "product_id": "fb821d4c-9318-4a90-bb53-8eca1cc234bd"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/fb821d4c-9318-4a90-bb53-8eca1cc234bd"
          }
        }
      }
    },
    {
      "id": "virtual-a2ca6e43-19f0-5dd1-9c30-357dddf774c7",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-07",
        "rented_count": 0,
        "interval": "day",
        "product_id": "fb821d4c-9318-4a90-bb53-8eca1cc234bd"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/fb821d4c-9318-4a90-bb53-8eca1cc234bd"
          }
        }
      }
    },
    {
      "id": "virtual-7d239be7-0fad-51bc-b137-8713647d9968",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-08",
        "rented_count": 1,
        "interval": "day",
        "product_id": "fb821d4c-9318-4a90-bb53-8eca1cc234bd"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/fb821d4c-9318-4a90-bb53-8eca1cc234bd"
          }
        }
      }
    },
    {
      "id": "virtual-92c208c0-ec9e-584c-96a2-01a0f5743538",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-09",
        "rented_count": 0,
        "interval": "day",
        "product_id": "fb821d4c-9318-4a90-bb53-8eca1cc234bd"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/fb821d4c-9318-4a90-bb53-8eca1cc234bd"
          }
        }
      }
    },
    {
      "id": "virtual-01d6c3fd-11f7-5d19-bb98-986d380373d5",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-10",
        "rented_count": 1,
        "interval": "day",
        "product_id": "fb821d4c-9318-4a90-bb53-8eca1cc234bd"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/fb821d4c-9318-4a90-bb53-8eca1cc234bd"
          }
        }
      }
    },
    {
      "id": "virtual-cb5cebb8-c7d8-53d8-95fe-3e8ce58984d3",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-11",
        "rented_count": 0,
        "interval": "day",
        "product_id": "fb821d4c-9318-4a90-bb53-8eca1cc234bd"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/fb821d4c-9318-4a90-bb53-8eca1cc234bd"
          }
        }
      }
    },
    {
      "id": "virtual-a6bc574e-5156-57f8-8eb7-8c64d4ee6179",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-12",
        "rented_count": 1,
        "interval": "day",
        "product_id": "fb821d4c-9318-4a90-bb53-8eca1cc234bd"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/fb821d4c-9318-4a90-bb53-8eca1cc234bd"
          }
        }
      }
    },
    {
      "id": "virtual-89b415d6-30ca-5907-8a31-9616b116080b",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-13",
        "rented_count": 0,
        "interval": "day",
        "product_id": "fb821d4c-9318-4a90-bb53-8eca1cc234bd"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/fb821d4c-9318-4a90-bb53-8eca1cc234bd"
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
- | -
`include` | **String** <br>List of comma seperated relationships `?include=product`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[report_rental_intervals]=id,created_at,updated_at`
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-14T15:25:59Z`
`sort` | **String** <br>How to sort the data `?sort=-created_at`
`meta` | **Hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String** <br>The page to request
`page[size]` | **String** <br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
`product_id` | **Uuid** `required`<br>`eq`
`from` | **Datetime** <br>`eq`
`till` | **Datetime** <br>`eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array** <br>`count`


### Includes

This request accepts the following includes:

`product` => 
`photo`







