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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-02-03+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=58f8192e-7957-40e2-a740-b98da3de4411&filter%5Btill%5D=2023-02-12+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-fb1d9aba-19e4-5bab-add8-950cd81a7f6d",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-03",
        "rented_count": 0,
        "interval": "day",
        "product_id": "58f8192e-7957-40e2-a740-b98da3de4411"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/58f8192e-7957-40e2-a740-b98da3de4411"
          }
        }
      }
    },
    {
      "id": "virtual-61703634-71d7-5694-9eb0-da6eb9444a63",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-04",
        "rented_count": 0,
        "interval": "day",
        "product_id": "58f8192e-7957-40e2-a740-b98da3de4411"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/58f8192e-7957-40e2-a740-b98da3de4411"
          }
        }
      }
    },
    {
      "id": "virtual-b628e54b-9d6b-5560-8142-219641969046",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-05",
        "rented_count": 0,
        "interval": "day",
        "product_id": "58f8192e-7957-40e2-a740-b98da3de4411"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/58f8192e-7957-40e2-a740-b98da3de4411"
          }
        }
      }
    },
    {
      "id": "virtual-ab0495d6-c34b-55a1-a456-1d33a0351f8c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-06",
        "rented_count": 0,
        "interval": "day",
        "product_id": "58f8192e-7957-40e2-a740-b98da3de4411"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/58f8192e-7957-40e2-a740-b98da3de4411"
          }
        }
      }
    },
    {
      "id": "virtual-e4246e5f-9184-5469-be21-fe871aec17dc",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-07",
        "rented_count": 1,
        "interval": "day",
        "product_id": "58f8192e-7957-40e2-a740-b98da3de4411"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/58f8192e-7957-40e2-a740-b98da3de4411"
          }
        }
      }
    },
    {
      "id": "virtual-e51e4778-1dc1-55a6-ad71-2848148d2cf3",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-08",
        "rented_count": 0,
        "interval": "day",
        "product_id": "58f8192e-7957-40e2-a740-b98da3de4411"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/58f8192e-7957-40e2-a740-b98da3de4411"
          }
        }
      }
    },
    {
      "id": "virtual-3050d6aa-5641-5795-b564-e9cf7bd4db20",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-09",
        "rented_count": 1,
        "interval": "day",
        "product_id": "58f8192e-7957-40e2-a740-b98da3de4411"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/58f8192e-7957-40e2-a740-b98da3de4411"
          }
        }
      }
    },
    {
      "id": "virtual-0c6cb927-6f68-5606-84aa-9e6a0a6efb91",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-10",
        "rented_count": 0,
        "interval": "day",
        "product_id": "58f8192e-7957-40e2-a740-b98da3de4411"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/58f8192e-7957-40e2-a740-b98da3de4411"
          }
        }
      }
    },
    {
      "id": "virtual-ab4bd109-6e68-5850-9951-ae2351b1c166",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-11",
        "rented_count": 1,
        "interval": "day",
        "product_id": "58f8192e-7957-40e2-a740-b98da3de4411"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/58f8192e-7957-40e2-a740-b98da3de4411"
          }
        }
      }
    },
    {
      "id": "virtual-0c06ab67-0664-55a7-932a-6c445f7f399a",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-12",
        "rented_count": 0,
        "interval": "day",
        "product_id": "58f8192e-7957-40e2-a740-b98da3de4411"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/58f8192e-7957-40e2-a740-b98da3de4411"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-13T09:07:30Z`
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







