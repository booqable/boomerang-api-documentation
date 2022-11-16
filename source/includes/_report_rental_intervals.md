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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2022-11-06+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=c5fbfb64-6be3-477b-9031-480aa131efc7&filter%5Btill%5D=2022-11-15+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-25ee2188-aa38-5175-992c-9c4d7efb8e40",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-06",
        "rented_count": 0,
        "interval": "day",
        "product_id": "c5fbfb64-6be3-477b-9031-480aa131efc7"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/c5fbfb64-6be3-477b-9031-480aa131efc7"
          }
        }
      }
    },
    {
      "id": "virtual-ef098b5d-06b8-51fb-a5ad-605f1cf9242a",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-07",
        "rented_count": 0,
        "interval": "day",
        "product_id": "c5fbfb64-6be3-477b-9031-480aa131efc7"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/c5fbfb64-6be3-477b-9031-480aa131efc7"
          }
        }
      }
    },
    {
      "id": "virtual-a496e561-da28-5eb6-84fe-2e97ae2e442a",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-08",
        "rented_count": 0,
        "interval": "day",
        "product_id": "c5fbfb64-6be3-477b-9031-480aa131efc7"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/c5fbfb64-6be3-477b-9031-480aa131efc7"
          }
        }
      }
    },
    {
      "id": "virtual-bafb0813-bf07-54c2-ab72-5056ab8ee4be",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-09",
        "rented_count": 0,
        "interval": "day",
        "product_id": "c5fbfb64-6be3-477b-9031-480aa131efc7"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/c5fbfb64-6be3-477b-9031-480aa131efc7"
          }
        }
      }
    },
    {
      "id": "virtual-400509e8-024a-580e-90f2-656479aeaa19",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-10",
        "rented_count": 1,
        "interval": "day",
        "product_id": "c5fbfb64-6be3-477b-9031-480aa131efc7"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/c5fbfb64-6be3-477b-9031-480aa131efc7"
          }
        }
      }
    },
    {
      "id": "virtual-f0f43b60-d131-5f19-becd-4f1b91a7db24",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-11",
        "rented_count": 0,
        "interval": "day",
        "product_id": "c5fbfb64-6be3-477b-9031-480aa131efc7"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/c5fbfb64-6be3-477b-9031-480aa131efc7"
          }
        }
      }
    },
    {
      "id": "virtual-5a0b728f-a742-51f6-9f14-ecde3173aa93",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-12",
        "rented_count": 1,
        "interval": "day",
        "product_id": "c5fbfb64-6be3-477b-9031-480aa131efc7"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/c5fbfb64-6be3-477b-9031-480aa131efc7"
          }
        }
      }
    },
    {
      "id": "virtual-9917591f-9757-516e-bb8f-42f2c7fa0793",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-13",
        "rented_count": 0,
        "interval": "day",
        "product_id": "c5fbfb64-6be3-477b-9031-480aa131efc7"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/c5fbfb64-6be3-477b-9031-480aa131efc7"
          }
        }
      }
    },
    {
      "id": "virtual-59bdfc19-0291-5237-b282-537d0fb2d1df",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-14",
        "rented_count": 1,
        "interval": "day",
        "product_id": "c5fbfb64-6be3-477b-9031-480aa131efc7"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/c5fbfb64-6be3-477b-9031-480aa131efc7"
          }
        }
      }
    },
    {
      "id": "virtual-9d7848f9-f357-54e4-b204-4029589ee101",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-15",
        "rented_count": 0,
        "interval": "day",
        "product_id": "c5fbfb64-6be3-477b-9031-480aa131efc7"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/c5fbfb64-6be3-477b-9031-480aa131efc7"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-11-16T14:21:49Z`
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







