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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-12-01+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=ec893f8e-e885-4cd1-88c1-4aa492e386c3&filter%5Btill%5D=2023-12-10+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "7f1719f1-6b43-421d-a76f-42dcefc4f618",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-12-01",
        "rented_count": 0,
        "interval": "day",
        "product_id": "ec893f8e-e885-4cd1-88c1-4aa492e386c3"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/ec893f8e-e885-4cd1-88c1-4aa492e386c3"
          }
        }
      }
    },
    {
      "id": "0d3309ad-eda0-4cea-bea3-87701c90726e",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-12-02",
        "rented_count": 0,
        "interval": "day",
        "product_id": "ec893f8e-e885-4cd1-88c1-4aa492e386c3"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/ec893f8e-e885-4cd1-88c1-4aa492e386c3"
          }
        }
      }
    },
    {
      "id": "b21f0c94-6224-4dac-9565-a2533641d60a",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-12-03",
        "rented_count": 0,
        "interval": "day",
        "product_id": "ec893f8e-e885-4cd1-88c1-4aa492e386c3"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/ec893f8e-e885-4cd1-88c1-4aa492e386c3"
          }
        }
      }
    },
    {
      "id": "e757448a-6578-4cf6-bcfc-9486826e6314",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-12-04",
        "rented_count": 0,
        "interval": "day",
        "product_id": "ec893f8e-e885-4cd1-88c1-4aa492e386c3"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/ec893f8e-e885-4cd1-88c1-4aa492e386c3"
          }
        }
      }
    },
    {
      "id": "bfffd497-917e-40c7-8d55-66cb7859bbf3",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-12-05",
        "rented_count": 1,
        "interval": "day",
        "product_id": "ec893f8e-e885-4cd1-88c1-4aa492e386c3"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/ec893f8e-e885-4cd1-88c1-4aa492e386c3"
          }
        }
      }
    },
    {
      "id": "332cb4fe-5998-48e2-b1f6-56e0f8611846",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-12-06",
        "rented_count": 0,
        "interval": "day",
        "product_id": "ec893f8e-e885-4cd1-88c1-4aa492e386c3"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/ec893f8e-e885-4cd1-88c1-4aa492e386c3"
          }
        }
      }
    },
    {
      "id": "a4aa1d22-c1f1-4acd-af51-77689284e80b",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-12-07",
        "rented_count": 1,
        "interval": "day",
        "product_id": "ec893f8e-e885-4cd1-88c1-4aa492e386c3"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/ec893f8e-e885-4cd1-88c1-4aa492e386c3"
          }
        }
      }
    },
    {
      "id": "53ddbaa7-0bd8-4bdf-bf2d-3ba780142885",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-12-08",
        "rented_count": 0,
        "interval": "day",
        "product_id": "ec893f8e-e885-4cd1-88c1-4aa492e386c3"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/ec893f8e-e885-4cd1-88c1-4aa492e386c3"
          }
        }
      }
    },
    {
      "id": "bdf027f6-8bdb-4656-bbf6-105dff635e4c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-12-09",
        "rented_count": 1,
        "interval": "day",
        "product_id": "ec893f8e-e885-4cd1-88c1-4aa492e386c3"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/ec893f8e-e885-4cd1-88c1-4aa492e386c3"
          }
        }
      }
    },
    {
      "id": "3ea17d93-6201-4c78-ade7-fd21a73d0c40",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-12-10",
        "rented_count": 0,
        "interval": "day",
        "product_id": "ec893f8e-e885-4cd1-88c1-4aa492e386c3"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/ec893f8e-e885-4cd1-88c1-4aa492e386c3"
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







