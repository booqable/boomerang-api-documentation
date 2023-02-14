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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-02-04+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=392046f9-75f6-402f-b15e-6bf09d4b0f63&filter%5Btill%5D=2023-02-13+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-446ccbe5-15cc-5a69-b5a4-c59fb69fde45",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-04",
        "rented_count": 0,
        "interval": "day",
        "product_id": "392046f9-75f6-402f-b15e-6bf09d4b0f63"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/392046f9-75f6-402f-b15e-6bf09d4b0f63"
          }
        }
      }
    },
    {
      "id": "virtual-26e3df22-3dd0-592d-a34c-e7247315ef50",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-05",
        "rented_count": 0,
        "interval": "day",
        "product_id": "392046f9-75f6-402f-b15e-6bf09d4b0f63"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/392046f9-75f6-402f-b15e-6bf09d4b0f63"
          }
        }
      }
    },
    {
      "id": "virtual-47cf176d-53c0-5652-b174-09ecf7b5bc53",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-06",
        "rented_count": 0,
        "interval": "day",
        "product_id": "392046f9-75f6-402f-b15e-6bf09d4b0f63"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/392046f9-75f6-402f-b15e-6bf09d4b0f63"
          }
        }
      }
    },
    {
      "id": "virtual-a6891636-6123-5de2-b199-389d1b6e4469",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-07",
        "rented_count": 0,
        "interval": "day",
        "product_id": "392046f9-75f6-402f-b15e-6bf09d4b0f63"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/392046f9-75f6-402f-b15e-6bf09d4b0f63"
          }
        }
      }
    },
    {
      "id": "virtual-1d2a7a36-fd0b-5a0d-8533-b73a40537ca9",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-08",
        "rented_count": 1,
        "interval": "day",
        "product_id": "392046f9-75f6-402f-b15e-6bf09d4b0f63"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/392046f9-75f6-402f-b15e-6bf09d4b0f63"
          }
        }
      }
    },
    {
      "id": "virtual-36fe6205-5e61-523c-94ec-e430dab7d50d",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-09",
        "rented_count": 0,
        "interval": "day",
        "product_id": "392046f9-75f6-402f-b15e-6bf09d4b0f63"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/392046f9-75f6-402f-b15e-6bf09d4b0f63"
          }
        }
      }
    },
    {
      "id": "virtual-41c3d39d-c95d-5c9f-bfc2-3d74451cdf47",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-10",
        "rented_count": 1,
        "interval": "day",
        "product_id": "392046f9-75f6-402f-b15e-6bf09d4b0f63"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/392046f9-75f6-402f-b15e-6bf09d4b0f63"
          }
        }
      }
    },
    {
      "id": "virtual-1575ad72-038e-5abe-a605-ab6e7f3c28b8",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-11",
        "rented_count": 0,
        "interval": "day",
        "product_id": "392046f9-75f6-402f-b15e-6bf09d4b0f63"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/392046f9-75f6-402f-b15e-6bf09d4b0f63"
          }
        }
      }
    },
    {
      "id": "virtual-e535f23b-834e-554f-8cf1-dd65b6776e4c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-12",
        "rented_count": 1,
        "interval": "day",
        "product_id": "392046f9-75f6-402f-b15e-6bf09d4b0f63"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/392046f9-75f6-402f-b15e-6bf09d4b0f63"
          }
        }
      }
    },
    {
      "id": "virtual-41ddec21-2ff8-53d2-8567-813829769c41",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-13",
        "rented_count": 0,
        "interval": "day",
        "product_id": "392046f9-75f6-402f-b15e-6bf09d4b0f63"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/392046f9-75f6-402f-b15e-6bf09d4b0f63"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-14T11:03:18Z`
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







