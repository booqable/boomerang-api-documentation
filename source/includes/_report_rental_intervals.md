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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-02-11+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=8b7f5cf3-b0ba-43f9-a0b6-c6b63c2deaba&filter%5Btill%5D=2023-02-20+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-a529af48-274c-5a1d-b3ab-2d03d98e3232",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-11",
        "rented_count": 0,
        "interval": "day",
        "product_id": "8b7f5cf3-b0ba-43f9-a0b6-c6b63c2deaba"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/8b7f5cf3-b0ba-43f9-a0b6-c6b63c2deaba"
          }
        }
      }
    },
    {
      "id": "virtual-2bb28957-3887-5c3d-823f-a5d5aedea8c2",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-12",
        "rented_count": 0,
        "interval": "day",
        "product_id": "8b7f5cf3-b0ba-43f9-a0b6-c6b63c2deaba"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/8b7f5cf3-b0ba-43f9-a0b6-c6b63c2deaba"
          }
        }
      }
    },
    {
      "id": "virtual-d9081449-6212-5c80-830f-721df356182d",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-13",
        "rented_count": 0,
        "interval": "day",
        "product_id": "8b7f5cf3-b0ba-43f9-a0b6-c6b63c2deaba"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/8b7f5cf3-b0ba-43f9-a0b6-c6b63c2deaba"
          }
        }
      }
    },
    {
      "id": "virtual-4379c43e-2d63-5d52-9fe4-c6a8e281a573",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-14",
        "rented_count": 0,
        "interval": "day",
        "product_id": "8b7f5cf3-b0ba-43f9-a0b6-c6b63c2deaba"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/8b7f5cf3-b0ba-43f9-a0b6-c6b63c2deaba"
          }
        }
      }
    },
    {
      "id": "virtual-1b5b7860-263d-501d-bc24-0e335d3075d5",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-15",
        "rented_count": 1,
        "interval": "day",
        "product_id": "8b7f5cf3-b0ba-43f9-a0b6-c6b63c2deaba"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/8b7f5cf3-b0ba-43f9-a0b6-c6b63c2deaba"
          }
        }
      }
    },
    {
      "id": "virtual-7baf7670-02e3-56dc-ba19-142e18694230",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-16",
        "rented_count": 0,
        "interval": "day",
        "product_id": "8b7f5cf3-b0ba-43f9-a0b6-c6b63c2deaba"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/8b7f5cf3-b0ba-43f9-a0b6-c6b63c2deaba"
          }
        }
      }
    },
    {
      "id": "virtual-f13147f2-5ac5-5c34-8008-31374771229c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-17",
        "rented_count": 1,
        "interval": "day",
        "product_id": "8b7f5cf3-b0ba-43f9-a0b6-c6b63c2deaba"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/8b7f5cf3-b0ba-43f9-a0b6-c6b63c2deaba"
          }
        }
      }
    },
    {
      "id": "virtual-b767b24d-fd99-5c32-99fe-9b3ec7818bab",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-18",
        "rented_count": 0,
        "interval": "day",
        "product_id": "8b7f5cf3-b0ba-43f9-a0b6-c6b63c2deaba"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/8b7f5cf3-b0ba-43f9-a0b6-c6b63c2deaba"
          }
        }
      }
    },
    {
      "id": "virtual-d1c293bb-30b9-544e-bc5d-7a42951624eb",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-19",
        "rented_count": 1,
        "interval": "day",
        "product_id": "8b7f5cf3-b0ba-43f9-a0b6-c6b63c2deaba"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/8b7f5cf3-b0ba-43f9-a0b6-c6b63c2deaba"
          }
        }
      }
    },
    {
      "id": "virtual-ee220e6d-7125-50ea-88b4-b733cd1c8d5b",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-20",
        "rented_count": 0,
        "interval": "day",
        "product_id": "8b7f5cf3-b0ba-43f9-a0b6-c6b63c2deaba"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/8b7f5cf3-b0ba-43f9-a0b6-c6b63c2deaba"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-21T16:20:54Z`
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







