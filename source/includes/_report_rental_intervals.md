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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-01-29+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=963f3278-19b5-488f-b8f7-c7d102a3341f&filter%5Btill%5D=2023-02-07+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-37c7dade-c70a-556a-95d5-6447e7fce2d3",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-29",
        "rented_count": 0,
        "interval": "day",
        "product_id": "963f3278-19b5-488f-b8f7-c7d102a3341f"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/963f3278-19b5-488f-b8f7-c7d102a3341f"
          }
        }
      }
    },
    {
      "id": "virtual-f16229d9-795f-55c5-b250-6c07d51224d7",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-30",
        "rented_count": 0,
        "interval": "day",
        "product_id": "963f3278-19b5-488f-b8f7-c7d102a3341f"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/963f3278-19b5-488f-b8f7-c7d102a3341f"
          }
        }
      }
    },
    {
      "id": "virtual-be5cc099-f821-5eea-b2b8-476aa20d5aff",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-31",
        "rented_count": 0,
        "interval": "day",
        "product_id": "963f3278-19b5-488f-b8f7-c7d102a3341f"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/963f3278-19b5-488f-b8f7-c7d102a3341f"
          }
        }
      }
    },
    {
      "id": "virtual-d39ec3c2-7901-5300-b8f9-b91d107db62f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-01",
        "rented_count": 0,
        "interval": "day",
        "product_id": "963f3278-19b5-488f-b8f7-c7d102a3341f"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/963f3278-19b5-488f-b8f7-c7d102a3341f"
          }
        }
      }
    },
    {
      "id": "virtual-8270dcca-03ae-5ba8-a1e3-3aee37e7d6b0",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-02",
        "rented_count": 1,
        "interval": "day",
        "product_id": "963f3278-19b5-488f-b8f7-c7d102a3341f"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/963f3278-19b5-488f-b8f7-c7d102a3341f"
          }
        }
      }
    },
    {
      "id": "virtual-116f939d-b993-53e9-a497-92a608890fac",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-03",
        "rented_count": 0,
        "interval": "day",
        "product_id": "963f3278-19b5-488f-b8f7-c7d102a3341f"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/963f3278-19b5-488f-b8f7-c7d102a3341f"
          }
        }
      }
    },
    {
      "id": "virtual-ee25c382-33a1-54a3-8d04-1ef20a6e8303",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-04",
        "rented_count": 1,
        "interval": "day",
        "product_id": "963f3278-19b5-488f-b8f7-c7d102a3341f"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/963f3278-19b5-488f-b8f7-c7d102a3341f"
          }
        }
      }
    },
    {
      "id": "virtual-164d9a5f-15a4-55b1-8e7b-43bdce4f16f7",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-05",
        "rented_count": 0,
        "interval": "day",
        "product_id": "963f3278-19b5-488f-b8f7-c7d102a3341f"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/963f3278-19b5-488f-b8f7-c7d102a3341f"
          }
        }
      }
    },
    {
      "id": "virtual-6d9119d3-f4d9-5065-a887-a5186ecceea7",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-06",
        "rented_count": 1,
        "interval": "day",
        "product_id": "963f3278-19b5-488f-b8f7-c7d102a3341f"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/963f3278-19b5-488f-b8f7-c7d102a3341f"
          }
        }
      }
    },
    {
      "id": "virtual-d9fe5664-6a71-51b5-81c4-4d0f095fba48",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-07",
        "rented_count": 0,
        "interval": "day",
        "product_id": "963f3278-19b5-488f-b8f7-c7d102a3341f"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/963f3278-19b5-488f-b8f7-c7d102a3341f"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-08T13:50:28Z`
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







