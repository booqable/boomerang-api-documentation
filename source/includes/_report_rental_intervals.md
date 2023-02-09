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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-01-30+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=bcdb2941-8fa2-4b45-b57a-6413642b2e7b&filter%5Btill%5D=2023-02-08+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-22ed0e8b-3c64-5908-a597-9362358352be",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-30",
        "rented_count": 0,
        "interval": "day",
        "product_id": "bcdb2941-8fa2-4b45-b57a-6413642b2e7b"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/bcdb2941-8fa2-4b45-b57a-6413642b2e7b"
          }
        }
      }
    },
    {
      "id": "virtual-402df95e-1bc3-5f7f-98d3-25e0cd350256",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-31",
        "rented_count": 0,
        "interval": "day",
        "product_id": "bcdb2941-8fa2-4b45-b57a-6413642b2e7b"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/bcdb2941-8fa2-4b45-b57a-6413642b2e7b"
          }
        }
      }
    },
    {
      "id": "virtual-0ce849af-f52c-5966-8b84-ed5416566def",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-01",
        "rented_count": 0,
        "interval": "day",
        "product_id": "bcdb2941-8fa2-4b45-b57a-6413642b2e7b"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/bcdb2941-8fa2-4b45-b57a-6413642b2e7b"
          }
        }
      }
    },
    {
      "id": "virtual-909a2b3b-2c65-5b09-84a6-be81b5d35292",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-02",
        "rented_count": 0,
        "interval": "day",
        "product_id": "bcdb2941-8fa2-4b45-b57a-6413642b2e7b"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/bcdb2941-8fa2-4b45-b57a-6413642b2e7b"
          }
        }
      }
    },
    {
      "id": "virtual-b4b2af56-58ce-57c0-a2bc-bda765210f11",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-03",
        "rented_count": 1,
        "interval": "day",
        "product_id": "bcdb2941-8fa2-4b45-b57a-6413642b2e7b"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/bcdb2941-8fa2-4b45-b57a-6413642b2e7b"
          }
        }
      }
    },
    {
      "id": "virtual-a52d01b6-0bd0-5057-8514-a7b7e8dc9745",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-04",
        "rented_count": 0,
        "interval": "day",
        "product_id": "bcdb2941-8fa2-4b45-b57a-6413642b2e7b"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/bcdb2941-8fa2-4b45-b57a-6413642b2e7b"
          }
        }
      }
    },
    {
      "id": "virtual-92214d93-59a0-571d-ba20-c044887b4b67",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-05",
        "rented_count": 1,
        "interval": "day",
        "product_id": "bcdb2941-8fa2-4b45-b57a-6413642b2e7b"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/bcdb2941-8fa2-4b45-b57a-6413642b2e7b"
          }
        }
      }
    },
    {
      "id": "virtual-5601226c-03df-56a0-bf85-c81e853f3f56",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-06",
        "rented_count": 0,
        "interval": "day",
        "product_id": "bcdb2941-8fa2-4b45-b57a-6413642b2e7b"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/bcdb2941-8fa2-4b45-b57a-6413642b2e7b"
          }
        }
      }
    },
    {
      "id": "virtual-08b3392e-19cc-5cb2-bbc5-183ea6da0ecd",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-07",
        "rented_count": 1,
        "interval": "day",
        "product_id": "bcdb2941-8fa2-4b45-b57a-6413642b2e7b"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/bcdb2941-8fa2-4b45-b57a-6413642b2e7b"
          }
        }
      }
    },
    {
      "id": "virtual-13fb109f-bd02-5a85-9ae0-f5c10fc8389e",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-08",
        "rented_count": 0,
        "interval": "day",
        "product_id": "bcdb2941-8fa2-4b45-b57a-6413642b2e7b"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/bcdb2941-8fa2-4b45-b57a-6413642b2e7b"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-09T11:01:31Z`
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







