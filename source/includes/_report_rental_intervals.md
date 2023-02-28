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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-02-18+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=4a26b6bf-ce49-406e-9b4f-389861799304&filter%5Btill%5D=2023-02-27+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-985bfb9f-dfb6-5d46-b953-6581d4d0c758",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-18",
        "rented_count": 0,
        "interval": "day",
        "product_id": "4a26b6bf-ce49-406e-9b4f-389861799304"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4a26b6bf-ce49-406e-9b4f-389861799304"
          }
        }
      }
    },
    {
      "id": "virtual-4a82d153-c8de-5dd2-8b7a-cab51a6c823e",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-19",
        "rented_count": 0,
        "interval": "day",
        "product_id": "4a26b6bf-ce49-406e-9b4f-389861799304"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4a26b6bf-ce49-406e-9b4f-389861799304"
          }
        }
      }
    },
    {
      "id": "virtual-c943d97a-48c1-553d-88b1-b50c94c0002d",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-20",
        "rented_count": 0,
        "interval": "day",
        "product_id": "4a26b6bf-ce49-406e-9b4f-389861799304"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4a26b6bf-ce49-406e-9b4f-389861799304"
          }
        }
      }
    },
    {
      "id": "virtual-a7c9f0cf-bb37-56fe-9bf7-6ae78d26722c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-21",
        "rented_count": 0,
        "interval": "day",
        "product_id": "4a26b6bf-ce49-406e-9b4f-389861799304"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4a26b6bf-ce49-406e-9b4f-389861799304"
          }
        }
      }
    },
    {
      "id": "virtual-1f8fc281-0d89-5996-b37d-19cdd42f04fd",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-22",
        "rented_count": 1,
        "interval": "day",
        "product_id": "4a26b6bf-ce49-406e-9b4f-389861799304"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4a26b6bf-ce49-406e-9b4f-389861799304"
          }
        }
      }
    },
    {
      "id": "virtual-c6950deb-56e4-5eb1-922c-4e38450a05ab",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-23",
        "rented_count": 0,
        "interval": "day",
        "product_id": "4a26b6bf-ce49-406e-9b4f-389861799304"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4a26b6bf-ce49-406e-9b4f-389861799304"
          }
        }
      }
    },
    {
      "id": "virtual-02382ffe-b34c-5ab7-ab25-d16efb1713e9",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-24",
        "rented_count": 1,
        "interval": "day",
        "product_id": "4a26b6bf-ce49-406e-9b4f-389861799304"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4a26b6bf-ce49-406e-9b4f-389861799304"
          }
        }
      }
    },
    {
      "id": "virtual-bb742478-90fe-5fb0-9b94-864c689eb1fd",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-25",
        "rented_count": 0,
        "interval": "day",
        "product_id": "4a26b6bf-ce49-406e-9b4f-389861799304"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4a26b6bf-ce49-406e-9b4f-389861799304"
          }
        }
      }
    },
    {
      "id": "virtual-641475b5-c399-5ecf-bd5a-8081ba4aa74c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-26",
        "rented_count": 1,
        "interval": "day",
        "product_id": "4a26b6bf-ce49-406e-9b4f-389861799304"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4a26b6bf-ce49-406e-9b4f-389861799304"
          }
        }
      }
    },
    {
      "id": "virtual-e0abf906-e87e-5696-93eb-65ab5b8eae63",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-27",
        "rented_count": 0,
        "interval": "day",
        "product_id": "4a26b6bf-ce49-406e-9b4f-389861799304"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4a26b6bf-ce49-406e-9b4f-389861799304"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-28T08:43:59Z`
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







