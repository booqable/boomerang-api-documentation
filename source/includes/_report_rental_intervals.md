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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2024-02-16+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=c4df5042-310f-4e9b-8ade-5fbee7c73e80&filter%5Btill%5D=2024-02-25+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "56b6836d-3632-4ff8-aa03-371115d2fc21",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-02-16",
        "rented_count": 0,
        "interval": "day",
        "product_id": "c4df5042-310f-4e9b-8ade-5fbee7c73e80"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/c4df5042-310f-4e9b-8ade-5fbee7c73e80"
          }
        }
      }
    },
    {
      "id": "509e0db9-b052-41b0-8c2d-c24b94cb69e2",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-02-17",
        "rented_count": 0,
        "interval": "day",
        "product_id": "c4df5042-310f-4e9b-8ade-5fbee7c73e80"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/c4df5042-310f-4e9b-8ade-5fbee7c73e80"
          }
        }
      }
    },
    {
      "id": "bb4c7086-721d-4ae7-9f94-16d48037f26c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-02-18",
        "rented_count": 0,
        "interval": "day",
        "product_id": "c4df5042-310f-4e9b-8ade-5fbee7c73e80"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/c4df5042-310f-4e9b-8ade-5fbee7c73e80"
          }
        }
      }
    },
    {
      "id": "6e92a2c7-e25e-46fb-ba08-6c63025b327f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-02-19",
        "rented_count": 0,
        "interval": "day",
        "product_id": "c4df5042-310f-4e9b-8ade-5fbee7c73e80"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/c4df5042-310f-4e9b-8ade-5fbee7c73e80"
          }
        }
      }
    },
    {
      "id": "432a3c5d-e260-45df-b1b4-22b55580610c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-02-20",
        "rented_count": 1,
        "interval": "day",
        "product_id": "c4df5042-310f-4e9b-8ade-5fbee7c73e80"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/c4df5042-310f-4e9b-8ade-5fbee7c73e80"
          }
        }
      }
    },
    {
      "id": "ff227a23-289a-4460-ac33-6906a4e8272d",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-02-21",
        "rented_count": 0,
        "interval": "day",
        "product_id": "c4df5042-310f-4e9b-8ade-5fbee7c73e80"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/c4df5042-310f-4e9b-8ade-5fbee7c73e80"
          }
        }
      }
    },
    {
      "id": "e0acc1fd-a857-4d5d-8c12-757bd27f8ba8",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-02-22",
        "rented_count": 1,
        "interval": "day",
        "product_id": "c4df5042-310f-4e9b-8ade-5fbee7c73e80"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/c4df5042-310f-4e9b-8ade-5fbee7c73e80"
          }
        }
      }
    },
    {
      "id": "8ec7a489-241a-4a95-b5d4-062a2eb66a09",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-02-23",
        "rented_count": 0,
        "interval": "day",
        "product_id": "c4df5042-310f-4e9b-8ade-5fbee7c73e80"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/c4df5042-310f-4e9b-8ade-5fbee7c73e80"
          }
        }
      }
    },
    {
      "id": "4195f9af-92c4-4d0e-8466-41d2caaf606d",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-02-24",
        "rented_count": 1,
        "interval": "day",
        "product_id": "c4df5042-310f-4e9b-8ade-5fbee7c73e80"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/c4df5042-310f-4e9b-8ade-5fbee7c73e80"
          }
        }
      }
    },
    {
      "id": "17e69b8f-fcc8-47c5-8637-50047f5f1cff",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-02-25",
        "rented_count": 0,
        "interval": "day",
        "product_id": "c4df5042-310f-4e9b-8ade-5fbee7c73e80"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/c4df5042-310f-4e9b-8ade-5fbee7c73e80"
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







