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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2024-06-14+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=0251aa58-a72e-4443-88a0-9f349cbeeeef&filter%5Btill%5D=2024-06-23+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "2996e165-a67c-4c8c-b17e-0da5269e5a2a",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-06-14",
        "rented_count": 0,
        "interval": "day",
        "product_id": "0251aa58-a72e-4443-88a0-9f349cbeeeef"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/0251aa58-a72e-4443-88a0-9f349cbeeeef"
          }
        }
      }
    },
    {
      "id": "32a05006-cd67-4282-afcb-9a44b8d6b7d3",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-06-15",
        "rented_count": 0,
        "interval": "day",
        "product_id": "0251aa58-a72e-4443-88a0-9f349cbeeeef"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/0251aa58-a72e-4443-88a0-9f349cbeeeef"
          }
        }
      }
    },
    {
      "id": "3320396b-9b6d-48f5-9c97-2d97c882f206",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-06-16",
        "rented_count": 0,
        "interval": "day",
        "product_id": "0251aa58-a72e-4443-88a0-9f349cbeeeef"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/0251aa58-a72e-4443-88a0-9f349cbeeeef"
          }
        }
      }
    },
    {
      "id": "cb198cfb-e3f1-4ecf-bc3c-363b14063d91",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-06-17",
        "rented_count": 0,
        "interval": "day",
        "product_id": "0251aa58-a72e-4443-88a0-9f349cbeeeef"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/0251aa58-a72e-4443-88a0-9f349cbeeeef"
          }
        }
      }
    },
    {
      "id": "acd2fe7d-89cb-4af4-83ca-151f8b9ebbb2",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-06-18",
        "rented_count": 1,
        "interval": "day",
        "product_id": "0251aa58-a72e-4443-88a0-9f349cbeeeef"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/0251aa58-a72e-4443-88a0-9f349cbeeeef"
          }
        }
      }
    },
    {
      "id": "2fb5a8a1-251d-450a-b142-c2dddc30d87e",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-06-19",
        "rented_count": 0,
        "interval": "day",
        "product_id": "0251aa58-a72e-4443-88a0-9f349cbeeeef"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/0251aa58-a72e-4443-88a0-9f349cbeeeef"
          }
        }
      }
    },
    {
      "id": "fdf7e170-875f-4057-a8a4-7534dc6cf0f8",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-06-20",
        "rented_count": 1,
        "interval": "day",
        "product_id": "0251aa58-a72e-4443-88a0-9f349cbeeeef"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/0251aa58-a72e-4443-88a0-9f349cbeeeef"
          }
        }
      }
    },
    {
      "id": "742c3ad8-edea-42a4-974e-a274262d4398",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-06-21",
        "rented_count": 0,
        "interval": "day",
        "product_id": "0251aa58-a72e-4443-88a0-9f349cbeeeef"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/0251aa58-a72e-4443-88a0-9f349cbeeeef"
          }
        }
      }
    },
    {
      "id": "5a024113-7ede-4854-8a8d-6c6001cdeb82",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-06-22",
        "rented_count": 1,
        "interval": "day",
        "product_id": "0251aa58-a72e-4443-88a0-9f349cbeeeef"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/0251aa58-a72e-4443-88a0-9f349cbeeeef"
          }
        }
      }
    },
    {
      "id": "91a70f92-1b86-456a-80cd-47de4885570e",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-06-23",
        "rented_count": 0,
        "interval": "day",
        "product_id": "0251aa58-a72e-4443-88a0-9f349cbeeeef"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/0251aa58-a72e-4443-88a0-9f349cbeeeef"
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







