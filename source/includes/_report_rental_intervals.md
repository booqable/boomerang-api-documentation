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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-01-02+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=85dd4f0d-909a-42e6-84d6-a79c130c0c80&filter%5Btill%5D=2023-01-11+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-e9abf2f4-aa34-548d-bf31-8c8051d83d04",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-02",
        "rented_count": 0,
        "interval": "day",
        "product_id": "85dd4f0d-909a-42e6-84d6-a79c130c0c80"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/85dd4f0d-909a-42e6-84d6-a79c130c0c80"
          }
        }
      }
    },
    {
      "id": "virtual-ded63edd-15af-5770-9d4d-e57cc115fa3f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-03",
        "rented_count": 0,
        "interval": "day",
        "product_id": "85dd4f0d-909a-42e6-84d6-a79c130c0c80"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/85dd4f0d-909a-42e6-84d6-a79c130c0c80"
          }
        }
      }
    },
    {
      "id": "virtual-fef829a4-81ca-57e8-8087-2b4a377f1d9c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-04",
        "rented_count": 0,
        "interval": "day",
        "product_id": "85dd4f0d-909a-42e6-84d6-a79c130c0c80"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/85dd4f0d-909a-42e6-84d6-a79c130c0c80"
          }
        }
      }
    },
    {
      "id": "virtual-d9412b74-6cad-5f24-812e-2b406351930b",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-05",
        "rented_count": 0,
        "interval": "day",
        "product_id": "85dd4f0d-909a-42e6-84d6-a79c130c0c80"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/85dd4f0d-909a-42e6-84d6-a79c130c0c80"
          }
        }
      }
    },
    {
      "id": "virtual-6c5f7bde-ed9d-5f01-a34b-c56605be3dc2",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-06",
        "rented_count": 1,
        "interval": "day",
        "product_id": "85dd4f0d-909a-42e6-84d6-a79c130c0c80"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/85dd4f0d-909a-42e6-84d6-a79c130c0c80"
          }
        }
      }
    },
    {
      "id": "virtual-b34b16a2-ea1a-50df-b0ff-aaea792ae360",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-07",
        "rented_count": 0,
        "interval": "day",
        "product_id": "85dd4f0d-909a-42e6-84d6-a79c130c0c80"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/85dd4f0d-909a-42e6-84d6-a79c130c0c80"
          }
        }
      }
    },
    {
      "id": "virtual-fa89bc6c-cf91-548b-bb6d-60ec01e3ba14",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-08",
        "rented_count": 1,
        "interval": "day",
        "product_id": "85dd4f0d-909a-42e6-84d6-a79c130c0c80"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/85dd4f0d-909a-42e6-84d6-a79c130c0c80"
          }
        }
      }
    },
    {
      "id": "virtual-5fbf14be-e014-5b17-9328-43f4a86d8999",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-09",
        "rented_count": 0,
        "interval": "day",
        "product_id": "85dd4f0d-909a-42e6-84d6-a79c130c0c80"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/85dd4f0d-909a-42e6-84d6-a79c130c0c80"
          }
        }
      }
    },
    {
      "id": "virtual-332f0f32-6285-51bb-a788-5d91e01adc3f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-10",
        "rented_count": 1,
        "interval": "day",
        "product_id": "85dd4f0d-909a-42e6-84d6-a79c130c0c80"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/85dd4f0d-909a-42e6-84d6-a79c130c0c80"
          }
        }
      }
    },
    {
      "id": "virtual-393027f0-c352-5af9-88be-3f0b0afc6a26",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-11",
        "rented_count": 0,
        "interval": "day",
        "product_id": "85dd4f0d-909a-42e6-84d6-a79c130c0c80"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/85dd4f0d-909a-42e6-84d6-a79c130c0c80"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-01-12T14:26:09Z`
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







