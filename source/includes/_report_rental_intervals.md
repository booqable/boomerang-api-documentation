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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2022-12-27+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=b65af074-1a62-486d-9b76-79b212dd952d&filter%5Btill%5D=2023-01-05+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-2edd37fd-9c27-5714-8141-c12a13b28992",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-12-27",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b65af074-1a62-486d-9b76-79b212dd952d"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b65af074-1a62-486d-9b76-79b212dd952d"
          }
        }
      }
    },
    {
      "id": "virtual-07d88590-acc3-505a-8cd3-c7f3a03b1120",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-12-28",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b65af074-1a62-486d-9b76-79b212dd952d"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b65af074-1a62-486d-9b76-79b212dd952d"
          }
        }
      }
    },
    {
      "id": "virtual-681e1db5-9190-5e51-9390-4883aceb191b",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-12-29",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b65af074-1a62-486d-9b76-79b212dd952d"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b65af074-1a62-486d-9b76-79b212dd952d"
          }
        }
      }
    },
    {
      "id": "virtual-fbd3685c-c09a-5f73-9335-085e0c2921d1",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-12-30",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b65af074-1a62-486d-9b76-79b212dd952d"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b65af074-1a62-486d-9b76-79b212dd952d"
          }
        }
      }
    },
    {
      "id": "virtual-b165ca93-1c6b-5269-87e0-dc4cb830527e",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-12-31",
        "rented_count": 1,
        "interval": "day",
        "product_id": "b65af074-1a62-486d-9b76-79b212dd952d"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b65af074-1a62-486d-9b76-79b212dd952d"
          }
        }
      }
    },
    {
      "id": "virtual-0c8a35fb-3a2c-5669-9b91-5546238e9457",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-01",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b65af074-1a62-486d-9b76-79b212dd952d"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b65af074-1a62-486d-9b76-79b212dd952d"
          }
        }
      }
    },
    {
      "id": "virtual-97af5242-dcba-5c4f-add6-52116632f01c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-02",
        "rented_count": 1,
        "interval": "day",
        "product_id": "b65af074-1a62-486d-9b76-79b212dd952d"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b65af074-1a62-486d-9b76-79b212dd952d"
          }
        }
      }
    },
    {
      "id": "virtual-3b7406eb-45fa-5a49-b86d-ff114432f32f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-03",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b65af074-1a62-486d-9b76-79b212dd952d"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b65af074-1a62-486d-9b76-79b212dd952d"
          }
        }
      }
    },
    {
      "id": "virtual-d2a1cf88-2c3e-5669-959c-2069ff08db7a",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-04",
        "rented_count": 1,
        "interval": "day",
        "product_id": "b65af074-1a62-486d-9b76-79b212dd952d"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b65af074-1a62-486d-9b76-79b212dd952d"
          }
        }
      }
    },
    {
      "id": "virtual-cb3a1969-6bc7-59eb-8e8c-335747e70090",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-05",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b65af074-1a62-486d-9b76-79b212dd952d"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b65af074-1a62-486d-9b76-79b212dd952d"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-01-06T15:12:23Z`
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







