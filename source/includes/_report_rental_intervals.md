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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2023-01-30+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=30d25e9d-a2fd-47ef-9e93-224e7e67d81b&filter%5Btill%5D=2023-02-08+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-9ceef30e-0c34-53ed-b57b-feef344ea7fc",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-30",
        "rented_count": 0,
        "interval": "day",
        "product_id": "30d25e9d-a2fd-47ef-9e93-224e7e67d81b"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/30d25e9d-a2fd-47ef-9e93-224e7e67d81b"
          }
        }
      }
    },
    {
      "id": "virtual-8ce903fb-21a2-581b-95cf-2b36733b661f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-01-31",
        "rented_count": 0,
        "interval": "day",
        "product_id": "30d25e9d-a2fd-47ef-9e93-224e7e67d81b"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/30d25e9d-a2fd-47ef-9e93-224e7e67d81b"
          }
        }
      }
    },
    {
      "id": "virtual-5788ef9b-c29e-57f1-8463-22d380dc5061",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-01",
        "rented_count": 0,
        "interval": "day",
        "product_id": "30d25e9d-a2fd-47ef-9e93-224e7e67d81b"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/30d25e9d-a2fd-47ef-9e93-224e7e67d81b"
          }
        }
      }
    },
    {
      "id": "virtual-a9eca160-e918-59d6-b47e-35729246d5ca",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-02",
        "rented_count": 0,
        "interval": "day",
        "product_id": "30d25e9d-a2fd-47ef-9e93-224e7e67d81b"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/30d25e9d-a2fd-47ef-9e93-224e7e67d81b"
          }
        }
      }
    },
    {
      "id": "virtual-ecdcdeaf-baae-528c-b844-207daeecb061",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-03",
        "rented_count": 1,
        "interval": "day",
        "product_id": "30d25e9d-a2fd-47ef-9e93-224e7e67d81b"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/30d25e9d-a2fd-47ef-9e93-224e7e67d81b"
          }
        }
      }
    },
    {
      "id": "virtual-43eac877-315b-5801-b91f-3119268b1a7e",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-04",
        "rented_count": 0,
        "interval": "day",
        "product_id": "30d25e9d-a2fd-47ef-9e93-224e7e67d81b"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/30d25e9d-a2fd-47ef-9e93-224e7e67d81b"
          }
        }
      }
    },
    {
      "id": "virtual-f2380f41-3758-5313-8268-1995d6a9d2d7",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-05",
        "rented_count": 1,
        "interval": "day",
        "product_id": "30d25e9d-a2fd-47ef-9e93-224e7e67d81b"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/30d25e9d-a2fd-47ef-9e93-224e7e67d81b"
          }
        }
      }
    },
    {
      "id": "virtual-478cfd5c-a4f7-5a01-bce4-2d2bd96527c5",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-06",
        "rented_count": 0,
        "interval": "day",
        "product_id": "30d25e9d-a2fd-47ef-9e93-224e7e67d81b"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/30d25e9d-a2fd-47ef-9e93-224e7e67d81b"
          }
        }
      }
    },
    {
      "id": "virtual-4d712566-4d7a-51b7-87fb-a93cb4f92ed4",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-07",
        "rented_count": 1,
        "interval": "day",
        "product_id": "30d25e9d-a2fd-47ef-9e93-224e7e67d81b"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/30d25e9d-a2fd-47ef-9e93-224e7e67d81b"
          }
        }
      }
    },
    {
      "id": "virtual-9e4fae0e-bc28-5e27-ba64-e97633d585e4",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2023-02-08",
        "rented_count": 0,
        "interval": "day",
        "product_id": "30d25e9d-a2fd-47ef-9e93-224e7e67d81b"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/30d25e9d-a2fd-47ef-9e93-224e7e67d81b"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-09T12:16:55Z`
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







