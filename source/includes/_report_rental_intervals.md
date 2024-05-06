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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2024-04-26+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=0fd848fc-c815-4bd9-9a4e-2f7e9a21a860&filter%5Btill%5D=2024-05-05+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "3dec1f88-169f-4458-b11d-bf52d11f26a0",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-04-26",
        "rented_count": 0,
        "interval": "day",
        "product_id": "0fd848fc-c815-4bd9-9a4e-2f7e9a21a860"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/0fd848fc-c815-4bd9-9a4e-2f7e9a21a860"
          }
        }
      }
    },
    {
      "id": "bef05f98-3f7c-4885-adbd-bb07d3274f43",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-04-27",
        "rented_count": 0,
        "interval": "day",
        "product_id": "0fd848fc-c815-4bd9-9a4e-2f7e9a21a860"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/0fd848fc-c815-4bd9-9a4e-2f7e9a21a860"
          }
        }
      }
    },
    {
      "id": "b9c1e338-4a20-4a47-a4d9-3960bc5d54eb",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-04-28",
        "rented_count": 0,
        "interval": "day",
        "product_id": "0fd848fc-c815-4bd9-9a4e-2f7e9a21a860"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/0fd848fc-c815-4bd9-9a4e-2f7e9a21a860"
          }
        }
      }
    },
    {
      "id": "f4de205d-8cdb-4c49-ad6d-8e8fa04321d9",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-04-29",
        "rented_count": 0,
        "interval": "day",
        "product_id": "0fd848fc-c815-4bd9-9a4e-2f7e9a21a860"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/0fd848fc-c815-4bd9-9a4e-2f7e9a21a860"
          }
        }
      }
    },
    {
      "id": "0a85ce15-9af7-45a6-8151-b305b5523edc",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-04-30",
        "rented_count": 1,
        "interval": "day",
        "product_id": "0fd848fc-c815-4bd9-9a4e-2f7e9a21a860"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/0fd848fc-c815-4bd9-9a4e-2f7e9a21a860"
          }
        }
      }
    },
    {
      "id": "aa295742-1d36-493f-a28a-7c86dedb2050",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-05-01",
        "rented_count": 0,
        "interval": "day",
        "product_id": "0fd848fc-c815-4bd9-9a4e-2f7e9a21a860"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/0fd848fc-c815-4bd9-9a4e-2f7e9a21a860"
          }
        }
      }
    },
    {
      "id": "70d90b35-b483-4657-b6ec-103724267450",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-05-02",
        "rented_count": 1,
        "interval": "day",
        "product_id": "0fd848fc-c815-4bd9-9a4e-2f7e9a21a860"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/0fd848fc-c815-4bd9-9a4e-2f7e9a21a860"
          }
        }
      }
    },
    {
      "id": "f5f5a9df-8614-412b-9b07-55391422e7c4",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-05-03",
        "rented_count": 0,
        "interval": "day",
        "product_id": "0fd848fc-c815-4bd9-9a4e-2f7e9a21a860"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/0fd848fc-c815-4bd9-9a4e-2f7e9a21a860"
          }
        }
      }
    },
    {
      "id": "98dc5c01-a642-4d4a-b291-1d89cc103bfe",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-05-04",
        "rented_count": 1,
        "interval": "day",
        "product_id": "0fd848fc-c815-4bd9-9a4e-2f7e9a21a860"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/0fd848fc-c815-4bd9-9a4e-2f7e9a21a860"
          }
        }
      }
    },
    {
      "id": "51cdcf6a-534d-46de-8752-908d8347e883",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-05-05",
        "rented_count": 0,
        "interval": "day",
        "product_id": "0fd848fc-c815-4bd9-9a4e-2f7e9a21a860"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/0fd848fc-c815-4bd9-9a4e-2f7e9a21a860"
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







