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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2024-04-19+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=eb8872eb-adee-4433-8c9e-e71dcfb0d77f&filter%5Btill%5D=2024-04-28+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "6ed201a8-a95a-4e6a-9b26-21e78cc82f48",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-04-19",
        "rented_count": 0,
        "interval": "day",
        "product_id": "eb8872eb-adee-4433-8c9e-e71dcfb0d77f"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/eb8872eb-adee-4433-8c9e-e71dcfb0d77f"
          }
        }
      }
    },
    {
      "id": "0c8907d0-2a1e-47c1-9cfe-f2c10e7b9f36",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-04-20",
        "rented_count": 0,
        "interval": "day",
        "product_id": "eb8872eb-adee-4433-8c9e-e71dcfb0d77f"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/eb8872eb-adee-4433-8c9e-e71dcfb0d77f"
          }
        }
      }
    },
    {
      "id": "e2f8efce-e673-4d1d-883e-02cbad8c34f5",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-04-21",
        "rented_count": 0,
        "interval": "day",
        "product_id": "eb8872eb-adee-4433-8c9e-e71dcfb0d77f"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/eb8872eb-adee-4433-8c9e-e71dcfb0d77f"
          }
        }
      }
    },
    {
      "id": "da2f424e-5a68-45af-9350-ba8684b2efcc",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-04-22",
        "rented_count": 0,
        "interval": "day",
        "product_id": "eb8872eb-adee-4433-8c9e-e71dcfb0d77f"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/eb8872eb-adee-4433-8c9e-e71dcfb0d77f"
          }
        }
      }
    },
    {
      "id": "60607fa3-17b8-4981-90bb-97c7f185a64d",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-04-23",
        "rented_count": 1,
        "interval": "day",
        "product_id": "eb8872eb-adee-4433-8c9e-e71dcfb0d77f"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/eb8872eb-adee-4433-8c9e-e71dcfb0d77f"
          }
        }
      }
    },
    {
      "id": "8f2e8b89-3ec0-4421-b50c-40a65d0966c4",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-04-24",
        "rented_count": 0,
        "interval": "day",
        "product_id": "eb8872eb-adee-4433-8c9e-e71dcfb0d77f"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/eb8872eb-adee-4433-8c9e-e71dcfb0d77f"
          }
        }
      }
    },
    {
      "id": "dffa9f27-50e7-4380-807a-619ee92e2a83",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-04-25",
        "rented_count": 1,
        "interval": "day",
        "product_id": "eb8872eb-adee-4433-8c9e-e71dcfb0d77f"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/eb8872eb-adee-4433-8c9e-e71dcfb0d77f"
          }
        }
      }
    },
    {
      "id": "d22967ee-f74f-4216-9766-1bb2648ffe99",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-04-26",
        "rented_count": 0,
        "interval": "day",
        "product_id": "eb8872eb-adee-4433-8c9e-e71dcfb0d77f"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/eb8872eb-adee-4433-8c9e-e71dcfb0d77f"
          }
        }
      }
    },
    {
      "id": "4fe0ffbf-eefb-4e10-b570-6ac7fea9ea1b",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-04-27",
        "rented_count": 1,
        "interval": "day",
        "product_id": "eb8872eb-adee-4433-8c9e-e71dcfb0d77f"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/eb8872eb-adee-4433-8c9e-e71dcfb0d77f"
          }
        }
      }
    },
    {
      "id": "e6c806a5-0b98-42a6-8c85-bed8249bf387",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-04-28",
        "rented_count": 0,
        "interval": "day",
        "product_id": "eb8872eb-adee-4433-8c9e-e71dcfb0d77f"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/eb8872eb-adee-4433-8c9e-e71dcfb0d77f"
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







