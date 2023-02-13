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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-02-03+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=e749462b-beab-4b07-82c5-4b5513fb243e&filter%5Btill%5D=2023-02-12+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-b6287c88-6259-51b2-8a9c-ced9212967be",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-03",
        "rented_count": 0,
        "interval": "day",
        "product_id": "e749462b-beab-4b07-82c5-4b5513fb243e"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e749462b-beab-4b07-82c5-4b5513fb243e"
          }
        }
      }
    },
    {
      "id": "virtual-5482a3e2-c3cf-5d69-a32f-9d17b1162c17",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-04",
        "rented_count": 0,
        "interval": "day",
        "product_id": "e749462b-beab-4b07-82c5-4b5513fb243e"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e749462b-beab-4b07-82c5-4b5513fb243e"
          }
        }
      }
    },
    {
      "id": "virtual-904db3f6-c485-5751-b80f-d12ae98aa45e",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-05",
        "rented_count": 0,
        "interval": "day",
        "product_id": "e749462b-beab-4b07-82c5-4b5513fb243e"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e749462b-beab-4b07-82c5-4b5513fb243e"
          }
        }
      }
    },
    {
      "id": "virtual-d8f4ac1a-b203-5fdd-bf1d-fde1b07ab367",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-06",
        "rented_count": 0,
        "interval": "day",
        "product_id": "e749462b-beab-4b07-82c5-4b5513fb243e"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e749462b-beab-4b07-82c5-4b5513fb243e"
          }
        }
      }
    },
    {
      "id": "virtual-0d887607-d2b6-5f05-b600-d4730fd43207",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-07",
        "rented_count": 1,
        "interval": "day",
        "product_id": "e749462b-beab-4b07-82c5-4b5513fb243e"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e749462b-beab-4b07-82c5-4b5513fb243e"
          }
        }
      }
    },
    {
      "id": "virtual-918461a8-5807-512c-b33d-e8e988b684b4",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-08",
        "rented_count": 0,
        "interval": "day",
        "product_id": "e749462b-beab-4b07-82c5-4b5513fb243e"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e749462b-beab-4b07-82c5-4b5513fb243e"
          }
        }
      }
    },
    {
      "id": "virtual-c74532ad-c42d-526a-8b61-5e33acf6ad63",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-09",
        "rented_count": 1,
        "interval": "day",
        "product_id": "e749462b-beab-4b07-82c5-4b5513fb243e"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e749462b-beab-4b07-82c5-4b5513fb243e"
          }
        }
      }
    },
    {
      "id": "virtual-d42d1c85-1b1d-5201-a60a-c2b0a0025b92",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-10",
        "rented_count": 0,
        "interval": "day",
        "product_id": "e749462b-beab-4b07-82c5-4b5513fb243e"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e749462b-beab-4b07-82c5-4b5513fb243e"
          }
        }
      }
    },
    {
      "id": "virtual-e554be8b-3d4a-56ae-ae00-2b26dc4f527e",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-11",
        "rented_count": 1,
        "interval": "day",
        "product_id": "e749462b-beab-4b07-82c5-4b5513fb243e"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e749462b-beab-4b07-82c5-4b5513fb243e"
          }
        }
      }
    },
    {
      "id": "virtual-07435378-f964-5222-8643-41e2d9859e97",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-12",
        "rented_count": 0,
        "interval": "day",
        "product_id": "e749462b-beab-4b07-82c5-4b5513fb243e"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/e749462b-beab-4b07-82c5-4b5513fb243e"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-13T15:59:18Z`
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







