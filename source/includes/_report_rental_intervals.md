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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-01-30+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=b83e3a70-4191-4f0d-a922-1bc756032559&filter%5Btill%5D=2023-02-08+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-f22870e6-7725-5d6d-bce4-3bfd1688205f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-30",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b83e3a70-4191-4f0d-a922-1bc756032559"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b83e3a70-4191-4f0d-a922-1bc756032559"
          }
        }
      }
    },
    {
      "id": "virtual-b77cc337-da56-595f-a7e4-f8df6aebfe10",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-31",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b83e3a70-4191-4f0d-a922-1bc756032559"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b83e3a70-4191-4f0d-a922-1bc756032559"
          }
        }
      }
    },
    {
      "id": "virtual-e479a1b4-ca8a-563f-936e-ea194a6dea29",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-01",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b83e3a70-4191-4f0d-a922-1bc756032559"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b83e3a70-4191-4f0d-a922-1bc756032559"
          }
        }
      }
    },
    {
      "id": "virtual-45ede4af-3701-5c29-8975-85c96b7381ac",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-02",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b83e3a70-4191-4f0d-a922-1bc756032559"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b83e3a70-4191-4f0d-a922-1bc756032559"
          }
        }
      }
    },
    {
      "id": "virtual-c6ff978c-7e9c-5b01-825b-795d24481a42",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-03",
        "rented_count": 1,
        "interval": "day",
        "product_id": "b83e3a70-4191-4f0d-a922-1bc756032559"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b83e3a70-4191-4f0d-a922-1bc756032559"
          }
        }
      }
    },
    {
      "id": "virtual-d3e0b6af-039f-5d48-acff-50496dc443de",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-04",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b83e3a70-4191-4f0d-a922-1bc756032559"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b83e3a70-4191-4f0d-a922-1bc756032559"
          }
        }
      }
    },
    {
      "id": "virtual-c4746b24-5fce-5f1e-b94e-f9cafea02479",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-05",
        "rented_count": 1,
        "interval": "day",
        "product_id": "b83e3a70-4191-4f0d-a922-1bc756032559"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b83e3a70-4191-4f0d-a922-1bc756032559"
          }
        }
      }
    },
    {
      "id": "virtual-0a78cb53-2f71-5032-ae57-95fce643be3f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-06",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b83e3a70-4191-4f0d-a922-1bc756032559"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b83e3a70-4191-4f0d-a922-1bc756032559"
          }
        }
      }
    },
    {
      "id": "virtual-50fe1b6c-567f-5026-8a8e-2342c2d0ee74",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-07",
        "rented_count": 1,
        "interval": "day",
        "product_id": "b83e3a70-4191-4f0d-a922-1bc756032559"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b83e3a70-4191-4f0d-a922-1bc756032559"
          }
        }
      }
    },
    {
      "id": "virtual-7d932ea2-bbc7-5a20-b82a-a6521504dec5",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-08",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b83e3a70-4191-4f0d-a922-1bc756032559"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b83e3a70-4191-4f0d-a922-1bc756032559"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-09T10:09:54Z`
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







