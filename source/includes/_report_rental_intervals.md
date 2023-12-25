# Report rental intervals

Breakdown of how many times a product was rented during a specific period.

## Fields
Every report rental interval has the following fields:

Name | Description
-- | --
`id` | **Uuid** `readonly`<br>
`date` | **Date** <br>Interval date
`rented_count` | **Integer** <br>Times the product was rented
`interval` | **String** <br>The interval of the breakdown
`product_id` | **Uuid** <br>The associated Product


## Relationships
Report rental intervals have the following relationships:

Name | Description
-- | --
`product` | **Products** `readonly`<br>Associated Product


## Listing performance for a rental product per interval



> How to fetch performance per interval for a product:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-12-15+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=faa271fc-f729-4b54-b862-5ce1b3b6bc00&filter%5Btill%5D=2023-12-24+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "36cef8c2-c984-4bab-914a-c0e73e68b1a3",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-12-15",
        "rented_count": 0,
        "interval": "day",
        "product_id": "faa271fc-f729-4b54-b862-5ce1b3b6bc00"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/faa271fc-f729-4b54-b862-5ce1b3b6bc00"
          }
        }
      }
    },
    {
      "id": "d1499b02-b1ae-48cd-8ad9-da244bb455da",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-12-16",
        "rented_count": 0,
        "interval": "day",
        "product_id": "faa271fc-f729-4b54-b862-5ce1b3b6bc00"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/faa271fc-f729-4b54-b862-5ce1b3b6bc00"
          }
        }
      }
    },
    {
      "id": "b484b400-3334-475d-8b17-696113d51cc8",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-12-17",
        "rented_count": 0,
        "interval": "day",
        "product_id": "faa271fc-f729-4b54-b862-5ce1b3b6bc00"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/faa271fc-f729-4b54-b862-5ce1b3b6bc00"
          }
        }
      }
    },
    {
      "id": "470bc5f1-f7b6-462d-8097-3ddfdadf5ff2",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-12-18",
        "rented_count": 0,
        "interval": "day",
        "product_id": "faa271fc-f729-4b54-b862-5ce1b3b6bc00"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/faa271fc-f729-4b54-b862-5ce1b3b6bc00"
          }
        }
      }
    },
    {
      "id": "fc1e9691-34fa-45a2-848e-c86b248f1883",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-12-19",
        "rented_count": 1,
        "interval": "day",
        "product_id": "faa271fc-f729-4b54-b862-5ce1b3b6bc00"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/faa271fc-f729-4b54-b862-5ce1b3b6bc00"
          }
        }
      }
    },
    {
      "id": "ff5a8e9b-9bb5-4e2d-b57b-77900364692f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-12-20",
        "rented_count": 0,
        "interval": "day",
        "product_id": "faa271fc-f729-4b54-b862-5ce1b3b6bc00"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/faa271fc-f729-4b54-b862-5ce1b3b6bc00"
          }
        }
      }
    },
    {
      "id": "f2130d77-e1db-4a8e-8456-9d88ae0f19b0",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-12-21",
        "rented_count": 1,
        "interval": "day",
        "product_id": "faa271fc-f729-4b54-b862-5ce1b3b6bc00"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/faa271fc-f729-4b54-b862-5ce1b3b6bc00"
          }
        }
      }
    },
    {
      "id": "51b9cf79-aa03-4a0f-8ce3-e44c92334735",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-12-22",
        "rented_count": 0,
        "interval": "day",
        "product_id": "faa271fc-f729-4b54-b862-5ce1b3b6bc00"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/faa271fc-f729-4b54-b862-5ce1b3b6bc00"
          }
        }
      }
    },
    {
      "id": "ac2c2f5b-dd85-4e9e-a441-b0d4262a87d7",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-12-23",
        "rented_count": 1,
        "interval": "day",
        "product_id": "faa271fc-f729-4b54-b862-5ce1b3b6bc00"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/faa271fc-f729-4b54-b862-5ce1b3b6bc00"
          }
        }
      }
    },
    {
      "id": "324be7be-bcb7-41a5-9fb2-78e847ec010d",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-12-24",
        "rented_count": 0,
        "interval": "day",
        "product_id": "faa271fc-f729-4b54-b862-5ce1b3b6bc00"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/faa271fc-f729-4b54-b862-5ce1b3b6bc00"
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
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=product`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[report_rental_intervals]=date,rented_count,interval`
`filter` | **Hash** <br>The filters to apply `?filter[attribute][eq]=value`
`sort` | **String** <br>How to sort the data `?sort=attribute1,-attribute2`
`meta` | **Hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String** <br>The page to request
`page[size]` | **String** <br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
-- | --
`product_id` | **Uuid** `required`<br>`eq`
`from` | **Datetime** <br>`eq`
`till` | **Datetime** <br>`eq`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **Array** <br>`count`


### Includes

This request accepts the following includes:

`product` => 
`photo`







