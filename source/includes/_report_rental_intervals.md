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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-02-04+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=4931216c-cb18-480a-a267-665e0e8b28c1&filter%5Btill%5D=2023-02-13+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-13c996f7-4050-53d1-abd5-6fba322b2840",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-04",
        "rented_count": 0,
        "interval": "day",
        "product_id": "4931216c-cb18-480a-a267-665e0e8b28c1"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4931216c-cb18-480a-a267-665e0e8b28c1"
          }
        }
      }
    },
    {
      "id": "virtual-29b6585b-2ff1-548c-98a7-523909cdacdb",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-05",
        "rented_count": 0,
        "interval": "day",
        "product_id": "4931216c-cb18-480a-a267-665e0e8b28c1"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4931216c-cb18-480a-a267-665e0e8b28c1"
          }
        }
      }
    },
    {
      "id": "virtual-e36bec4e-7ed8-5f80-b2cc-b773ffa8447b",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-06",
        "rented_count": 0,
        "interval": "day",
        "product_id": "4931216c-cb18-480a-a267-665e0e8b28c1"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4931216c-cb18-480a-a267-665e0e8b28c1"
          }
        }
      }
    },
    {
      "id": "virtual-d061d959-853b-53e1-af3a-9c5873473c16",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-07",
        "rented_count": 0,
        "interval": "day",
        "product_id": "4931216c-cb18-480a-a267-665e0e8b28c1"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4931216c-cb18-480a-a267-665e0e8b28c1"
          }
        }
      }
    },
    {
      "id": "virtual-e143bce8-0db8-5ea9-bdac-2a53cd23bf37",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-08",
        "rented_count": 1,
        "interval": "day",
        "product_id": "4931216c-cb18-480a-a267-665e0e8b28c1"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4931216c-cb18-480a-a267-665e0e8b28c1"
          }
        }
      }
    },
    {
      "id": "virtual-efff315c-54b3-5ce4-99a0-71df9d1320e1",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-09",
        "rented_count": 0,
        "interval": "day",
        "product_id": "4931216c-cb18-480a-a267-665e0e8b28c1"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4931216c-cb18-480a-a267-665e0e8b28c1"
          }
        }
      }
    },
    {
      "id": "virtual-80681e2a-9ffb-5e45-9a25-32116ad33732",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-10",
        "rented_count": 1,
        "interval": "day",
        "product_id": "4931216c-cb18-480a-a267-665e0e8b28c1"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4931216c-cb18-480a-a267-665e0e8b28c1"
          }
        }
      }
    },
    {
      "id": "virtual-0bc86b72-c9eb-5338-9402-edbbafcb8b93",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-11",
        "rented_count": 0,
        "interval": "day",
        "product_id": "4931216c-cb18-480a-a267-665e0e8b28c1"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4931216c-cb18-480a-a267-665e0e8b28c1"
          }
        }
      }
    },
    {
      "id": "virtual-20fa3c9e-7748-569d-9882-2f643d52a0b2",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-12",
        "rented_count": 1,
        "interval": "day",
        "product_id": "4931216c-cb18-480a-a267-665e0e8b28c1"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4931216c-cb18-480a-a267-665e0e8b28c1"
          }
        }
      }
    },
    {
      "id": "virtual-38f8ccc9-ecb0-5d6b-ac8e-0abd142faa20",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-13",
        "rented_count": 0,
        "interval": "day",
        "product_id": "4931216c-cb18-480a-a267-665e0e8b28c1"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4931216c-cb18-480a-a267-665e0e8b28c1"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-14T11:06:07Z`
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







