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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-12-22+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=01acb78d-45cc-4419-871c-943ef2473203&filter%5Btill%5D=2023-12-31+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "0ab6fba8-f9f3-4ee4-bb7c-b368054f4025",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-12-22",
        "rented_count": 0,
        "interval": "day",
        "product_id": "01acb78d-45cc-4419-871c-943ef2473203"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/01acb78d-45cc-4419-871c-943ef2473203"
          }
        }
      }
    },
    {
      "id": "97fc8b2f-51f8-43f7-b3f1-5b1f8c2f7ca9",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-12-23",
        "rented_count": 0,
        "interval": "day",
        "product_id": "01acb78d-45cc-4419-871c-943ef2473203"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/01acb78d-45cc-4419-871c-943ef2473203"
          }
        }
      }
    },
    {
      "id": "38698391-ca08-4528-832f-adb7556934e3",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-12-24",
        "rented_count": 0,
        "interval": "day",
        "product_id": "01acb78d-45cc-4419-871c-943ef2473203"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/01acb78d-45cc-4419-871c-943ef2473203"
          }
        }
      }
    },
    {
      "id": "b56f5dfc-fd11-4e61-b355-fc8a87b99802",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-12-25",
        "rented_count": 0,
        "interval": "day",
        "product_id": "01acb78d-45cc-4419-871c-943ef2473203"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/01acb78d-45cc-4419-871c-943ef2473203"
          }
        }
      }
    },
    {
      "id": "eec7e76c-1bed-4067-a554-f4671b834f55",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-12-26",
        "rented_count": 1,
        "interval": "day",
        "product_id": "01acb78d-45cc-4419-871c-943ef2473203"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/01acb78d-45cc-4419-871c-943ef2473203"
          }
        }
      }
    },
    {
      "id": "973c3909-f547-43ec-aa5c-b776bbe230dd",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-12-27",
        "rented_count": 0,
        "interval": "day",
        "product_id": "01acb78d-45cc-4419-871c-943ef2473203"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/01acb78d-45cc-4419-871c-943ef2473203"
          }
        }
      }
    },
    {
      "id": "d014be21-d442-4037-92a0-66971bf2cf55",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-12-28",
        "rented_count": 1,
        "interval": "day",
        "product_id": "01acb78d-45cc-4419-871c-943ef2473203"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/01acb78d-45cc-4419-871c-943ef2473203"
          }
        }
      }
    },
    {
      "id": "0b42e829-96fd-4d1a-85be-a7ec2df2f08a",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-12-29",
        "rented_count": 0,
        "interval": "day",
        "product_id": "01acb78d-45cc-4419-871c-943ef2473203"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/01acb78d-45cc-4419-871c-943ef2473203"
          }
        }
      }
    },
    {
      "id": "55e1a29c-c522-47de-8e2c-5bf9056dc900",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-12-30",
        "rented_count": 1,
        "interval": "day",
        "product_id": "01acb78d-45cc-4419-871c-943ef2473203"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/01acb78d-45cc-4419-871c-943ef2473203"
          }
        }
      }
    },
    {
      "id": "316bacfb-f26a-45a4-83f9-4a0dd987234a",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-12-31",
        "rented_count": 0,
        "interval": "day",
        "product_id": "01acb78d-45cc-4419-871c-943ef2473203"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/01acb78d-45cc-4419-871c-943ef2473203"
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







