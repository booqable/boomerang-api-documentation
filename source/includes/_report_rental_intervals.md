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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2024-05-03+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=cd455e8f-4be2-415b-ae2a-2829343139b3&filter%5Btill%5D=2024-05-12+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "24418d4e-8ab4-4cc9-8986-e82ce760c71a",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-05-03",
        "rented_count": 0,
        "interval": "day",
        "product_id": "cd455e8f-4be2-415b-ae2a-2829343139b3"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/cd455e8f-4be2-415b-ae2a-2829343139b3"
          }
        }
      }
    },
    {
      "id": "97e127f3-fa2d-48e3-aeda-83863e1beb29",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-05-04",
        "rented_count": 0,
        "interval": "day",
        "product_id": "cd455e8f-4be2-415b-ae2a-2829343139b3"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/cd455e8f-4be2-415b-ae2a-2829343139b3"
          }
        }
      }
    },
    {
      "id": "364dd92a-6d11-418f-8ffd-017af3758da7",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-05-05",
        "rented_count": 0,
        "interval": "day",
        "product_id": "cd455e8f-4be2-415b-ae2a-2829343139b3"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/cd455e8f-4be2-415b-ae2a-2829343139b3"
          }
        }
      }
    },
    {
      "id": "c725f592-a3e0-4245-b539-a532ea3f44f4",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-05-06",
        "rented_count": 0,
        "interval": "day",
        "product_id": "cd455e8f-4be2-415b-ae2a-2829343139b3"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/cd455e8f-4be2-415b-ae2a-2829343139b3"
          }
        }
      }
    },
    {
      "id": "25278ff3-b953-4181-b70d-7021343c000d",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-05-07",
        "rented_count": 1,
        "interval": "day",
        "product_id": "cd455e8f-4be2-415b-ae2a-2829343139b3"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/cd455e8f-4be2-415b-ae2a-2829343139b3"
          }
        }
      }
    },
    {
      "id": "97bf0872-4c1d-4421-ab4e-44ebc4fb93f7",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-05-08",
        "rented_count": 0,
        "interval": "day",
        "product_id": "cd455e8f-4be2-415b-ae2a-2829343139b3"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/cd455e8f-4be2-415b-ae2a-2829343139b3"
          }
        }
      }
    },
    {
      "id": "f138e9ed-6a0c-4a5a-9f36-8a25754f2f34",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-05-09",
        "rented_count": 1,
        "interval": "day",
        "product_id": "cd455e8f-4be2-415b-ae2a-2829343139b3"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/cd455e8f-4be2-415b-ae2a-2829343139b3"
          }
        }
      }
    },
    {
      "id": "f21878c7-2d1d-4388-8bf1-06e74118971f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-05-10",
        "rented_count": 0,
        "interval": "day",
        "product_id": "cd455e8f-4be2-415b-ae2a-2829343139b3"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/cd455e8f-4be2-415b-ae2a-2829343139b3"
          }
        }
      }
    },
    {
      "id": "3e02a1b7-cd5a-48fe-897d-e835b9d64cd3",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-05-11",
        "rented_count": 1,
        "interval": "day",
        "product_id": "cd455e8f-4be2-415b-ae2a-2829343139b3"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/cd455e8f-4be2-415b-ae2a-2829343139b3"
          }
        }
      }
    },
    {
      "id": "bd2194aa-aeb1-4dbb-8d70-16a6e49c4647",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-05-12",
        "rented_count": 0,
        "interval": "day",
        "product_id": "cd455e8f-4be2-415b-ae2a-2829343139b3"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/cd455e8f-4be2-415b-ae2a-2829343139b3"
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







