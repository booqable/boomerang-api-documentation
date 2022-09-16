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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2022-09-06+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=4faf7d11-46e1-44a6-a7d8-e8e22c750c61&filter%5Btill%5D=2022-09-15+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-57ce3404-b8a9-554b-8ef0-bc0a5250eef2",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-09-06",
        "rented_count": 0,
        "interval": "day",
        "product_id": "4faf7d11-46e1-44a6-a7d8-e8e22c750c61"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4faf7d11-46e1-44a6-a7d8-e8e22c750c61"
          }
        }
      }
    },
    {
      "id": "virtual-863e5762-ad83-5088-9d53-04f657f39298",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-09-07",
        "rented_count": 0,
        "interval": "day",
        "product_id": "4faf7d11-46e1-44a6-a7d8-e8e22c750c61"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4faf7d11-46e1-44a6-a7d8-e8e22c750c61"
          }
        }
      }
    },
    {
      "id": "virtual-1e5909c2-dc3b-53f6-ad4f-cd2e69b1c7da",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-09-08",
        "rented_count": 0,
        "interval": "day",
        "product_id": "4faf7d11-46e1-44a6-a7d8-e8e22c750c61"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4faf7d11-46e1-44a6-a7d8-e8e22c750c61"
          }
        }
      }
    },
    {
      "id": "virtual-97c28fde-0eda-58e3-8a87-36f797f811a5",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-09-09",
        "rented_count": 0,
        "interval": "day",
        "product_id": "4faf7d11-46e1-44a6-a7d8-e8e22c750c61"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4faf7d11-46e1-44a6-a7d8-e8e22c750c61"
          }
        }
      }
    },
    {
      "id": "virtual-7e467ea1-521b-53e3-a88d-608eaf412057",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-09-10",
        "rented_count": 1,
        "interval": "day",
        "product_id": "4faf7d11-46e1-44a6-a7d8-e8e22c750c61"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4faf7d11-46e1-44a6-a7d8-e8e22c750c61"
          }
        }
      }
    },
    {
      "id": "virtual-b7596b93-71a6-5cb4-a788-21ccf70bcc42",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-09-11",
        "rented_count": 0,
        "interval": "day",
        "product_id": "4faf7d11-46e1-44a6-a7d8-e8e22c750c61"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4faf7d11-46e1-44a6-a7d8-e8e22c750c61"
          }
        }
      }
    },
    {
      "id": "virtual-c0366dad-38a5-513c-831a-078f9c08f025",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-09-12",
        "rented_count": 1,
        "interval": "day",
        "product_id": "4faf7d11-46e1-44a6-a7d8-e8e22c750c61"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4faf7d11-46e1-44a6-a7d8-e8e22c750c61"
          }
        }
      }
    },
    {
      "id": "virtual-05350538-1236-5465-b87a-09c40d197d02",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-09-13",
        "rented_count": 0,
        "interval": "day",
        "product_id": "4faf7d11-46e1-44a6-a7d8-e8e22c750c61"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4faf7d11-46e1-44a6-a7d8-e8e22c750c61"
          }
        }
      }
    },
    {
      "id": "virtual-5a650b53-4c4e-51c2-a451-51ff19404921",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-09-14",
        "rented_count": 1,
        "interval": "day",
        "product_id": "4faf7d11-46e1-44a6-a7d8-e8e22c750c61"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4faf7d11-46e1-44a6-a7d8-e8e22c750c61"
          }
        }
      }
    },
    {
      "id": "virtual-fd6348ea-3c85-58ed-ad0b-d16d198b7697",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-09-15",
        "rented_count": 0,
        "interval": "day",
        "product_id": "4faf7d11-46e1-44a6-a7d8-e8e22c750c61"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4faf7d11-46e1-44a6-a7d8-e8e22c750c61"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-09-16T14:12:38Z`
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







