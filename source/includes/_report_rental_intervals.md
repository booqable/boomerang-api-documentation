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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-01-29+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=17ca169b-dd63-418c-8b0f-c2ee9bed5c1c&filter%5Btill%5D=2023-02-07+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-d196babc-de7e-58ea-9d0b-1acaa94e3da3",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-29",
        "rented_count": 0,
        "interval": "day",
        "product_id": "17ca169b-dd63-418c-8b0f-c2ee9bed5c1c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/17ca169b-dd63-418c-8b0f-c2ee9bed5c1c"
          }
        }
      }
    },
    {
      "id": "virtual-c0443044-fd0c-51dd-b312-680d8380fdd6",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-30",
        "rented_count": 0,
        "interval": "day",
        "product_id": "17ca169b-dd63-418c-8b0f-c2ee9bed5c1c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/17ca169b-dd63-418c-8b0f-c2ee9bed5c1c"
          }
        }
      }
    },
    {
      "id": "virtual-01b98ad1-01b4-5d52-a284-4a9abcff0e35",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-31",
        "rented_count": 0,
        "interval": "day",
        "product_id": "17ca169b-dd63-418c-8b0f-c2ee9bed5c1c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/17ca169b-dd63-418c-8b0f-c2ee9bed5c1c"
          }
        }
      }
    },
    {
      "id": "virtual-80c2c782-56b4-599f-a324-8853458f018b",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-01",
        "rented_count": 0,
        "interval": "day",
        "product_id": "17ca169b-dd63-418c-8b0f-c2ee9bed5c1c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/17ca169b-dd63-418c-8b0f-c2ee9bed5c1c"
          }
        }
      }
    },
    {
      "id": "virtual-86ac77ca-8dbf-59f8-a21c-5871fc86be2f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-02",
        "rented_count": 1,
        "interval": "day",
        "product_id": "17ca169b-dd63-418c-8b0f-c2ee9bed5c1c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/17ca169b-dd63-418c-8b0f-c2ee9bed5c1c"
          }
        }
      }
    },
    {
      "id": "virtual-4b00febc-cb3a-5abc-b0d9-7f588c7fc549",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-03",
        "rented_count": 0,
        "interval": "day",
        "product_id": "17ca169b-dd63-418c-8b0f-c2ee9bed5c1c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/17ca169b-dd63-418c-8b0f-c2ee9bed5c1c"
          }
        }
      }
    },
    {
      "id": "virtual-d08560f6-6384-55ba-b307-3c9d43412978",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-04",
        "rented_count": 1,
        "interval": "day",
        "product_id": "17ca169b-dd63-418c-8b0f-c2ee9bed5c1c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/17ca169b-dd63-418c-8b0f-c2ee9bed5c1c"
          }
        }
      }
    },
    {
      "id": "virtual-b12b48ba-5897-550b-8bbf-597cf577b737",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-05",
        "rented_count": 0,
        "interval": "day",
        "product_id": "17ca169b-dd63-418c-8b0f-c2ee9bed5c1c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/17ca169b-dd63-418c-8b0f-c2ee9bed5c1c"
          }
        }
      }
    },
    {
      "id": "virtual-91ff34b4-51ce-5aa1-bedb-5a37ed9f8db3",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-06",
        "rented_count": 1,
        "interval": "day",
        "product_id": "17ca169b-dd63-418c-8b0f-c2ee9bed5c1c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/17ca169b-dd63-418c-8b0f-c2ee9bed5c1c"
          }
        }
      }
    },
    {
      "id": "virtual-1ce97ea4-df28-5c08-a48d-4dac190ff28e",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-07",
        "rented_count": 0,
        "interval": "day",
        "product_id": "17ca169b-dd63-418c-8b0f-c2ee9bed5c1c"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/17ca169b-dd63-418c-8b0f-c2ee9bed5c1c"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-08T09:17:23Z`
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







