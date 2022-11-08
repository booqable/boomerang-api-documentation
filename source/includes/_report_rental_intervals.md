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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2022-10-29+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=2bbb1410-0ed9-48be-8a54-1b37225eefcf&filter%5Btill%5D=2022-11-07+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-5d79fdd2-3f8c-5bc8-bb4b-76d2765e51fb",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-29",
        "rented_count": 0,
        "interval": "day",
        "product_id": "2bbb1410-0ed9-48be-8a54-1b37225eefcf"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/2bbb1410-0ed9-48be-8a54-1b37225eefcf"
          }
        }
      }
    },
    {
      "id": "virtual-0de798d6-75f1-592a-9946-fb96421ef9f2",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-30",
        "rented_count": 0,
        "interval": "day",
        "product_id": "2bbb1410-0ed9-48be-8a54-1b37225eefcf"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/2bbb1410-0ed9-48be-8a54-1b37225eefcf"
          }
        }
      }
    },
    {
      "id": "virtual-0e1dc5dc-8251-588d-8672-7f29ae46556f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-31",
        "rented_count": 0,
        "interval": "day",
        "product_id": "2bbb1410-0ed9-48be-8a54-1b37225eefcf"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/2bbb1410-0ed9-48be-8a54-1b37225eefcf"
          }
        }
      }
    },
    {
      "id": "virtual-df597e29-b0b6-5984-903a-07fc93f2f5e1",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-01",
        "rented_count": 0,
        "interval": "day",
        "product_id": "2bbb1410-0ed9-48be-8a54-1b37225eefcf"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/2bbb1410-0ed9-48be-8a54-1b37225eefcf"
          }
        }
      }
    },
    {
      "id": "virtual-65da7ca8-a839-5104-8278-29d6c0b77439",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-02",
        "rented_count": 1,
        "interval": "day",
        "product_id": "2bbb1410-0ed9-48be-8a54-1b37225eefcf"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/2bbb1410-0ed9-48be-8a54-1b37225eefcf"
          }
        }
      }
    },
    {
      "id": "virtual-41cc2458-a0f2-51e2-8c4b-5676eb98e6d6",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-03",
        "rented_count": 0,
        "interval": "day",
        "product_id": "2bbb1410-0ed9-48be-8a54-1b37225eefcf"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/2bbb1410-0ed9-48be-8a54-1b37225eefcf"
          }
        }
      }
    },
    {
      "id": "virtual-eaa99dc2-0da1-5dba-abff-f57f70a5b95c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-04",
        "rented_count": 1,
        "interval": "day",
        "product_id": "2bbb1410-0ed9-48be-8a54-1b37225eefcf"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/2bbb1410-0ed9-48be-8a54-1b37225eefcf"
          }
        }
      }
    },
    {
      "id": "virtual-aa3a345e-78a0-58e5-a4dc-aaa09e7fdbd8",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-05",
        "rented_count": 0,
        "interval": "day",
        "product_id": "2bbb1410-0ed9-48be-8a54-1b37225eefcf"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/2bbb1410-0ed9-48be-8a54-1b37225eefcf"
          }
        }
      }
    },
    {
      "id": "virtual-504f4bfc-79f1-5d08-83eb-f75860f6a9cb",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-06",
        "rented_count": 1,
        "interval": "day",
        "product_id": "2bbb1410-0ed9-48be-8a54-1b37225eefcf"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/2bbb1410-0ed9-48be-8a54-1b37225eefcf"
          }
        }
      }
    },
    {
      "id": "virtual-c86ca1f1-f54e-5a8c-9154-cf8926367af2",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-07",
        "rented_count": 0,
        "interval": "day",
        "product_id": "2bbb1410-0ed9-48be-8a54-1b37225eefcf"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/2bbb1410-0ed9-48be-8a54-1b37225eefcf"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-11-08T13:51:46Z`
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







