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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-02-24+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=c3e20e3f-68bb-4f16-98cf-45f5399c9c7f&filter%5Btill%5D=2023-03-05+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-efe247a3-c2d6-593b-a87e-79fbb51d2aae",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-24",
        "rented_count": 0,
        "interval": "day",
        "product_id": "c3e20e3f-68bb-4f16-98cf-45f5399c9c7f"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/c3e20e3f-68bb-4f16-98cf-45f5399c9c7f"
          }
        }
      }
    },
    {
      "id": "virtual-4e093251-16e7-5938-9c57-e61e738ae00d",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-25",
        "rented_count": 0,
        "interval": "day",
        "product_id": "c3e20e3f-68bb-4f16-98cf-45f5399c9c7f"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/c3e20e3f-68bb-4f16-98cf-45f5399c9c7f"
          }
        }
      }
    },
    {
      "id": "virtual-be8e571f-23c4-5ef3-b7b0-8badf2c8e852",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-26",
        "rented_count": 0,
        "interval": "day",
        "product_id": "c3e20e3f-68bb-4f16-98cf-45f5399c9c7f"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/c3e20e3f-68bb-4f16-98cf-45f5399c9c7f"
          }
        }
      }
    },
    {
      "id": "virtual-17debf66-7ad3-5678-acae-55749988609a",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-27",
        "rented_count": 0,
        "interval": "day",
        "product_id": "c3e20e3f-68bb-4f16-98cf-45f5399c9c7f"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/c3e20e3f-68bb-4f16-98cf-45f5399c9c7f"
          }
        }
      }
    },
    {
      "id": "virtual-7d083ec0-8073-508d-bccb-a6c40455972a",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-28",
        "rented_count": 1,
        "interval": "day",
        "product_id": "c3e20e3f-68bb-4f16-98cf-45f5399c9c7f"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/c3e20e3f-68bb-4f16-98cf-45f5399c9c7f"
          }
        }
      }
    },
    {
      "id": "virtual-96caa24d-2a4f-5d85-948d-2c0d1549b931",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-01",
        "rented_count": 0,
        "interval": "day",
        "product_id": "c3e20e3f-68bb-4f16-98cf-45f5399c9c7f"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/c3e20e3f-68bb-4f16-98cf-45f5399c9c7f"
          }
        }
      }
    },
    {
      "id": "virtual-eaace978-e8cd-55e5-9f85-40093e5abf67",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-02",
        "rented_count": 1,
        "interval": "day",
        "product_id": "c3e20e3f-68bb-4f16-98cf-45f5399c9c7f"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/c3e20e3f-68bb-4f16-98cf-45f5399c9c7f"
          }
        }
      }
    },
    {
      "id": "virtual-98f0735e-fc25-5a75-97fa-0151069524c6",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-03",
        "rented_count": 0,
        "interval": "day",
        "product_id": "c3e20e3f-68bb-4f16-98cf-45f5399c9c7f"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/c3e20e3f-68bb-4f16-98cf-45f5399c9c7f"
          }
        }
      }
    },
    {
      "id": "virtual-caa93873-5bdc-5ce2-a6a5-5cb604d9b5e3",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-04",
        "rented_count": 1,
        "interval": "day",
        "product_id": "c3e20e3f-68bb-4f16-98cf-45f5399c9c7f"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/c3e20e3f-68bb-4f16-98cf-45f5399c9c7f"
          }
        }
      }
    },
    {
      "id": "virtual-f0ed04ab-a7aa-5aa4-9867-cdfce5fb194d",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-03-05",
        "rented_count": 0,
        "interval": "day",
        "product_id": "c3e20e3f-68bb-4f16-98cf-45f5399c9c7f"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/c3e20e3f-68bb-4f16-98cf-45f5399c9c7f"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-03-06T10:39:41Z`
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







