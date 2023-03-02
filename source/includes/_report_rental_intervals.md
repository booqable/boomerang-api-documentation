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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-02-20+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=2c43a67a-0c1d-4fd4-b7da-c31ad9edfbbb&filter%5Btill%5D=2023-03-01+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-60df88c2-e072-543c-87d2-491b664f0262",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-20",
        "rented_count": 0,
        "interval": "day",
        "product_id": "2c43a67a-0c1d-4fd4-b7da-c31ad9edfbbb"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/2c43a67a-0c1d-4fd4-b7da-c31ad9edfbbb"
          }
        }
      }
    },
    {
      "id": "virtual-fbdadd21-507d-5f8f-b33c-e87cac33b83b",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-21",
        "rented_count": 0,
        "interval": "day",
        "product_id": "2c43a67a-0c1d-4fd4-b7da-c31ad9edfbbb"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/2c43a67a-0c1d-4fd4-b7da-c31ad9edfbbb"
          }
        }
      }
    },
    {
      "id": "virtual-b73f5610-0f34-5044-8ab4-56c8602137cc",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-22",
        "rented_count": 0,
        "interval": "day",
        "product_id": "2c43a67a-0c1d-4fd4-b7da-c31ad9edfbbb"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/2c43a67a-0c1d-4fd4-b7da-c31ad9edfbbb"
          }
        }
      }
    },
    {
      "id": "virtual-0ce35451-95b9-5811-89f2-50ef21cfb402",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-23",
        "rented_count": 0,
        "interval": "day",
        "product_id": "2c43a67a-0c1d-4fd4-b7da-c31ad9edfbbb"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/2c43a67a-0c1d-4fd4-b7da-c31ad9edfbbb"
          }
        }
      }
    },
    {
      "id": "virtual-585790d6-4b7b-56cc-9f6d-2a0d77143d9e",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-24",
        "rented_count": 1,
        "interval": "day",
        "product_id": "2c43a67a-0c1d-4fd4-b7da-c31ad9edfbbb"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/2c43a67a-0c1d-4fd4-b7da-c31ad9edfbbb"
          }
        }
      }
    },
    {
      "id": "virtual-8ee381d8-607b-528e-889d-2c7dcdd5a73a",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-25",
        "rented_count": 0,
        "interval": "day",
        "product_id": "2c43a67a-0c1d-4fd4-b7da-c31ad9edfbbb"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/2c43a67a-0c1d-4fd4-b7da-c31ad9edfbbb"
          }
        }
      }
    },
    {
      "id": "virtual-7bf549c6-a32d-521c-8070-5488d2d1bf38",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-26",
        "rented_count": 1,
        "interval": "day",
        "product_id": "2c43a67a-0c1d-4fd4-b7da-c31ad9edfbbb"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/2c43a67a-0c1d-4fd4-b7da-c31ad9edfbbb"
          }
        }
      }
    },
    {
      "id": "virtual-d5e99a32-c060-5422-b95d-b1ee0166997a",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-27",
        "rented_count": 0,
        "interval": "day",
        "product_id": "2c43a67a-0c1d-4fd4-b7da-c31ad9edfbbb"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/2c43a67a-0c1d-4fd4-b7da-c31ad9edfbbb"
          }
        }
      }
    },
    {
      "id": "virtual-2285181e-abe0-5866-a4cb-a57f3fd44389",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-28",
        "rented_count": 1,
        "interval": "day",
        "product_id": "2c43a67a-0c1d-4fd4-b7da-c31ad9edfbbb"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/2c43a67a-0c1d-4fd4-b7da-c31ad9edfbbb"
          }
        }
      }
    },
    {
      "id": "virtual-353af55c-730f-55b4-b09c-653e90415aaa",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-01",
        "rented_count": 0,
        "interval": "day",
        "product_id": "2c43a67a-0c1d-4fd4-b7da-c31ad9edfbbb"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/2c43a67a-0c1d-4fd4-b7da-c31ad9edfbbb"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-03-02T09:22:42Z`
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







