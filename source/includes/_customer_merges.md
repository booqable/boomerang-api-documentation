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
          "merge_from_customer_id": "e9de7527-57f5-4183-ac72-d723909e78bb",
          "merge_into_customer_id": "be1668a0-5c57-43e9-a803-9b6a7817e52c"
        }
      },
      "include": "customer"
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "637ef154-5b7e-5c5e-a1d5-8c801ccd3bab",
    "type": "customer_merges",
    "attributes": {
      "merge_into_customer_id": "be1668a0-5c57-43e9-a803-9b6a7817e52c",
      "merge_from_customer_id": "e9de7527-57f5-4183-ac72-d723909e78bb",
      "customer_id": "be1668a0-5c57-43e9-a803-9b6a7817e52c"
    },
    "relationships": {
      "customer": {
        "data": {
          "type": "customers",
          "id": "be1668a0-5c57-43e9-a803-9b6a7817e52c"
        }
      }
    }
  },
  "included": [
    {
      "id": "be1668a0-5c57-43e9-a803-9b6a7817e52c",
      "type": "customers",
      "attributes": {
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
    "self": "api/boomerang/customer_merges?customer_merge%5Bdata%5D%5Battributes%5D%5Bmerge_from_customer_id%5D=e9de7527-57f5-4183-ac72-d723909e78bb&customer_merge%5Bdata%5D%5Battributes%5D%5Bmerge_into_customer_id%5D=be1668a0-5c57-43e9-a803-9b6a7817e52c&customer_merge%5Bdata%5D%5Btype%5D=customer_merges&customer_merge%5Binclude%5D=customer&data%5Battributes%5D%5Bmerge_from_customer_id%5D=e9de7527-57f5-4183-ac72-d723909e78bb&data%5Battributes%5D%5Bmerge_into_customer_id%5D=be1668a0-5c57-43e9-a803-9b6a7817e52c&data%5Btype%5D=customer_merges&include=customer&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/customer_merges?customer_merge%5Bdata%5D%5Battributes%5D%5Bmerge_from_customer_id%5D=e9de7527-57f5-4183-ac72-d723909e78bb&customer_merge%5Bdata%5D%5Battributes%5D%5Bmerge_into_customer_id%5D=be1668a0-5c57-43e9-a803-9b6a7817e52c&customer_merge%5Bdata%5D%5Btype%5D=customer_merges&customer_merge%5Binclude%5D=customer&data%5Battributes%5D%5Bmerge_from_customer_id%5D=e9de7527-57f5-4183-ac72-d723909e78bb&data%5Battributes%5D%5Bmerge_into_customer_id%5D=be1668a0-5c57-43e9-a803-9b6a7817e52c&data%5Btype%5D=customer_merges&include=customer&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/customer_merges?customer_merge%5Bdata%5D%5Battributes%5D%5Bmerge_from_customer_id%5D=e9de7527-57f5-4183-ac72-d723909e78bb&customer_merge%5Bdata%5D%5Battributes%5D%5Bmerge_into_customer_id%5D=be1668a0-5c57-43e9-a803-9b6a7817e52c&customer_merge%5Bdata%5D%5Btype%5D=customer_merges&customer_merge%5Binclude%5D=customer&data%5Battributes%5D%5Bmerge_from_customer_id%5D=e9de7527-57f5-4183-ac72-d723909e78bb&data%5Battributes%5D%5Bmerge_into_customer_id%5D=be1668a0-5c57-43e9-a803-9b6a7817e52c&data%5Btype%5D=customer_merges&include=customer&page%5Bnumber%5D=&page%5Bsize%5D=25",
    "next": "api/boomerang/customer_merges?customer_merge%5Bdata%5D%5Battributes%5D%5Bmerge_from_customer_id%5D=e9de7527-57f5-4183-ac72-d723909e78bb&customer_merge%5Bdata%5D%5Battributes%5D%5Bmerge_into_customer_id%5D=be1668a0-5c57-43e9-a803-9b6a7817e52c&customer_merge%5Bdata%5D%5Btype%5D=customer_merges&customer_merge%5Binclude%5D=customer&data%5Battributes%5D%5Bmerge_from_customer_id%5D=e9de7527-57f5-4183-ac72-d723909e78bb&data%5Battributes%5D%5Bmerge_into_customer_id%5D=be1668a0-5c57-43e9-a803-9b6a7817e52c&data%5Btype%5D=customer_merges&include=customer&page%5Bnumber%5D=2&page%5Bsize%5D=25"
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





