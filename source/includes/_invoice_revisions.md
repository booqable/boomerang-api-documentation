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
          "order_id": "718fe5e2-ddd1-4826-89b0-c3011b3503ec"
        }
      }
    }'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "df0621d1-0c27-503b-b641-7d77f09652db",
    "type": "invoice_revisions",
    "attributes": {
      "order_id": "718fe5e2-ddd1-4826-89b0-c3011b3503ec",
      "revised_invoice_id": "b597fc68-aada-468b-ac18-1c2f9f39cf1f",
      "revision_invoice_id": "d22d636e-d41b-459d-9bad-d1cbf1f6f8ff"
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





