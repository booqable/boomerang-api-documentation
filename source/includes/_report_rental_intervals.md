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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-01-27+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=fa380768-b023-4345-80dc-c060fd176f8b&filter%5Btill%5D=2023-02-05+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-81731583-bdab-591e-a5ad-872210d70c31",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-27",
        "rented_count": 0,
        "interval": "day",
        "product_id": "fa380768-b023-4345-80dc-c060fd176f8b"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/fa380768-b023-4345-80dc-c060fd176f8b"
          }
        }
      }
    },
    {
      "id": "virtual-860d551b-4add-57a6-bc4f-2467dec73465",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-28",
        "rented_count": 0,
        "interval": "day",
        "product_id": "fa380768-b023-4345-80dc-c060fd176f8b"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/fa380768-b023-4345-80dc-c060fd176f8b"
          }
        }
      }
    },
    {
      "id": "virtual-103cb132-3cad-527b-901a-94b1734c6454",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-29",
        "rented_count": 0,
        "interval": "day",
        "product_id": "fa380768-b023-4345-80dc-c060fd176f8b"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/fa380768-b023-4345-80dc-c060fd176f8b"
          }
        }
      }
    },
    {
      "id": "virtual-ee97f4ae-b57e-53d2-a409-07a07e3093d9",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-30",
        "rented_count": 0,
        "interval": "day",
        "product_id": "fa380768-b023-4345-80dc-c060fd176f8b"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/fa380768-b023-4345-80dc-c060fd176f8b"
          }
        }
      }
    },
    {
      "id": "virtual-ebf67b39-ccd6-5831-aa9b-44e4cc7e9b32",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-31",
        "rented_count": 1,
        "interval": "day",
        "product_id": "fa380768-b023-4345-80dc-c060fd176f8b"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/fa380768-b023-4345-80dc-c060fd176f8b"
          }
        }
      }
    },
    {
      "id": "virtual-7991f40f-0e08-56e6-97a5-ff1840de0d35",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-01",
        "rented_count": 0,
        "interval": "day",
        "product_id": "fa380768-b023-4345-80dc-c060fd176f8b"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/fa380768-b023-4345-80dc-c060fd176f8b"
          }
        }
      }
    },
    {
      "id": "virtual-36aded25-fe93-5754-bd54-7c854ec76341",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-02",
        "rented_count": 1,
        "interval": "day",
        "product_id": "fa380768-b023-4345-80dc-c060fd176f8b"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/fa380768-b023-4345-80dc-c060fd176f8b"
          }
        }
      }
    },
    {
      "id": "virtual-51c3e989-2129-5e03-a6bb-4f216c7baca2",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-03",
        "rented_count": 0,
        "interval": "day",
        "product_id": "fa380768-b023-4345-80dc-c060fd176f8b"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/fa380768-b023-4345-80dc-c060fd176f8b"
          }
        }
      }
    },
    {
      "id": "virtual-2c76e830-9028-5c7e-a782-c2ac7b41a105",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-04",
        "rented_count": 1,
        "interval": "day",
        "product_id": "fa380768-b023-4345-80dc-c060fd176f8b"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/fa380768-b023-4345-80dc-c060fd176f8b"
          }
        }
      }
    },
    {
      "id": "virtual-27badbdf-9639-55cf-844f-3b79b2cbf3d3",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-05",
        "rented_count": 0,
        "interval": "day",
        "product_id": "fa380768-b023-4345-80dc-c060fd176f8b"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/fa380768-b023-4345-80dc-c060fd176f8b"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-06T08:38:57Z`
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







