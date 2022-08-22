# Report rental intervals

Breakdown of how many times a product was rented during a specific period.

## Fields
Every report rental interval has the following fields:

Name | Description
- | -
`id` | **Uuid** `readonly`<br>
`date` | **Date**<br>Interval date
`rented_count` | **Integer**<br>Times the product was rented
`interval` | **String**<br>The interval of the breakdown
`product_id` | **Uuid**<br>The associated Product


## Relationships
Report rental intervals have the following relationships:

Name | Description
- | -
`product` | **Products** `readonly`<br>Associated Product


## Listing performance for a rental product per interval



> How to fetch performance per interval for a product:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2022-08-12+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=b75ddff1-df91-40ae-bedf-05b0375a2220&filter%5Btill%5D=2022-08-21+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-00c898a0-0445-5cf5-baf2-33c4323233da",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-08-12",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b75ddff1-df91-40ae-bedf-05b0375a2220"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b75ddff1-df91-40ae-bedf-05b0375a2220"
          }
        }
      }
    },
    {
      "id": "virtual-7be47b00-881b-5dd0-b209-293ab14c12f8",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-08-13",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b75ddff1-df91-40ae-bedf-05b0375a2220"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b75ddff1-df91-40ae-bedf-05b0375a2220"
          }
        }
      }
    },
    {
      "id": "virtual-b35fe81a-67fa-5044-9392-39292375a98c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-08-14",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b75ddff1-df91-40ae-bedf-05b0375a2220"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b75ddff1-df91-40ae-bedf-05b0375a2220"
          }
        }
      }
    },
    {
      "id": "virtual-fc32216e-fd30-58f7-b2f5-5d79bda98911",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-08-15",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b75ddff1-df91-40ae-bedf-05b0375a2220"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b75ddff1-df91-40ae-bedf-05b0375a2220"
          }
        }
      }
    },
    {
      "id": "virtual-77237754-8cc1-533d-981e-2e7bb4fc2cc7",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-08-16",
        "rented_count": 1,
        "interval": "day",
        "product_id": "b75ddff1-df91-40ae-bedf-05b0375a2220"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b75ddff1-df91-40ae-bedf-05b0375a2220"
          }
        }
      }
    },
    {
      "id": "virtual-a41e6f47-de49-5ca5-9042-dc633721d9bc",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-08-17",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b75ddff1-df91-40ae-bedf-05b0375a2220"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b75ddff1-df91-40ae-bedf-05b0375a2220"
          }
        }
      }
    },
    {
      "id": "virtual-38659951-785e-5f09-b377-07544fb5f71c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-08-18",
        "rented_count": 1,
        "interval": "day",
        "product_id": "b75ddff1-df91-40ae-bedf-05b0375a2220"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b75ddff1-df91-40ae-bedf-05b0375a2220"
          }
        }
      }
    },
    {
      "id": "virtual-371943ec-a69b-5136-855b-011d7b0556fe",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-08-19",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b75ddff1-df91-40ae-bedf-05b0375a2220"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b75ddff1-df91-40ae-bedf-05b0375a2220"
          }
        }
      }
    },
    {
      "id": "virtual-fce29fc9-6db0-5e8a-95f6-5d381e5ce94d",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-08-20",
        "rented_count": 1,
        "interval": "day",
        "product_id": "b75ddff1-df91-40ae-bedf-05b0375a2220"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b75ddff1-df91-40ae-bedf-05b0375a2220"
          }
        }
      }
    },
    {
      "id": "virtual-9c148232-ca57-5424-977a-82e85e0d3719",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-08-21",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b75ddff1-df91-40ae-bedf-05b0375a2220"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b75ddff1-df91-40ae-bedf-05b0375a2220"
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=product`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[report_rental_intervals]=id,created_at,updated_at`
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-08-22T15:50:07Z`
`sort` | **String**<br>How to sort the data `?sort=-created_at`
`meta` | **Hash**<br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String**<br>The page to request
`page[size]` | **String**<br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
`product_id` | **Uuid** `required`<br>`eq`
`from` | **Datetime**<br>`eq`
`till` | **Datetime**<br>`eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array**<br>`count`


### Includes

This request accepts the following includes:

`product` => 
`photo`







