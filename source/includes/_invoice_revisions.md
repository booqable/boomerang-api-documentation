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
`order` | **Orders** <br>Associated Order
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
          "order_id": "3847becc-f3e5-430f-b208-d678222f247c"
        }
      }
    }'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "bd966064-a376-5559-9da5-6bd93279b0d7",
    "type": "invoice_revisions",
    "attributes": {
      "order_id": "3847becc-f3e5-430f-b208-d678222f247c",
      "revised_invoice_id": "2eb98b2e-929d-429e-a424-01a812b5f4de",
      "revision_invoice_id": "ed5166f2-c2ba-4473-b19d-ff49a0a0a59a"
    },
    "relationships": {}
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





