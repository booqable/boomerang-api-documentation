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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2022-10-24+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=3a9b2d55-7363-44f9-bd5f-14082f1de835&filter%5Btill%5D=2022-11-02+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-564b2cb6-99a3-5cbe-a013-053ca77be6f7",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-24",
        "rented_count": 0,
        "interval": "day",
        "product_id": "3a9b2d55-7363-44f9-bd5f-14082f1de835"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/3a9b2d55-7363-44f9-bd5f-14082f1de835"
          }
        }
      }
    },
    {
      "id": "virtual-1ecf189e-6abe-5bde-8d7d-18244b679ad1",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-25",
        "rented_count": 0,
        "interval": "day",
        "product_id": "3a9b2d55-7363-44f9-bd5f-14082f1de835"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/3a9b2d55-7363-44f9-bd5f-14082f1de835"
          }
        }
      }
    },
    {
      "id": "virtual-77e0960f-2c2b-5631-887b-2780da38e3ca",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-26",
        "rented_count": 0,
        "interval": "day",
        "product_id": "3a9b2d55-7363-44f9-bd5f-14082f1de835"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/3a9b2d55-7363-44f9-bd5f-14082f1de835"
          }
        }
      }
    },
    {
      "id": "virtual-f46731dd-a0e8-5c68-b068-c22a179d6762",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-27",
        "rented_count": 0,
        "interval": "day",
        "product_id": "3a9b2d55-7363-44f9-bd5f-14082f1de835"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/3a9b2d55-7363-44f9-bd5f-14082f1de835"
          }
        }
      }
    },
    {
      "id": "virtual-b77cd339-0044-5944-858f-08a5aaa5fe0a",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-28",
        "rented_count": 1,
        "interval": "day",
        "product_id": "3a9b2d55-7363-44f9-bd5f-14082f1de835"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/3a9b2d55-7363-44f9-bd5f-14082f1de835"
          }
        }
      }
    },
    {
      "id": "virtual-81f3efa5-5397-5485-9971-09880ca4ce11",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-29",
        "rented_count": 0,
        "interval": "day",
        "product_id": "3a9b2d55-7363-44f9-bd5f-14082f1de835"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/3a9b2d55-7363-44f9-bd5f-14082f1de835"
          }
        }
      }
    },
    {
      "id": "virtual-54e00000-a864-5ea9-b6af-4c1ef0758e30",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-30",
        "rented_count": 1,
        "interval": "day",
        "product_id": "3a9b2d55-7363-44f9-bd5f-14082f1de835"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/3a9b2d55-7363-44f9-bd5f-14082f1de835"
          }
        }
      }
    },
    {
      "id": "virtual-f4bfc59a-16ca-5436-a9d8-da8cae4d999e",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-31",
        "rented_count": 0,
        "interval": "day",
        "product_id": "3a9b2d55-7363-44f9-bd5f-14082f1de835"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/3a9b2d55-7363-44f9-bd5f-14082f1de835"
          }
        }
      }
    },
    {
      "id": "virtual-19d528d0-d458-5ea8-a7a4-ed41fbd16a39",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-01",
        "rented_count": 1,
        "interval": "day",
        "product_id": "3a9b2d55-7363-44f9-bd5f-14082f1de835"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/3a9b2d55-7363-44f9-bd5f-14082f1de835"
          }
        }
      }
    },
    {
      "id": "virtual-3cd00bb1-7535-563a-9d2f-0e6d33df56ff",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-02",
        "rented_count": 0,
        "interval": "day",
        "product_id": "3a9b2d55-7363-44f9-bd5f-14082f1de835"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/3a9b2d55-7363-44f9-bd5f-14082f1de835"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-11-03T11:05:12Z`
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







