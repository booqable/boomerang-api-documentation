# Merges

Merging enables you to merge the data of two records. The following types are supported: `customers`.

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
          "source_id": "1a363c71-8960-4690-b7c9-ce151001befd",
          "target_id": "4c6b9f65-0b95-436e-a60c-51e55fc8e58f"
        }
      },
      "include": "target"
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "76eec991-e361-5272-8043-c6ae5c6e664a",
    "type": "merges",
    "attributes": {
      "type": "customers",
      "source_id": "1a363c71-8960-4690-b7c9-ce151001befd",
      "target_id": "4c6b9f65-0b95-436e-a60c-51e55fc8e58f"
    },
    "relationships": {
      "target": {
        "data": {
          "type": "customers",
          "id": "4c6b9f65-0b95-436e-a60c-51e55fc8e58f"
        }
      }
    }
  },
  "included": [
    {
      "id": "4c6b9f65-0b95-436e-a60c-51e55fc8e58f",
      "type": "customers",
      "attributes": {
        "created_at": "2021-12-02T14:38:14+00:00",
        "updated_at": "2021-12-02T14:38:14+00:00",
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
    "self": "api/boomerang/merges?data%5Battributes%5D%5Bsource_id%5D=1a363c71-8960-4690-b7c9-ce151001befd&data%5Battributes%5D%5Btarget_id%5D=4c6b9f65-0b95-436e-a60c-51e55fc8e58f&data%5Battributes%5D%5Btype%5D=customers&data%5Btype%5D=merges&include=target&merge%5Bdata%5D%5Battributes%5D%5Bsource_id%5D=1a363c71-8960-4690-b7c9-ce151001befd&merge%5Bdata%5D%5Battributes%5D%5Btarget_id%5D=4c6b9f65-0b95-436e-a60c-51e55fc8e58f&merge%5Bdata%5D%5Battributes%5D%5Btype%5D=customers&merge%5Bdata%5D%5Btype%5D=merges&merge%5Binclude%5D=target&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/merges?data%5Battributes%5D%5Bsource_id%5D=1a363c71-8960-4690-b7c9-ce151001befd&data%5Battributes%5D%5Btarget_id%5D=4c6b9f65-0b95-436e-a60c-51e55fc8e58f&data%5Battributes%5D%5Btype%5D=customers&data%5Btype%5D=merges&include=target&merge%5Bdata%5D%5Battributes%5D%5Bsource_id%5D=1a363c71-8960-4690-b7c9-ce151001befd&merge%5Bdata%5D%5Battributes%5D%5Btarget_id%5D=4c6b9f65-0b95-436e-a60c-51e55fc8e58f&merge%5Bdata%5D%5Battributes%5D%5Btype%5D=customers&merge%5Bdata%5D%5Btype%5D=merges&merge%5Binclude%5D=target&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/merges?data%5Battributes%5D%5Bsource_id%5D=1a363c71-8960-4690-b7c9-ce151001befd&data%5Battributes%5D%5Btarget_id%5D=4c6b9f65-0b95-436e-a60c-51e55fc8e58f&data%5Battributes%5D%5Btype%5D=customers&data%5Btype%5D=merges&include=target&merge%5Bdata%5D%5Battributes%5D%5Bsource_id%5D=1a363c71-8960-4690-b7c9-ce151001befd&merge%5Bdata%5D%5Battributes%5D%5Btarget_id%5D=4c6b9f65-0b95-436e-a60c-51e55fc8e58f&merge%5Bdata%5D%5Battributes%5D%5Btype%5D=customers&merge%5Bdata%5D%5Btype%5D=merges&merge%5Binclude%5D=target&page%5Bnumber%5D=&page%5Bsize%5D=25",
    "next": "api/boomerang/merges?data%5Battributes%5D%5Bsource_id%5D=1a363c71-8960-4690-b7c9-ce151001befd&data%5Battributes%5D%5Btarget_id%5D=4c6b9f65-0b95-436e-a60c-51e55fc8e58f&data%5Battributes%5D%5Btype%5D=customers&data%5Btype%5D=merges&include=target&merge%5Bdata%5D%5Battributes%5D%5Bsource_id%5D=1a363c71-8960-4690-b7c9-ce151001befd&merge%5Bdata%5D%5Battributes%5D%5Btarget_id%5D=4c6b9f65-0b95-436e-a60c-51e55fc8e58f&merge%5Bdata%5D%5Battributes%5D%5Btype%5D=customers&merge%5Bdata%5D%5Btype%5D=merges&merge%5Binclude%5D=target&page%5Bnumber%5D=2&page%5Bsize%5D=25"
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





