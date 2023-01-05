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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2022-12-26+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=25494491-c533-49fa-91ce-35e9a6ad5a9e&filter%5Btill%5D=2023-01-04+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-e3beb6c9-db53-5d9b-871b-06bb9d05ddfe",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-12-26",
        "rented_count": 0,
        "interval": "day",
        "product_id": "25494491-c533-49fa-91ce-35e9a6ad5a9e"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/25494491-c533-49fa-91ce-35e9a6ad5a9e"
          }
        }
      }
    },
    {
      "id": "virtual-40a34cac-4f29-5621-836d-6c2ca392da6f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-12-27",
        "rented_count": 0,
        "interval": "day",
        "product_id": "25494491-c533-49fa-91ce-35e9a6ad5a9e"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/25494491-c533-49fa-91ce-35e9a6ad5a9e"
          }
        }
      }
    },
    {
      "id": "virtual-5b15c93a-c8c7-51b6-9644-9c3d5c28b0bf",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-12-28",
        "rented_count": 0,
        "interval": "day",
        "product_id": "25494491-c533-49fa-91ce-35e9a6ad5a9e"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/25494491-c533-49fa-91ce-35e9a6ad5a9e"
          }
        }
      }
    },
    {
      "id": "virtual-ade73aaf-4818-5694-8652-153a43e489bb",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-12-29",
        "rented_count": 0,
        "interval": "day",
        "product_id": "25494491-c533-49fa-91ce-35e9a6ad5a9e"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/25494491-c533-49fa-91ce-35e9a6ad5a9e"
          }
        }
      }
    },
    {
      "id": "virtual-267b3546-e5a9-5b51-8aa5-8e1e59878d2d",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-12-30",
        "rented_count": 1,
        "interval": "day",
        "product_id": "25494491-c533-49fa-91ce-35e9a6ad5a9e"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/25494491-c533-49fa-91ce-35e9a6ad5a9e"
          }
        }
      }
    },
    {
      "id": "virtual-3610bec5-ae6b-52b7-babc-e985a80cff42",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-12-31",
        "rented_count": 0,
        "interval": "day",
        "product_id": "25494491-c533-49fa-91ce-35e9a6ad5a9e"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/25494491-c533-49fa-91ce-35e9a6ad5a9e"
          }
        }
      }
    },
    {
      "id": "virtual-eaea7bd3-020f-5ed3-82bf-c1412ac8e3c9",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-01",
        "rented_count": 1,
        "interval": "day",
        "product_id": "25494491-c533-49fa-91ce-35e9a6ad5a9e"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/25494491-c533-49fa-91ce-35e9a6ad5a9e"
          }
        }
      }
    },
    {
      "id": "virtual-e4bedf5c-ac35-53c7-aa3b-691e4dab7192",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-02",
        "rented_count": 0,
        "interval": "day",
        "product_id": "25494491-c533-49fa-91ce-35e9a6ad5a9e"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/25494491-c533-49fa-91ce-35e9a6ad5a9e"
          }
        }
      }
    },
    {
      "id": "virtual-024f8207-c0fa-5ba6-8b1f-24c5ce83797c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-03",
        "rented_count": 1,
        "interval": "day",
        "product_id": "25494491-c533-49fa-91ce-35e9a6ad5a9e"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/25494491-c533-49fa-91ce-35e9a6ad5a9e"
          }
        }
      }
    },
    {
      "id": "virtual-ae84e1df-d5ec-5d9e-a42b-189eb055c78f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-04",
        "rented_count": 0,
        "interval": "day",
        "product_id": "25494491-c533-49fa-91ce-35e9a6ad5a9e"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/25494491-c533-49fa-91ce-35e9a6ad5a9e"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-01-05T13:07:32Z`
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







