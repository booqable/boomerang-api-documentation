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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-11-27+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=051acc16-e33a-4d18-8397-7aaf7e43bc64&filter%5Btill%5D=2023-12-06+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "6fe2e76d-4ce3-478b-86b1-2b179fb93179",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-11-27",
        "rented_count": 0,
        "interval": "day",
        "product_id": "051acc16-e33a-4d18-8397-7aaf7e43bc64"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/051acc16-e33a-4d18-8397-7aaf7e43bc64"
          }
        }
      }
    },
    {
      "id": "787e9187-22b0-486a-b80b-56f06a80ddc8",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-11-28",
        "rented_count": 0,
        "interval": "day",
        "product_id": "051acc16-e33a-4d18-8397-7aaf7e43bc64"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/051acc16-e33a-4d18-8397-7aaf7e43bc64"
          }
        }
      }
    },
    {
      "id": "257d5c4e-ba61-4509-9ff4-1c020265dfec",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-11-29",
        "rented_count": 0,
        "interval": "day",
        "product_id": "051acc16-e33a-4d18-8397-7aaf7e43bc64"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/051acc16-e33a-4d18-8397-7aaf7e43bc64"
          }
        }
      }
    },
    {
      "id": "2238f202-09c6-42f8-9f9c-182dcb740aa9",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-11-30",
        "rented_count": 0,
        "interval": "day",
        "product_id": "051acc16-e33a-4d18-8397-7aaf7e43bc64"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/051acc16-e33a-4d18-8397-7aaf7e43bc64"
          }
        }
      }
    },
    {
      "id": "16ac61e0-64c3-455e-91ba-b9fb47b30769",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-12-01",
        "rented_count": 1,
        "interval": "day",
        "product_id": "051acc16-e33a-4d18-8397-7aaf7e43bc64"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/051acc16-e33a-4d18-8397-7aaf7e43bc64"
          }
        }
      }
    },
    {
      "id": "63ae1abe-b853-417b-ada9-761d80deb030",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-12-02",
        "rented_count": 0,
        "interval": "day",
        "product_id": "051acc16-e33a-4d18-8397-7aaf7e43bc64"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/051acc16-e33a-4d18-8397-7aaf7e43bc64"
          }
        }
      }
    },
    {
      "id": "ddf74233-dde8-438e-879f-fa700e7bc38d",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-12-03",
        "rented_count": 1,
        "interval": "day",
        "product_id": "051acc16-e33a-4d18-8397-7aaf7e43bc64"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/051acc16-e33a-4d18-8397-7aaf7e43bc64"
          }
        }
      }
    },
    {
      "id": "727fabf6-3388-40ec-bb14-4e40e1fbfd1b",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-12-04",
        "rented_count": 0,
        "interval": "day",
        "product_id": "051acc16-e33a-4d18-8397-7aaf7e43bc64"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/051acc16-e33a-4d18-8397-7aaf7e43bc64"
          }
        }
      }
    },
    {
      "id": "2fad4faf-9ae9-4371-a3b9-bbd4d9705c04",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-12-05",
        "rented_count": 1,
        "interval": "day",
        "product_id": "051acc16-e33a-4d18-8397-7aaf7e43bc64"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/051acc16-e33a-4d18-8397-7aaf7e43bc64"
          }
        }
      }
    },
    {
      "id": "3e14df0b-27ac-4e05-a0eb-673e1254060b",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-12-06",
        "rented_count": 0,
        "interval": "day",
        "product_id": "051acc16-e33a-4d18-8397-7aaf7e43bc64"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/051acc16-e33a-4d18-8397-7aaf7e43bc64"
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







