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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-01-31+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=ba6ae30d-efe1-438f-b4e6-660b3d0f5773&filter%5Btill%5D=2023-02-09+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-ad43ce80-5cf6-5d2e-8529-e7e34fad4dd3",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-31",
        "rented_count": 0,
        "interval": "day",
        "product_id": "ba6ae30d-efe1-438f-b4e6-660b3d0f5773"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/ba6ae30d-efe1-438f-b4e6-660b3d0f5773"
          }
        }
      }
    },
    {
      "id": "virtual-d6e3a40d-7d26-5372-8395-b4d3d4b83040",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-01",
        "rented_count": 0,
        "interval": "day",
        "product_id": "ba6ae30d-efe1-438f-b4e6-660b3d0f5773"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/ba6ae30d-efe1-438f-b4e6-660b3d0f5773"
          }
        }
      }
    },
    {
      "id": "virtual-2137c954-e1df-5a38-8eba-b4e767ba401f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-02",
        "rented_count": 0,
        "interval": "day",
        "product_id": "ba6ae30d-efe1-438f-b4e6-660b3d0f5773"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/ba6ae30d-efe1-438f-b4e6-660b3d0f5773"
          }
        }
      }
    },
    {
      "id": "virtual-908490bd-91d7-535a-af74-58c6c2b53868",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-03",
        "rented_count": 0,
        "interval": "day",
        "product_id": "ba6ae30d-efe1-438f-b4e6-660b3d0f5773"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/ba6ae30d-efe1-438f-b4e6-660b3d0f5773"
          }
        }
      }
    },
    {
      "id": "virtual-391088a8-ed45-5941-945d-ae1e4a6f91ae",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-04",
        "rented_count": 1,
        "interval": "day",
        "product_id": "ba6ae30d-efe1-438f-b4e6-660b3d0f5773"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/ba6ae30d-efe1-438f-b4e6-660b3d0f5773"
          }
        }
      }
    },
    {
      "id": "virtual-32e2a40c-8ec1-5cd5-ac9c-7e36065f3a8e",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-05",
        "rented_count": 0,
        "interval": "day",
        "product_id": "ba6ae30d-efe1-438f-b4e6-660b3d0f5773"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/ba6ae30d-efe1-438f-b4e6-660b3d0f5773"
          }
        }
      }
    },
    {
      "id": "virtual-eb648a1f-c5cf-5578-a10f-bb17c2f5723f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-06",
        "rented_count": 1,
        "interval": "day",
        "product_id": "ba6ae30d-efe1-438f-b4e6-660b3d0f5773"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/ba6ae30d-efe1-438f-b4e6-660b3d0f5773"
          }
        }
      }
    },
    {
      "id": "virtual-72e581e3-f357-5af1-86e4-7f534e478e89",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-07",
        "rented_count": 0,
        "interval": "day",
        "product_id": "ba6ae30d-efe1-438f-b4e6-660b3d0f5773"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/ba6ae30d-efe1-438f-b4e6-660b3d0f5773"
          }
        }
      }
    },
    {
      "id": "virtual-ade5bfb4-df87-52fc-a1f4-c7a5aec1fa63",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-08",
        "rented_count": 1,
        "interval": "day",
        "product_id": "ba6ae30d-efe1-438f-b4e6-660b3d0f5773"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/ba6ae30d-efe1-438f-b4e6-660b3d0f5773"
          }
        }
      }
    },
    {
      "id": "virtual-ff4cfe12-b76f-5330-a415-eff27818be68",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-09",
        "rented_count": 0,
        "interval": "day",
        "product_id": "ba6ae30d-efe1-438f-b4e6-660b3d0f5773"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/ba6ae30d-efe1-438f-b4e6-660b3d0f5773"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-10T11:14:44Z`
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







