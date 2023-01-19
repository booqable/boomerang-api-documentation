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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-01-09+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=dc8274a6-41f9-4832-bc7d-bd0c372fb470&filter%5Btill%5D=2023-01-18+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-0e46fa79-aaea-5ac6-ad22-83b90b261241",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-09",
        "rented_count": 0,
        "interval": "day",
        "product_id": "dc8274a6-41f9-4832-bc7d-bd0c372fb470"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/dc8274a6-41f9-4832-bc7d-bd0c372fb470"
          }
        }
      }
    },
    {
      "id": "virtual-e38885ae-032c-5100-9fd8-88b0be565abd",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-10",
        "rented_count": 0,
        "interval": "day",
        "product_id": "dc8274a6-41f9-4832-bc7d-bd0c372fb470"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/dc8274a6-41f9-4832-bc7d-bd0c372fb470"
          }
        }
      }
    },
    {
      "id": "virtual-bf2732aa-0fc4-5be3-9962-da3c74fe1425",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-11",
        "rented_count": 0,
        "interval": "day",
        "product_id": "dc8274a6-41f9-4832-bc7d-bd0c372fb470"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/dc8274a6-41f9-4832-bc7d-bd0c372fb470"
          }
        }
      }
    },
    {
      "id": "virtual-3c7422c6-c7eb-5124-af7d-2b3778802776",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-12",
        "rented_count": 0,
        "interval": "day",
        "product_id": "dc8274a6-41f9-4832-bc7d-bd0c372fb470"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/dc8274a6-41f9-4832-bc7d-bd0c372fb470"
          }
        }
      }
    },
    {
      "id": "virtual-76310166-f7bf-5c8d-9503-616e1822ac61",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-13",
        "rented_count": 1,
        "interval": "day",
        "product_id": "dc8274a6-41f9-4832-bc7d-bd0c372fb470"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/dc8274a6-41f9-4832-bc7d-bd0c372fb470"
          }
        }
      }
    },
    {
      "id": "virtual-73413142-b893-53d7-8fc6-3f6db5eb9d31",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-14",
        "rented_count": 0,
        "interval": "day",
        "product_id": "dc8274a6-41f9-4832-bc7d-bd0c372fb470"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/dc8274a6-41f9-4832-bc7d-bd0c372fb470"
          }
        }
      }
    },
    {
      "id": "virtual-4c541756-a8eb-520c-b3fb-3ecef0707892",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-15",
        "rented_count": 1,
        "interval": "day",
        "product_id": "dc8274a6-41f9-4832-bc7d-bd0c372fb470"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/dc8274a6-41f9-4832-bc7d-bd0c372fb470"
          }
        }
      }
    },
    {
      "id": "virtual-51ea9f24-48c2-5a0a-aeea-9d759b31d4fc",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-16",
        "rented_count": 0,
        "interval": "day",
        "product_id": "dc8274a6-41f9-4832-bc7d-bd0c372fb470"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/dc8274a6-41f9-4832-bc7d-bd0c372fb470"
          }
        }
      }
    },
    {
      "id": "virtual-c92c6a02-911b-5d9d-b685-e70171ed5bd3",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-17",
        "rented_count": 1,
        "interval": "day",
        "product_id": "dc8274a6-41f9-4832-bc7d-bd0c372fb470"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/dc8274a6-41f9-4832-bc7d-bd0c372fb470"
          }
        }
      }
    },
    {
      "id": "virtual-69818fd2-d365-5db3-ac00-0782b768cedb",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-18",
        "rented_count": 0,
        "interval": "day",
        "product_id": "dc8274a6-41f9-4832-bc7d-bd0c372fb470"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/dc8274a6-41f9-4832-bc7d-bd0c372fb470"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-01-19T10:27:22Z`
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







