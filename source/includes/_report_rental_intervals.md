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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-02-26+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=5273347b-c9cc-4580-ad5d-b8d25fc111f6&filter%5Btill%5D=2023-03-07+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-4451a525-404a-5559-b1ce-2979c46180d5",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-26",
        "rented_count": 0,
        "interval": "day",
        "product_id": "5273347b-c9cc-4580-ad5d-b8d25fc111f6"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/5273347b-c9cc-4580-ad5d-b8d25fc111f6"
          }
        }
      }
    },
    {
      "id": "virtual-eb32199b-7db6-538a-8d2f-862fb91b6651",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-27",
        "rented_count": 0,
        "interval": "day",
        "product_id": "5273347b-c9cc-4580-ad5d-b8d25fc111f6"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/5273347b-c9cc-4580-ad5d-b8d25fc111f6"
          }
        }
      }
    },
    {
      "id": "virtual-ccc1ef0b-12d7-5856-aabb-e269da1c8ce3",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-28",
        "rented_count": 0,
        "interval": "day",
        "product_id": "5273347b-c9cc-4580-ad5d-b8d25fc111f6"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/5273347b-c9cc-4580-ad5d-b8d25fc111f6"
          }
        }
      }
    },
    {
      "id": "virtual-0df9a76a-0f5f-5e90-becb-bb236b1c0900",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-01",
        "rented_count": 0,
        "interval": "day",
        "product_id": "5273347b-c9cc-4580-ad5d-b8d25fc111f6"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/5273347b-c9cc-4580-ad5d-b8d25fc111f6"
          }
        }
      }
    },
    {
      "id": "virtual-a7d2f163-db2b-58ba-9676-0ddf2b8d4453",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-02",
        "rented_count": 1,
        "interval": "day",
        "product_id": "5273347b-c9cc-4580-ad5d-b8d25fc111f6"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/5273347b-c9cc-4580-ad5d-b8d25fc111f6"
          }
        }
      }
    },
    {
      "id": "virtual-51030932-a724-5b81-9937-f1caa37d5a06",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-03",
        "rented_count": 0,
        "interval": "day",
        "product_id": "5273347b-c9cc-4580-ad5d-b8d25fc111f6"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/5273347b-c9cc-4580-ad5d-b8d25fc111f6"
          }
        }
      }
    },
    {
      "id": "virtual-1e7b842d-cdb6-5658-a16c-a9fb90eba005",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-04",
        "rented_count": 1,
        "interval": "day",
        "product_id": "5273347b-c9cc-4580-ad5d-b8d25fc111f6"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/5273347b-c9cc-4580-ad5d-b8d25fc111f6"
          }
        }
      }
    },
    {
      "id": "virtual-60424f6d-7cb7-578b-b30a-78fa378cb46b",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-05",
        "rented_count": 0,
        "interval": "day",
        "product_id": "5273347b-c9cc-4580-ad5d-b8d25fc111f6"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/5273347b-c9cc-4580-ad5d-b8d25fc111f6"
          }
        }
      }
    },
    {
      "id": "virtual-c6d87505-1ac7-5708-93b0-76a23a61f32f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-06",
        "rented_count": 1,
        "interval": "day",
        "product_id": "5273347b-c9cc-4580-ad5d-b8d25fc111f6"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/5273347b-c9cc-4580-ad5d-b8d25fc111f6"
          }
        }
      }
    },
    {
      "id": "virtual-f477cccb-5c3c-57bd-9f8b-afd7fad57bd0",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-07",
        "rented_count": 0,
        "interval": "day",
        "product_id": "5273347b-c9cc-4580-ad5d-b8d25fc111f6"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/5273347b-c9cc-4580-ad5d-b8d25fc111f6"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-03-08T09:39:35Z`
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







