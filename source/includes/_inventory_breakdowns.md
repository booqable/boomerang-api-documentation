# Inventory breakdowns

Inventory breakdowns

## Fields
Every inventory breakdown has the following fields:

Name | Description
- | -
`id` | **Uuid** `readonly`<br>
`from` | **Datetime**<br>When the amount of items will be available (only for status `expected`)
`till` | **Datetime**<br>When the amount of items will become unavailable (only for type `temporary`)
`total` | **Integer**<br>The total amount of stock for product and location
`started` | **Integer**<br>The amount if items that are started for product and location
`status` | **String**<br>One of `expected`, `in_stock`, `expired`
`inventory_breakdown_type` | **String**<br>One of `regular`, `temporary`
`location_id` | **Uuid**<br>The associated Location
`product_id` | **Uuid**<br>The associated Product


## Relationships
Inventory breakdowns have the following relationships:

Name | Description
- | -
`location` | **Locations** `readonly`<br>Associated Location
`product` | **Products** `readonly`<br>Associated Product


## Listing inventory breakdowns



> How to fetch a breakdown of all items in stock:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/inventory_breakdowns?filter%5Bproduct_group_id%5D=7ecdc8f6-01a9-441e-bbff-0cdcef28f1c6&filter%5Bstatus%5D=in_stock&stats%5Binventory_breakdown_type%5D%5B%5D=sum&stats%5Bstarted%5D%5B%5D=sum&stats%5Bstatus%5D%5B%5D=sum&stats%5Btotal%5D%5B%5D=sum' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-1ca0f2d1-87b0-590e-aad0-9c96b5f65f9c",
      "type": "inventory_breakdowns",
      "attributes": {
        "total": 100,
        "started": 0,
        "status": "in_stock",
        "inventory_breakdown_type": "regular",
        "location_id": "6206af73-5025-42d6-b328-7ddefcb0d725",
        "product_id": "769cf473-5352-4080-a9ed-7e0eedf62b32"
      },
      "relationships": {
        "location": {
          "links": {
            "related": "api/boomerang/locations/6206af73-5025-42d6-b328-7ddefcb0d725"
          }
        },
        "product": {
          "links": {
            "related": "api/boomerang/products/769cf473-5352-4080-a9ed-7e0eedf62b32"
          }
        }
      }
    },
    {
      "id": "virtual-3798ac8f-83c2-58cb-b103-93d2d752c307",
      "type": "inventory_breakdowns",
      "attributes": {
        "till": "2022-07-07T11:08:45+00:00",
        "total": 5,
        "started": 0,
        "status": "in_stock",
        "inventory_breakdown_type": "temporary",
        "location_id": "6206af73-5025-42d6-b328-7ddefcb0d725",
        "product_id": "769cf473-5352-4080-a9ed-7e0eedf62b32"
      },
      "relationships": {
        "location": {
          "links": {
            "related": "api/boomerang/locations/6206af73-5025-42d6-b328-7ddefcb0d725"
          }
        },
        "product": {
          "links": {
            "related": "api/boomerang/products/769cf473-5352-4080-a9ed-7e0eedf62b32"
          }
        }
      }
    }
  ],
  "meta": {
    "stats": {
      "inventory_breakdown_type": {
        "sum": {
          "regular": 100,
          "temporary": 5
        }
      },
      "started": {
        "sum": 0
      },
      "status": {
        "sum": {
          "in_stock": 105,
          "expected": 17,
          "expired": 5
        }
      },
      "total": {
        "sum": 105
      }
    }
  }
}
```


> How to fetch a breakdown of all regular items in stock:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/inventory_breakdowns?filter%5Binventory_breakdown_type%5D=regular&filter%5Bproduct_group_id%5D=b4f72b66-ac43-464e-aacf-aeb075461dae&filter%5Bstatus%5D=in_stock&stats%5Binventory_breakdown_type%5D%5B%5D=sum&stats%5Bstarted%5D%5B%5D=sum&stats%5Bstatus%5D%5B%5D=sum&stats%5Btotal%5D%5B%5D=sum' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-1ed09a6c-2a24-5a11-b8b3-ec677d904db6",
      "type": "inventory_breakdowns",
      "attributes": {
        "total": 100,
        "started": 0,
        "status": "in_stock",
        "inventory_breakdown_type": "regular",
        "location_id": "58a24e18-e5df-4852-8c57-55fd2bf0dc5c",
        "product_id": "5354166e-6dd3-499a-93cd-1182749fece5"
      },
      "relationships": {
        "location": {
          "links": {
            "related": "api/boomerang/locations/58a24e18-e5df-4852-8c57-55fd2bf0dc5c"
          }
        },
        "product": {
          "links": {
            "related": "api/boomerang/products/5354166e-6dd3-499a-93cd-1182749fece5"
          }
        }
      }
    },
    {
      "id": "virtual-545c14e3-8e75-5b91-8dca-61e56e30ac4e",
      "type": "inventory_breakdowns",
      "attributes": {
        "till": "2022-07-07T11:08:47+00:00",
        "total": 5,
        "started": 0,
        "status": "in_stock",
        "inventory_breakdown_type": "temporary",
        "location_id": "58a24e18-e5df-4852-8c57-55fd2bf0dc5c",
        "product_id": "5354166e-6dd3-499a-93cd-1182749fece5"
      },
      "relationships": {
        "location": {
          "links": {
            "related": "api/boomerang/locations/58a24e18-e5df-4852-8c57-55fd2bf0dc5c"
          }
        },
        "product": {
          "links": {
            "related": "api/boomerang/products/5354166e-6dd3-499a-93cd-1182749fece5"
          }
        }
      }
    }
  ],
  "meta": {
    "stats": {
      "inventory_breakdown_type": {
        "sum": {
          "regular": 100,
          "temporary": 5
        }
      },
      "started": {
        "sum": 0
      },
      "status": {
        "sum": {
          "in_stock": 100,
          "expected": 12,
          "expired": 0
        }
      },
      "total": {
        "sum": 105
      }
    }
  }
}
```


> How to fetch a breakdown of all expected items:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/inventory_breakdowns?filter%5Bproduct_group_id%5D=cfa63809-ab14-4682-ab6b-25aae6bc3096&filter%5Bstatus%5D=expected&stats%5Binventory_breakdown_type%5D%5B%5D=sum&stats%5Bstarted%5D%5B%5D=sum&stats%5Bstatus%5D%5B%5D=sum&stats%5Btotal%5D%5B%5D=sum' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-34451e9e-4622-53d1-a42a-d1bb2aa1505c",
      "type": "inventory_breakdowns",
      "attributes": {
        "from": "2023-01-07T11:08:49+00:00",
        "total": 12,
        "status": "expected",
        "inventory_breakdown_type": "regular",
        "location_id": "64304e2d-39dd-43fc-a0a7-eae47421749d",
        "product_id": "2c65be23-2eb0-4f40-9177-c7446b643048"
      },
      "relationships": {
        "location": {
          "links": {
            "related": "api/boomerang/locations/64304e2d-39dd-43fc-a0a7-eae47421749d"
          }
        },
        "product": {
          "links": {
            "related": "api/boomerang/products/2c65be23-2eb0-4f40-9177-c7446b643048"
          }
        }
      }
    },
    {
      "id": "virtual-e7031b5a-957f-5b6a-ac6c-273772ca9537",
      "type": "inventory_breakdowns",
      "attributes": {
        "from": "2023-01-07T11:08:49+00:00",
        "till": "2023-02-07T11:08:49+00:00",
        "total": 5,
        "status": "expected",
        "inventory_breakdown_type": "temporary",
        "location_id": "64304e2d-39dd-43fc-a0a7-eae47421749d",
        "product_id": "2c65be23-2eb0-4f40-9177-c7446b643048"
      },
      "relationships": {
        "location": {
          "links": {
            "related": "api/boomerang/locations/64304e2d-39dd-43fc-a0a7-eae47421749d"
          }
        },
        "product": {
          "links": {
            "related": "api/boomerang/products/2c65be23-2eb0-4f40-9177-c7446b643048"
          }
        }
      }
    }
  ],
  "meta": {
    "stats": {
      "inventory_breakdown_type": {
        "sum": {
          "regular": 12,
          "temporary": 5
        }
      },
      "started": {
        "sum": 0
      },
      "status": {
        "sum": {
          "in_stock": 105,
          "expected": 17,
          "expired": 5
        }
      },
      "total": {
        "sum": 17
      }
    }
  }
}
```


> How to fetch a breakdown of all expired items:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/inventory_breakdowns?filter%5Bproduct_group_id%5D=03af2c24-d484-4f06-a218-fe8767293050&filter%5Bstatus%5D=expired&stats%5Binventory_breakdown_type%5D%5B%5D=sum&stats%5Bstarted%5D%5B%5D=sum&stats%5Bstatus%5D%5B%5D=sum&stats%5Btotal%5D%5B%5D=sum' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-c3ed91d7-0a20-5316-a320-97f467dfa59b",
      "type": "inventory_breakdowns",
      "attributes": {
        "till": "2021-12-07T11:08:51+00:00",
        "total": 5,
        "status": "expired",
        "inventory_breakdown_type": "temporary",
        "location_id": "a9d05bdd-67bc-4d2d-9cff-3deb43e05c67",
        "product_id": "a8a75ed7-469b-4d65-b201-743f5fcabecc"
      },
      "relationships": {
        "location": {
          "links": {
            "related": "api/boomerang/locations/a9d05bdd-67bc-4d2d-9cff-3deb43e05c67"
          }
        },
        "product": {
          "links": {
            "related": "api/boomerang/products/a8a75ed7-469b-4d65-b201-743f5fcabecc"
          }
        }
      }
    }
  ],
  "meta": {
    "stats": {
      "inventory_breakdown_type": {
        "sum": {
          "regular": 0,
          "temporary": 0
        }
      },
      "started": {
        "sum": 0
      },
      "status": {
        "sum": {
          "in_stock": 105,
          "expected": 17,
          "expired": 5
        }
      },
      "total": {
        "sum": 5
      }
    }
  }
}
```

### HTTP Request

`GET /api/boomerang/inventory_breakdowns`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=location,product`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[inventory_breakdowns]=id,created_at,updated_at`
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-01-07T11:08:42Z`
`sort` | **String**<br>How to sort the data `?sort=-created_at`
`meta` | **Hash**<br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String**<br>The page to request
`page[size]` | **String**<br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
`location_id` | **Uuid**<br>`eq`
`product_id` | **Uuid**<br>`eq`
`product_group_id` | **Uuid**<br>`eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`status` | **Array**<br>`sum`
`inventory_breakdown_type` | **Array**<br>`sum`
`total` | **Array**<br>`sum`
`started` | **Array**<br>`sum`


### Includes

All includes are allowed on this request