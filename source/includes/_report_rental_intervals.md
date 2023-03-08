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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-02-26+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=b1a2f6be-019e-4029-97de-e8036b0555e6&filter%5Btill%5D=2023-03-07+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-036b86c1-104f-5923-8e7b-5b7886f93b79",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-26",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b1a2f6be-019e-4029-97de-e8036b0555e6"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b1a2f6be-019e-4029-97de-e8036b0555e6"
          }
        }
      }
    },
    {
      "id": "virtual-4adc5b4d-7015-52c6-9d29-adc279bfb262",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-27",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b1a2f6be-019e-4029-97de-e8036b0555e6"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b1a2f6be-019e-4029-97de-e8036b0555e6"
          }
        }
      }
    },
    {
      "id": "virtual-0b585958-1c90-541d-9e48-55add0039379",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-28",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b1a2f6be-019e-4029-97de-e8036b0555e6"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b1a2f6be-019e-4029-97de-e8036b0555e6"
          }
        }
      }
    },
    {
      "id": "virtual-628e436f-cbda-5cbc-8832-8f873b1e6bc5",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-01",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b1a2f6be-019e-4029-97de-e8036b0555e6"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b1a2f6be-019e-4029-97de-e8036b0555e6"
          }
        }
      }
    },
    {
      "id": "virtual-b387b16d-dfa8-5e16-b3ce-31571efc2af1",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-02",
        "rented_count": 1,
        "interval": "day",
        "product_id": "b1a2f6be-019e-4029-97de-e8036b0555e6"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b1a2f6be-019e-4029-97de-e8036b0555e6"
          }
        }
      }
    },
    {
      "id": "virtual-f92d254f-b32e-5807-98b8-4052b974a375",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-03",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b1a2f6be-019e-4029-97de-e8036b0555e6"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b1a2f6be-019e-4029-97de-e8036b0555e6"
          }
        }
      }
    },
    {
      "id": "virtual-2b765b59-5515-5a58-b155-0bc6fc684510",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-04",
        "rented_count": 1,
        "interval": "day",
        "product_id": "b1a2f6be-019e-4029-97de-e8036b0555e6"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b1a2f6be-019e-4029-97de-e8036b0555e6"
          }
        }
      }
    },
    {
      "id": "virtual-5ad0f3b6-9b68-5b91-916b-60c0f938062c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-05",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b1a2f6be-019e-4029-97de-e8036b0555e6"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b1a2f6be-019e-4029-97de-e8036b0555e6"
          }
        }
      }
    },
    {
      "id": "virtual-83da5dcf-2eaa-5ce6-b1a7-1a246d66b9cb",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-06",
        "rented_count": 1,
        "interval": "day",
        "product_id": "b1a2f6be-019e-4029-97de-e8036b0555e6"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b1a2f6be-019e-4029-97de-e8036b0555e6"
          }
        }
      }
    },
    {
      "id": "virtual-c6869769-760e-5fd2-83f2-42d2318f43ca",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-07",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b1a2f6be-019e-4029-97de-e8036b0555e6"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b1a2f6be-019e-4029-97de-e8036b0555e6"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-03-08T15:21:50Z`
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







