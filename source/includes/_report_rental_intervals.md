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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-01-28+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=78ab96d1-b817-4492-a537-c4f55e73e5b8&filter%5Btill%5D=2023-02-06+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-ee71196a-3710-5aaf-b3fe-974f6e3fe819",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-28",
        "rented_count": 0,
        "interval": "day",
        "product_id": "78ab96d1-b817-4492-a537-c4f55e73e5b8"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/78ab96d1-b817-4492-a537-c4f55e73e5b8"
          }
        }
      }
    },
    {
      "id": "virtual-344ff14b-05d3-564b-b03a-bd4b8c955d57",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-29",
        "rented_count": 0,
        "interval": "day",
        "product_id": "78ab96d1-b817-4492-a537-c4f55e73e5b8"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/78ab96d1-b817-4492-a537-c4f55e73e5b8"
          }
        }
      }
    },
    {
      "id": "virtual-8a4442d9-8ac2-51c0-b126-16ddf7bcedf3",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-30",
        "rented_count": 0,
        "interval": "day",
        "product_id": "78ab96d1-b817-4492-a537-c4f55e73e5b8"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/78ab96d1-b817-4492-a537-c4f55e73e5b8"
          }
        }
      }
    },
    {
      "id": "virtual-ae4bf7b4-c5e3-542c-8738-47824aada412",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-31",
        "rented_count": 0,
        "interval": "day",
        "product_id": "78ab96d1-b817-4492-a537-c4f55e73e5b8"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/78ab96d1-b817-4492-a537-c4f55e73e5b8"
          }
        }
      }
    },
    {
      "id": "virtual-0390b105-2f9f-53e0-82f0-ba235b5e0e75",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-01",
        "rented_count": 1,
        "interval": "day",
        "product_id": "78ab96d1-b817-4492-a537-c4f55e73e5b8"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/78ab96d1-b817-4492-a537-c4f55e73e5b8"
          }
        }
      }
    },
    {
      "id": "virtual-d7c73cc5-0928-5ff8-9c35-27f2c378b278",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-02",
        "rented_count": 0,
        "interval": "day",
        "product_id": "78ab96d1-b817-4492-a537-c4f55e73e5b8"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/78ab96d1-b817-4492-a537-c4f55e73e5b8"
          }
        }
      }
    },
    {
      "id": "virtual-44cc1d7b-d58b-523b-b783-e5fb2d2bad85",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-03",
        "rented_count": 1,
        "interval": "day",
        "product_id": "78ab96d1-b817-4492-a537-c4f55e73e5b8"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/78ab96d1-b817-4492-a537-c4f55e73e5b8"
          }
        }
      }
    },
    {
      "id": "virtual-2c8c801c-224c-5bb2-9846-946478ade2e1",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-04",
        "rented_count": 0,
        "interval": "day",
        "product_id": "78ab96d1-b817-4492-a537-c4f55e73e5b8"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/78ab96d1-b817-4492-a537-c4f55e73e5b8"
          }
        }
      }
    },
    {
      "id": "virtual-0c8c1a15-e64f-5cdd-8e92-ca1fa3fd0a7a",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-05",
        "rented_count": 1,
        "interval": "day",
        "product_id": "78ab96d1-b817-4492-a537-c4f55e73e5b8"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/78ab96d1-b817-4492-a537-c4f55e73e5b8"
          }
        }
      }
    },
    {
      "id": "virtual-060af478-501a-51e4-bfd1-f996d8dd1447",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-06",
        "rented_count": 0,
        "interval": "day",
        "product_id": "78ab96d1-b817-4492-a537-c4f55e73e5b8"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/78ab96d1-b817-4492-a537-c4f55e73e5b8"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-07T14:59:22Z`
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







