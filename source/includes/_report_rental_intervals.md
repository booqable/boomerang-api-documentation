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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-01-30+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=e95cb619-61c4-45fb-81d5-1e5f52bc01ee&filter%5Btill%5D=2023-02-08+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-f4ee14c3-7d47-5030-9c52-09e3d34641d8",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-30",
        "rented_count": 0,
        "interval": "day",
        "product_id": "e95cb619-61c4-45fb-81d5-1e5f52bc01ee"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e95cb619-61c4-45fb-81d5-1e5f52bc01ee"
          }
        }
      }
    },
    {
      "id": "virtual-38fed9dd-c31c-5514-b552-e4ef52dade56",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-31",
        "rented_count": 0,
        "interval": "day",
        "product_id": "e95cb619-61c4-45fb-81d5-1e5f52bc01ee"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e95cb619-61c4-45fb-81d5-1e5f52bc01ee"
          }
        }
      }
    },
    {
      "id": "virtual-84406f33-3c17-5800-9200-ae2ff6f8d86a",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-01",
        "rented_count": 0,
        "interval": "day",
        "product_id": "e95cb619-61c4-45fb-81d5-1e5f52bc01ee"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e95cb619-61c4-45fb-81d5-1e5f52bc01ee"
          }
        }
      }
    },
    {
      "id": "virtual-3510d194-6c90-563a-ae0e-a43de0f0c79b",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-02",
        "rented_count": 0,
        "interval": "day",
        "product_id": "e95cb619-61c4-45fb-81d5-1e5f52bc01ee"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e95cb619-61c4-45fb-81d5-1e5f52bc01ee"
          }
        }
      }
    },
    {
      "id": "virtual-c74b7600-9bec-5f5c-b81f-0b7d84aced6d",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-03",
        "rented_count": 1,
        "interval": "day",
        "product_id": "e95cb619-61c4-45fb-81d5-1e5f52bc01ee"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e95cb619-61c4-45fb-81d5-1e5f52bc01ee"
          }
        }
      }
    },
    {
      "id": "virtual-b4c774af-8698-59a9-a202-f6807f6b6d8b",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-04",
        "rented_count": 0,
        "interval": "day",
        "product_id": "e95cb619-61c4-45fb-81d5-1e5f52bc01ee"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e95cb619-61c4-45fb-81d5-1e5f52bc01ee"
          }
        }
      }
    },
    {
      "id": "virtual-80676667-cfcc-59dc-a69b-4c6a0e5588a1",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-05",
        "rented_count": 1,
        "interval": "day",
        "product_id": "e95cb619-61c4-45fb-81d5-1e5f52bc01ee"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e95cb619-61c4-45fb-81d5-1e5f52bc01ee"
          }
        }
      }
    },
    {
      "id": "virtual-744acca0-b338-5bbe-88e6-f89117bf6df2",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-06",
        "rented_count": 0,
        "interval": "day",
        "product_id": "e95cb619-61c4-45fb-81d5-1e5f52bc01ee"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e95cb619-61c4-45fb-81d5-1e5f52bc01ee"
          }
        }
      }
    },
    {
      "id": "virtual-bfeda21e-d3ab-5ebb-b09b-f38ace787fbf",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-07",
        "rented_count": 1,
        "interval": "day",
        "product_id": "e95cb619-61c4-45fb-81d5-1e5f52bc01ee"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e95cb619-61c4-45fb-81d5-1e5f52bc01ee"
          }
        }
      }
    },
    {
      "id": "virtual-89c2abe1-869f-550b-aa78-a398fadffb27",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-08",
        "rented_count": 0,
        "interval": "day",
        "product_id": "e95cb619-61c4-45fb-81d5-1e5f52bc01ee"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e95cb619-61c4-45fb-81d5-1e5f52bc01ee"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-09T09:25:54Z`
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







