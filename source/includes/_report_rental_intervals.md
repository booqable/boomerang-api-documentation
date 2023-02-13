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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-02-03+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=f9e554d4-5d1a-4eb8-87a1-85ef89090c2d&filter%5Btill%5D=2023-02-12+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-25880b80-8fda-53aa-81e6-fa426cc59e43",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-03",
        "rented_count": 0,
        "interval": "day",
        "product_id": "f9e554d4-5d1a-4eb8-87a1-85ef89090c2d"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/f9e554d4-5d1a-4eb8-87a1-85ef89090c2d"
          }
        }
      }
    },
    {
      "id": "virtual-134b85cd-9cbe-550a-809d-8a1459bce312",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-04",
        "rented_count": 0,
        "interval": "day",
        "product_id": "f9e554d4-5d1a-4eb8-87a1-85ef89090c2d"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/f9e554d4-5d1a-4eb8-87a1-85ef89090c2d"
          }
        }
      }
    },
    {
      "id": "virtual-a03af462-828f-5681-98c3-0ae1c629e5ee",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-05",
        "rented_count": 0,
        "interval": "day",
        "product_id": "f9e554d4-5d1a-4eb8-87a1-85ef89090c2d"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/f9e554d4-5d1a-4eb8-87a1-85ef89090c2d"
          }
        }
      }
    },
    {
      "id": "virtual-493212ca-8712-5769-838d-31f5fb940675",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-06",
        "rented_count": 0,
        "interval": "day",
        "product_id": "f9e554d4-5d1a-4eb8-87a1-85ef89090c2d"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/f9e554d4-5d1a-4eb8-87a1-85ef89090c2d"
          }
        }
      }
    },
    {
      "id": "virtual-3e3b0da5-04ee-5d4e-a952-26edcd8a9393",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-07",
        "rented_count": 1,
        "interval": "day",
        "product_id": "f9e554d4-5d1a-4eb8-87a1-85ef89090c2d"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/f9e554d4-5d1a-4eb8-87a1-85ef89090c2d"
          }
        }
      }
    },
    {
      "id": "virtual-7aa2624f-615b-5342-b44b-b530e1e321fa",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-08",
        "rented_count": 0,
        "interval": "day",
        "product_id": "f9e554d4-5d1a-4eb8-87a1-85ef89090c2d"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/f9e554d4-5d1a-4eb8-87a1-85ef89090c2d"
          }
        }
      }
    },
    {
      "id": "virtual-b9827c34-20ce-51ae-80ba-9f7f2eb63475",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-09",
        "rented_count": 1,
        "interval": "day",
        "product_id": "f9e554d4-5d1a-4eb8-87a1-85ef89090c2d"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/f9e554d4-5d1a-4eb8-87a1-85ef89090c2d"
          }
        }
      }
    },
    {
      "id": "virtual-ac549af2-82a2-56c5-a77f-fc1e5d32a3d0",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-10",
        "rented_count": 0,
        "interval": "day",
        "product_id": "f9e554d4-5d1a-4eb8-87a1-85ef89090c2d"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/f9e554d4-5d1a-4eb8-87a1-85ef89090c2d"
          }
        }
      }
    },
    {
      "id": "virtual-f61423ae-33b7-5cde-8da5-f69e1412b8cf",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-11",
        "rented_count": 1,
        "interval": "day",
        "product_id": "f9e554d4-5d1a-4eb8-87a1-85ef89090c2d"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/f9e554d4-5d1a-4eb8-87a1-85ef89090c2d"
          }
        }
      }
    },
    {
      "id": "virtual-c71b1709-96ef-5877-ae81-9cf05d7409a2",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-12",
        "rented_count": 0,
        "interval": "day",
        "product_id": "f9e554d4-5d1a-4eb8-87a1-85ef89090c2d"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/f9e554d4-5d1a-4eb8-87a1-85ef89090c2d"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-13T12:45:26Z`
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







