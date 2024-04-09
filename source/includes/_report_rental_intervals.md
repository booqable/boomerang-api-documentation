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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2024-03-30+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=0abdc0a0-e3f7-4098-ad5f-18bd37cd7421&filter%5Btill%5D=2024-04-08+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "406c44a7-7459-4b3f-8f13-5457df60c730",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-03-30",
        "rented_count": 0,
        "interval": "day",
        "product_id": "0abdc0a0-e3f7-4098-ad5f-18bd37cd7421"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/0abdc0a0-e3f7-4098-ad5f-18bd37cd7421"
          }
        }
      }
    },
    {
      "id": "13ba225f-6616-431b-8106-a0d0d4f32b38",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-03-31",
        "rented_count": 0,
        "interval": "day",
        "product_id": "0abdc0a0-e3f7-4098-ad5f-18bd37cd7421"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/0abdc0a0-e3f7-4098-ad5f-18bd37cd7421"
          }
        }
      }
    },
    {
      "id": "3cd9f186-7ad5-4a31-8c45-4ae5ee379a4a",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-04-01",
        "rented_count": 0,
        "interval": "day",
        "product_id": "0abdc0a0-e3f7-4098-ad5f-18bd37cd7421"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/0abdc0a0-e3f7-4098-ad5f-18bd37cd7421"
          }
        }
      }
    },
    {
      "id": "4ce7dab5-307c-4f61-9c53-0c0789b4e4e4",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-04-02",
        "rented_count": 0,
        "interval": "day",
        "product_id": "0abdc0a0-e3f7-4098-ad5f-18bd37cd7421"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/0abdc0a0-e3f7-4098-ad5f-18bd37cd7421"
          }
        }
      }
    },
    {
      "id": "842b188c-b8e1-4d7a-99e3-34db52249e70",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-04-03",
        "rented_count": 1,
        "interval": "day",
        "product_id": "0abdc0a0-e3f7-4098-ad5f-18bd37cd7421"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/0abdc0a0-e3f7-4098-ad5f-18bd37cd7421"
          }
        }
      }
    },
    {
      "id": "6de929e4-95cd-4d14-aa24-e45df091a69b",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-04-04",
        "rented_count": 0,
        "interval": "day",
        "product_id": "0abdc0a0-e3f7-4098-ad5f-18bd37cd7421"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/0abdc0a0-e3f7-4098-ad5f-18bd37cd7421"
          }
        }
      }
    },
    {
      "id": "749c9aec-d92a-4e70-b086-bad6fac72740",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-04-05",
        "rented_count": 1,
        "interval": "day",
        "product_id": "0abdc0a0-e3f7-4098-ad5f-18bd37cd7421"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/0abdc0a0-e3f7-4098-ad5f-18bd37cd7421"
          }
        }
      }
    },
    {
      "id": "ff767fdb-6767-400f-9f01-4fc3c49c3337",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-04-06",
        "rented_count": 0,
        "interval": "day",
        "product_id": "0abdc0a0-e3f7-4098-ad5f-18bd37cd7421"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/0abdc0a0-e3f7-4098-ad5f-18bd37cd7421"
          }
        }
      }
    },
    {
      "id": "6017a14c-c823-4eb7-8d8b-cb1d8a0bf02b",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-04-07",
        "rented_count": 1,
        "interval": "day",
        "product_id": "0abdc0a0-e3f7-4098-ad5f-18bd37cd7421"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/0abdc0a0-e3f7-4098-ad5f-18bd37cd7421"
          }
        }
      }
    },
    {
      "id": "0fdff648-99c5-4888-abc6-cdda76514bdc",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-04-08",
        "rented_count": 0,
        "interval": "day",
        "product_id": "0abdc0a0-e3f7-4098-ad5f-18bd37cd7421"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/0abdc0a0-e3f7-4098-ad5f-18bd37cd7421"
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







