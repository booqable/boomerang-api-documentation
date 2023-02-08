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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-01-29+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=ad5a0a13-f173-40cf-b427-11c662326825&filter%5Btill%5D=2023-02-07+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-28b975c4-f0e9-50af-abe3-6c3a93e2af27",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-29",
        "rented_count": 0,
        "interval": "day",
        "product_id": "ad5a0a13-f173-40cf-b427-11c662326825"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/ad5a0a13-f173-40cf-b427-11c662326825"
          }
        }
      }
    },
    {
      "id": "virtual-542ab144-862f-54d3-a94c-218779510b80",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-30",
        "rented_count": 0,
        "interval": "day",
        "product_id": "ad5a0a13-f173-40cf-b427-11c662326825"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/ad5a0a13-f173-40cf-b427-11c662326825"
          }
        }
      }
    },
    {
      "id": "virtual-7053c359-c749-5041-97bc-44fc2371d055",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-31",
        "rented_count": 0,
        "interval": "day",
        "product_id": "ad5a0a13-f173-40cf-b427-11c662326825"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/ad5a0a13-f173-40cf-b427-11c662326825"
          }
        }
      }
    },
    {
      "id": "virtual-93193479-c7f5-53c4-a692-e5dc580d8b8c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-01",
        "rented_count": 0,
        "interval": "day",
        "product_id": "ad5a0a13-f173-40cf-b427-11c662326825"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/ad5a0a13-f173-40cf-b427-11c662326825"
          }
        }
      }
    },
    {
      "id": "virtual-340f6c69-736b-5ff1-bb18-26ffe796fefe",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-02",
        "rented_count": 1,
        "interval": "day",
        "product_id": "ad5a0a13-f173-40cf-b427-11c662326825"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/ad5a0a13-f173-40cf-b427-11c662326825"
          }
        }
      }
    },
    {
      "id": "virtual-0d6947a4-7420-535b-a30c-d4b56c4a6c0b",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-03",
        "rented_count": 0,
        "interval": "day",
        "product_id": "ad5a0a13-f173-40cf-b427-11c662326825"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/ad5a0a13-f173-40cf-b427-11c662326825"
          }
        }
      }
    },
    {
      "id": "virtual-200534ee-859a-572a-8b90-fb43e724ff80",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-04",
        "rented_count": 1,
        "interval": "day",
        "product_id": "ad5a0a13-f173-40cf-b427-11c662326825"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/ad5a0a13-f173-40cf-b427-11c662326825"
          }
        }
      }
    },
    {
      "id": "virtual-01cefa6d-b9ac-5289-a0e0-3a77b559d323",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-05",
        "rented_count": 0,
        "interval": "day",
        "product_id": "ad5a0a13-f173-40cf-b427-11c662326825"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/ad5a0a13-f173-40cf-b427-11c662326825"
          }
        }
      }
    },
    {
      "id": "virtual-c7847229-44cc-5ed2-83fc-6a31ece1acbc",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-06",
        "rented_count": 1,
        "interval": "day",
        "product_id": "ad5a0a13-f173-40cf-b427-11c662326825"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/ad5a0a13-f173-40cf-b427-11c662326825"
          }
        }
      }
    },
    {
      "id": "virtual-2b8a4c06-8a06-5746-b51d-6e3eb98d0864",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-07",
        "rented_count": 0,
        "interval": "day",
        "product_id": "ad5a0a13-f173-40cf-b427-11c662326825"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/ad5a0a13-f173-40cf-b427-11c662326825"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-08T14:59:07Z`
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







