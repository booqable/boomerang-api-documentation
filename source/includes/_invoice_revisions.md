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
- | -
`id` | **Uuid** `readonly`<br>
`order_id` | **Uuid** <br>The associated Order
`revised_invoice_id` | **Uuid** `readonly`<br>The associated Revised invoice
`revision_invoice_id` | **Uuid** `readonly`<br>The associated Revision invoice


## Relationships
Invoice revisions have the following relationships:

Name | Description
- | -
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
          "order_id": "9d3a2b98-8c8d-41ee-b603-1d4f46da61d4"
        }
      }
    }'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "b4cf15ff-71ba-531f-ac58-4f677d0b3bc3",
    "type": "invoice_revisions",
    "attributes": {
      "order_id": "9d3a2b98-8c8d-41ee-b603-1d4f46da61d4",
      "revised_invoice_id": "fad1a8f1-35b3-4a40-a710-22dce79b5343",
      "revision_invoice_id": "1a62d74f-2c38-4949-a914-ee404aea6cce"
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
- | -
`include` | **String** <br>List of comma seperated relationships `?include=order,revised_invoice,revision_invoice`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[invoice_revisions]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][order_id]` | **Uuid** <br>The associated Order


### Includes

This request accepts the following includes:

`order`


`revised_invoice`


`revision_invoice`





