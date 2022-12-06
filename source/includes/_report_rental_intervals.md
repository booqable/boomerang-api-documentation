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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2022-11-26+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=a39a7f57-4167-4e67-af73-4fb8e8de3c2a&filter%5Btill%5D=2022-12-05+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-a98677f5-ebe6-58d1-a116-e4180dc9f4be",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-26",
        "rented_count": 0,
        "interval": "day",
        "product_id": "a39a7f57-4167-4e67-af73-4fb8e8de3c2a"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/a39a7f57-4167-4e67-af73-4fb8e8de3c2a"
          }
        }
      }
    },
    {
      "id": "virtual-e1deb9ca-4124-5faf-8ce7-a4eb19eaf4c7",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-27",
        "rented_count": 0,
        "interval": "day",
        "product_id": "a39a7f57-4167-4e67-af73-4fb8e8de3c2a"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/a39a7f57-4167-4e67-af73-4fb8e8de3c2a"
          }
        }
      }
    },
    {
      "id": "virtual-c519ef8f-3100-52d0-a312-c98dd879a5b3",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-28",
        "rented_count": 0,
        "interval": "day",
        "product_id": "a39a7f57-4167-4e67-af73-4fb8e8de3c2a"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/a39a7f57-4167-4e67-af73-4fb8e8de3c2a"
          }
        }
      }
    },
    {
      "id": "virtual-de82e8c8-badc-59c3-82c0-6eae54ee7fce",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-29",
        "rented_count": 0,
        "interval": "day",
        "product_id": "a39a7f57-4167-4e67-af73-4fb8e8de3c2a"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/a39a7f57-4167-4e67-af73-4fb8e8de3c2a"
          }
        }
      }
    },
    {
      "id": "virtual-41f486e6-6fd1-5de7-982d-7878f7ec27ec",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-30",
        "rented_count": 1,
        "interval": "day",
        "product_id": "a39a7f57-4167-4e67-af73-4fb8e8de3c2a"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/a39a7f57-4167-4e67-af73-4fb8e8de3c2a"
          }
        }
      }
    },
    {
      "id": "virtual-a3bac3f1-5696-5355-8bca-6eea233f3acb",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-12-01",
        "rented_count": 0,
        "interval": "day",
        "product_id": "a39a7f57-4167-4e67-af73-4fb8e8de3c2a"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/a39a7f57-4167-4e67-af73-4fb8e8de3c2a"
          }
        }
      }
    },
    {
      "id": "virtual-736bc94d-de0c-5533-aa9b-7f934dab10b5",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-12-02",
        "rented_count": 1,
        "interval": "day",
        "product_id": "a39a7f57-4167-4e67-af73-4fb8e8de3c2a"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/a39a7f57-4167-4e67-af73-4fb8e8de3c2a"
          }
        }
      }
    },
    {
      "id": "virtual-08c882be-8e0f-52a9-bf49-193968826b4e",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-12-03",
        "rented_count": 0,
        "interval": "day",
        "product_id": "a39a7f57-4167-4e67-af73-4fb8e8de3c2a"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/a39a7f57-4167-4e67-af73-4fb8e8de3c2a"
          }
        }
      }
    },
    {
      "id": "virtual-c91bc94e-e710-5a43-aa9e-4a4983bff918",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-12-04",
        "rented_count": 1,
        "interval": "day",
        "product_id": "a39a7f57-4167-4e67-af73-4fb8e8de3c2a"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/a39a7f57-4167-4e67-af73-4fb8e8de3c2a"
          }
        }
      }
    },
    {
      "id": "virtual-b01ae8f7-cf51-57c7-9289-1b2b9c88b1ea",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-12-05",
        "rented_count": 0,
        "interval": "day",
        "product_id": "a39a7f57-4167-4e67-af73-4fb8e8de3c2a"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/a39a7f57-4167-4e67-af73-4fb8e8de3c2a"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-12-06T11:16:36Z`
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







