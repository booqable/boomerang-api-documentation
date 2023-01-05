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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2022-12-26+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=342dd002-23f0-4ee9-8358-21a1ad36b2de&filter%5Btill%5D=2023-01-04+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-c60a1f64-e5da-591c-af44-963418f774ee",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-12-26",
        "rented_count": 0,
        "interval": "day",
        "product_id": "342dd002-23f0-4ee9-8358-21a1ad36b2de"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/342dd002-23f0-4ee9-8358-21a1ad36b2de"
          }
        }
      }
    },
    {
      "id": "virtual-7f997328-caef-5f89-925d-b0b2ed1d6775",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-12-27",
        "rented_count": 0,
        "interval": "day",
        "product_id": "342dd002-23f0-4ee9-8358-21a1ad36b2de"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/342dd002-23f0-4ee9-8358-21a1ad36b2de"
          }
        }
      }
    },
    {
      "id": "virtual-95f52ffd-7861-5064-b7d9-d50dfbf94dfc",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-12-28",
        "rented_count": 0,
        "interval": "day",
        "product_id": "342dd002-23f0-4ee9-8358-21a1ad36b2de"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/342dd002-23f0-4ee9-8358-21a1ad36b2de"
          }
        }
      }
    },
    {
      "id": "virtual-5a242c1a-9062-5956-9366-9cb23908fc9a",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-12-29",
        "rented_count": 0,
        "interval": "day",
        "product_id": "342dd002-23f0-4ee9-8358-21a1ad36b2de"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/342dd002-23f0-4ee9-8358-21a1ad36b2de"
          }
        }
      }
    },
    {
      "id": "virtual-1005d742-c4e7-5a80-92fd-efbf1a3da3f2",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-12-30",
        "rented_count": 1,
        "interval": "day",
        "product_id": "342dd002-23f0-4ee9-8358-21a1ad36b2de"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/342dd002-23f0-4ee9-8358-21a1ad36b2de"
          }
        }
      }
    },
    {
      "id": "virtual-49f07069-9bbb-57c2-a287-9b03457ab24d",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-12-31",
        "rented_count": 0,
        "interval": "day",
        "product_id": "342dd002-23f0-4ee9-8358-21a1ad36b2de"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/342dd002-23f0-4ee9-8358-21a1ad36b2de"
          }
        }
      }
    },
    {
      "id": "virtual-fd1be55a-f58f-596a-8fdc-cdd89c3137c4",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-01",
        "rented_count": 1,
        "interval": "day",
        "product_id": "342dd002-23f0-4ee9-8358-21a1ad36b2de"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/342dd002-23f0-4ee9-8358-21a1ad36b2de"
          }
        }
      }
    },
    {
      "id": "virtual-0464dad6-f52e-5392-8e10-07598c134195",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-02",
        "rented_count": 0,
        "interval": "day",
        "product_id": "342dd002-23f0-4ee9-8358-21a1ad36b2de"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/342dd002-23f0-4ee9-8358-21a1ad36b2de"
          }
        }
      }
    },
    {
      "id": "virtual-aaf41049-799c-504b-b439-1c3358e4b3e2",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-03",
        "rented_count": 1,
        "interval": "day",
        "product_id": "342dd002-23f0-4ee9-8358-21a1ad36b2de"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/342dd002-23f0-4ee9-8358-21a1ad36b2de"
          }
        }
      }
    },
    {
      "id": "virtual-7b5995f9-857a-547f-88ea-845fb5ae4c90",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-04",
        "rented_count": 0,
        "interval": "day",
        "product_id": "342dd002-23f0-4ee9-8358-21a1ad36b2de"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/342dd002-23f0-4ee9-8358-21a1ad36b2de"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-01-05T13:01:30Z`
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







