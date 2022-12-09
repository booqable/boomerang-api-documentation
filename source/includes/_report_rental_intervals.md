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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2022-11-29+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=57df8e1a-7c9a-4158-a092-a78ff8a98484&filter%5Btill%5D=2022-12-08+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-5fb9de16-0de4-5e76-8f26-ce73ff82f191",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-29",
        "rented_count": 0,
        "interval": "day",
        "product_id": "57df8e1a-7c9a-4158-a092-a78ff8a98484"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/57df8e1a-7c9a-4158-a092-a78ff8a98484"
          }
        }
      }
    },
    {
      "id": "virtual-05aa176b-4432-5fef-8fcc-2f1719602c73",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-30",
        "rented_count": 0,
        "interval": "day",
        "product_id": "57df8e1a-7c9a-4158-a092-a78ff8a98484"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/57df8e1a-7c9a-4158-a092-a78ff8a98484"
          }
        }
      }
    },
    {
      "id": "virtual-a32df58a-7632-533e-bb05-08d533466b62",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-12-01",
        "rented_count": 0,
        "interval": "day",
        "product_id": "57df8e1a-7c9a-4158-a092-a78ff8a98484"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/57df8e1a-7c9a-4158-a092-a78ff8a98484"
          }
        }
      }
    },
    {
      "id": "virtual-064b9c02-7b6a-5c07-81e0-d6508069a9b0",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-12-02",
        "rented_count": 0,
        "interval": "day",
        "product_id": "57df8e1a-7c9a-4158-a092-a78ff8a98484"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/57df8e1a-7c9a-4158-a092-a78ff8a98484"
          }
        }
      }
    },
    {
      "id": "virtual-33abc67d-8785-5802-a56f-4f7d679efcd0",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-12-03",
        "rented_count": 1,
        "interval": "day",
        "product_id": "57df8e1a-7c9a-4158-a092-a78ff8a98484"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/57df8e1a-7c9a-4158-a092-a78ff8a98484"
          }
        }
      }
    },
    {
      "id": "virtual-50d95e2b-7fad-52cf-8f6a-b0d28c692670",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-12-04",
        "rented_count": 0,
        "interval": "day",
        "product_id": "57df8e1a-7c9a-4158-a092-a78ff8a98484"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/57df8e1a-7c9a-4158-a092-a78ff8a98484"
          }
        }
      }
    },
    {
      "id": "virtual-38263aa8-3f45-595a-b9e8-dc504868fc20",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-12-05",
        "rented_count": 1,
        "interval": "day",
        "product_id": "57df8e1a-7c9a-4158-a092-a78ff8a98484"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/57df8e1a-7c9a-4158-a092-a78ff8a98484"
          }
        }
      }
    },
    {
      "id": "virtual-226cbeae-924f-5ebb-8d92-5a53ed75721c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-12-06",
        "rented_count": 0,
        "interval": "day",
        "product_id": "57df8e1a-7c9a-4158-a092-a78ff8a98484"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/57df8e1a-7c9a-4158-a092-a78ff8a98484"
          }
        }
      }
    },
    {
      "id": "virtual-4ff526d1-1b23-5107-bdb4-176ce7bbeb33",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-12-07",
        "rented_count": 1,
        "interval": "day",
        "product_id": "57df8e1a-7c9a-4158-a092-a78ff8a98484"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/57df8e1a-7c9a-4158-a092-a78ff8a98484"
          }
        }
      }
    },
    {
      "id": "virtual-f83c7a5d-fe3e-5dec-8f94-3bf248d7f6a1",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-12-08",
        "rented_count": 0,
        "interval": "day",
        "product_id": "57df8e1a-7c9a-4158-a092-a78ff8a98484"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/57df8e1a-7c9a-4158-a092-a78ff8a98484"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-12-09T08:11:55Z`
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







