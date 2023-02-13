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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-02-03+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=cdb1ff65-ad84-4545-afba-065f932fd0f9&filter%5Btill%5D=2023-02-12+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-3bcad962-97fc-573d-8ed4-5a9aae5ac836",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-03",
        "rented_count": 0,
        "interval": "day",
        "product_id": "cdb1ff65-ad84-4545-afba-065f932fd0f9"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/cdb1ff65-ad84-4545-afba-065f932fd0f9"
          }
        }
      }
    },
    {
      "id": "virtual-d6b7f82a-036e-5eb8-9191-3ac0b6f0340c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-04",
        "rented_count": 0,
        "interval": "day",
        "product_id": "cdb1ff65-ad84-4545-afba-065f932fd0f9"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/cdb1ff65-ad84-4545-afba-065f932fd0f9"
          }
        }
      }
    },
    {
      "id": "virtual-209a0a5f-7169-567a-8a36-094cbbab0fdf",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-05",
        "rented_count": 0,
        "interval": "day",
        "product_id": "cdb1ff65-ad84-4545-afba-065f932fd0f9"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/cdb1ff65-ad84-4545-afba-065f932fd0f9"
          }
        }
      }
    },
    {
      "id": "virtual-31a8a480-6cf6-5a9d-87b8-1862f1df4243",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-06",
        "rented_count": 0,
        "interval": "day",
        "product_id": "cdb1ff65-ad84-4545-afba-065f932fd0f9"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/cdb1ff65-ad84-4545-afba-065f932fd0f9"
          }
        }
      }
    },
    {
      "id": "virtual-f3430fb4-ef26-5111-bbb8-2c8f3addfdd6",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-07",
        "rented_count": 1,
        "interval": "day",
        "product_id": "cdb1ff65-ad84-4545-afba-065f932fd0f9"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/cdb1ff65-ad84-4545-afba-065f932fd0f9"
          }
        }
      }
    },
    {
      "id": "virtual-5e858a83-8cc1-56dc-a13f-f45581d1482c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-08",
        "rented_count": 0,
        "interval": "day",
        "product_id": "cdb1ff65-ad84-4545-afba-065f932fd0f9"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/cdb1ff65-ad84-4545-afba-065f932fd0f9"
          }
        }
      }
    },
    {
      "id": "virtual-a04108db-c52e-5101-8ad4-efb4fd40dfe9",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-09",
        "rented_count": 1,
        "interval": "day",
        "product_id": "cdb1ff65-ad84-4545-afba-065f932fd0f9"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/cdb1ff65-ad84-4545-afba-065f932fd0f9"
          }
        }
      }
    },
    {
      "id": "virtual-2d2f8a43-d2bd-524c-a4c0-c79a72561767",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-10",
        "rented_count": 0,
        "interval": "day",
        "product_id": "cdb1ff65-ad84-4545-afba-065f932fd0f9"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/cdb1ff65-ad84-4545-afba-065f932fd0f9"
          }
        }
      }
    },
    {
      "id": "virtual-580d966d-cdf5-5d48-b1df-84ee5aaca1f0",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-11",
        "rented_count": 1,
        "interval": "day",
        "product_id": "cdb1ff65-ad84-4545-afba-065f932fd0f9"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/cdb1ff65-ad84-4545-afba-065f932fd0f9"
          }
        }
      }
    },
    {
      "id": "virtual-f7634c4e-9979-5bcc-81e8-60e20297c9b7",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-12",
        "rented_count": 0,
        "interval": "day",
        "product_id": "cdb1ff65-ad84-4545-afba-065f932fd0f9"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/cdb1ff65-ad84-4545-afba-065f932fd0f9"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-13T12:12:14Z`
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







