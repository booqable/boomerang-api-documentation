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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2022-11-20+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=da63223f-b5c1-44f2-9475-a47b23f43b52&filter%5Btill%5D=2022-11-29+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-8977ea37-cba0-5854-95a6-08af688c76fb",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-20",
        "rented_count": 0,
        "interval": "day",
        "product_id": "da63223f-b5c1-44f2-9475-a47b23f43b52"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/da63223f-b5c1-44f2-9475-a47b23f43b52"
          }
        }
      }
    },
    {
      "id": "virtual-1c24184a-2c43-5e86-a60e-1c33b1e0600d",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-21",
        "rented_count": 0,
        "interval": "day",
        "product_id": "da63223f-b5c1-44f2-9475-a47b23f43b52"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/da63223f-b5c1-44f2-9475-a47b23f43b52"
          }
        }
      }
    },
    {
      "id": "virtual-81d02698-8e72-5517-afd4-52d79feb5fff",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-22",
        "rented_count": 0,
        "interval": "day",
        "product_id": "da63223f-b5c1-44f2-9475-a47b23f43b52"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/da63223f-b5c1-44f2-9475-a47b23f43b52"
          }
        }
      }
    },
    {
      "id": "virtual-373ebfd1-a317-57d2-9ac3-d569ded55c54",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-23",
        "rented_count": 0,
        "interval": "day",
        "product_id": "da63223f-b5c1-44f2-9475-a47b23f43b52"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/da63223f-b5c1-44f2-9475-a47b23f43b52"
          }
        }
      }
    },
    {
      "id": "virtual-dc311f05-deb2-5c8d-ba6c-eded4dad27e5",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-24",
        "rented_count": 1,
        "interval": "day",
        "product_id": "da63223f-b5c1-44f2-9475-a47b23f43b52"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/da63223f-b5c1-44f2-9475-a47b23f43b52"
          }
        }
      }
    },
    {
      "id": "virtual-5c802bcc-da67-5c93-b13e-6b162e2ef64f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-25",
        "rented_count": 0,
        "interval": "day",
        "product_id": "da63223f-b5c1-44f2-9475-a47b23f43b52"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/da63223f-b5c1-44f2-9475-a47b23f43b52"
          }
        }
      }
    },
    {
      "id": "virtual-88135a74-78a4-5d7a-a9ff-ca015d3e4871",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-26",
        "rented_count": 1,
        "interval": "day",
        "product_id": "da63223f-b5c1-44f2-9475-a47b23f43b52"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/da63223f-b5c1-44f2-9475-a47b23f43b52"
          }
        }
      }
    },
    {
      "id": "virtual-4a89a803-15e1-5456-9ea7-e6dbc21d6b03",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-27",
        "rented_count": 0,
        "interval": "day",
        "product_id": "da63223f-b5c1-44f2-9475-a47b23f43b52"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/da63223f-b5c1-44f2-9475-a47b23f43b52"
          }
        }
      }
    },
    {
      "id": "virtual-766e5ac2-9670-56bb-86b2-f88709abfaca",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-28",
        "rented_count": 1,
        "interval": "day",
        "product_id": "da63223f-b5c1-44f2-9475-a47b23f43b52"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/da63223f-b5c1-44f2-9475-a47b23f43b52"
          }
        }
      }
    },
    {
      "id": "virtual-0eef1a03-29d0-5aaf-8786-5e4111b5fb83",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-29",
        "rented_count": 0,
        "interval": "day",
        "product_id": "da63223f-b5c1-44f2-9475-a47b23f43b52"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/da63223f-b5c1-44f2-9475-a47b23f43b52"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-11-30T08:56:45Z`
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







