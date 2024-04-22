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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2024-04-12+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=c40faddf-c7a8-4f68-8266-12f0439c255d&filter%5Btill%5D=2024-04-21+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "0850db3d-c847-4593-8b35-522192c7346c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-04-12",
        "rented_count": 0,
        "interval": "day",
        "product_id": "c40faddf-c7a8-4f68-8266-12f0439c255d"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/c40faddf-c7a8-4f68-8266-12f0439c255d"
          }
        }
      }
    },
    {
      "id": "6d9c12c5-5cea-4230-9a05-5c9962022ce6",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-04-13",
        "rented_count": 0,
        "interval": "day",
        "product_id": "c40faddf-c7a8-4f68-8266-12f0439c255d"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/c40faddf-c7a8-4f68-8266-12f0439c255d"
          }
        }
      }
    },
    {
      "id": "9430143f-784d-4a81-9534-45d516576e6f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-04-14",
        "rented_count": 0,
        "interval": "day",
        "product_id": "c40faddf-c7a8-4f68-8266-12f0439c255d"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/c40faddf-c7a8-4f68-8266-12f0439c255d"
          }
        }
      }
    },
    {
      "id": "b7e8e31f-efd5-4d88-bd65-f5dfcf80fdb7",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-04-15",
        "rented_count": 0,
        "interval": "day",
        "product_id": "c40faddf-c7a8-4f68-8266-12f0439c255d"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/c40faddf-c7a8-4f68-8266-12f0439c255d"
          }
        }
      }
    },
    {
      "id": "060099bd-f2cd-4d1a-b989-0dd79d977be4",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-04-16",
        "rented_count": 1,
        "interval": "day",
        "product_id": "c40faddf-c7a8-4f68-8266-12f0439c255d"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/c40faddf-c7a8-4f68-8266-12f0439c255d"
          }
        }
      }
    },
    {
      "id": "a4588379-7c2f-440b-8109-25ee796c8223",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-04-17",
        "rented_count": 0,
        "interval": "day",
        "product_id": "c40faddf-c7a8-4f68-8266-12f0439c255d"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/c40faddf-c7a8-4f68-8266-12f0439c255d"
          }
        }
      }
    },
    {
      "id": "b6816c04-313d-4503-a9a1-e6ae418f9837",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-04-18",
        "rented_count": 1,
        "interval": "day",
        "product_id": "c40faddf-c7a8-4f68-8266-12f0439c255d"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/c40faddf-c7a8-4f68-8266-12f0439c255d"
          }
        }
      }
    },
    {
      "id": "ce4838c7-35b7-489a-ab50-fe9ece64d017",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-04-19",
        "rented_count": 0,
        "interval": "day",
        "product_id": "c40faddf-c7a8-4f68-8266-12f0439c255d"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/c40faddf-c7a8-4f68-8266-12f0439c255d"
          }
        }
      }
    },
    {
      "id": "74e75c22-f08f-462b-9a5d-8589d6971768",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-04-20",
        "rented_count": 1,
        "interval": "day",
        "product_id": "c40faddf-c7a8-4f68-8266-12f0439c255d"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/c40faddf-c7a8-4f68-8266-12f0439c255d"
          }
        }
      }
    },
    {
      "id": "7cb5c854-92bf-49f3-bc34-d9a6cd735035",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-04-21",
        "rented_count": 0,
        "interval": "day",
        "product_id": "c40faddf-c7a8-4f68-8266-12f0439c255d"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/c40faddf-c7a8-4f68-8266-12f0439c255d"
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







