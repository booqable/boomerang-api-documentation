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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-02-04+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=934b4f58-2eee-4d61-8bbf-fa3c15b909c3&filter%5Btill%5D=2023-02-13+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-3c99d64b-79d5-5adc-b50c-a44b9c60d9c3",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-04",
        "rented_count": 0,
        "interval": "day",
        "product_id": "934b4f58-2eee-4d61-8bbf-fa3c15b909c3"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/934b4f58-2eee-4d61-8bbf-fa3c15b909c3"
          }
        }
      }
    },
    {
      "id": "virtual-6785a4cd-2d73-5317-adfb-b307b2d14390",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-05",
        "rented_count": 0,
        "interval": "day",
        "product_id": "934b4f58-2eee-4d61-8bbf-fa3c15b909c3"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/934b4f58-2eee-4d61-8bbf-fa3c15b909c3"
          }
        }
      }
    },
    {
      "id": "virtual-535f69aa-88bb-50db-accd-d63bd57a168b",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-06",
        "rented_count": 0,
        "interval": "day",
        "product_id": "934b4f58-2eee-4d61-8bbf-fa3c15b909c3"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/934b4f58-2eee-4d61-8bbf-fa3c15b909c3"
          }
        }
      }
    },
    {
      "id": "virtual-9346c866-8cb1-5315-8e65-47fe426662a8",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-07",
        "rented_count": 0,
        "interval": "day",
        "product_id": "934b4f58-2eee-4d61-8bbf-fa3c15b909c3"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/934b4f58-2eee-4d61-8bbf-fa3c15b909c3"
          }
        }
      }
    },
    {
      "id": "virtual-2fad879e-f5f9-5d14-99c8-7b1cd0909972",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-08",
        "rented_count": 1,
        "interval": "day",
        "product_id": "934b4f58-2eee-4d61-8bbf-fa3c15b909c3"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/934b4f58-2eee-4d61-8bbf-fa3c15b909c3"
          }
        }
      }
    },
    {
      "id": "virtual-e9a986d7-e63b-5814-8bcb-79e5750b6d3f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-09",
        "rented_count": 0,
        "interval": "day",
        "product_id": "934b4f58-2eee-4d61-8bbf-fa3c15b909c3"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/934b4f58-2eee-4d61-8bbf-fa3c15b909c3"
          }
        }
      }
    },
    {
      "id": "virtual-ff63e617-deb4-582d-bca5-cd44904e1158",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-10",
        "rented_count": 1,
        "interval": "day",
        "product_id": "934b4f58-2eee-4d61-8bbf-fa3c15b909c3"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/934b4f58-2eee-4d61-8bbf-fa3c15b909c3"
          }
        }
      }
    },
    {
      "id": "virtual-c3ee622d-d153-580d-81ad-f7a6ce8cdd49",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-11",
        "rented_count": 0,
        "interval": "day",
        "product_id": "934b4f58-2eee-4d61-8bbf-fa3c15b909c3"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/934b4f58-2eee-4d61-8bbf-fa3c15b909c3"
          }
        }
      }
    },
    {
      "id": "virtual-cd836dd9-238d-52e9-9443-61a48c09a3af",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-12",
        "rented_count": 1,
        "interval": "day",
        "product_id": "934b4f58-2eee-4d61-8bbf-fa3c15b909c3"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/934b4f58-2eee-4d61-8bbf-fa3c15b909c3"
          }
        }
      }
    },
    {
      "id": "virtual-0cffe24e-bc9a-512e-8093-a767a304b587",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-13",
        "rented_count": 0,
        "interval": "day",
        "product_id": "934b4f58-2eee-4d61-8bbf-fa3c15b909c3"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/934b4f58-2eee-4d61-8bbf-fa3c15b909c3"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-14T12:45:18Z`
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







