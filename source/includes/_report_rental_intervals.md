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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2022-09-27+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=d364416a-86a7-46c6-9897-fce1fe2f75e2&filter%5Btill%5D=2022-10-06+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-00ca2a6b-d1c1-5ca8-8ac7-c587c8da0b46",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-09-27",
        "rented_count": 0,
        "interval": "day",
        "product_id": "d364416a-86a7-46c6-9897-fce1fe2f75e2"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/d364416a-86a7-46c6-9897-fce1fe2f75e2"
          }
        }
      }
    },
    {
      "id": "virtual-2eb352d3-3510-5f1e-a98b-eee5bede7957",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-09-28",
        "rented_count": 0,
        "interval": "day",
        "product_id": "d364416a-86a7-46c6-9897-fce1fe2f75e2"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/d364416a-86a7-46c6-9897-fce1fe2f75e2"
          }
        }
      }
    },
    {
      "id": "virtual-a64bb855-28bf-565f-9054-a9f64fffc818",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-09-29",
        "rented_count": 0,
        "interval": "day",
        "product_id": "d364416a-86a7-46c6-9897-fce1fe2f75e2"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/d364416a-86a7-46c6-9897-fce1fe2f75e2"
          }
        }
      }
    },
    {
      "id": "virtual-4c8d3106-eb9a-58bb-a153-84cc04646f7a",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-09-30",
        "rented_count": 0,
        "interval": "day",
        "product_id": "d364416a-86a7-46c6-9897-fce1fe2f75e2"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/d364416a-86a7-46c6-9897-fce1fe2f75e2"
          }
        }
      }
    },
    {
      "id": "virtual-2c7566da-a6db-57cd-82a9-99b4fc977293",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-01",
        "rented_count": 1,
        "interval": "day",
        "product_id": "d364416a-86a7-46c6-9897-fce1fe2f75e2"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/d364416a-86a7-46c6-9897-fce1fe2f75e2"
          }
        }
      }
    },
    {
      "id": "virtual-4f6addc1-874f-573f-b50d-cba8ce12654c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-02",
        "rented_count": 0,
        "interval": "day",
        "product_id": "d364416a-86a7-46c6-9897-fce1fe2f75e2"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/d364416a-86a7-46c6-9897-fce1fe2f75e2"
          }
        }
      }
    },
    {
      "id": "virtual-e3ff3af2-b658-5c61-b1b5-0e2c481ce968",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-03",
        "rented_count": 1,
        "interval": "day",
        "product_id": "d364416a-86a7-46c6-9897-fce1fe2f75e2"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/d364416a-86a7-46c6-9897-fce1fe2f75e2"
          }
        }
      }
    },
    {
      "id": "virtual-0e1bb466-e1a8-5f43-9efa-16291fd69900",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-04",
        "rented_count": 0,
        "interval": "day",
        "product_id": "d364416a-86a7-46c6-9897-fce1fe2f75e2"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/d364416a-86a7-46c6-9897-fce1fe2f75e2"
          }
        }
      }
    },
    {
      "id": "virtual-3157c95d-983d-548e-b1cf-28f5d86e8a3e",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-05",
        "rented_count": 1,
        "interval": "day",
        "product_id": "d364416a-86a7-46c6-9897-fce1fe2f75e2"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/d364416a-86a7-46c6-9897-fce1fe2f75e2"
          }
        }
      }
    },
    {
      "id": "virtual-76356409-da74-54ac-b297-95da4c3300d4",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-06",
        "rented_count": 0,
        "interval": "day",
        "product_id": "d364416a-86a7-46c6-9897-fce1fe2f75e2"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/d364416a-86a7-46c6-9897-fce1fe2f75e2"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-10-07T15:04:27Z`
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







