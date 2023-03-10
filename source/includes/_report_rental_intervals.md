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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-02-28+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=a8e01f41-62d8-4877-861d-438da8081542&filter%5Btill%5D=2023-03-09+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-9b03ad54-bf86-5076-b418-a1fd00d7108a",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-28",
        "rented_count": 0,
        "interval": "day",
        "product_id": "a8e01f41-62d8-4877-861d-438da8081542"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/a8e01f41-62d8-4877-861d-438da8081542"
          }
        }
      }
    },
    {
      "id": "virtual-dd85e4b1-0486-58af-8499-eb7d0482ec32",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-01",
        "rented_count": 0,
        "interval": "day",
        "product_id": "a8e01f41-62d8-4877-861d-438da8081542"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/a8e01f41-62d8-4877-861d-438da8081542"
          }
        }
      }
    },
    {
      "id": "virtual-e3d41de4-048a-5bdf-b092-75cb6b576c73",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-02",
        "rented_count": 0,
        "interval": "day",
        "product_id": "a8e01f41-62d8-4877-861d-438da8081542"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/a8e01f41-62d8-4877-861d-438da8081542"
          }
        }
      }
    },
    {
      "id": "virtual-e38b7da5-e0de-565c-bee0-6be0a6d156da",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-03",
        "rented_count": 0,
        "interval": "day",
        "product_id": "a8e01f41-62d8-4877-861d-438da8081542"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/a8e01f41-62d8-4877-861d-438da8081542"
          }
        }
      }
    },
    {
      "id": "virtual-9509b1f9-d289-5935-a43c-1e44caf775db",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-04",
        "rented_count": 1,
        "interval": "day",
        "product_id": "a8e01f41-62d8-4877-861d-438da8081542"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/a8e01f41-62d8-4877-861d-438da8081542"
          }
        }
      }
    },
    {
      "id": "virtual-0a33d391-24e2-5aec-a17f-c3df6bf0c408",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-05",
        "rented_count": 0,
        "interval": "day",
        "product_id": "a8e01f41-62d8-4877-861d-438da8081542"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/a8e01f41-62d8-4877-861d-438da8081542"
          }
        }
      }
    },
    {
      "id": "virtual-889d336c-503b-5108-aec9-19b1cded879d",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-06",
        "rented_count": 1,
        "interval": "day",
        "product_id": "a8e01f41-62d8-4877-861d-438da8081542"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/a8e01f41-62d8-4877-861d-438da8081542"
          }
        }
      }
    },
    {
      "id": "virtual-54241546-1867-55a6-841b-02258e2d2399",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-07",
        "rented_count": 0,
        "interval": "day",
        "product_id": "a8e01f41-62d8-4877-861d-438da8081542"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/a8e01f41-62d8-4877-861d-438da8081542"
          }
        }
      }
    },
    {
      "id": "virtual-b09c75a1-bc9e-5bb4-b1bc-0f6bb1887b40",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-08",
        "rented_count": 1,
        "interval": "day",
        "product_id": "a8e01f41-62d8-4877-861d-438da8081542"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/a8e01f41-62d8-4877-861d-438da8081542"
          }
        }
      }
    },
    {
      "id": "virtual-6df210c3-d52b-5021-878a-8b4a8caeccc3",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-09",
        "rented_count": 0,
        "interval": "day",
        "product_id": "a8e01f41-62d8-4877-861d-438da8081542"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/a8e01f41-62d8-4877-861d-438da8081542"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-03-10T08:36:03Z`
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







