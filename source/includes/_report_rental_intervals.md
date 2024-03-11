# Report rental intervals

Breakdown of how many times a product was rented during a specific period.

## Fields
Every report rental interval has the following fields:

Name | Description
-- | --
`id` | **Uuid** `readonly`<br>
`date` | **Date** <br>Interval date
`rented_count` | **Integer** <br>Times the product was rented
`interval` | **String** <br>The interval of the breakdown
`product_id` | **Uuid** <br>The associated Product


## Relationships
Report rental intervals have the following relationships:

Name | Description
-- | --
`product` | **Products** `readonly`<br>Associated Product


## Listing performance for a rental product per interval



> How to fetch performance per interval for a product:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2024-03-01+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=d8572055-d3b8-40f0-833c-613ab36a2ae0&filter%5Btill%5D=2024-03-10+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "4354d48c-a3e7-4e4a-990d-e75eef9baf80",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-03-01",
        "rented_count": 0,
        "interval": "day",
        "product_id": "d8572055-d3b8-40f0-833c-613ab36a2ae0"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/d8572055-d3b8-40f0-833c-613ab36a2ae0"
          }
        }
      }
    },
    {
      "id": "c7860188-eced-4349-9e22-148c00eec37c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-03-02",
        "rented_count": 0,
        "interval": "day",
        "product_id": "d8572055-d3b8-40f0-833c-613ab36a2ae0"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/d8572055-d3b8-40f0-833c-613ab36a2ae0"
          }
        }
      }
    },
    {
      "id": "d77c73b9-48e0-474f-b24e-cf7c597fd150",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-03-03",
        "rented_count": 0,
        "interval": "day",
        "product_id": "d8572055-d3b8-40f0-833c-613ab36a2ae0"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/d8572055-d3b8-40f0-833c-613ab36a2ae0"
          }
        }
      }
    },
    {
      "id": "3a6182f0-0740-45ac-bd4b-21a964b1479a",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-03-04",
        "rented_count": 0,
        "interval": "day",
        "product_id": "d8572055-d3b8-40f0-833c-613ab36a2ae0"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/d8572055-d3b8-40f0-833c-613ab36a2ae0"
          }
        }
      }
    },
    {
      "id": "cfaf955a-df31-4459-986d-4f570c1190b7",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-03-05",
        "rented_count": 1,
        "interval": "day",
        "product_id": "d8572055-d3b8-40f0-833c-613ab36a2ae0"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/d8572055-d3b8-40f0-833c-613ab36a2ae0"
          }
        }
      }
    },
    {
      "id": "a65495a0-877d-4aac-b491-c6147eb2ee0f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-03-06",
        "rented_count": 0,
        "interval": "day",
        "product_id": "d8572055-d3b8-40f0-833c-613ab36a2ae0"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/d8572055-d3b8-40f0-833c-613ab36a2ae0"
          }
        }
      }
    },
    {
      "id": "8c7d08b5-f4b7-4635-8a4b-3ec0e65dc28e",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-03-07",
        "rented_count": 1,
        "interval": "day",
        "product_id": "d8572055-d3b8-40f0-833c-613ab36a2ae0"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/d8572055-d3b8-40f0-833c-613ab36a2ae0"
          }
        }
      }
    },
    {
      "id": "73b16601-4d9f-4867-83c5-9c0c89a6b172",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-03-08",
        "rented_count": 0,
        "interval": "day",
        "product_id": "d8572055-d3b8-40f0-833c-613ab36a2ae0"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/d8572055-d3b8-40f0-833c-613ab36a2ae0"
          }
        }
      }
    },
    {
      "id": "6d355e55-e52f-4c03-86a7-94aea63ad23d",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-03-09",
        "rented_count": 1,
        "interval": "day",
        "product_id": "d8572055-d3b8-40f0-833c-613ab36a2ae0"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/d8572055-d3b8-40f0-833c-613ab36a2ae0"
          }
        }
      }
    },
    {
      "id": "fc29c9f5-518c-431f-9e58-fbeb8ddd37f2",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-03-10",
        "rented_count": 0,
        "interval": "day",
        "product_id": "d8572055-d3b8-40f0-833c-613ab36a2ae0"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/d8572055-d3b8-40f0-833c-613ab36a2ae0"
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
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=product`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[report_rental_intervals]=date,rented_count,interval`
`filter` | **Hash** <br>The filters to apply `?filter[attribute][eq]=value`
`sort` | **String** <br>How to sort the data `?sort=attribute1,-attribute2`
`meta` | **Hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String** <br>The page to request
`page[size]` | **String** <br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
-- | --
`product_id` | **Uuid** `required`<br>`eq`
`from` | **Datetime** <br>`eq`
`till` | **Datetime** <br>`eq`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **Array** <br>`count`


### Includes

This request accepts the following includes:

`product` => 
`photo`







