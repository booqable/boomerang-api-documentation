# Report rental intervals

Breakdown of how many times a product was rented during a specific period.

## Fields
Every report rental interval has the following fields:

Name | Description
- | -
`id` | **Uuid** `readonly`<br>
`date` | **Date** <br>Interval date
`rented_count` | **Integer** <br>Times the product was rented
`interval` | **String** <br>The interval of the breakdown
`product_id` | **Uuid** <br>The associated Product


## Relationships
Report rental intervals have the following relationships:

Name | Description
- | -
`product` | **Products** `readonly`<br>Associated Product


## Listing performance for a rental product per interval



> How to fetch performance per interval for a product:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2022-11-13+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=ebd902c5-c768-4811-9d16-4ef8c59dbd98&filter%5Btill%5D=2022-11-22+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-ecdb58ee-33f2-532d-bef0-caeb9e1471ce",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-13",
        "rented_count": 0,
        "interval": "day",
        "product_id": "ebd902c5-c768-4811-9d16-4ef8c59dbd98"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/ebd902c5-c768-4811-9d16-4ef8c59dbd98"
          }
        }
      }
    },
    {
      "id": "virtual-0e1938b7-4b72-53ea-b699-7cfbc6ffacd5",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-14",
        "rented_count": 0,
        "interval": "day",
        "product_id": "ebd902c5-c768-4811-9d16-4ef8c59dbd98"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/ebd902c5-c768-4811-9d16-4ef8c59dbd98"
          }
        }
      }
    },
    {
      "id": "virtual-7bd663e1-2c4c-5948-ad00-df1ae4040706",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-15",
        "rented_count": 0,
        "interval": "day",
        "product_id": "ebd902c5-c768-4811-9d16-4ef8c59dbd98"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/ebd902c5-c768-4811-9d16-4ef8c59dbd98"
          }
        }
      }
    },
    {
      "id": "virtual-34f627d3-669f-577c-b859-6fcb186564c7",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-16",
        "rented_count": 0,
        "interval": "day",
        "product_id": "ebd902c5-c768-4811-9d16-4ef8c59dbd98"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/ebd902c5-c768-4811-9d16-4ef8c59dbd98"
          }
        }
      }
    },
    {
      "id": "virtual-05968e83-7f96-530f-bb0c-a699e59441ac",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-17",
        "rented_count": 1,
        "interval": "day",
        "product_id": "ebd902c5-c768-4811-9d16-4ef8c59dbd98"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/ebd902c5-c768-4811-9d16-4ef8c59dbd98"
          }
        }
      }
    },
    {
      "id": "virtual-3e386880-f202-5010-9c03-df867a03d4cb",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-18",
        "rented_count": 0,
        "interval": "day",
        "product_id": "ebd902c5-c768-4811-9d16-4ef8c59dbd98"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/ebd902c5-c768-4811-9d16-4ef8c59dbd98"
          }
        }
      }
    },
    {
      "id": "virtual-ab17fd03-ac4e-517f-937f-0b0ba78d0216",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-19",
        "rented_count": 1,
        "interval": "day",
        "product_id": "ebd902c5-c768-4811-9d16-4ef8c59dbd98"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/ebd902c5-c768-4811-9d16-4ef8c59dbd98"
          }
        }
      }
    },
    {
      "id": "virtual-9ce4bb2c-777f-5d62-8bae-b7824711f572",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-20",
        "rented_count": 0,
        "interval": "day",
        "product_id": "ebd902c5-c768-4811-9d16-4ef8c59dbd98"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/ebd902c5-c768-4811-9d16-4ef8c59dbd98"
          }
        }
      }
    },
    {
      "id": "virtual-763aadd5-329c-5f1a-8704-a7979066dc72",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-21",
        "rented_count": 1,
        "interval": "day",
        "product_id": "ebd902c5-c768-4811-9d16-4ef8c59dbd98"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/ebd902c5-c768-4811-9d16-4ef8c59dbd98"
          }
        }
      }
    },
    {
      "id": "virtual-fe9308cc-919d-54ae-9f6b-aac98af6915c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-22",
        "rented_count": 0,
        "interval": "day",
        "product_id": "ebd902c5-c768-4811-9d16-4ef8c59dbd98"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/ebd902c5-c768-4811-9d16-4ef8c59dbd98"
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
- | -
`include` | **String** <br>List of comma seperated relationships `?include=product`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[report_rental_intervals]=id,created_at,updated_at`
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-11-23T11:33:07Z`
`sort` | **String** <br>How to sort the data `?sort=-created_at`
`meta` | **Hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String** <br>The page to request
`page[size]` | **String** <br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
`product_id` | **Uuid** `required`<br>`eq`
`from` | **Datetime** <br>`eq`
`till` | **Datetime** <br>`eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array** <br>`count`


### Includes

This request accepts the following includes:

`product` => 
`photo`







