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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-01-30+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=a74eab89-ce38-4f63-b801-c67215ae198a&filter%5Btill%5D=2023-02-08+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-fccbf74d-11a8-53ca-8024-e1435a25b05e",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-30",
        "rented_count": 0,
        "interval": "day",
        "product_id": "a74eab89-ce38-4f63-b801-c67215ae198a"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/a74eab89-ce38-4f63-b801-c67215ae198a"
          }
        }
      }
    },
    {
      "id": "virtual-2f01f7c5-ff0a-5d23-9010-290752db952e",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-31",
        "rented_count": 0,
        "interval": "day",
        "product_id": "a74eab89-ce38-4f63-b801-c67215ae198a"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/a74eab89-ce38-4f63-b801-c67215ae198a"
          }
        }
      }
    },
    {
      "id": "virtual-214f6b90-a0e5-5b00-8de6-e239be1e7415",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-01",
        "rented_count": 0,
        "interval": "day",
        "product_id": "a74eab89-ce38-4f63-b801-c67215ae198a"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/a74eab89-ce38-4f63-b801-c67215ae198a"
          }
        }
      }
    },
    {
      "id": "virtual-3e3ce4f6-34af-5c31-8832-32b2e20820a1",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-02",
        "rented_count": 0,
        "interval": "day",
        "product_id": "a74eab89-ce38-4f63-b801-c67215ae198a"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/a74eab89-ce38-4f63-b801-c67215ae198a"
          }
        }
      }
    },
    {
      "id": "virtual-01b0b15f-b4ea-5e62-9d6f-6ddfa91e2160",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-03",
        "rented_count": 1,
        "interval": "day",
        "product_id": "a74eab89-ce38-4f63-b801-c67215ae198a"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/a74eab89-ce38-4f63-b801-c67215ae198a"
          }
        }
      }
    },
    {
      "id": "virtual-dc57662e-757c-5b51-a3ba-d6fd116efa4e",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-04",
        "rented_count": 0,
        "interval": "day",
        "product_id": "a74eab89-ce38-4f63-b801-c67215ae198a"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/a74eab89-ce38-4f63-b801-c67215ae198a"
          }
        }
      }
    },
    {
      "id": "virtual-811618dc-96f1-55a4-87e8-1acae3eaf20f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-05",
        "rented_count": 1,
        "interval": "day",
        "product_id": "a74eab89-ce38-4f63-b801-c67215ae198a"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/a74eab89-ce38-4f63-b801-c67215ae198a"
          }
        }
      }
    },
    {
      "id": "virtual-667fce50-abd1-55ae-85d1-9dcff8edb8e8",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-06",
        "rented_count": 0,
        "interval": "day",
        "product_id": "a74eab89-ce38-4f63-b801-c67215ae198a"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/a74eab89-ce38-4f63-b801-c67215ae198a"
          }
        }
      }
    },
    {
      "id": "virtual-7c2ac9ce-7667-5e03-8f7d-0c338e97d387",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-07",
        "rented_count": 1,
        "interval": "day",
        "product_id": "a74eab89-ce38-4f63-b801-c67215ae198a"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/a74eab89-ce38-4f63-b801-c67215ae198a"
          }
        }
      }
    },
    {
      "id": "virtual-d834776e-04c6-5fc8-91ad-e42dd4e32b02",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-08",
        "rented_count": 0,
        "interval": "day",
        "product_id": "a74eab89-ce38-4f63-b801-c67215ae198a"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/a74eab89-ce38-4f63-b801-c67215ae198a"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-09T12:15:53Z`
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







