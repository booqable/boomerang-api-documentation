# Report rental intervals

Breakdown of how many times a product was rented during a specific period.

## Fields
Every report rental interval has the following fields:

Name | Description
-- | --
`id` | **Uuid** `readonly`<br>
`date` | **Date** <br>Interval date
`rented_count` | **Integer** <br>Times the product was rented
`interval` | **String** <br>The interval of the breakdown
`product_id` | **Uuid** <br>The associated Product


## Relationships
Report rental intervals have the following relationships:

Name | Description
-- | --
`product` | **Products** `readonly`<br>Associated Product


## Listing performance for a rental product per interval



> How to fetch performance per interval for a product:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2024-05-31+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=273eb195-ce68-45ed-a271-9af8239fb157&filter%5Btill%5D=2024-06-09+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "1a04e270-2326-4512-b989-b8d6a1244c94",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-05-31",
        "rented_count": 0,
        "interval": "day",
        "product_id": "273eb195-ce68-45ed-a271-9af8239fb157"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/273eb195-ce68-45ed-a271-9af8239fb157"
          }
        }
      }
    },
    {
      "id": "f44ca3dd-bcf8-4678-ad8d-9e5219f695ba",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-06-01",
        "rented_count": 0,
        "interval": "day",
        "product_id": "273eb195-ce68-45ed-a271-9af8239fb157"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/273eb195-ce68-45ed-a271-9af8239fb157"
          }
        }
      }
    },
    {
      "id": "f8fdcfa2-7b1f-4b26-b37b-05dd01251eb9",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-06-02",
        "rented_count": 0,
        "interval": "day",
        "product_id": "273eb195-ce68-45ed-a271-9af8239fb157"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/273eb195-ce68-45ed-a271-9af8239fb157"
          }
        }
      }
    },
    {
      "id": "56393808-25df-4458-bbd9-a325c69b9272",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-06-03",
        "rented_count": 0,
        "interval": "day",
        "product_id": "273eb195-ce68-45ed-a271-9af8239fb157"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/273eb195-ce68-45ed-a271-9af8239fb157"
          }
        }
      }
    },
    {
      "id": "5051f975-aab2-4b13-a92c-6a46fc19af54",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-06-04",
        "rented_count": 1,
        "interval": "day",
        "product_id": "273eb195-ce68-45ed-a271-9af8239fb157"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/273eb195-ce68-45ed-a271-9af8239fb157"
          }
        }
      }
    },
    {
      "id": "92ff3e19-daee-4efd-b61c-0802adfea84a",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-06-05",
        "rented_count": 0,
        "interval": "day",
        "product_id": "273eb195-ce68-45ed-a271-9af8239fb157"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/273eb195-ce68-45ed-a271-9af8239fb157"
          }
        }
      }
    },
    {
      "id": "dbc27982-82f8-4d1e-9e65-f06e538a23f9",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-06-06",
        "rented_count": 1,
        "interval": "day",
        "product_id": "273eb195-ce68-45ed-a271-9af8239fb157"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/273eb195-ce68-45ed-a271-9af8239fb157"
          }
        }
      }
    },
    {
      "id": "06a244d2-db2d-45c8-ae88-ca8e778f5d54",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-06-07",
        "rented_count": 0,
        "interval": "day",
        "product_id": "273eb195-ce68-45ed-a271-9af8239fb157"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/273eb195-ce68-45ed-a271-9af8239fb157"
          }
        }
      }
    },
    {
      "id": "a74572a9-7181-430d-b4fa-d1f8f1776861",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-06-08",
        "rented_count": 1,
        "interval": "day",
        "product_id": "273eb195-ce68-45ed-a271-9af8239fb157"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/273eb195-ce68-45ed-a271-9af8239fb157"
          }
        }
      }
    },
    {
      "id": "ac18a52a-9c08-46a5-8076-5700669af24c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-06-09",
        "rented_count": 0,
        "interval": "day",
        "product_id": "273eb195-ce68-45ed-a271-9af8239fb157"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/273eb195-ce68-45ed-a271-9af8239fb157"
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
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=product`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[report_rental_intervals]=date,rented_count,interval`
`filter` | **Hash** <br>The filters to apply `?filter[attribute][eq]=value`
`sort` | **String** <br>How to sort the data `?sort=attribute1,-attribute2`
`meta` | **Hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String** <br>The page to request
`page[size]` | **String** <br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
-- | --
`product_id` | **Uuid** `required`<br>`eq`
`from` | **Datetime** <br>`eq`
`till` | **Datetime** <br>`eq`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **Array** <br>`count`


### Includes

This request accepts the following includes:

`product` => 
`photo`







