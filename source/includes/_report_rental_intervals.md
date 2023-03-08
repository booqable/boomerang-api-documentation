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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-02-26+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=e61d761c-6542-4929-b10b-2d310ed4f119&filter%5Btill%5D=2023-03-07+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-41ae4f8a-c5f5-5de8-999f-32afc120b664",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-26",
        "rented_count": 0,
        "interval": "day",
        "product_id": "e61d761c-6542-4929-b10b-2d310ed4f119"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e61d761c-6542-4929-b10b-2d310ed4f119"
          }
        }
      }
    },
    {
      "id": "virtual-8e657d8f-3787-5ff1-a43f-47dcb0cd7d2b",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-27",
        "rented_count": 0,
        "interval": "day",
        "product_id": "e61d761c-6542-4929-b10b-2d310ed4f119"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e61d761c-6542-4929-b10b-2d310ed4f119"
          }
        }
      }
    },
    {
      "id": "virtual-9e17532a-9b74-5057-bb0b-8859b9b2dd5a",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-28",
        "rented_count": 0,
        "interval": "day",
        "product_id": "e61d761c-6542-4929-b10b-2d310ed4f119"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e61d761c-6542-4929-b10b-2d310ed4f119"
          }
        }
      }
    },
    {
      "id": "virtual-5ead61f9-a277-54c8-819d-b3fc6a969374",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-01",
        "rented_count": 0,
        "interval": "day",
        "product_id": "e61d761c-6542-4929-b10b-2d310ed4f119"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e61d761c-6542-4929-b10b-2d310ed4f119"
          }
        }
      }
    },
    {
      "id": "virtual-f1f5728c-a8f7-5b37-9351-a172107945c3",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-02",
        "rented_count": 1,
        "interval": "day",
        "product_id": "e61d761c-6542-4929-b10b-2d310ed4f119"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e61d761c-6542-4929-b10b-2d310ed4f119"
          }
        }
      }
    },
    {
      "id": "virtual-be829a96-5745-5747-aa27-69766f301046",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-03",
        "rented_count": 0,
        "interval": "day",
        "product_id": "e61d761c-6542-4929-b10b-2d310ed4f119"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e61d761c-6542-4929-b10b-2d310ed4f119"
          }
        }
      }
    },
    {
      "id": "virtual-ff6e6747-7df7-5855-be69-cbd12606b96a",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-04",
        "rented_count": 1,
        "interval": "day",
        "product_id": "e61d761c-6542-4929-b10b-2d310ed4f119"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e61d761c-6542-4929-b10b-2d310ed4f119"
          }
        }
      }
    },
    {
      "id": "virtual-4d71c065-4c39-51a8-8b06-c67362b5fef9",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-05",
        "rented_count": 0,
        "interval": "day",
        "product_id": "e61d761c-6542-4929-b10b-2d310ed4f119"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e61d761c-6542-4929-b10b-2d310ed4f119"
          }
        }
      }
    },
    {
      "id": "virtual-81fab455-5f01-5478-bc4d-3f24f1ecd299",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-06",
        "rented_count": 1,
        "interval": "day",
        "product_id": "e61d761c-6542-4929-b10b-2d310ed4f119"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e61d761c-6542-4929-b10b-2d310ed4f119"
          }
        }
      }
    },
    {
      "id": "virtual-c6250ce7-78b7-543c-8951-9e66f533aa4b",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-07",
        "rented_count": 0,
        "interval": "day",
        "product_id": "e61d761c-6542-4929-b10b-2d310ed4f119"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e61d761c-6542-4929-b10b-2d310ed4f119"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-03-08T09:17:34Z`
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







