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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2024-02-09+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=33db3eff-e477-418b-8918-a7333bab2f02&filter%5Btill%5D=2024-02-18+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "87bc83af-b544-4d30-b110-1328486e5376",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-02-09",
        "rented_count": 0,
        "interval": "day",
        "product_id": "33db3eff-e477-418b-8918-a7333bab2f02"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/33db3eff-e477-418b-8918-a7333bab2f02"
          }
        }
      }
    },
    {
      "id": "cd458c86-2c2c-47cd-b86e-dea3e83f0659",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-02-10",
        "rented_count": 0,
        "interval": "day",
        "product_id": "33db3eff-e477-418b-8918-a7333bab2f02"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/33db3eff-e477-418b-8918-a7333bab2f02"
          }
        }
      }
    },
    {
      "id": "794f977d-f6a4-46dd-94bf-cfe96c7a0a1a",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-02-11",
        "rented_count": 0,
        "interval": "day",
        "product_id": "33db3eff-e477-418b-8918-a7333bab2f02"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/33db3eff-e477-418b-8918-a7333bab2f02"
          }
        }
      }
    },
    {
      "id": "65e6d59a-d489-463a-ac4a-da3dc9bd9cc9",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-02-12",
        "rented_count": 0,
        "interval": "day",
        "product_id": "33db3eff-e477-418b-8918-a7333bab2f02"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/33db3eff-e477-418b-8918-a7333bab2f02"
          }
        }
      }
    },
    {
      "id": "4476fde9-987e-44b5-8d6b-66120f1fc967",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-02-13",
        "rented_count": 1,
        "interval": "day",
        "product_id": "33db3eff-e477-418b-8918-a7333bab2f02"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/33db3eff-e477-418b-8918-a7333bab2f02"
          }
        }
      }
    },
    {
      "id": "083d3531-24c5-46b8-a941-6717d287bf4d",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-02-14",
        "rented_count": 0,
        "interval": "day",
        "product_id": "33db3eff-e477-418b-8918-a7333bab2f02"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/33db3eff-e477-418b-8918-a7333bab2f02"
          }
        }
      }
    },
    {
      "id": "6c2360dc-c7b9-4872-8deb-94063836ab52",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-02-15",
        "rented_count": 1,
        "interval": "day",
        "product_id": "33db3eff-e477-418b-8918-a7333bab2f02"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/33db3eff-e477-418b-8918-a7333bab2f02"
          }
        }
      }
    },
    {
      "id": "552cbafd-9e3c-48a5-8b24-90ed1a027b48",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-02-16",
        "rented_count": 0,
        "interval": "day",
        "product_id": "33db3eff-e477-418b-8918-a7333bab2f02"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/33db3eff-e477-418b-8918-a7333bab2f02"
          }
        }
      }
    },
    {
      "id": "6a09c606-b5f6-4932-a812-8119632ef28c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-02-17",
        "rented_count": 1,
        "interval": "day",
        "product_id": "33db3eff-e477-418b-8918-a7333bab2f02"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/33db3eff-e477-418b-8918-a7333bab2f02"
          }
        }
      }
    },
    {
      "id": "2569adce-e2c0-4201-90d3-6f8c6f881720",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-02-18",
        "rented_count": 0,
        "interval": "day",
        "product_id": "33db3eff-e477-418b-8918-a7333bab2f02"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/33db3eff-e477-418b-8918-a7333bab2f02"
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







