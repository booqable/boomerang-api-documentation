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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-02-10+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=2742e85f-cbb1-4083-a11d-668044daed75&filter%5Btill%5D=2023-02-19+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-07d7a9af-4233-5408-8641-524a8f776660",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-10",
        "rented_count": 0,
        "interval": "day",
        "product_id": "2742e85f-cbb1-4083-a11d-668044daed75"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/2742e85f-cbb1-4083-a11d-668044daed75"
          }
        }
      }
    },
    {
      "id": "virtual-b4fb163a-b5c4-5847-92c9-e98c5f4cb129",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-11",
        "rented_count": 0,
        "interval": "day",
        "product_id": "2742e85f-cbb1-4083-a11d-668044daed75"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/2742e85f-cbb1-4083-a11d-668044daed75"
          }
        }
      }
    },
    {
      "id": "virtual-a13fb0fe-b0aa-5ee1-a7bc-4f246998e192",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-12",
        "rented_count": 0,
        "interval": "day",
        "product_id": "2742e85f-cbb1-4083-a11d-668044daed75"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/2742e85f-cbb1-4083-a11d-668044daed75"
          }
        }
      }
    },
    {
      "id": "virtual-28dbf87f-3048-5108-a8ca-f9941323b23b",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-13",
        "rented_count": 0,
        "interval": "day",
        "product_id": "2742e85f-cbb1-4083-a11d-668044daed75"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/2742e85f-cbb1-4083-a11d-668044daed75"
          }
        }
      }
    },
    {
      "id": "virtual-0a4fa3b2-aed2-5271-9d4f-1a657ffbf895",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-14",
        "rented_count": 1,
        "interval": "day",
        "product_id": "2742e85f-cbb1-4083-a11d-668044daed75"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/2742e85f-cbb1-4083-a11d-668044daed75"
          }
        }
      }
    },
    {
      "id": "virtual-26d5be61-c4d2-5942-afa0-c0e335cfeab9",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-15",
        "rented_count": 0,
        "interval": "day",
        "product_id": "2742e85f-cbb1-4083-a11d-668044daed75"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/2742e85f-cbb1-4083-a11d-668044daed75"
          }
        }
      }
    },
    {
      "id": "virtual-a89c0045-82c8-5683-9c3f-3b440b5268be",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-16",
        "rented_count": 1,
        "interval": "day",
        "product_id": "2742e85f-cbb1-4083-a11d-668044daed75"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/2742e85f-cbb1-4083-a11d-668044daed75"
          }
        }
      }
    },
    {
      "id": "virtual-95106f6f-a5aa-5ae3-b3c1-10ab5f2c2ae4",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-17",
        "rented_count": 0,
        "interval": "day",
        "product_id": "2742e85f-cbb1-4083-a11d-668044daed75"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/2742e85f-cbb1-4083-a11d-668044daed75"
          }
        }
      }
    },
    {
      "id": "virtual-86df5adc-416e-55b5-a6a5-f0fdb0cacdde",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-18",
        "rented_count": 1,
        "interval": "day",
        "product_id": "2742e85f-cbb1-4083-a11d-668044daed75"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/2742e85f-cbb1-4083-a11d-668044daed75"
          }
        }
      }
    },
    {
      "id": "virtual-9a7bbaa3-993d-5592-a746-aaa8e272a0f2",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-19",
        "rented_count": 0,
        "interval": "day",
        "product_id": "2742e85f-cbb1-4083-a11d-668044daed75"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/2742e85f-cbb1-4083-a11d-668044daed75"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-20T11:45:20Z`
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







