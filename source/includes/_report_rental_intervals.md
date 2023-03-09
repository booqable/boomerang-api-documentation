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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-02-27+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=e758fe39-9408-479b-a63b-c6e0415a3172&filter%5Btill%5D=2023-03-08+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-a96227cd-6aa2-5209-8523-af54c3206f21",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-27",
        "rented_count": 0,
        "interval": "day",
        "product_id": "e758fe39-9408-479b-a63b-c6e0415a3172"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e758fe39-9408-479b-a63b-c6e0415a3172"
          }
        }
      }
    },
    {
      "id": "virtual-55057006-a5b7-5139-94d4-1cef5f957971",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-28",
        "rented_count": 0,
        "interval": "day",
        "product_id": "e758fe39-9408-479b-a63b-c6e0415a3172"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e758fe39-9408-479b-a63b-c6e0415a3172"
          }
        }
      }
    },
    {
      "id": "virtual-5fa5a085-a744-5247-92ac-1e6b4d2b066d",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-01",
        "rented_count": 0,
        "interval": "day",
        "product_id": "e758fe39-9408-479b-a63b-c6e0415a3172"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e758fe39-9408-479b-a63b-c6e0415a3172"
          }
        }
      }
    },
    {
      "id": "virtual-41439902-3532-5a69-934c-6290d45d2c7a",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-02",
        "rented_count": 0,
        "interval": "day",
        "product_id": "e758fe39-9408-479b-a63b-c6e0415a3172"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e758fe39-9408-479b-a63b-c6e0415a3172"
          }
        }
      }
    },
    {
      "id": "virtual-6cd8059d-f84e-53a8-918a-19e5fc9eb714",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-03",
        "rented_count": 1,
        "interval": "day",
        "product_id": "e758fe39-9408-479b-a63b-c6e0415a3172"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e758fe39-9408-479b-a63b-c6e0415a3172"
          }
        }
      }
    },
    {
      "id": "virtual-bc39436d-9701-5c16-a6e9-8aceac5f9cc5",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-04",
        "rented_count": 0,
        "interval": "day",
        "product_id": "e758fe39-9408-479b-a63b-c6e0415a3172"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e758fe39-9408-479b-a63b-c6e0415a3172"
          }
        }
      }
    },
    {
      "id": "virtual-068a8925-81dc-5ad0-ab37-a3bdd8f7b58d",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-05",
        "rented_count": 1,
        "interval": "day",
        "product_id": "e758fe39-9408-479b-a63b-c6e0415a3172"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e758fe39-9408-479b-a63b-c6e0415a3172"
          }
        }
      }
    },
    {
      "id": "virtual-4015a644-7b24-5e8b-be67-f935abf76370",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-06",
        "rented_count": 0,
        "interval": "day",
        "product_id": "e758fe39-9408-479b-a63b-c6e0415a3172"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e758fe39-9408-479b-a63b-c6e0415a3172"
          }
        }
      }
    },
    {
      "id": "virtual-4b015ff5-5207-5fb0-8c71-710a297eb9da",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-07",
        "rented_count": 1,
        "interval": "day",
        "product_id": "e758fe39-9408-479b-a63b-c6e0415a3172"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e758fe39-9408-479b-a63b-c6e0415a3172"
          }
        }
      }
    },
    {
      "id": "virtual-38b4002d-3645-5251-9d6c-ed751f24bd16",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-08",
        "rented_count": 0,
        "interval": "day",
        "product_id": "e758fe39-9408-479b-a63b-c6e0415a3172"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e758fe39-9408-479b-a63b-c6e0415a3172"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-03-09T13:48:17Z`
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







