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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2024-05-10+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=6982e3c1-d036-4ba2-b77f-7c5ae4d4cac1&filter%5Btill%5D=2024-05-19+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "6e7697b9-d4cc-47dc-85b5-5d671929fe34",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-05-10",
        "rented_count": 0,
        "interval": "day",
        "product_id": "6982e3c1-d036-4ba2-b77f-7c5ae4d4cac1"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/6982e3c1-d036-4ba2-b77f-7c5ae4d4cac1"
          }
        }
      }
    },
    {
      "id": "b8ef8d9c-203b-48bf-95e4-c2d68c585282",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-05-11",
        "rented_count": 0,
        "interval": "day",
        "product_id": "6982e3c1-d036-4ba2-b77f-7c5ae4d4cac1"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/6982e3c1-d036-4ba2-b77f-7c5ae4d4cac1"
          }
        }
      }
    },
    {
      "id": "aed5470b-35f2-4169-96b0-23ad3eb09958",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-05-12",
        "rented_count": 0,
        "interval": "day",
        "product_id": "6982e3c1-d036-4ba2-b77f-7c5ae4d4cac1"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/6982e3c1-d036-4ba2-b77f-7c5ae4d4cac1"
          }
        }
      }
    },
    {
      "id": "2be60e93-975a-44d8-aae0-0b0daf221358",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-05-13",
        "rented_count": 0,
        "interval": "day",
        "product_id": "6982e3c1-d036-4ba2-b77f-7c5ae4d4cac1"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/6982e3c1-d036-4ba2-b77f-7c5ae4d4cac1"
          }
        }
      }
    },
    {
      "id": "310db049-e3ce-4bff-91ef-d5c5342403e9",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-05-14",
        "rented_count": 1,
        "interval": "day",
        "product_id": "6982e3c1-d036-4ba2-b77f-7c5ae4d4cac1"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/6982e3c1-d036-4ba2-b77f-7c5ae4d4cac1"
          }
        }
      }
    },
    {
      "id": "8910db68-3062-4ff2-be80-5e494b409b71",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-05-15",
        "rented_count": 0,
        "interval": "day",
        "product_id": "6982e3c1-d036-4ba2-b77f-7c5ae4d4cac1"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/6982e3c1-d036-4ba2-b77f-7c5ae4d4cac1"
          }
        }
      }
    },
    {
      "id": "729efe5c-4016-406e-b700-1946fbeb6833",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-05-16",
        "rented_count": 1,
        "interval": "day",
        "product_id": "6982e3c1-d036-4ba2-b77f-7c5ae4d4cac1"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/6982e3c1-d036-4ba2-b77f-7c5ae4d4cac1"
          }
        }
      }
    },
    {
      "id": "5a6cadde-8169-454d-85f7-b1c33182aaf9",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-05-17",
        "rented_count": 0,
        "interval": "day",
        "product_id": "6982e3c1-d036-4ba2-b77f-7c5ae4d4cac1"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/6982e3c1-d036-4ba2-b77f-7c5ae4d4cac1"
          }
        }
      }
    },
    {
      "id": "54d30ec8-2b45-48fe-9108-3034f230640c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-05-18",
        "rented_count": 1,
        "interval": "day",
        "product_id": "6982e3c1-d036-4ba2-b77f-7c5ae4d4cac1"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/6982e3c1-d036-4ba2-b77f-7c5ae4d4cac1"
          }
        }
      }
    },
    {
      "id": "c57292f9-e5ec-482c-82e4-c02d4a8d26f5",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-05-19",
        "rented_count": 0,
        "interval": "day",
        "product_id": "6982e3c1-d036-4ba2-b77f-7c5ae4d4cac1"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/6982e3c1-d036-4ba2-b77f-7c5ae4d4cac1"
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







