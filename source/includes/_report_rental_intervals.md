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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-01-29+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=1c5cb638-22a0-417b-82fe-600aa341958a&filter%5Btill%5D=2023-02-07+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-bdf35f06-ced1-5720-aa62-6478f8ed0183",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-29",
        "rented_count": 0,
        "interval": "day",
        "product_id": "1c5cb638-22a0-417b-82fe-600aa341958a"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/1c5cb638-22a0-417b-82fe-600aa341958a"
          }
        }
      }
    },
    {
      "id": "virtual-20bcf183-3cf6-5b1f-8bc1-006cecd89975",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-30",
        "rented_count": 0,
        "interval": "day",
        "product_id": "1c5cb638-22a0-417b-82fe-600aa341958a"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/1c5cb638-22a0-417b-82fe-600aa341958a"
          }
        }
      }
    },
    {
      "id": "virtual-2f7e9e54-6d7f-5043-9e86-aa6b60ecab36",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-31",
        "rented_count": 0,
        "interval": "day",
        "product_id": "1c5cb638-22a0-417b-82fe-600aa341958a"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/1c5cb638-22a0-417b-82fe-600aa341958a"
          }
        }
      }
    },
    {
      "id": "virtual-9f4a47f2-7ed8-5f50-abe2-cd074e675419",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-01",
        "rented_count": 0,
        "interval": "day",
        "product_id": "1c5cb638-22a0-417b-82fe-600aa341958a"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/1c5cb638-22a0-417b-82fe-600aa341958a"
          }
        }
      }
    },
    {
      "id": "virtual-7532e3ab-2fec-5702-b622-86d3713d9bc6",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-02",
        "rented_count": 1,
        "interval": "day",
        "product_id": "1c5cb638-22a0-417b-82fe-600aa341958a"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/1c5cb638-22a0-417b-82fe-600aa341958a"
          }
        }
      }
    },
    {
      "id": "virtual-e17ab0aa-dc08-5b97-b7ac-92b4dfbb603d",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-03",
        "rented_count": 0,
        "interval": "day",
        "product_id": "1c5cb638-22a0-417b-82fe-600aa341958a"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/1c5cb638-22a0-417b-82fe-600aa341958a"
          }
        }
      }
    },
    {
      "id": "virtual-ce5e3e8e-7b4e-5563-9a05-b322775942b3",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-04",
        "rented_count": 1,
        "interval": "day",
        "product_id": "1c5cb638-22a0-417b-82fe-600aa341958a"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/1c5cb638-22a0-417b-82fe-600aa341958a"
          }
        }
      }
    },
    {
      "id": "virtual-dede11ec-43ca-5efc-adbf-e957eeb6d1e7",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-05",
        "rented_count": 0,
        "interval": "day",
        "product_id": "1c5cb638-22a0-417b-82fe-600aa341958a"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/1c5cb638-22a0-417b-82fe-600aa341958a"
          }
        }
      }
    },
    {
      "id": "virtual-c60518f3-9b60-5fef-a356-64c35fe020a3",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-06",
        "rented_count": 1,
        "interval": "day",
        "product_id": "1c5cb638-22a0-417b-82fe-600aa341958a"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/1c5cb638-22a0-417b-82fe-600aa341958a"
          }
        }
      }
    },
    {
      "id": "virtual-8d70c914-373a-5b37-8e6f-a72ea68d34ef",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-07",
        "rented_count": 0,
        "interval": "day",
        "product_id": "1c5cb638-22a0-417b-82fe-600aa341958a"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/1c5cb638-22a0-417b-82fe-600aa341958a"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-08T15:17:18Z`
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







