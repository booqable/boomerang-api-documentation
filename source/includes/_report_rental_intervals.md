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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2022-11-28+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=502249d5-15c1-4af3-9fbd-d8ff6068b1b2&filter%5Btill%5D=2022-12-07+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-38679766-fa7f-554a-9e5d-5e9df9078e86",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-28",
        "rented_count": 0,
        "interval": "day",
        "product_id": "502249d5-15c1-4af3-9fbd-d8ff6068b1b2"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/502249d5-15c1-4af3-9fbd-d8ff6068b1b2"
          }
        }
      }
    },
    {
      "id": "virtual-58f758a9-3275-532a-92dd-7bb0580d01ad",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-29",
        "rented_count": 0,
        "interval": "day",
        "product_id": "502249d5-15c1-4af3-9fbd-d8ff6068b1b2"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/502249d5-15c1-4af3-9fbd-d8ff6068b1b2"
          }
        }
      }
    },
    {
      "id": "virtual-b5d29bf6-290c-512b-83e9-380027e599b6",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-30",
        "rented_count": 0,
        "interval": "day",
        "product_id": "502249d5-15c1-4af3-9fbd-d8ff6068b1b2"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/502249d5-15c1-4af3-9fbd-d8ff6068b1b2"
          }
        }
      }
    },
    {
      "id": "virtual-cdd90cb3-bbfc-5b52-b6f5-a2f6aef00c01",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-12-01",
        "rented_count": 0,
        "interval": "day",
        "product_id": "502249d5-15c1-4af3-9fbd-d8ff6068b1b2"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/502249d5-15c1-4af3-9fbd-d8ff6068b1b2"
          }
        }
      }
    },
    {
      "id": "virtual-d812ebc2-9b61-5af0-a519-5260de96ba60",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-12-02",
        "rented_count": 1,
        "interval": "day",
        "product_id": "502249d5-15c1-4af3-9fbd-d8ff6068b1b2"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/502249d5-15c1-4af3-9fbd-d8ff6068b1b2"
          }
        }
      }
    },
    {
      "id": "virtual-528e62c7-fa3d-5aab-9380-f5fc2a64cad5",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-12-03",
        "rented_count": 0,
        "interval": "day",
        "product_id": "502249d5-15c1-4af3-9fbd-d8ff6068b1b2"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/502249d5-15c1-4af3-9fbd-d8ff6068b1b2"
          }
        }
      }
    },
    {
      "id": "virtual-c4dff912-3868-5085-9d03-761db6da0030",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-12-04",
        "rented_count": 1,
        "interval": "day",
        "product_id": "502249d5-15c1-4af3-9fbd-d8ff6068b1b2"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/502249d5-15c1-4af3-9fbd-d8ff6068b1b2"
          }
        }
      }
    },
    {
      "id": "virtual-26fdf0e1-6d54-59c2-86a7-103f21dd61da",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-12-05",
        "rented_count": 0,
        "interval": "day",
        "product_id": "502249d5-15c1-4af3-9fbd-d8ff6068b1b2"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/502249d5-15c1-4af3-9fbd-d8ff6068b1b2"
          }
        }
      }
    },
    {
      "id": "virtual-2c5b333f-8e77-59d0-92a5-9ed4c5b137db",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-12-06",
        "rented_count": 1,
        "interval": "day",
        "product_id": "502249d5-15c1-4af3-9fbd-d8ff6068b1b2"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/502249d5-15c1-4af3-9fbd-d8ff6068b1b2"
          }
        }
      }
    },
    {
      "id": "virtual-c5312c3c-828e-5daa-9d06-77b13884b8e0",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-12-07",
        "rented_count": 0,
        "interval": "day",
        "product_id": "502249d5-15c1-4af3-9fbd-d8ff6068b1b2"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/502249d5-15c1-4af3-9fbd-d8ff6068b1b2"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-12-08T11:02:06Z`
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







