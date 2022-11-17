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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2022-11-07+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=51717bd4-d03a-4ef1-a277-26b6790388df&filter%5Btill%5D=2022-11-16+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-fbcb9755-9801-5b07-be67-b5c16421042a",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-07",
        "rented_count": 0,
        "interval": "day",
        "product_id": "51717bd4-d03a-4ef1-a277-26b6790388df"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/51717bd4-d03a-4ef1-a277-26b6790388df"
          }
        }
      }
    },
    {
      "id": "virtual-8076fe56-d9bc-5ad3-8488-c2f73adc73bd",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-08",
        "rented_count": 0,
        "interval": "day",
        "product_id": "51717bd4-d03a-4ef1-a277-26b6790388df"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/51717bd4-d03a-4ef1-a277-26b6790388df"
          }
        }
      }
    },
    {
      "id": "virtual-26fe6de2-2393-5411-96c0-982d8030e71b",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-09",
        "rented_count": 0,
        "interval": "day",
        "product_id": "51717bd4-d03a-4ef1-a277-26b6790388df"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/51717bd4-d03a-4ef1-a277-26b6790388df"
          }
        }
      }
    },
    {
      "id": "virtual-07f80160-c80f-5145-b2cd-adf2b17b01bf",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-10",
        "rented_count": 0,
        "interval": "day",
        "product_id": "51717bd4-d03a-4ef1-a277-26b6790388df"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/51717bd4-d03a-4ef1-a277-26b6790388df"
          }
        }
      }
    },
    {
      "id": "virtual-81d1049e-2d36-57de-ad37-6e6c9f4e1b20",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-11",
        "rented_count": 1,
        "interval": "day",
        "product_id": "51717bd4-d03a-4ef1-a277-26b6790388df"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/51717bd4-d03a-4ef1-a277-26b6790388df"
          }
        }
      }
    },
    {
      "id": "virtual-8580a239-17a0-563a-b213-384dbbc33fc0",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-12",
        "rented_count": 0,
        "interval": "day",
        "product_id": "51717bd4-d03a-4ef1-a277-26b6790388df"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/51717bd4-d03a-4ef1-a277-26b6790388df"
          }
        }
      }
    },
    {
      "id": "virtual-72b0f3d3-7840-5cb5-bf44-bbe34d928627",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-13",
        "rented_count": 1,
        "interval": "day",
        "product_id": "51717bd4-d03a-4ef1-a277-26b6790388df"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/51717bd4-d03a-4ef1-a277-26b6790388df"
          }
        }
      }
    },
    {
      "id": "virtual-5543a707-4f24-50c4-a7e6-f23d70c06e30",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-14",
        "rented_count": 0,
        "interval": "day",
        "product_id": "51717bd4-d03a-4ef1-a277-26b6790388df"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/51717bd4-d03a-4ef1-a277-26b6790388df"
          }
        }
      }
    },
    {
      "id": "virtual-fccb922f-a209-53cd-a8c8-9cb7a24c5b62",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-15",
        "rented_count": 1,
        "interval": "day",
        "product_id": "51717bd4-d03a-4ef1-a277-26b6790388df"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/51717bd4-d03a-4ef1-a277-26b6790388df"
          }
        }
      }
    },
    {
      "id": "virtual-82381782-59f9-512b-bd6a-932d4bf7c6a9",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-16",
        "rented_count": 0,
        "interval": "day",
        "product_id": "51717bd4-d03a-4ef1-a277-26b6790388df"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/51717bd4-d03a-4ef1-a277-26b6790388df"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-11-17T11:32:25Z`
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







