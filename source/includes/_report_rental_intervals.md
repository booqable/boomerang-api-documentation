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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-01-30+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=1c6e8e30-d266-4491-a8e8-5c0cd4a27065&filter%5Btill%5D=2023-02-08+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-cc2b6428-ec7b-562d-80a7-97d0690db9af",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-30",
        "rented_count": 0,
        "interval": "day",
        "product_id": "1c6e8e30-d266-4491-a8e8-5c0cd4a27065"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/1c6e8e30-d266-4491-a8e8-5c0cd4a27065"
          }
        }
      }
    },
    {
      "id": "virtual-335adf1d-e3f8-50a0-982f-6dea1bcef9df",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-31",
        "rented_count": 0,
        "interval": "day",
        "product_id": "1c6e8e30-d266-4491-a8e8-5c0cd4a27065"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/1c6e8e30-d266-4491-a8e8-5c0cd4a27065"
          }
        }
      }
    },
    {
      "id": "virtual-1368ae88-b50a-56ed-a55e-d121683984bd",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-01",
        "rented_count": 0,
        "interval": "day",
        "product_id": "1c6e8e30-d266-4491-a8e8-5c0cd4a27065"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/1c6e8e30-d266-4491-a8e8-5c0cd4a27065"
          }
        }
      }
    },
    {
      "id": "virtual-d6dc1dd6-aaad-5019-a00a-b9ab4dce79be",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-02",
        "rented_count": 0,
        "interval": "day",
        "product_id": "1c6e8e30-d266-4491-a8e8-5c0cd4a27065"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/1c6e8e30-d266-4491-a8e8-5c0cd4a27065"
          }
        }
      }
    },
    {
      "id": "virtual-2108a024-e1bb-582f-a88f-d2b4242da4f7",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-03",
        "rented_count": 1,
        "interval": "day",
        "product_id": "1c6e8e30-d266-4491-a8e8-5c0cd4a27065"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/1c6e8e30-d266-4491-a8e8-5c0cd4a27065"
          }
        }
      }
    },
    {
      "id": "virtual-c7870e22-d992-53dc-9d24-b6e467a1b35b",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-04",
        "rented_count": 0,
        "interval": "day",
        "product_id": "1c6e8e30-d266-4491-a8e8-5c0cd4a27065"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/1c6e8e30-d266-4491-a8e8-5c0cd4a27065"
          }
        }
      }
    },
    {
      "id": "virtual-2ef2cb72-c341-5f1b-ba1b-2efb3e64a203",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-05",
        "rented_count": 1,
        "interval": "day",
        "product_id": "1c6e8e30-d266-4491-a8e8-5c0cd4a27065"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/1c6e8e30-d266-4491-a8e8-5c0cd4a27065"
          }
        }
      }
    },
    {
      "id": "virtual-b8be9fc7-efbf-55e0-b1e6-667438d9a9e3",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-06",
        "rented_count": 0,
        "interval": "day",
        "product_id": "1c6e8e30-d266-4491-a8e8-5c0cd4a27065"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/1c6e8e30-d266-4491-a8e8-5c0cd4a27065"
          }
        }
      }
    },
    {
      "id": "virtual-315b5260-e4f9-599b-9bcc-aba13c9bf65c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-07",
        "rented_count": 1,
        "interval": "day",
        "product_id": "1c6e8e30-d266-4491-a8e8-5c0cd4a27065"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/1c6e8e30-d266-4491-a8e8-5c0cd4a27065"
          }
        }
      }
    },
    {
      "id": "virtual-3ab97f5d-cc60-585a-9a60-00aae28d5972",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-08",
        "rented_count": 0,
        "interval": "day",
        "product_id": "1c6e8e30-d266-4491-a8e8-5c0cd4a27065"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/1c6e8e30-d266-4491-a8e8-5c0cd4a27065"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-09T10:17:18Z`
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







