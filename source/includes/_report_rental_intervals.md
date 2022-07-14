# Report rental intervals

Breakdown of how many times a product was rented during a specific period.

## Fields
Every report rental interval has the following fields:

Name | Description
- | -
`id` | **Uuid** `readonly`<br>
`date` | **Date**<br>Interval date
`rented_count` | **Integer**<br>Times the product was rented
`interval` | **String**<br>The interval of the breakdown
`product_id` | **Uuid**<br>The associated Product


## Relationships
Report rental intervals have the following relationships:

Name | Description
- | -
`product` | **Products** `readonly`<br>Associated Product


## Listing performance for a rental product per interval



> How to fetch performance per interval for a product:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2022-07-04+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=b2123e36-c9da-4f4f-be72-acf97dcee906&filter%5Btill%5D=2022-07-13+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-1026e658-a94a-56d7-9b3e-de972c300e6b",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-04",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b2123e36-c9da-4f4f-be72-acf97dcee906"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b2123e36-c9da-4f4f-be72-acf97dcee906"
          }
        }
      }
    },
    {
      "id": "virtual-7b1ef733-da63-54fd-b723-a9a0023d713c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-05",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b2123e36-c9da-4f4f-be72-acf97dcee906"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b2123e36-c9da-4f4f-be72-acf97dcee906"
          }
        }
      }
    },
    {
      "id": "virtual-7c4d95c2-d80b-526c-875c-a44c1757405d",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-06",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b2123e36-c9da-4f4f-be72-acf97dcee906"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b2123e36-c9da-4f4f-be72-acf97dcee906"
          }
        }
      }
    },
    {
      "id": "virtual-3be84eba-f3be-53df-8f9b-5f9ee6c22eba",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-07",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b2123e36-c9da-4f4f-be72-acf97dcee906"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b2123e36-c9da-4f4f-be72-acf97dcee906"
          }
        }
      }
    },
    {
      "id": "virtual-b1576e37-c0b8-5feb-b817-54d6cc700326",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-08",
        "rented_count": 1,
        "interval": "day",
        "product_id": "b2123e36-c9da-4f4f-be72-acf97dcee906"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b2123e36-c9da-4f4f-be72-acf97dcee906"
          }
        }
      }
    },
    {
      "id": "virtual-423958d4-1618-5763-a76a-d6e029efc7c4",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-09",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b2123e36-c9da-4f4f-be72-acf97dcee906"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b2123e36-c9da-4f4f-be72-acf97dcee906"
          }
        }
      }
    },
    {
      "id": "virtual-c6d2eca2-99b5-509b-ba82-c82304a78a7f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-10",
        "rented_count": 1,
        "interval": "day",
        "product_id": "b2123e36-c9da-4f4f-be72-acf97dcee906"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b2123e36-c9da-4f4f-be72-acf97dcee906"
          }
        }
      }
    },
    {
      "id": "virtual-eda11020-3e83-58de-a9b3-c7cdd7029a32",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-11",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b2123e36-c9da-4f4f-be72-acf97dcee906"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b2123e36-c9da-4f4f-be72-acf97dcee906"
          }
        }
      }
    },
    {
      "id": "virtual-43cfe7a9-0c2e-54fc-a659-5d9695eb9cc1",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-12",
        "rented_count": 1,
        "interval": "day",
        "product_id": "b2123e36-c9da-4f4f-be72-acf97dcee906"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b2123e36-c9da-4f4f-be72-acf97dcee906"
          }
        }
      }
    },
    {
      "id": "virtual-4e7e6f67-bce5-543d-9dae-9f7cebc47491",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-13",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b2123e36-c9da-4f4f-be72-acf97dcee906"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/b2123e36-c9da-4f4f-be72-acf97dcee906"
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=product`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[report_rental_intervals]=id,created_at,updated_at`
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-07-14T13:03:03Z`
`sort` | **String**<br>How to sort the data `?sort=-created_at`
`meta` | **Hash**<br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String**<br>The page to request
`page[size]` | **String**<br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
`product_id` | **Uuid** `required`<br>`eq`
`from` | **Datetime**<br>`eq`
`till` | **Datetime**<br>`eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array**<br>`count`


### Includes

This request accepts the following includes:

`product` => 
`photo`







