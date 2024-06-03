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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2024-05-24+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=e6cce491-12e6-4403-82e8-ab916c54f728&filter%5Btill%5D=2024-06-02+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "ce368575-ace6-44dd-a61f-819da2726cbf",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-05-24",
        "rented_count": 0,
        "interval": "day",
        "product_id": "e6cce491-12e6-4403-82e8-ab916c54f728"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e6cce491-12e6-4403-82e8-ab916c54f728"
          }
        }
      }
    },
    {
      "id": "12a11da4-30a7-4626-95d8-986af3d24471",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-05-25",
        "rented_count": 0,
        "interval": "day",
        "product_id": "e6cce491-12e6-4403-82e8-ab916c54f728"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e6cce491-12e6-4403-82e8-ab916c54f728"
          }
        }
      }
    },
    {
      "id": "384fc2d0-6f8a-4b43-a56b-fd0afdac2d49",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-05-26",
        "rented_count": 0,
        "interval": "day",
        "product_id": "e6cce491-12e6-4403-82e8-ab916c54f728"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e6cce491-12e6-4403-82e8-ab916c54f728"
          }
        }
      }
    },
    {
      "id": "5c694603-1654-4932-b831-1a95487658a0",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-05-27",
        "rented_count": 0,
        "interval": "day",
        "product_id": "e6cce491-12e6-4403-82e8-ab916c54f728"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e6cce491-12e6-4403-82e8-ab916c54f728"
          }
        }
      }
    },
    {
      "id": "0441bea6-2380-4c80-a34f-c0c631fa7e9a",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-05-28",
        "rented_count": 1,
        "interval": "day",
        "product_id": "e6cce491-12e6-4403-82e8-ab916c54f728"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e6cce491-12e6-4403-82e8-ab916c54f728"
          }
        }
      }
    },
    {
      "id": "df14c9f6-0635-4779-8ed3-0cef706d0ba5",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-05-29",
        "rented_count": 0,
        "interval": "day",
        "product_id": "e6cce491-12e6-4403-82e8-ab916c54f728"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e6cce491-12e6-4403-82e8-ab916c54f728"
          }
        }
      }
    },
    {
      "id": "1f11eade-8060-4bdd-9436-b40d0a868556",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-05-30",
        "rented_count": 1,
        "interval": "day",
        "product_id": "e6cce491-12e6-4403-82e8-ab916c54f728"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e6cce491-12e6-4403-82e8-ab916c54f728"
          }
        }
      }
    },
    {
      "id": "06328da2-3369-43e9-b616-4d478aef53b9",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-05-31",
        "rented_count": 0,
        "interval": "day",
        "product_id": "e6cce491-12e6-4403-82e8-ab916c54f728"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e6cce491-12e6-4403-82e8-ab916c54f728"
          }
        }
      }
    },
    {
      "id": "c8fe6d8b-72c9-41e8-91f2-f43af1155cb5",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-06-01",
        "rented_count": 1,
        "interval": "day",
        "product_id": "e6cce491-12e6-4403-82e8-ab916c54f728"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e6cce491-12e6-4403-82e8-ab916c54f728"
          }
        }
      }
    },
    {
      "id": "78b8ff9d-0643-4df2-893e-c851d7f3f332",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-06-02",
        "rented_count": 0,
        "interval": "day",
        "product_id": "e6cce491-12e6-4403-82e8-ab916c54f728"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e6cce491-12e6-4403-82e8-ab916c54f728"
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







