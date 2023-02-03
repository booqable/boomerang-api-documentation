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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-01-24+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=11376fb1-f945-400f-a4db-52666646a906&filter%5Btill%5D=2023-02-02+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-21f6637c-b746-5ff5-a36c-f85a64fb68a1",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-24",
        "rented_count": 0,
        "interval": "day",
        "product_id": "11376fb1-f945-400f-a4db-52666646a906"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/11376fb1-f945-400f-a4db-52666646a906"
          }
        }
      }
    },
    {
      "id": "virtual-43a27ef7-7d24-5472-914b-91e1cc903b00",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-25",
        "rented_count": 0,
        "interval": "day",
        "product_id": "11376fb1-f945-400f-a4db-52666646a906"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/11376fb1-f945-400f-a4db-52666646a906"
          }
        }
      }
    },
    {
      "id": "virtual-f7040b77-6d21-5774-b793-7b7ec72668d7",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-26",
        "rented_count": 0,
        "interval": "day",
        "product_id": "11376fb1-f945-400f-a4db-52666646a906"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/11376fb1-f945-400f-a4db-52666646a906"
          }
        }
      }
    },
    {
      "id": "virtual-1e6d93f5-3947-53cd-be48-ed5354175b80",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-27",
        "rented_count": 0,
        "interval": "day",
        "product_id": "11376fb1-f945-400f-a4db-52666646a906"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/11376fb1-f945-400f-a4db-52666646a906"
          }
        }
      }
    },
    {
      "id": "virtual-06e4006c-f0bb-55ae-8405-dc40f4957b9b",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-28",
        "rented_count": 1,
        "interval": "day",
        "product_id": "11376fb1-f945-400f-a4db-52666646a906"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/11376fb1-f945-400f-a4db-52666646a906"
          }
        }
      }
    },
    {
      "id": "virtual-0cdebda5-8bac-5644-9ee2-f8984031ca56",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-29",
        "rented_count": 0,
        "interval": "day",
        "product_id": "11376fb1-f945-400f-a4db-52666646a906"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/11376fb1-f945-400f-a4db-52666646a906"
          }
        }
      }
    },
    {
      "id": "virtual-63ea9c5b-4508-5aeb-9d7f-b4030eb84454",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-30",
        "rented_count": 1,
        "interval": "day",
        "product_id": "11376fb1-f945-400f-a4db-52666646a906"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/11376fb1-f945-400f-a4db-52666646a906"
          }
        }
      }
    },
    {
      "id": "virtual-7f2dd84d-0016-5e73-8a69-59e451d6fe91",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-31",
        "rented_count": 0,
        "interval": "day",
        "product_id": "11376fb1-f945-400f-a4db-52666646a906"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/11376fb1-f945-400f-a4db-52666646a906"
          }
        }
      }
    },
    {
      "id": "virtual-6866f92b-607b-51d3-bd55-f090dc4694aa",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-01",
        "rented_count": 1,
        "interval": "day",
        "product_id": "11376fb1-f945-400f-a4db-52666646a906"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/11376fb1-f945-400f-a4db-52666646a906"
          }
        }
      }
    },
    {
      "id": "virtual-b2d6942c-ab30-549b-8f0c-d651163a6a9f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-02",
        "rented_count": 0,
        "interval": "day",
        "product_id": "11376fb1-f945-400f-a4db-52666646a906"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/11376fb1-f945-400f-a4db-52666646a906"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-03T13:08:12Z`
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







