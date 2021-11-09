# Introduction

The Booqable API is a RESTful [JSON API](https://jsonapi.org/) as such is designed to have predictable, resource-oriented URLs and to use HTTP response codes to indicate API errors. We use standard HTTP features, like HTTP authentication and HTTP verbs, which can be understood by [off-the-shelf HTTP clients](https://jsonapi.org/implementations/).

<aside class="warning">
  <b>WARNING:</b> Booqable's API is still in Beta we might introduce non-backwards compatible changes in the future!
</aside>


## Endpoint

All API requests need to be directed to the correct company-specific endpoint.
The format is as follows:

`https://{company_slug}.booqable.com/api/boomerang/`

<aside class="notice">
  You must replace <code>{company_slug}</code> with the name of your company.
</aside>


## Response types

The Booqable API supports two response types `jsonapi` and `json`.

By default, the API returns `jsonapi` responses. These responses are designed to return graph data more efficiently and also include links to related resources.

You can, however, also request data in nested structure by appending `.json` to the path of each request.

> A typical JSON API response:

```
GET /api/boomerang/orders?include=customer
```

```json
{
  "data": [
    {
      "id": "54808378-a247-4715-89f6-0a8da2e7ad62",
      "type": "orders",
      "attributes": {
        "starts_at": "2021-11-12T15:00:00+00:00",
        "stops_at": "2021-11-13T15:00:00+00:00"
      },
      "relationships": {
        "customer": {
          "links": {
            "related": "api/boomerang/customers/24e54970-7473-49a9-a71a-8c07eb97e510"
          },
          "data": {
            "type": "customers",
            "id": "24e54970-7473-49a9-a71a-8c07eb97e510"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "24e54970-7473-49a9-a71a-8c07eb97e510",
      "type": "customers",
      "attributes": {
        "name": "John Doe"
      },
      "relationships": {
        "properties": {
          "links": {
            "related": "api/boomerang/properties?filter[owner_id]=24e54970-7473-49a9-a71a-8c07eb97e510&filter[owner_type]=Customer"
          }
        }
      }
    }
  ],
  "links": {
    "self": "api/boomerang/orders?fields%5Bcustomer%5D=name&fields%5Borders%5D=starts_at%2Cstops_at&include=customer&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/orders?fields%5Bcustomer%5D=name&fields%5Borders%5D=starts_at%2Cstops_at&include=customer&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/orders?fields%5Bcustomer%5D=name&fields%5Borders%5D=starts_at%2Cstops_at&include=customer&page%5Bnumber%5D=1&page%5Bsize%5D=25"
  },
  "meta": {}
}
```

> A JSON response:

```
GET /api/boomerang/orders.json?include=customer
```

```json
{
  "data": [
    {
      "id": "30d35575-c8d1-4f5c-b4c6-cc0abc32c6ed",
      "starts_at": "2021-11-12T15:15:00+00:00",
      "stops_at": "2021-11-13T15:15:00+00:00",
      "customer": {
        "id": "92ec8fee-423e-4f7e-8565-3e6028a0f437",
        "name": "John Doe"
      }
    }
  ]
}
```


## Fields

For every resource, fields can be written, read, filtered, sorted, and aggregated. The behavior of fields is described for each resource.

On every request, you can specify fields to be returned in the response. Note that you can also specify fields of included resources.

> Including specific fields can be done like this:

```
?fields[orders]=starts_at,stops_at&fields[plannings]=reserved_from,reserved_till
```


## Filtering

Collections returned in list requests can be filtered on specific fields; the API supports the following operators:

| Type            | Operators                                                                                              |
|-----------------|--------------------------------------------------------------------------------------------------------|
| **String**      | `eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match` |
| **Uuid**        | `eq`, `not_eq`                                                                                         |
| **Enum**        | `eq`, `not_eq`                                                                                         |
| **Integer**     | `eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`                                                               |
| **Integer**     | `eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`                                                               |
| **Big Decimal** | `eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`                                                               |
| **Float**       | `eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`                                                               |
| **Boolean**     | `eq`                                                                                                   |
| **Date**        | `eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`                                                               |
| **DateTime**    | `eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`                                                               |
| **Hash**        | `eq`                                                                                                   |
| **Array**       | `eq`                                                                                                   |

<aside class="notice">
  Note that not all operators may be supported on each field, make sure to check the filters section for each resource.
</aside>

> How to filter a request:

```
/api/boomerang/orders?filter[starts_at][gte]=1980-11-16T09:00:00+00:00&filter[starts_at][lte]=1990-11-16T09:00:00+00:00&filter[status]=reserved
```


## Includes

The Booqable API consists of many resources related to each other. Therefore the API supports loading associated resources in a single request. Use the dot-syntax to deeply nest includes.

<aside class="notice">
  Note that not all includes are supported on each request even though the relation is present on a resource. Make sure to check out the resource-specific documentation.
</aside>

> Including associated data:

```
GET api/boomerang/orders?include=customer,customer.properties
```

```json
  {
  "data": {
    "id": "f2afdb0e-55bd-4993-b9c2-4f04b569419d",
    "type": "orders",
    "attributes": {
      "starts_at": "2021-11-12T16:00:00+00:00",
      "stops_at": "2021-11-13T16:00:00+00:00"
    },
    "relationships": {
      "customer": {
        "links": {
          "related": "api/boomerang/customers/404021af-c889-4d72-9296-481640f4c750"
        },
        "data": {
          "type": "customers",
          "id": "404021af-c889-4d72-9296-481640f4c750"
        }
      },
    }
  },
  "included": [
    {
      "id": "404021af-c889-4d72-9296-481640f4c750",
      "type": "customers",
      "attributes": {
        "name": "John Doe"
      },
      "relationships": {
        "properties": {
          "links": {
            "related": "api/boomerang/properties?filter[owner_id]=404021af-c889-4d72-9296-481640f4c750&filter[owner_type]=Customer"
          },
          "data": [
            {
              "type": "properties",
              "id": "9625bd15-732e-4301-8c1c-f5b3e03c1bed"
            }
          ]
        },
      }
    },
    {
      "id": "9625bd15-732e-4301-8c1c-f5b3e03c1bed",
      "type": "properties",
      "attributes": {
        "name": "Phone",
        "value": "+31600000000"
      },
      "relationships": {
        "owner": {
          "links": {
            "related": "api/boomerang/customers/404021af-c889-4d72-9296-481640f4c750"
          }
        }
      }
    }
  ],
  "meta": {}
}
```

## Stats

Results from list requests can be aggregated by providing stats. These stats are always computed over the unpaginated filtered collection. The following aggregations are supported: `count`, `count_each`, `average`, `sum`, `maximum`, `minimum`. You can supply multiple types for each field.

<aside class="notice">
  Note that not all types are supported for each field; check the resource-specific documentation for more information.
</aside>

> Example of how to request stats:

```
?stats[to_be_paid_in_cents][]=sum&stats[grand_total_in_cents][]=average&stats[grand_total_in_cents][]=sum&stats[total]=count&stats[payment_status]=count
```

```json
"meta": {
  "stats": {
    "to_be_paid_in_cents": {
      "sum": 79000
    },
    "grand_total_in_cents": {
      "average": 25000,
      "sum": 1198000
    },
    "total": {
      "count": 237
    },
    "payment_status": {
      "count": {
        "payment_due": 161,
        "paid": 51,
        "partially_paid": 13,
        "overpaid": 11,
        "process_deposit": 1
      }
    }
  }
}
```


## Sideposting

Due to the nature of actions in the API, the API does not support official JSON API compliant side posting. Instead, actions are designed in a way that related resources are managed automatically.

There are a few exceptions though, in these cases, resources can be created or associated by setting:

- `{resource_name}_attributes` array of resources to create, update and associate.
- `{resource_name}_ids` array of resources to associate.
- `{resource_name}_id` id off the resource to associate.

When side posting is supported, it will be mentioned in the resource-specific documentation.

