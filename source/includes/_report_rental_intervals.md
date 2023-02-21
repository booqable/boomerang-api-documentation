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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-02-11+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=4c3fcc79-24af-4184-8160-d6f4ff2c345c&filter%5Btill%5D=2023-02-20+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-daf17f32-0a9d-5ebf-afc7-19932009f776",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-11",
        "rented_count": 0,
        "interval": "day",
        "product_id": "4c3fcc79-24af-4184-8160-d6f4ff2c345c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4c3fcc79-24af-4184-8160-d6f4ff2c345c"
          }
        }
      }
    },
    {
      "id": "virtual-3cb63b45-03f2-51ff-aca1-788b7f1c6055",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-12",
        "rented_count": 0,
        "interval": "day",
        "product_id": "4c3fcc79-24af-4184-8160-d6f4ff2c345c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4c3fcc79-24af-4184-8160-d6f4ff2c345c"
          }
        }
      }
    },
    {
      "id": "virtual-44f2e6d1-cb6d-50fb-9bf4-8bc6bf242118",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-13",
        "rented_count": 0,
        "interval": "day",
        "product_id": "4c3fcc79-24af-4184-8160-d6f4ff2c345c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4c3fcc79-24af-4184-8160-d6f4ff2c345c"
          }
        }
      }
    },
    {
      "id": "virtual-abf132a3-8520-52ce-a69e-462c8b09ed33",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-14",
        "rented_count": 0,
        "interval": "day",
        "product_id": "4c3fcc79-24af-4184-8160-d6f4ff2c345c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4c3fcc79-24af-4184-8160-d6f4ff2c345c"
          }
        }
      }
    },
    {
      "id": "virtual-221c2f1d-615d-5051-9a4a-d5854c2a09f4",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-15",
        "rented_count": 1,
        "interval": "day",
        "product_id": "4c3fcc79-24af-4184-8160-d6f4ff2c345c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4c3fcc79-24af-4184-8160-d6f4ff2c345c"
          }
        }
      }
    },
    {
      "id": "virtual-ea4cb6a6-c531-5463-b2fd-b9a1121d0081",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-16",
        "rented_count": 0,
        "interval": "day",
        "product_id": "4c3fcc79-24af-4184-8160-d6f4ff2c345c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4c3fcc79-24af-4184-8160-d6f4ff2c345c"
          }
        }
      }
    },
    {
      "id": "virtual-c4babe0b-12d2-525f-b5c5-41b5c1e58ec6",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-17",
        "rented_count": 1,
        "interval": "day",
        "product_id": "4c3fcc79-24af-4184-8160-d6f4ff2c345c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4c3fcc79-24af-4184-8160-d6f4ff2c345c"
          }
        }
      }
    },
    {
      "id": "virtual-c454831d-60a8-5b35-b038-8d957ea79e2a",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-18",
        "rented_count": 0,
        "interval": "day",
        "product_id": "4c3fcc79-24af-4184-8160-d6f4ff2c345c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4c3fcc79-24af-4184-8160-d6f4ff2c345c"
          }
        }
      }
    },
    {
      "id": "virtual-3429ecfa-b602-5c21-975a-2ba79b68790b",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-19",
        "rented_count": 1,
        "interval": "day",
        "product_id": "4c3fcc79-24af-4184-8160-d6f4ff2c345c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4c3fcc79-24af-4184-8160-d6f4ff2c345c"
          }
        }
      }
    },
    {
      "id": "virtual-3f05899f-8d93-5917-b47e-2b093e4f18c3",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-20",
        "rented_count": 0,
        "interval": "day",
        "product_id": "4c3fcc79-24af-4184-8160-d6f4ff2c345c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4c3fcc79-24af-4184-8160-d6f4ff2c345c"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-21T10:47:38Z`
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







