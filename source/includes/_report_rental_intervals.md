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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-11-27+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=ebf5d2d5-3968-4bef-a644-cd8dd2b261db&filter%5Btill%5D=2023-12-06+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "b38c0281-ffd5-4994-9e4a-f45cff30622c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-11-27",
        "rented_count": 0,
        "interval": "day",
        "product_id": "ebf5d2d5-3968-4bef-a644-cd8dd2b261db"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/ebf5d2d5-3968-4bef-a644-cd8dd2b261db"
          }
        }
      }
    },
    {
      "id": "5b7807ad-2d5d-4e8c-9a5a-423e69456ce2",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-11-28",
        "rented_count": 0,
        "interval": "day",
        "product_id": "ebf5d2d5-3968-4bef-a644-cd8dd2b261db"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/ebf5d2d5-3968-4bef-a644-cd8dd2b261db"
          }
        }
      }
    },
    {
      "id": "2c5e50ca-1b12-4d50-a245-37ac3f55da39",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-11-29",
        "rented_count": 0,
        "interval": "day",
        "product_id": "ebf5d2d5-3968-4bef-a644-cd8dd2b261db"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/ebf5d2d5-3968-4bef-a644-cd8dd2b261db"
          }
        }
      }
    },
    {
      "id": "35bf52e6-c17a-48bc-a1c7-5649535fd219",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-11-30",
        "rented_count": 0,
        "interval": "day",
        "product_id": "ebf5d2d5-3968-4bef-a644-cd8dd2b261db"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/ebf5d2d5-3968-4bef-a644-cd8dd2b261db"
          }
        }
      }
    },
    {
      "id": "02fb2308-86b1-4a61-bac3-e9604276c174",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-12-01",
        "rented_count": 1,
        "interval": "day",
        "product_id": "ebf5d2d5-3968-4bef-a644-cd8dd2b261db"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/ebf5d2d5-3968-4bef-a644-cd8dd2b261db"
          }
        }
      }
    },
    {
      "id": "c08c8b40-c82a-40b6-ae24-ae120a6ae798",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-12-02",
        "rented_count": 0,
        "interval": "day",
        "product_id": "ebf5d2d5-3968-4bef-a644-cd8dd2b261db"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/ebf5d2d5-3968-4bef-a644-cd8dd2b261db"
          }
        }
      }
    },
    {
      "id": "011edef8-55fb-4a78-bac4-d4546bd88c49",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-12-03",
        "rented_count": 1,
        "interval": "day",
        "product_id": "ebf5d2d5-3968-4bef-a644-cd8dd2b261db"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/ebf5d2d5-3968-4bef-a644-cd8dd2b261db"
          }
        }
      }
    },
    {
      "id": "b969b610-bf4e-4aad-ad6c-bffc951fca82",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-12-04",
        "rented_count": 0,
        "interval": "day",
        "product_id": "ebf5d2d5-3968-4bef-a644-cd8dd2b261db"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/ebf5d2d5-3968-4bef-a644-cd8dd2b261db"
          }
        }
      }
    },
    {
      "id": "5e7bc08f-e863-41c8-9bb6-db3bac56450c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-12-05",
        "rented_count": 1,
        "interval": "day",
        "product_id": "ebf5d2d5-3968-4bef-a644-cd8dd2b261db"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/ebf5d2d5-3968-4bef-a644-cd8dd2b261db"
          }
        }
      }
    },
    {
      "id": "3717b2d0-da0e-4b63-a626-353e1e6e98b6",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-12-06",
        "rented_count": 0,
        "interval": "day",
        "product_id": "ebf5d2d5-3968-4bef-a644-cd8dd2b261db"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/ebf5d2d5-3968-4bef-a644-cd8dd2b261db"
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







