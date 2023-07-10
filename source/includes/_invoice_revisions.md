# Invoice revisions

Revises the last finalized invoice for an order by combining
it with the current pro forma invoice and creating a new
finalized invoice.

Creating a revision requires that there is a finalized invoice,
and that there is a pro forma invoice (i.e. changes must have been
made to the order since the last finalized invoice).

## Fields
Every invoice revision has the following fields:

Name | Description
-- | --
`id` | **Uuid** `readonly`<br>
`order_id` | **Uuid** <br>The associated Order
`revised_invoice_id` | **Uuid** `readonly`<br>The associated Revised invoice
`revision_invoice_id` | **Uuid** `readonly`<br>The associated Revision invoice


## Relationships
Invoice revisions have the following relationships:

Name | Description
-- | --
`order` | **Orders**<br>Associated Order
`revised_invoice` | **Documents** `readonly`<br>Associated Revised invoice
`revision_invoice` | **Documents** `readonly`<br>Associated Revision invoice


## Revise invoice



> Revise a finalized invoice:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/invoice_revisions' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "invoice_revisions",
        "attributes": {
          "order_id": "1a910cad-9e57-471b-9db0-7a4c9ef2ef4d"
        }
      }
    }'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "d5862009-4058-520c-b2ea-f246a3c0c417",
    "type": "invoice_revisions",
    "attributes": {
      "order_id": "1a910cad-9e57-471b-9db0-7a4c9ef2ef4d",
      "revised_invoice_id": "b6f5dd8c-f8a7-4210-8b1e-57a752d9b422",
      "revision_invoice_id": "0a172345-994c-4c4c-8131-098ea1a07bb1"
    },
    "relationships": {
      "order": {
        "meta": {
          "included": false
        }
      },
      "revised_invoice": {
        "meta": {
          "included": false
        }
      },
      "revision_invoice": {
        "meta": {
          "included": false
        }
      }
    }
  },
  "meta": {}
}
```

### HTTP Request

`POST /api/boomerang/invoice_revisions`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=order,revised_invoice,revision_invoice`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[invoice_revisions]=order_id,revised_invoice_id,revision_invoice_id`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][order_id]` | **Uuid** <br>The associated Order


### Includes

This request accepts the following includes:

`order`


`revised_invoice`


`revision_invoice`





