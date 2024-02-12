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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2024-02-02+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=765cec74-16cb-4ac5-bd38-55a02f39e155&filter%5Btill%5D=2024-02-11+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "779557fd-a789-4b31-82e4-cf458a29456e",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-02-02",
        "rented_count": 0,
        "interval": "day",
        "product_id": "765cec74-16cb-4ac5-bd38-55a02f39e155"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/765cec74-16cb-4ac5-bd38-55a02f39e155"
          }
        }
      }
    },
    {
      "id": "f105168e-f921-4439-b88f-0aacee1018c5",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-02-03",
        "rented_count": 0,
        "interval": "day",
        "product_id": "765cec74-16cb-4ac5-bd38-55a02f39e155"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/765cec74-16cb-4ac5-bd38-55a02f39e155"
          }
        }
      }
    },
    {
      "id": "b13da933-a7e8-4a3d-bac0-50854c7499ef",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-02-04",
        "rented_count": 0,
        "interval": "day",
        "product_id": "765cec74-16cb-4ac5-bd38-55a02f39e155"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/765cec74-16cb-4ac5-bd38-55a02f39e155"
          }
        }
      }
    },
    {
      "id": "cebfbdfa-43c9-45fc-8943-591a9824bcd1",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-02-05",
        "rented_count": 0,
        "interval": "day",
        "product_id": "765cec74-16cb-4ac5-bd38-55a02f39e155"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/765cec74-16cb-4ac5-bd38-55a02f39e155"
          }
        }
      }
    },
    {
      "id": "8faa304b-cf01-4978-8239-63a72503cab2",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-02-06",
        "rented_count": 1,
        "interval": "day",
        "product_id": "765cec74-16cb-4ac5-bd38-55a02f39e155"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/765cec74-16cb-4ac5-bd38-55a02f39e155"
          }
        }
      }
    },
    {
      "id": "dc6fe19c-4dae-4d9c-942f-73296c0d9a39",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-02-07",
        "rented_count": 0,
        "interval": "day",
        "product_id": "765cec74-16cb-4ac5-bd38-55a02f39e155"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/765cec74-16cb-4ac5-bd38-55a02f39e155"
          }
        }
      }
    },
    {
      "id": "2ef075a3-fbc6-4085-b830-3871cc848417",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-02-08",
        "rented_count": 1,
        "interval": "day",
        "product_id": "765cec74-16cb-4ac5-bd38-55a02f39e155"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/765cec74-16cb-4ac5-bd38-55a02f39e155"
          }
        }
      }
    },
    {
      "id": "26bc17d9-fb14-4da4-ab54-a11d2b5b933a",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-02-09",
        "rented_count": 0,
        "interval": "day",
        "product_id": "765cec74-16cb-4ac5-bd38-55a02f39e155"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/765cec74-16cb-4ac5-bd38-55a02f39e155"
          }
        }
      }
    },
    {
      "id": "c3d85da9-d0bc-4c65-8a63-0ffce67c9740",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-02-10",
        "rented_count": 1,
        "interval": "day",
        "product_id": "765cec74-16cb-4ac5-bd38-55a02f39e155"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/765cec74-16cb-4ac5-bd38-55a02f39e155"
          }
        }
      }
    },
    {
      "id": "0caaa235-6a14-4863-a161-06ebd8e85c1e",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-02-11",
        "rented_count": 0,
        "interval": "day",
        "product_id": "765cec74-16cb-4ac5-bd38-55a02f39e155"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/765cec74-16cb-4ac5-bd38-55a02f39e155"
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







