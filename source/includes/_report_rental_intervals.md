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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2022-07-04+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=43a05564-edf4-476f-83c6-d562fca8310b&filter%5Btill%5D=2022-07-13+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-5ff32af8-5caf-55ef-8fc1-fa2814fa9ecf",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-04",
        "rented_count": 0,
        "interval": "day",
        "product_id": "43a05564-edf4-476f-83c6-d562fca8310b"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/43a05564-edf4-476f-83c6-d562fca8310b"
          }
        }
      }
    },
    {
      "id": "virtual-3b83a2b7-b013-5486-8e2d-4c61de7452ba",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-05",
        "rented_count": 0,
        "interval": "day",
        "product_id": "43a05564-edf4-476f-83c6-d562fca8310b"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/43a05564-edf4-476f-83c6-d562fca8310b"
          }
        }
      }
    },
    {
      "id": "virtual-d9b53bde-970d-5d1c-98e0-c532791f8d6b",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-06",
        "rented_count": 0,
        "interval": "day",
        "product_id": "43a05564-edf4-476f-83c6-d562fca8310b"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/43a05564-edf4-476f-83c6-d562fca8310b"
          }
        }
      }
    },
    {
      "id": "virtual-bee4e0fc-29cc-5999-9ccb-2d571ca53ad3",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-07",
        "rented_count": 0,
        "interval": "day",
        "product_id": "43a05564-edf4-476f-83c6-d562fca8310b"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/43a05564-edf4-476f-83c6-d562fca8310b"
          }
        }
      }
    },
    {
      "id": "virtual-f9766015-092b-56c9-9548-b4273c569a9d",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-08",
        "rented_count": 1,
        "interval": "day",
        "product_id": "43a05564-edf4-476f-83c6-d562fca8310b"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/43a05564-edf4-476f-83c6-d562fca8310b"
          }
        }
      }
    },
    {
      "id": "virtual-2854f286-3878-5736-98fa-72f22b8c23a9",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-09",
        "rented_count": 0,
        "interval": "day",
        "product_id": "43a05564-edf4-476f-83c6-d562fca8310b"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/43a05564-edf4-476f-83c6-d562fca8310b"
          }
        }
      }
    },
    {
      "id": "virtual-4f66f5b0-699f-5b8b-b2bc-a0cf4d5721db",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-10",
        "rented_count": 1,
        "interval": "day",
        "product_id": "43a05564-edf4-476f-83c6-d562fca8310b"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/43a05564-edf4-476f-83c6-d562fca8310b"
          }
        }
      }
    },
    {
      "id": "virtual-5a2cd87c-b22a-5d26-8c61-a0e01d081021",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-11",
        "rented_count": 0,
        "interval": "day",
        "product_id": "43a05564-edf4-476f-83c6-d562fca8310b"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/43a05564-edf4-476f-83c6-d562fca8310b"
          }
        }
      }
    },
    {
      "id": "virtual-43d74993-682c-5a99-b63f-9115bb44773b",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-12",
        "rented_count": 1,
        "interval": "day",
        "product_id": "43a05564-edf4-476f-83c6-d562fca8310b"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/43a05564-edf4-476f-83c6-d562fca8310b"
          }
        }
      }
    },
    {
      "id": "virtual-ae1dc3ec-cf1a-5a66-8f4f-f1673db290d9",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-13",
        "rented_count": 0,
        "interval": "day",
        "product_id": "43a05564-edf4-476f-83c6-d562fca8310b"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/43a05564-edf4-476f-83c6-d562fca8310b"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-07-14T11:59:28Z`
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







