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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-02-03+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=79871f60-dfeb-43f1-abd3-03482e886ce9&filter%5Btill%5D=2023-02-12+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-6f0b2ae0-a55b-5962-8949-f1e03548d66b",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-03",
        "rented_count": 0,
        "interval": "day",
        "product_id": "79871f60-dfeb-43f1-abd3-03482e886ce9"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/79871f60-dfeb-43f1-abd3-03482e886ce9"
          }
        }
      }
    },
    {
      "id": "virtual-7b48aa02-1001-57c0-91f5-f84873138018",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-04",
        "rented_count": 0,
        "interval": "day",
        "product_id": "79871f60-dfeb-43f1-abd3-03482e886ce9"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/79871f60-dfeb-43f1-abd3-03482e886ce9"
          }
        }
      }
    },
    {
      "id": "virtual-2d5121d4-17e2-5235-834b-daf83e87e40d",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-05",
        "rented_count": 0,
        "interval": "day",
        "product_id": "79871f60-dfeb-43f1-abd3-03482e886ce9"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/79871f60-dfeb-43f1-abd3-03482e886ce9"
          }
        }
      }
    },
    {
      "id": "virtual-43d79338-1361-5bd6-b72c-397a817b1baf",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-06",
        "rented_count": 0,
        "interval": "day",
        "product_id": "79871f60-dfeb-43f1-abd3-03482e886ce9"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/79871f60-dfeb-43f1-abd3-03482e886ce9"
          }
        }
      }
    },
    {
      "id": "virtual-ad77e16e-3f97-5ac9-8141-d741b6335c03",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-07",
        "rented_count": 1,
        "interval": "day",
        "product_id": "79871f60-dfeb-43f1-abd3-03482e886ce9"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/79871f60-dfeb-43f1-abd3-03482e886ce9"
          }
        }
      }
    },
    {
      "id": "virtual-23bc45d8-973a-5288-bee5-58e2e84d4ad5",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-08",
        "rented_count": 0,
        "interval": "day",
        "product_id": "79871f60-dfeb-43f1-abd3-03482e886ce9"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/79871f60-dfeb-43f1-abd3-03482e886ce9"
          }
        }
      }
    },
    {
      "id": "virtual-4385e895-c145-5668-b1b0-835b26f0f026",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-09",
        "rented_count": 1,
        "interval": "day",
        "product_id": "79871f60-dfeb-43f1-abd3-03482e886ce9"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/79871f60-dfeb-43f1-abd3-03482e886ce9"
          }
        }
      }
    },
    {
      "id": "virtual-bf83f087-6e9a-5b36-9db8-d2b27ae550e8",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-10",
        "rented_count": 0,
        "interval": "day",
        "product_id": "79871f60-dfeb-43f1-abd3-03482e886ce9"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/79871f60-dfeb-43f1-abd3-03482e886ce9"
          }
        }
      }
    },
    {
      "id": "virtual-8ad44e41-df33-57ca-aa34-52f29dd7871e",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-11",
        "rented_count": 1,
        "interval": "day",
        "product_id": "79871f60-dfeb-43f1-abd3-03482e886ce9"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/79871f60-dfeb-43f1-abd3-03482e886ce9"
          }
        }
      }
    },
    {
      "id": "virtual-0caf125b-2ffc-5d75-9bf8-fb8ac794d803",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-12",
        "rented_count": 0,
        "interval": "day",
        "product_id": "79871f60-dfeb-43f1-abd3-03482e886ce9"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/79871f60-dfeb-43f1-abd3-03482e886ce9"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-13T12:13:06Z`
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







