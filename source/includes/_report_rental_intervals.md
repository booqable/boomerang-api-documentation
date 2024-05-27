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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2024-05-17+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=7df28eac-8c5f-4013-afc7-bd140bb6c97b&filter%5Btill%5D=2024-05-26+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "2b298a60-a647-45b8-aa87-a5a64a31926d",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-05-17",
        "rented_count": 0,
        "interval": "day",
        "product_id": "7df28eac-8c5f-4013-afc7-bd140bb6c97b"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/7df28eac-8c5f-4013-afc7-bd140bb6c97b"
          }
        }
      }
    },
    {
      "id": "452ba980-3220-4550-8de2-cf23ff78cbc9",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-05-18",
        "rented_count": 0,
        "interval": "day",
        "product_id": "7df28eac-8c5f-4013-afc7-bd140bb6c97b"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/7df28eac-8c5f-4013-afc7-bd140bb6c97b"
          }
        }
      }
    },
    {
      "id": "f94c26d5-c96b-49d4-be67-822db2c10cae",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-05-19",
        "rented_count": 0,
        "interval": "day",
        "product_id": "7df28eac-8c5f-4013-afc7-bd140bb6c97b"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/7df28eac-8c5f-4013-afc7-bd140bb6c97b"
          }
        }
      }
    },
    {
      "id": "9841e9e8-e4b2-45ec-bfdf-ef2164e5f68b",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-05-20",
        "rented_count": 0,
        "interval": "day",
        "product_id": "7df28eac-8c5f-4013-afc7-bd140bb6c97b"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/7df28eac-8c5f-4013-afc7-bd140bb6c97b"
          }
        }
      }
    },
    {
      "id": "379ba24f-4b0c-465e-8aa5-04782e9bea29",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-05-21",
        "rented_count": 1,
        "interval": "day",
        "product_id": "7df28eac-8c5f-4013-afc7-bd140bb6c97b"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/7df28eac-8c5f-4013-afc7-bd140bb6c97b"
          }
        }
      }
    },
    {
      "id": "d0cb2f18-03bc-4d24-8149-ec634eb2d69d",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-05-22",
        "rented_count": 0,
        "interval": "day",
        "product_id": "7df28eac-8c5f-4013-afc7-bd140bb6c97b"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/7df28eac-8c5f-4013-afc7-bd140bb6c97b"
          }
        }
      }
    },
    {
      "id": "a83401bf-3390-41e3-a86f-34f07df1a63b",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-05-23",
        "rented_count": 1,
        "interval": "day",
        "product_id": "7df28eac-8c5f-4013-afc7-bd140bb6c97b"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/7df28eac-8c5f-4013-afc7-bd140bb6c97b"
          }
        }
      }
    },
    {
      "id": "c9a69327-b880-4094-a1b7-78f4a12c8098",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-05-24",
        "rented_count": 0,
        "interval": "day",
        "product_id": "7df28eac-8c5f-4013-afc7-bd140bb6c97b"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/7df28eac-8c5f-4013-afc7-bd140bb6c97b"
          }
        }
      }
    },
    {
      "id": "9f34e9b9-aaeb-4bcc-aa5e-0a6315c9ed24",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-05-25",
        "rented_count": 1,
        "interval": "day",
        "product_id": "7df28eac-8c5f-4013-afc7-bd140bb6c97b"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/7df28eac-8c5f-4013-afc7-bd140bb6c97b"
          }
        }
      }
    },
    {
      "id": "45833b87-b630-432f-a9e1-91a6bed58d2c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-05-26",
        "rented_count": 0,
        "interval": "day",
        "product_id": "7df28eac-8c5f-4013-afc7-bd140bb6c97b"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/7df28eac-8c5f-4013-afc7-bd140bb6c97b"
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







