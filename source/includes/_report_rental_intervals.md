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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2022-10-03+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=fe881f06-e5c0-4a0c-95b0-47625adf1823&filter%5Btill%5D=2022-10-12+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-e53d9c44-8745-5e95-ad86-fededf1f037b",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-03",
        "rented_count": 0,
        "interval": "day",
        "product_id": "fe881f06-e5c0-4a0c-95b0-47625adf1823"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/fe881f06-e5c0-4a0c-95b0-47625adf1823"
          }
        }
      }
    },
    {
      "id": "virtual-7dd45bc0-520e-5b78-88a7-9a6dbdf8d4e3",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-04",
        "rented_count": 0,
        "interval": "day",
        "product_id": "fe881f06-e5c0-4a0c-95b0-47625adf1823"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/fe881f06-e5c0-4a0c-95b0-47625adf1823"
          }
        }
      }
    },
    {
      "id": "virtual-212a72de-0047-5313-9866-788cc9098e8b",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-05",
        "rented_count": 0,
        "interval": "day",
        "product_id": "fe881f06-e5c0-4a0c-95b0-47625adf1823"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/fe881f06-e5c0-4a0c-95b0-47625adf1823"
          }
        }
      }
    },
    {
      "id": "virtual-88de943b-ea71-5b71-94e0-5abb4a9a21d6",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-06",
        "rented_count": 0,
        "interval": "day",
        "product_id": "fe881f06-e5c0-4a0c-95b0-47625adf1823"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/fe881f06-e5c0-4a0c-95b0-47625adf1823"
          }
        }
      }
    },
    {
      "id": "virtual-844038c7-20cf-5414-90f0-d7729c2ea842",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-07",
        "rented_count": 1,
        "interval": "day",
        "product_id": "fe881f06-e5c0-4a0c-95b0-47625adf1823"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/fe881f06-e5c0-4a0c-95b0-47625adf1823"
          }
        }
      }
    },
    {
      "id": "virtual-9d192e63-3588-55ff-ad80-7d32b4bf128f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-08",
        "rented_count": 0,
        "interval": "day",
        "product_id": "fe881f06-e5c0-4a0c-95b0-47625adf1823"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/fe881f06-e5c0-4a0c-95b0-47625adf1823"
          }
        }
      }
    },
    {
      "id": "virtual-ec8660b2-0896-5981-bba9-0bc884b83b11",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-09",
        "rented_count": 1,
        "interval": "day",
        "product_id": "fe881f06-e5c0-4a0c-95b0-47625adf1823"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/fe881f06-e5c0-4a0c-95b0-47625adf1823"
          }
        }
      }
    },
    {
      "id": "virtual-f1285d10-f2b8-5d3b-8af5-1014a379d287",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-10",
        "rented_count": 0,
        "interval": "day",
        "product_id": "fe881f06-e5c0-4a0c-95b0-47625adf1823"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/fe881f06-e5c0-4a0c-95b0-47625adf1823"
          }
        }
      }
    },
    {
      "id": "virtual-699fb2cc-f283-5f8d-a47b-ab0b30f3a4b5",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-11",
        "rented_count": 1,
        "interval": "day",
        "product_id": "fe881f06-e5c0-4a0c-95b0-47625adf1823"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/fe881f06-e5c0-4a0c-95b0-47625adf1823"
          }
        }
      }
    },
    {
      "id": "virtual-423d7bc0-b821-5833-b379-c8f452e6e16f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-12",
        "rented_count": 0,
        "interval": "day",
        "product_id": "fe881f06-e5c0-4a0c-95b0-47625adf1823"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/fe881f06-e5c0-4a0c-95b0-47625adf1823"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-10-13T14:28:03Z`
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







