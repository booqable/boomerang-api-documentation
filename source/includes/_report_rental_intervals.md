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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-02-14+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=ded18bb4-64d1-410b-9d8f-9e0e8f76dea8&filter%5Btill%5D=2023-02-23+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-60d38bfc-27ca-5319-9eb7-e5c6748dc03a",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-14",
        "rented_count": 0,
        "interval": "day",
        "product_id": "ded18bb4-64d1-410b-9d8f-9e0e8f76dea8"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/ded18bb4-64d1-410b-9d8f-9e0e8f76dea8"
          }
        }
      }
    },
    {
      "id": "virtual-a7674117-7f1b-57eb-9b2d-be55fb12407c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-15",
        "rented_count": 0,
        "interval": "day",
        "product_id": "ded18bb4-64d1-410b-9d8f-9e0e8f76dea8"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/ded18bb4-64d1-410b-9d8f-9e0e8f76dea8"
          }
        }
      }
    },
    {
      "id": "virtual-c065137f-6773-5530-a95c-b3a711d6a7ec",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-16",
        "rented_count": 0,
        "interval": "day",
        "product_id": "ded18bb4-64d1-410b-9d8f-9e0e8f76dea8"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/ded18bb4-64d1-410b-9d8f-9e0e8f76dea8"
          }
        }
      }
    },
    {
      "id": "virtual-e70414d5-618e-5d6f-85d0-d480fbef45c5",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-17",
        "rented_count": 0,
        "interval": "day",
        "product_id": "ded18bb4-64d1-410b-9d8f-9e0e8f76dea8"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/ded18bb4-64d1-410b-9d8f-9e0e8f76dea8"
          }
        }
      }
    },
    {
      "id": "virtual-5107307e-fca2-5fa4-ba26-ac5c15ad0d4a",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-18",
        "rented_count": 1,
        "interval": "day",
        "product_id": "ded18bb4-64d1-410b-9d8f-9e0e8f76dea8"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/ded18bb4-64d1-410b-9d8f-9e0e8f76dea8"
          }
        }
      }
    },
    {
      "id": "virtual-c69cea8e-3174-5bfe-a4b4-68a943771608",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-19",
        "rented_count": 0,
        "interval": "day",
        "product_id": "ded18bb4-64d1-410b-9d8f-9e0e8f76dea8"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/ded18bb4-64d1-410b-9d8f-9e0e8f76dea8"
          }
        }
      }
    },
    {
      "id": "virtual-57a77064-f853-5357-9fe2-a8210bc63918",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-20",
        "rented_count": 1,
        "interval": "day",
        "product_id": "ded18bb4-64d1-410b-9d8f-9e0e8f76dea8"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/ded18bb4-64d1-410b-9d8f-9e0e8f76dea8"
          }
        }
      }
    },
    {
      "id": "virtual-2e0c02ab-f151-55bc-884e-e91b705cab72",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-21",
        "rented_count": 0,
        "interval": "day",
        "product_id": "ded18bb4-64d1-410b-9d8f-9e0e8f76dea8"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/ded18bb4-64d1-410b-9d8f-9e0e8f76dea8"
          }
        }
      }
    },
    {
      "id": "virtual-cd60c511-4ac9-58f3-bbad-3f0cab170da8",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-22",
        "rented_count": 1,
        "interval": "day",
        "product_id": "ded18bb4-64d1-410b-9d8f-9e0e8f76dea8"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/ded18bb4-64d1-410b-9d8f-9e0e8f76dea8"
          }
        }
      }
    },
    {
      "id": "virtual-eb19b5d0-86ba-536d-96a8-2ae293e4ced8",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-23",
        "rented_count": 0,
        "interval": "day",
        "product_id": "ded18bb4-64d1-410b-9d8f-9e0e8f76dea8"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/ded18bb4-64d1-410b-9d8f-9e0e8f76dea8"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-24T08:52:15Z`
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







