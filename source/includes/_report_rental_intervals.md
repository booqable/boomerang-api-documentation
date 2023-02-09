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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-01-30+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=ec44d443-a630-4b36-9305-aff1d5d96f89&filter%5Btill%5D=2023-02-08+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-6ff8cfc3-6144-5197-add7-7bb79e1697b8",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-30",
        "rented_count": 0,
        "interval": "day",
        "product_id": "ec44d443-a630-4b36-9305-aff1d5d96f89"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/ec44d443-a630-4b36-9305-aff1d5d96f89"
          }
        }
      }
    },
    {
      "id": "virtual-f8cd4fb5-0f1d-5c49-b169-9778959c0ff0",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-31",
        "rented_count": 0,
        "interval": "day",
        "product_id": "ec44d443-a630-4b36-9305-aff1d5d96f89"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/ec44d443-a630-4b36-9305-aff1d5d96f89"
          }
        }
      }
    },
    {
      "id": "virtual-0e3111f2-37e9-54e8-a49e-ccfd7ba6c67f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-01",
        "rented_count": 0,
        "interval": "day",
        "product_id": "ec44d443-a630-4b36-9305-aff1d5d96f89"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/ec44d443-a630-4b36-9305-aff1d5d96f89"
          }
        }
      }
    },
    {
      "id": "virtual-38fe2c7c-862c-521d-a3b5-4f0295037086",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-02",
        "rented_count": 0,
        "interval": "day",
        "product_id": "ec44d443-a630-4b36-9305-aff1d5d96f89"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/ec44d443-a630-4b36-9305-aff1d5d96f89"
          }
        }
      }
    },
    {
      "id": "virtual-838824f1-19a7-5b3d-812f-7b0542e823ad",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-03",
        "rented_count": 1,
        "interval": "day",
        "product_id": "ec44d443-a630-4b36-9305-aff1d5d96f89"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/ec44d443-a630-4b36-9305-aff1d5d96f89"
          }
        }
      }
    },
    {
      "id": "virtual-c75365ef-8271-5f4b-800d-425b761745c5",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-04",
        "rented_count": 0,
        "interval": "day",
        "product_id": "ec44d443-a630-4b36-9305-aff1d5d96f89"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/ec44d443-a630-4b36-9305-aff1d5d96f89"
          }
        }
      }
    },
    {
      "id": "virtual-429e31e0-222f-5c16-bbb5-ad5b82f5f60d",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-05",
        "rented_count": 1,
        "interval": "day",
        "product_id": "ec44d443-a630-4b36-9305-aff1d5d96f89"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/ec44d443-a630-4b36-9305-aff1d5d96f89"
          }
        }
      }
    },
    {
      "id": "virtual-2cc297ab-2f6c-5101-aa38-b2fdb23d781e",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-06",
        "rented_count": 0,
        "interval": "day",
        "product_id": "ec44d443-a630-4b36-9305-aff1d5d96f89"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/ec44d443-a630-4b36-9305-aff1d5d96f89"
          }
        }
      }
    },
    {
      "id": "virtual-d796cc21-7004-51fb-aed9-c2f473a26f46",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-07",
        "rented_count": 1,
        "interval": "day",
        "product_id": "ec44d443-a630-4b36-9305-aff1d5d96f89"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/ec44d443-a630-4b36-9305-aff1d5d96f89"
          }
        }
      }
    },
    {
      "id": "virtual-1b4e4a9f-d3f5-566b-9e4f-249da034eb93",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-08",
        "rented_count": 0,
        "interval": "day",
        "product_id": "ec44d443-a630-4b36-9305-aff1d5d96f89"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/ec44d443-a630-4b36-9305-aff1d5d96f89"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-09T15:54:14Z`
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







