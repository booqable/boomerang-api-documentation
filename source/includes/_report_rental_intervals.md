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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2022-10-25+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=89c92552-498d-4615-8344-ae2520028232&filter%5Btill%5D=2022-11-03+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-6f696358-37e9-52ed-97e9-93b711e24f39",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-25",
        "rented_count": 0,
        "interval": "day",
        "product_id": "89c92552-498d-4615-8344-ae2520028232"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/89c92552-498d-4615-8344-ae2520028232"
          }
        }
      }
    },
    {
      "id": "virtual-6f5779b3-8d94-5bb5-89f7-b661632f319b",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-26",
        "rented_count": 0,
        "interval": "day",
        "product_id": "89c92552-498d-4615-8344-ae2520028232"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/89c92552-498d-4615-8344-ae2520028232"
          }
        }
      }
    },
    {
      "id": "virtual-573e3686-51bc-5ef0-b5d1-4e1217b2236b",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-27",
        "rented_count": 0,
        "interval": "day",
        "product_id": "89c92552-498d-4615-8344-ae2520028232"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/89c92552-498d-4615-8344-ae2520028232"
          }
        }
      }
    },
    {
      "id": "virtual-621d2c0a-e2f0-5aa4-9f8c-22afddbf257f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-28",
        "rented_count": 0,
        "interval": "day",
        "product_id": "89c92552-498d-4615-8344-ae2520028232"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/89c92552-498d-4615-8344-ae2520028232"
          }
        }
      }
    },
    {
      "id": "virtual-f5dec672-3f05-52d2-a66e-44784485a3cf",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-29",
        "rented_count": 1,
        "interval": "day",
        "product_id": "89c92552-498d-4615-8344-ae2520028232"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/89c92552-498d-4615-8344-ae2520028232"
          }
        }
      }
    },
    {
      "id": "virtual-42f85e73-772c-5e68-8fc5-08877d26f46d",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-30",
        "rented_count": 0,
        "interval": "day",
        "product_id": "89c92552-498d-4615-8344-ae2520028232"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/89c92552-498d-4615-8344-ae2520028232"
          }
        }
      }
    },
    {
      "id": "virtual-70695515-1b01-555f-8a80-3cdc964dea0d",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-10-31",
        "rented_count": 1,
        "interval": "day",
        "product_id": "89c92552-498d-4615-8344-ae2520028232"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/89c92552-498d-4615-8344-ae2520028232"
          }
        }
      }
    },
    {
      "id": "virtual-1d3b7779-6405-5429-8919-7c1adfcc90dc",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-01",
        "rented_count": 0,
        "interval": "day",
        "product_id": "89c92552-498d-4615-8344-ae2520028232"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/89c92552-498d-4615-8344-ae2520028232"
          }
        }
      }
    },
    {
      "id": "virtual-8ea17e3b-13b0-570e-80ba-24d11d60f2f9",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-02",
        "rented_count": 1,
        "interval": "day",
        "product_id": "89c92552-498d-4615-8344-ae2520028232"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/89c92552-498d-4615-8344-ae2520028232"
          }
        }
      }
    },
    {
      "id": "virtual-ab0d768b-adc0-5a41-99f3-a978a658ea80",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2022-11-03",
        "rented_count": 0,
        "interval": "day",
        "product_id": "89c92552-498d-4615-8344-ae2520028232"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/89c92552-498d-4615-8344-ae2520028232"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-11-04T15:22:45Z`
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







