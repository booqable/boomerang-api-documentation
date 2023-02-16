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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-02-06+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=12074f9c-6a52-461d-96d5-fa948af071e9&filter%5Btill%5D=2023-02-15+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-15c913a4-ee6d-5c57-b0e2-33287e417b62",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-06",
        "rented_count": 0,
        "interval": "day",
        "product_id": "12074f9c-6a52-461d-96d5-fa948af071e9"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/12074f9c-6a52-461d-96d5-fa948af071e9"
          }
        }
      }
    },
    {
      "id": "virtual-49087bbd-0129-5255-a501-f45d068ee80c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-07",
        "rented_count": 0,
        "interval": "day",
        "product_id": "12074f9c-6a52-461d-96d5-fa948af071e9"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/12074f9c-6a52-461d-96d5-fa948af071e9"
          }
        }
      }
    },
    {
      "id": "virtual-b58e4c78-d148-5813-8926-861276952bcc",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-08",
        "rented_count": 0,
        "interval": "day",
        "product_id": "12074f9c-6a52-461d-96d5-fa948af071e9"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/12074f9c-6a52-461d-96d5-fa948af071e9"
          }
        }
      }
    },
    {
      "id": "virtual-29111a3d-d44e-52b3-97f1-35fdfe69f582",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-09",
        "rented_count": 0,
        "interval": "day",
        "product_id": "12074f9c-6a52-461d-96d5-fa948af071e9"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/12074f9c-6a52-461d-96d5-fa948af071e9"
          }
        }
      }
    },
    {
      "id": "virtual-cbc6fd7e-e119-5a3d-8ba5-1018baf5f85c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-10",
        "rented_count": 1,
        "interval": "day",
        "product_id": "12074f9c-6a52-461d-96d5-fa948af071e9"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/12074f9c-6a52-461d-96d5-fa948af071e9"
          }
        }
      }
    },
    {
      "id": "virtual-3b65fb0a-d8ed-5b91-a180-261557ac7632",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-11",
        "rented_count": 0,
        "interval": "day",
        "product_id": "12074f9c-6a52-461d-96d5-fa948af071e9"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/12074f9c-6a52-461d-96d5-fa948af071e9"
          }
        }
      }
    },
    {
      "id": "virtual-4b91e572-4eba-5a3f-b352-6e1c2b293da0",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-12",
        "rented_count": 1,
        "interval": "day",
        "product_id": "12074f9c-6a52-461d-96d5-fa948af071e9"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/12074f9c-6a52-461d-96d5-fa948af071e9"
          }
        }
      }
    },
    {
      "id": "virtual-66a2fcf2-7a06-52aa-978a-c1902136b860",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-13",
        "rented_count": 0,
        "interval": "day",
        "product_id": "12074f9c-6a52-461d-96d5-fa948af071e9"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/12074f9c-6a52-461d-96d5-fa948af071e9"
          }
        }
      }
    },
    {
      "id": "virtual-089fe734-cee5-50c6-b8fb-9c5b57834caf",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-14",
        "rented_count": 1,
        "interval": "day",
        "product_id": "12074f9c-6a52-461d-96d5-fa948af071e9"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/12074f9c-6a52-461d-96d5-fa948af071e9"
          }
        }
      }
    },
    {
      "id": "virtual-da72ccff-cf74-52e4-9dde-65c1d43b1053",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-15",
        "rented_count": 0,
        "interval": "day",
        "product_id": "12074f9c-6a52-461d-96d5-fa948af071e9"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/12074f9c-6a52-461d-96d5-fa948af071e9"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-16T10:58:41Z`
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







