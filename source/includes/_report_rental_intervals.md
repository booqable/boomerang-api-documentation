# Report rental intervals

Breakdown of how many times a product was rented during a specific period.

## Fields
Every report rental interval has the following fields:

Name | Description
- | -
`id` | **Uuid** `readonly`<br>
`date` | **Date**<br>Interval date
`rented_count` | **Integer**<br>Times the product was rented
`interval` | **String**<br>The interval of the breakdown
`product_id` | **Uuid**<br>The associated Product


## Relationships
Report rental intervals have the following relationships:

Name | Description
- | -
`product` | **Products** `readonly`<br>Associated Product


## Listing performance for a rental product per interval



> How to fetch performance per interval for a product:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2022-07-04+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=14ca1c36-d239-4dc3-a90d-6a7e6c8e14ec&filter%5Btill%5D=2022-07-13+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-e76a591c-e677-5e02-9316-6b103eef6620",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-04",
        "rented_count": 0,
        "interval": "day",
        "product_id": "14ca1c36-d239-4dc3-a90d-6a7e6c8e14ec"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/14ca1c36-d239-4dc3-a90d-6a7e6c8e14ec"
          }
        }
      }
    },
    {
      "id": "virtual-eedff7e7-1db3-5da5-8298-252c1b4d3105",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-05",
        "rented_count": 0,
        "interval": "day",
        "product_id": "14ca1c36-d239-4dc3-a90d-6a7e6c8e14ec"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/14ca1c36-d239-4dc3-a90d-6a7e6c8e14ec"
          }
        }
      }
    },
    {
      "id": "virtual-858e3e44-fdb6-52a7-96ba-01e5d6bb5b34",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-06",
        "rented_count": 0,
        "interval": "day",
        "product_id": "14ca1c36-d239-4dc3-a90d-6a7e6c8e14ec"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/14ca1c36-d239-4dc3-a90d-6a7e6c8e14ec"
          }
        }
      }
    },
    {
      "id": "virtual-cbd881ce-3310-5c2b-a56a-cb576787ed06",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-07",
        "rented_count": 0,
        "interval": "day",
        "product_id": "14ca1c36-d239-4dc3-a90d-6a7e6c8e14ec"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/14ca1c36-d239-4dc3-a90d-6a7e6c8e14ec"
          }
        }
      }
    },
    {
      "id": "virtual-f093027f-8f61-5147-99b7-2cb81a2d5580",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-08",
        "rented_count": 1,
        "interval": "day",
        "product_id": "14ca1c36-d239-4dc3-a90d-6a7e6c8e14ec"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/14ca1c36-d239-4dc3-a90d-6a7e6c8e14ec"
          }
        }
      }
    },
    {
      "id": "virtual-16fec13b-f4ac-5bdb-b7e6-c299320cae67",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-09",
        "rented_count": 0,
        "interval": "day",
        "product_id": "14ca1c36-d239-4dc3-a90d-6a7e6c8e14ec"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/14ca1c36-d239-4dc3-a90d-6a7e6c8e14ec"
          }
        }
      }
    },
    {
      "id": "virtual-a7c5da88-7d16-5de6-a652-0b1f35ffb5b8",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-10",
        "rented_count": 1,
        "interval": "day",
        "product_id": "14ca1c36-d239-4dc3-a90d-6a7e6c8e14ec"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/14ca1c36-d239-4dc3-a90d-6a7e6c8e14ec"
          }
        }
      }
    },
    {
      "id": "virtual-29d73432-89a7-5f03-92db-567525ac5368",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-11",
        "rented_count": 0,
        "interval": "day",
        "product_id": "14ca1c36-d239-4dc3-a90d-6a7e6c8e14ec"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/14ca1c36-d239-4dc3-a90d-6a7e6c8e14ec"
          }
        }
      }
    },
    {
      "id": "virtual-ef9c1e01-25aa-5a32-879e-c13f27cb298a",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-12",
        "rented_count": 1,
        "interval": "day",
        "product_id": "14ca1c36-d239-4dc3-a90d-6a7e6c8e14ec"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/14ca1c36-d239-4dc3-a90d-6a7e6c8e14ec"
          }
        }
      }
    },
    {
      "id": "virtual-149e75a0-1ef3-5535-bb8e-b43ca50ffad1",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-07-13",
        "rented_count": 0,
        "interval": "day",
        "product_id": "14ca1c36-d239-4dc3-a90d-6a7e6c8e14ec"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/14ca1c36-d239-4dc3-a90d-6a7e6c8e14ec"
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=product`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[report_rental_intervals]=id,created_at,updated_at`
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-07-14T10:48:21Z`
`sort` | **String**<br>How to sort the data `?sort=-created_at`
`meta` | **Hash**<br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String**<br>The page to request
`page[size]` | **String**<br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
`product_id` | **Uuid** `required`<br>`eq`
`from` | **Datetime**<br>`eq`
`till` | **Datetime**<br>`eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array**<br>`count`


### Includes

This request accepts the following includes:

`product` => 
`photo`







