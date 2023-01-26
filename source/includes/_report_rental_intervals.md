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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-01-16+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=f0780384-4096-4d7e-b273-527130d19460&filter%5Btill%5D=2023-01-25+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-c539e075-8fc7-5d12-ae13-314e495b5979",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-16",
        "rented_count": 0,
        "interval": "day",
        "product_id": "f0780384-4096-4d7e-b273-527130d19460"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/f0780384-4096-4d7e-b273-527130d19460"
          }
        }
      }
    },
    {
      "id": "virtual-1339fbae-0f8e-5369-a029-717704334d76",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-17",
        "rented_count": 0,
        "interval": "day",
        "product_id": "f0780384-4096-4d7e-b273-527130d19460"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/f0780384-4096-4d7e-b273-527130d19460"
          }
        }
      }
    },
    {
      "id": "virtual-22c901ee-cf8b-5e59-99c8-e3f0c3630514",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-18",
        "rented_count": 0,
        "interval": "day",
        "product_id": "f0780384-4096-4d7e-b273-527130d19460"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/f0780384-4096-4d7e-b273-527130d19460"
          }
        }
      }
    },
    {
      "id": "virtual-7bc13966-6627-5822-8cc4-37c00490e14c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-19",
        "rented_count": 0,
        "interval": "day",
        "product_id": "f0780384-4096-4d7e-b273-527130d19460"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/f0780384-4096-4d7e-b273-527130d19460"
          }
        }
      }
    },
    {
      "id": "virtual-763617c8-1fa8-5337-9e79-68b54e4b3ebf",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-20",
        "rented_count": 1,
        "interval": "day",
        "product_id": "f0780384-4096-4d7e-b273-527130d19460"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/f0780384-4096-4d7e-b273-527130d19460"
          }
        }
      }
    },
    {
      "id": "virtual-58ed2504-c670-557a-8b0d-537c85087921",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-21",
        "rented_count": 0,
        "interval": "day",
        "product_id": "f0780384-4096-4d7e-b273-527130d19460"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/f0780384-4096-4d7e-b273-527130d19460"
          }
        }
      }
    },
    {
      "id": "virtual-a21574e6-061b-598d-a561-df212d261165",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-22",
        "rented_count": 1,
        "interval": "day",
        "product_id": "f0780384-4096-4d7e-b273-527130d19460"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/f0780384-4096-4d7e-b273-527130d19460"
          }
        }
      }
    },
    {
      "id": "virtual-ff604987-4de0-526b-91f9-b185b77fcbea",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-23",
        "rented_count": 0,
        "interval": "day",
        "product_id": "f0780384-4096-4d7e-b273-527130d19460"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/f0780384-4096-4d7e-b273-527130d19460"
          }
        }
      }
    },
    {
      "id": "virtual-27fa6a30-7876-5950-8cdb-1e8954452932",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-24",
        "rented_count": 1,
        "interval": "day",
        "product_id": "f0780384-4096-4d7e-b273-527130d19460"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/f0780384-4096-4d7e-b273-527130d19460"
          }
        }
      }
    },
    {
      "id": "virtual-e3b99c27-ec42-532d-b4e7-13407d33159e",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-25",
        "rented_count": 0,
        "interval": "day",
        "product_id": "f0780384-4096-4d7e-b273-527130d19460"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/f0780384-4096-4d7e-b273-527130d19460"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-01-26T10:18:56Z`
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







