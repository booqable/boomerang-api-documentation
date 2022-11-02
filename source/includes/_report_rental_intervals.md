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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2022-10-23+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=aa3a5b8c-a5a7-4737-8d3a-25bd33e52772&filter%5Btill%5D=2022-11-01+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-faefaff4-5a41-5fd6-83f5-53a7c093f44c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-23",
        "rented_count": 0,
        "interval": "day",
        "product_id": "aa3a5b8c-a5a7-4737-8d3a-25bd33e52772"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/aa3a5b8c-a5a7-4737-8d3a-25bd33e52772"
          }
        }
      }
    },
    {
      "id": "virtual-99393ea1-e3fe-56cd-814c-751505e3f4f8",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-24",
        "rented_count": 0,
        "interval": "day",
        "product_id": "aa3a5b8c-a5a7-4737-8d3a-25bd33e52772"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/aa3a5b8c-a5a7-4737-8d3a-25bd33e52772"
          }
        }
      }
    },
    {
      "id": "virtual-1f768f1f-f178-5d0c-9315-af0f538c3d03",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-25",
        "rented_count": 0,
        "interval": "day",
        "product_id": "aa3a5b8c-a5a7-4737-8d3a-25bd33e52772"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/aa3a5b8c-a5a7-4737-8d3a-25bd33e52772"
          }
        }
      }
    },
    {
      "id": "virtual-5f055c2a-ce4a-5e44-bc98-3af12292b2d3",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-26",
        "rented_count": 0,
        "interval": "day",
        "product_id": "aa3a5b8c-a5a7-4737-8d3a-25bd33e52772"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/aa3a5b8c-a5a7-4737-8d3a-25bd33e52772"
          }
        }
      }
    },
    {
      "id": "virtual-05e25640-226b-5436-b48e-c4c4660d7fd7",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-27",
        "rented_count": 1,
        "interval": "day",
        "product_id": "aa3a5b8c-a5a7-4737-8d3a-25bd33e52772"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/aa3a5b8c-a5a7-4737-8d3a-25bd33e52772"
          }
        }
      }
    },
    {
      "id": "virtual-50a7d43b-584a-5ad3-bc78-00b525e27f0e",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-28",
        "rented_count": 0,
        "interval": "day",
        "product_id": "aa3a5b8c-a5a7-4737-8d3a-25bd33e52772"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/aa3a5b8c-a5a7-4737-8d3a-25bd33e52772"
          }
        }
      }
    },
    {
      "id": "virtual-a7e5b4e7-b40b-5cfb-869f-9592c8fea767",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-29",
        "rented_count": 1,
        "interval": "day",
        "product_id": "aa3a5b8c-a5a7-4737-8d3a-25bd33e52772"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/aa3a5b8c-a5a7-4737-8d3a-25bd33e52772"
          }
        }
      }
    },
    {
      "id": "virtual-c2395117-3183-5520-b2e7-2d1204404aab",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-30",
        "rented_count": 0,
        "interval": "day",
        "product_id": "aa3a5b8c-a5a7-4737-8d3a-25bd33e52772"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/aa3a5b8c-a5a7-4737-8d3a-25bd33e52772"
          }
        }
      }
    },
    {
      "id": "virtual-a394f136-5e0f-514b-b93a-9bc3d804f970",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-31",
        "rented_count": 1,
        "interval": "day",
        "product_id": "aa3a5b8c-a5a7-4737-8d3a-25bd33e52772"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/aa3a5b8c-a5a7-4737-8d3a-25bd33e52772"
          }
        }
      }
    },
    {
      "id": "virtual-ed2e8ac2-dcee-5312-88cf-923550b7798c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-01",
        "rented_count": 0,
        "interval": "day",
        "product_id": "aa3a5b8c-a5a7-4737-8d3a-25bd33e52772"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/aa3a5b8c-a5a7-4737-8d3a-25bd33e52772"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-11-02T10:18:14Z`
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







