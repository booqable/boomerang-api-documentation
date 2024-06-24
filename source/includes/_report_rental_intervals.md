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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2024-06-14+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=05a05c7f-2890-4c65-bb48-dbcf539d0ce7&filter%5Btill%5D=2024-06-23+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "e25c2506-7eb1-46c2-a8fe-797af670d2a0",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-06-14",
        "rented_count": 0,
        "interval": "day",
        "product_id": "05a05c7f-2890-4c65-bb48-dbcf539d0ce7"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/05a05c7f-2890-4c65-bb48-dbcf539d0ce7"
          }
        }
      }
    },
    {
      "id": "1191688f-a867-447a-9785-f6e79c81ebc0",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-06-15",
        "rented_count": 0,
        "interval": "day",
        "product_id": "05a05c7f-2890-4c65-bb48-dbcf539d0ce7"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/05a05c7f-2890-4c65-bb48-dbcf539d0ce7"
          }
        }
      }
    },
    {
      "id": "952fa522-1e76-46d8-8e04-255539a7e3f2",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-06-16",
        "rented_count": 0,
        "interval": "day",
        "product_id": "05a05c7f-2890-4c65-bb48-dbcf539d0ce7"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/05a05c7f-2890-4c65-bb48-dbcf539d0ce7"
          }
        }
      }
    },
    {
      "id": "c78ddf75-ddb4-45a8-88f7-74e10bccec72",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-06-17",
        "rented_count": 0,
        "interval": "day",
        "product_id": "05a05c7f-2890-4c65-bb48-dbcf539d0ce7"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/05a05c7f-2890-4c65-bb48-dbcf539d0ce7"
          }
        }
      }
    },
    {
      "id": "dd4ee56a-6354-4680-b021-f3522808e0a5",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-06-18",
        "rented_count": 1,
        "interval": "day",
        "product_id": "05a05c7f-2890-4c65-bb48-dbcf539d0ce7"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/05a05c7f-2890-4c65-bb48-dbcf539d0ce7"
          }
        }
      }
    },
    {
      "id": "918f4e17-db41-4967-95fc-69be38e59c64",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-06-19",
        "rented_count": 0,
        "interval": "day",
        "product_id": "05a05c7f-2890-4c65-bb48-dbcf539d0ce7"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/05a05c7f-2890-4c65-bb48-dbcf539d0ce7"
          }
        }
      }
    },
    {
      "id": "13b8aa77-d010-4cc5-8146-c45d2e065c1f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-06-20",
        "rented_count": 1,
        "interval": "day",
        "product_id": "05a05c7f-2890-4c65-bb48-dbcf539d0ce7"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/05a05c7f-2890-4c65-bb48-dbcf539d0ce7"
          }
        }
      }
    },
    {
      "id": "fa435c29-3975-4cac-9c3d-00ecd29a4c7c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-06-21",
        "rented_count": 0,
        "interval": "day",
        "product_id": "05a05c7f-2890-4c65-bb48-dbcf539d0ce7"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/05a05c7f-2890-4c65-bb48-dbcf539d0ce7"
          }
        }
      }
    },
    {
      "id": "6b3c2656-74f5-42e4-acfe-76e6da11eb15",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-06-22",
        "rented_count": 1,
        "interval": "day",
        "product_id": "05a05c7f-2890-4c65-bb48-dbcf539d0ce7"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/05a05c7f-2890-4c65-bb48-dbcf539d0ce7"
          }
        }
      }
    },
    {
      "id": "4d63a2a1-8c59-4535-8ef5-753f5d77cdc3",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-06-23",
        "rented_count": 0,
        "interval": "day",
        "product_id": "05a05c7f-2890-4c65-bb48-dbcf539d0ce7"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/05a05c7f-2890-4c65-bb48-dbcf539d0ce7"
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







