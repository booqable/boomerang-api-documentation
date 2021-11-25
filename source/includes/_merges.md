# Merges

Merging enables you to merge the data of two records. The following types are supported: `customers`.

## Endpoints
`POST /api/boomerang/merges`

## Fields
Every merge has the following fields:

Name | Description
- | -
`id` | **Uuid** `readonly`<br>
`type` | **Uuid**<br>Type of resource to merge. One of `customers`
`source_id` | **Uuid**<br>Resource from which data is taken, this resource gets archived or destroyed
`target_id` | **Uuid**<br>Resource to which data is saved, this resource is returned if `target` is specified in includes


## Relationships
Merges have the following relationships:

Name | Description
- | -
`target` | **Customers**<br>Associated Target


## Merging resources



> How to merge one customer's data into another customer:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/merges' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "merges",
        "attributes": {
          "type": "customers",
          "source_id": "69180e06-0cf6-4f71-9702-300900813e52",
          "target_id": "6ebf4631-feb2-494f-ab26-05cb72918c76"
        }
      },
      "include": "target"
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "60bd582e-f6f1-5d2b-ba52-903924ece23a",
    "type": "merges",
    "attributes": {
      "type": "customers",
      "source_id": "69180e06-0cf6-4f71-9702-300900813e52",
      "target_id": "6ebf4631-feb2-494f-ab26-05cb72918c76"
    },
    "relationships": {
      "target": {
        "data": {
          "type": "customers",
          "id": "6ebf4631-feb2-494f-ab26-05cb72918c76"
        }
      }
    }
  },
  "included": [
    {
      "id": "6ebf4631-feb2-494f-ab26-05cb72918c76",
      "type": "customers",
      "attributes": {
        "created_at": "2021-11-23T12:48:29+00:00",
        "updated_at": "2021-11-23T12:48:30+00:00",
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
    "self": "api/boomerang/merges?data%5Battributes%5D%5Bsource_id%5D=69180e06-0cf6-4f71-9702-300900813e52&data%5Battributes%5D%5Btarget_id%5D=6ebf4631-feb2-494f-ab26-05cb72918c76&data%5Battributes%5D%5Btype%5D=customers&data%5Btype%5D=merges&include=target&merge%5Bdata%5D%5Battributes%5D%5Bsource_id%5D=69180e06-0cf6-4f71-9702-300900813e52&merge%5Bdata%5D%5Battributes%5D%5Btarget_id%5D=6ebf4631-feb2-494f-ab26-05cb72918c76&merge%5Bdata%5D%5Battributes%5D%5Btype%5D=customers&merge%5Bdata%5D%5Btype%5D=merges&merge%5Binclude%5D=target&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/merges?data%5Battributes%5D%5Bsource_id%5D=69180e06-0cf6-4f71-9702-300900813e52&data%5Battributes%5D%5Btarget_id%5D=6ebf4631-feb2-494f-ab26-05cb72918c76&data%5Battributes%5D%5Btype%5D=customers&data%5Btype%5D=merges&include=target&merge%5Bdata%5D%5Battributes%5D%5Bsource_id%5D=69180e06-0cf6-4f71-9702-300900813e52&merge%5Bdata%5D%5Battributes%5D%5Btarget_id%5D=6ebf4631-feb2-494f-ab26-05cb72918c76&merge%5Bdata%5D%5Battributes%5D%5Btype%5D=customers&merge%5Bdata%5D%5Btype%5D=merges&merge%5Binclude%5D=target&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/merges?data%5Battributes%5D%5Bsource_id%5D=69180e06-0cf6-4f71-9702-300900813e52&data%5Battributes%5D%5Btarget_id%5D=6ebf4631-feb2-494f-ab26-05cb72918c76&data%5Battributes%5D%5Btype%5D=customers&data%5Btype%5D=merges&include=target&merge%5Bdata%5D%5Battributes%5D%5Bsource_id%5D=69180e06-0cf6-4f71-9702-300900813e52&merge%5Bdata%5D%5Battributes%5D%5Btarget_id%5D=6ebf4631-feb2-494f-ab26-05cb72918c76&merge%5Bdata%5D%5Battributes%5D%5Btype%5D=customers&merge%5Bdata%5D%5Btype%5D=merges&merge%5Binclude%5D=target&page%5Bnumber%5D=&page%5Bsize%5D=25",
    "next": "api/boomerang/merges?data%5Battributes%5D%5Bsource_id%5D=69180e06-0cf6-4f71-9702-300900813e52&data%5Battributes%5D%5Btarget_id%5D=6ebf4631-feb2-494f-ab26-05cb72918c76&data%5Battributes%5D%5Btype%5D=customers&data%5Btype%5D=merges&include=target&merge%5Bdata%5D%5Battributes%5D%5Bsource_id%5D=69180e06-0cf6-4f71-9702-300900813e52&merge%5Bdata%5D%5Battributes%5D%5Btarget_id%5D=6ebf4631-feb2-494f-ab26-05cb72918c76&merge%5Bdata%5D%5Battributes%5D%5Btype%5D=customers&merge%5Bdata%5D%5Btype%5D=merges&merge%5Binclude%5D=target&page%5Bnumber%5D=2&page%5Bsize%5D=25"
  },
  "meta": {}
}
```

### HTTP Request

`POST /api/boomerang/merges`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=target`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[merges]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][type]` | **Uuid**<br>Type of resource to merge. One of `customers`
`data[attributes][source_id]` | **Uuid**<br>Resource from which data is taken, this resource gets archived or destroyed
`data[attributes][target_id]` | **Uuid**<br>Resource to which data is saved, this resource is returned if `target` is specified in includes


### Includes

This request accepts the following includes:

`target`




