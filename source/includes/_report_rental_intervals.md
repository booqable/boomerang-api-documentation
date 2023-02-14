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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-02-04+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=a087b209-2add-4016-aa2f-1449ffff1655&filter%5Btill%5D=2023-02-13+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-a6b281c3-3fb1-5e2a-8d7c-4ac0221ce74d",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-04",
        "rented_count": 0,
        "interval": "day",
        "product_id": "a087b209-2add-4016-aa2f-1449ffff1655"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/a087b209-2add-4016-aa2f-1449ffff1655"
          }
        }
      }
    },
    {
      "id": "virtual-51d6997f-79b5-5fc7-b22e-d77f5ce5b93b",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-05",
        "rented_count": 0,
        "interval": "day",
        "product_id": "a087b209-2add-4016-aa2f-1449ffff1655"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/a087b209-2add-4016-aa2f-1449ffff1655"
          }
        }
      }
    },
    {
      "id": "virtual-089a4ab6-aeba-5609-8355-30dbe43780c7",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-06",
        "rented_count": 0,
        "interval": "day",
        "product_id": "a087b209-2add-4016-aa2f-1449ffff1655"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/a087b209-2add-4016-aa2f-1449ffff1655"
          }
        }
      }
    },
    {
      "id": "virtual-0cef3564-ca95-57e8-831d-abf715a6bfc1",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-07",
        "rented_count": 0,
        "interval": "day",
        "product_id": "a087b209-2add-4016-aa2f-1449ffff1655"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/a087b209-2add-4016-aa2f-1449ffff1655"
          }
        }
      }
    },
    {
      "id": "virtual-7faec6d9-396b-53c2-98dd-86f9915a4a49",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-08",
        "rented_count": 1,
        "interval": "day",
        "product_id": "a087b209-2add-4016-aa2f-1449ffff1655"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/a087b209-2add-4016-aa2f-1449ffff1655"
          }
        }
      }
    },
    {
      "id": "virtual-74011231-6778-5328-b7a5-ffc89f7dbc03",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-09",
        "rented_count": 0,
        "interval": "day",
        "product_id": "a087b209-2add-4016-aa2f-1449ffff1655"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/a087b209-2add-4016-aa2f-1449ffff1655"
          }
        }
      }
    },
    {
      "id": "virtual-195e0cb8-e1c0-50a0-aee6-025f3e50a4bb",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-10",
        "rented_count": 1,
        "interval": "day",
        "product_id": "a087b209-2add-4016-aa2f-1449ffff1655"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/a087b209-2add-4016-aa2f-1449ffff1655"
          }
        }
      }
    },
    {
      "id": "virtual-6672a7cd-47f1-55da-83e6-11934b2d7ad9",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-11",
        "rented_count": 0,
        "interval": "day",
        "product_id": "a087b209-2add-4016-aa2f-1449ffff1655"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/a087b209-2add-4016-aa2f-1449ffff1655"
          }
        }
      }
    },
    {
      "id": "virtual-7478bf6c-f3c6-5c09-b440-f608217eaa63",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-12",
        "rented_count": 1,
        "interval": "day",
        "product_id": "a087b209-2add-4016-aa2f-1449ffff1655"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/a087b209-2add-4016-aa2f-1449ffff1655"
          }
        }
      }
    },
    {
      "id": "virtual-191e3d11-9168-5874-9ab2-a0ed54615927",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-13",
        "rented_count": 0,
        "interval": "day",
        "product_id": "a087b209-2add-4016-aa2f-1449ffff1655"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/a087b209-2add-4016-aa2f-1449ffff1655"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-14T11:05:20Z`
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







