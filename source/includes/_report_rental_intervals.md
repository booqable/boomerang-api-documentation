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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2022-12-10+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=bf3c6a6e-6e3c-41db-be7f-1590319042ff&filter%5Btill%5D=2022-12-19+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-0fb3733d-a5a7-5322-9720-3d5170dd4d8f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-12-10",
        "rented_count": 0,
        "interval": "day",
        "product_id": "bf3c6a6e-6e3c-41db-be7f-1590319042ff"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/bf3c6a6e-6e3c-41db-be7f-1590319042ff"
          }
        }
      }
    },
    {
      "id": "virtual-9505198e-374e-5d71-a054-154a14c0d62a",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-12-11",
        "rented_count": 0,
        "interval": "day",
        "product_id": "bf3c6a6e-6e3c-41db-be7f-1590319042ff"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/bf3c6a6e-6e3c-41db-be7f-1590319042ff"
          }
        }
      }
    },
    {
      "id": "virtual-909c5999-cd16-57d7-9868-24e91f21cc64",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-12-12",
        "rented_count": 0,
        "interval": "day",
        "product_id": "bf3c6a6e-6e3c-41db-be7f-1590319042ff"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/bf3c6a6e-6e3c-41db-be7f-1590319042ff"
          }
        }
      }
    },
    {
      "id": "virtual-9613b7f2-b045-57f6-944c-7e97fcdf16bb",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-12-13",
        "rented_count": 0,
        "interval": "day",
        "product_id": "bf3c6a6e-6e3c-41db-be7f-1590319042ff"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/bf3c6a6e-6e3c-41db-be7f-1590319042ff"
          }
        }
      }
    },
    {
      "id": "virtual-eabcfeac-feda-569f-9dfb-c840d76ec5b7",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-12-14",
        "rented_count": 1,
        "interval": "day",
        "product_id": "bf3c6a6e-6e3c-41db-be7f-1590319042ff"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/bf3c6a6e-6e3c-41db-be7f-1590319042ff"
          }
        }
      }
    },
    {
      "id": "virtual-0cb35d9c-b665-5f3a-99e9-89a22fac36dd",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-12-15",
        "rented_count": 0,
        "interval": "day",
        "product_id": "bf3c6a6e-6e3c-41db-be7f-1590319042ff"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/bf3c6a6e-6e3c-41db-be7f-1590319042ff"
          }
        }
      }
    },
    {
      "id": "virtual-5107ef94-7d68-5491-8135-22603afdf5e8",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-12-16",
        "rented_count": 1,
        "interval": "day",
        "product_id": "bf3c6a6e-6e3c-41db-be7f-1590319042ff"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/bf3c6a6e-6e3c-41db-be7f-1590319042ff"
          }
        }
      }
    },
    {
      "id": "virtual-f515268f-f864-5655-b0fa-78ea6130e8a1",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-12-17",
        "rented_count": 0,
        "interval": "day",
        "product_id": "bf3c6a6e-6e3c-41db-be7f-1590319042ff"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/bf3c6a6e-6e3c-41db-be7f-1590319042ff"
          }
        }
      }
    },
    {
      "id": "virtual-8e4d77ca-1409-57dd-b405-89bece67f835",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-12-18",
        "rented_count": 1,
        "interval": "day",
        "product_id": "bf3c6a6e-6e3c-41db-be7f-1590319042ff"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/bf3c6a6e-6e3c-41db-be7f-1590319042ff"
          }
        }
      }
    },
    {
      "id": "virtual-365020ef-4710-5108-8884-847c35fe3b07",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-12-19",
        "rented_count": 0,
        "interval": "day",
        "product_id": "bf3c6a6e-6e3c-41db-be7f-1590319042ff"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/bf3c6a6e-6e3c-41db-be7f-1590319042ff"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-12-20T14:47:46Z`
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







