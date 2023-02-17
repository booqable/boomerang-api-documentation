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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-02-07+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=24fb0a9e-23bb-41e6-9321-57e963b46b0f&filter%5Btill%5D=2023-02-16+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-5922bff0-1978-5be1-829a-cfe57e04208c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-07",
        "rented_count": 0,
        "interval": "day",
        "product_id": "24fb0a9e-23bb-41e6-9321-57e963b46b0f"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/24fb0a9e-23bb-41e6-9321-57e963b46b0f"
          }
        }
      }
    },
    {
      "id": "virtual-ec2a657e-2264-53f6-a9b0-d7ecaa68f00c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-08",
        "rented_count": 0,
        "interval": "day",
        "product_id": "24fb0a9e-23bb-41e6-9321-57e963b46b0f"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/24fb0a9e-23bb-41e6-9321-57e963b46b0f"
          }
        }
      }
    },
    {
      "id": "virtual-cbf01fb2-7fb5-540b-aed6-5ab902544c9a",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-09",
        "rented_count": 0,
        "interval": "day",
        "product_id": "24fb0a9e-23bb-41e6-9321-57e963b46b0f"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/24fb0a9e-23bb-41e6-9321-57e963b46b0f"
          }
        }
      }
    },
    {
      "id": "virtual-dfd24e86-3727-576f-b828-b21e4e4113d7",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-10",
        "rented_count": 0,
        "interval": "day",
        "product_id": "24fb0a9e-23bb-41e6-9321-57e963b46b0f"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/24fb0a9e-23bb-41e6-9321-57e963b46b0f"
          }
        }
      }
    },
    {
      "id": "virtual-6b8a035c-aed9-5e77-9652-3af741bc4c33",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-11",
        "rented_count": 1,
        "interval": "day",
        "product_id": "24fb0a9e-23bb-41e6-9321-57e963b46b0f"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/24fb0a9e-23bb-41e6-9321-57e963b46b0f"
          }
        }
      }
    },
    {
      "id": "virtual-799169b6-2425-5ecf-a3ea-2f182a8971ff",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-12",
        "rented_count": 0,
        "interval": "day",
        "product_id": "24fb0a9e-23bb-41e6-9321-57e963b46b0f"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/24fb0a9e-23bb-41e6-9321-57e963b46b0f"
          }
        }
      }
    },
    {
      "id": "virtual-ca88b8d4-edda-5474-9700-48215d72a249",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-13",
        "rented_count": 1,
        "interval": "day",
        "product_id": "24fb0a9e-23bb-41e6-9321-57e963b46b0f"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/24fb0a9e-23bb-41e6-9321-57e963b46b0f"
          }
        }
      }
    },
    {
      "id": "virtual-1c24e57d-78f7-56e9-b9b9-689ec7673855",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-14",
        "rented_count": 0,
        "interval": "day",
        "product_id": "24fb0a9e-23bb-41e6-9321-57e963b46b0f"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/24fb0a9e-23bb-41e6-9321-57e963b46b0f"
          }
        }
      }
    },
    {
      "id": "virtual-d9f56c6b-b487-51a4-8093-b9eeeed45931",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-15",
        "rented_count": 1,
        "interval": "day",
        "product_id": "24fb0a9e-23bb-41e6-9321-57e963b46b0f"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/24fb0a9e-23bb-41e6-9321-57e963b46b0f"
          }
        }
      }
    },
    {
      "id": "virtual-241803c0-db0c-50a6-b40a-54bf243670b7",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-16",
        "rented_count": 0,
        "interval": "day",
        "product_id": "24fb0a9e-23bb-41e6-9321-57e963b46b0f"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/24fb0a9e-23bb-41e6-9321-57e963b46b0f"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-17T10:31:31Z`
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







