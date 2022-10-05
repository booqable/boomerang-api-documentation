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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2022-09-25+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=3b62f64e-292d-4270-a78f-ab80ff13c021&filter%5Btill%5D=2022-10-04+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-947fe574-f256-53bf-bd88-a9ae01dffcd5",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-09-25",
        "rented_count": 0,
        "interval": "day",
        "product_id": "3b62f64e-292d-4270-a78f-ab80ff13c021"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/3b62f64e-292d-4270-a78f-ab80ff13c021"
          }
        }
      }
    },
    {
      "id": "virtual-2e5abe96-86b9-5d2d-8bf1-723e76807f6b",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-09-26",
        "rented_count": 0,
        "interval": "day",
        "product_id": "3b62f64e-292d-4270-a78f-ab80ff13c021"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/3b62f64e-292d-4270-a78f-ab80ff13c021"
          }
        }
      }
    },
    {
      "id": "virtual-13dc6cfa-81a0-54b6-a839-269f06988b30",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-09-27",
        "rented_count": 0,
        "interval": "day",
        "product_id": "3b62f64e-292d-4270-a78f-ab80ff13c021"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/3b62f64e-292d-4270-a78f-ab80ff13c021"
          }
        }
      }
    },
    {
      "id": "virtual-6ee7f6e9-3c55-5c59-b09d-f9745c08c925",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-09-28",
        "rented_count": 0,
        "interval": "day",
        "product_id": "3b62f64e-292d-4270-a78f-ab80ff13c021"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/3b62f64e-292d-4270-a78f-ab80ff13c021"
          }
        }
      }
    },
    {
      "id": "virtual-47c10d21-8671-520a-b7d9-3db1992c54bd",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-09-29",
        "rented_count": 1,
        "interval": "day",
        "product_id": "3b62f64e-292d-4270-a78f-ab80ff13c021"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/3b62f64e-292d-4270-a78f-ab80ff13c021"
          }
        }
      }
    },
    {
      "id": "virtual-19046cc5-4ec9-5c98-8312-2b324b31c5cd",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-09-30",
        "rented_count": 0,
        "interval": "day",
        "product_id": "3b62f64e-292d-4270-a78f-ab80ff13c021"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/3b62f64e-292d-4270-a78f-ab80ff13c021"
          }
        }
      }
    },
    {
      "id": "virtual-0b0c41bf-b4d7-5005-b857-dc8e315d973c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-01",
        "rented_count": 1,
        "interval": "day",
        "product_id": "3b62f64e-292d-4270-a78f-ab80ff13c021"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/3b62f64e-292d-4270-a78f-ab80ff13c021"
          }
        }
      }
    },
    {
      "id": "virtual-2383492e-4df4-5da1-8538-7fcdf009f50a",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-02",
        "rented_count": 0,
        "interval": "day",
        "product_id": "3b62f64e-292d-4270-a78f-ab80ff13c021"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/3b62f64e-292d-4270-a78f-ab80ff13c021"
          }
        }
      }
    },
    {
      "id": "virtual-437ac724-5060-5048-bac6-87fa65de4216",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-03",
        "rented_count": 1,
        "interval": "day",
        "product_id": "3b62f64e-292d-4270-a78f-ab80ff13c021"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/3b62f64e-292d-4270-a78f-ab80ff13c021"
          }
        }
      }
    },
    {
      "id": "virtual-8228e273-3bd2-506a-a845-7a44dc934043",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-04",
        "rented_count": 0,
        "interval": "day",
        "product_id": "3b62f64e-292d-4270-a78f-ab80ff13c021"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/3b62f64e-292d-4270-a78f-ab80ff13c021"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-10-05T11:34:45Z`
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







