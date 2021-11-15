# Customer merges

Merging customers is a simple way to clean up your customer list. For example when the same customer creates multiple orders through the online store without using logins.

## Endpoints
`POST /api/boomerang/customer_merges`

## Fields
Every customer merge has the following fields:

Name | Description
- | -
`id` | **Uuid** `readonly`<br>
`merge_into_customer_id` | **Uuid**<br>Customer to which data is saved, this customer is returned if `customer` is specified in includes
`merge_from_customer_id` | **Uuid**<br>Customer from which data is taken, this customer gets archived
`customer_id` | **Uuid**<br>The associated Customer


## Relationships
Customer merges have the following relationships:

Name | Description
- | -
`customer` | **Customers** `readonly`<br>Associated Customer


## Merging customers



> How to merge one customer's data into another customer:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/customer_merges' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "customer_merges",
        "attributes": {
          "merge_from_customer_id": "a8f281ea-f8ba-4240-9242-aa67e26082e8",
          "merge_into_customer_id": "7954c4ec-77cf-430d-89be-706d809d1056"
        }
      },
      "include": "customer"
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "d3b4032b-6c9a-556c-9f5d-175f489404bf",
    "type": "customer_merges",
    "attributes": {
      "merge_into_customer_id": "7954c4ec-77cf-430d-89be-706d809d1056",
      "merge_from_customer_id": "a8f281ea-f8ba-4240-9242-aa67e26082e8",
      "customer_id": "7954c4ec-77cf-430d-89be-706d809d1056"
    },
    "relationships": {
      "customer": {
        "data": {
          "type": "customers",
          "id": "7954c4ec-77cf-430d-89be-706d809d1056"
        }
      }
    }
  },
  "included": [
    {
      "id": "7954c4ec-77cf-430d-89be-706d809d1056",
      "type": "customers",
      "attributes": {
        "created_at": "2021-11-15T07:45:52+00:00",
        "updated_at": "2021-11-15T07:45:53+00:00",
        "number": 1,
        "name": "John Doe",
        "email": "johndoe@company.test",
        "archived": false,
        "deposit_type": "default",
        "deposit_value": 0.0,
        "discount_percentage": 0.0,
        "legal_type": "person",
        "properties": {},
        "tag_list": [],
        "merge_suggestion_customer_id": null,
        "tax_region_id": null
      },
      "relationships": {
        "merge_suggestion_customer": {
          "meta": {
            "included": false
          }
        },
        "tax_region": {
          "meta": {
            "included": false
          }
        },
        "properties": {
          "meta": {
            "included": false
          }
        },
        "barcode": {
          "meta": {
            "included": false
          }
        },
        "notes": {
          "meta": {
            "included": false
          }
        }
      }
    }
  ],
  "links": {
    "self": "api/boomerang/customer_merges?customer_merge%5Bdata%5D%5Battributes%5D%5Bmerge_from_customer_id%5D=a8f281ea-f8ba-4240-9242-aa67e26082e8&customer_merge%5Bdata%5D%5Battributes%5D%5Bmerge_into_customer_id%5D=7954c4ec-77cf-430d-89be-706d809d1056&customer_merge%5Bdata%5D%5Btype%5D=customer_merges&customer_merge%5Binclude%5D=customer&data%5Battributes%5D%5Bmerge_from_customer_id%5D=a8f281ea-f8ba-4240-9242-aa67e26082e8&data%5Battributes%5D%5Bmerge_into_customer_id%5D=7954c4ec-77cf-430d-89be-706d809d1056&data%5Btype%5D=customer_merges&include=customer&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/customer_merges?customer_merge%5Bdata%5D%5Battributes%5D%5Bmerge_from_customer_id%5D=a8f281ea-f8ba-4240-9242-aa67e26082e8&customer_merge%5Bdata%5D%5Battributes%5D%5Bmerge_into_customer_id%5D=7954c4ec-77cf-430d-89be-706d809d1056&customer_merge%5Bdata%5D%5Btype%5D=customer_merges&customer_merge%5Binclude%5D=customer&data%5Battributes%5D%5Bmerge_from_customer_id%5D=a8f281ea-f8ba-4240-9242-aa67e26082e8&data%5Battributes%5D%5Bmerge_into_customer_id%5D=7954c4ec-77cf-430d-89be-706d809d1056&data%5Btype%5D=customer_merges&include=customer&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/customer_merges?customer_merge%5Bdata%5D%5Battributes%5D%5Bmerge_from_customer_id%5D=a8f281ea-f8ba-4240-9242-aa67e26082e8&customer_merge%5Bdata%5D%5Battributes%5D%5Bmerge_into_customer_id%5D=7954c4ec-77cf-430d-89be-706d809d1056&customer_merge%5Bdata%5D%5Btype%5D=customer_merges&customer_merge%5Binclude%5D=customer&data%5Battributes%5D%5Bmerge_from_customer_id%5D=a8f281ea-f8ba-4240-9242-aa67e26082e8&data%5Battributes%5D%5Bmerge_into_customer_id%5D=7954c4ec-77cf-430d-89be-706d809d1056&data%5Btype%5D=customer_merges&include=customer&page%5Bnumber%5D=&page%5Bsize%5D=25",
    "next": "api/boomerang/customer_merges?customer_merge%5Bdata%5D%5Battributes%5D%5Bmerge_from_customer_id%5D=a8f281ea-f8ba-4240-9242-aa67e26082e8&customer_merge%5Bdata%5D%5Battributes%5D%5Bmerge_into_customer_id%5D=7954c4ec-77cf-430d-89be-706d809d1056&customer_merge%5Bdata%5D%5Btype%5D=customer_merges&customer_merge%5Binclude%5D=customer&data%5Battributes%5D%5Bmerge_from_customer_id%5D=a8f281ea-f8ba-4240-9242-aa67e26082e8&data%5Battributes%5D%5Bmerge_into_customer_id%5D=7954c4ec-77cf-430d-89be-706d809d1056&data%5Btype%5D=customer_merges&include=customer&page%5Bnumber%5D=2&page%5Bsize%5D=25"
  },
  "meta": {}
}
```

### HTTP Request

`POST /api/boomerang/customer_merges`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=customer`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[customer_merges]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][merge_into_customer_id]` | **Uuid**<br>Customer to which data is saved, this customer is returned if `customer` is specified in includes
`data[attributes][merge_from_customer_id]` | **Uuid**<br>Customer from which data is taken, this customer gets archived
`data[attributes][customer_id]` | **Uuid**<br>The associated Customer


### Includes

This request accepts the following includes:

`customer`





