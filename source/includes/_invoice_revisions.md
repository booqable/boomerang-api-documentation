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
`id` | **Uuid** `readonly`<br>Primary key
`order_id` | **Uuid** <br>ID of the order for which the invoice needs to be revised.
`revised_invoice_id` | **Uuid** `readonly`<br>Document ID of the finalized invoice that was revised.
`revision_invoice_id` | **Uuid** `readonly`<br>Associated Revision invoice


## Relationships
Invoice revisions have the following relationships:

Name | Description
-- | --
`order` | **[Order](#orders)** <br>Associated Order
`revised_invoice` | **[Document](#documents)** <br>Associated Revised invoice
`revision_invoice` | **[Document](#documents)** <br>Associated Revision invoice


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
          "order_id": "63df83a3-da51-41fe-9b3b-b6b41fe7ea78"
        }
      }
    }'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "ab4fe8c1-7ca9-509e-a489-02cd2e39f57f",
    "type": "invoice_revisions",
    "attributes": {
      "order_id": "63df83a3-da51-41fe-9b3b-b6b41fe7ea78",
      "revised_invoice_id": "8dbb0b52-7751-4440-b7a1-89fe3641bec3",
      "revision_invoice_id": "0af43d14-d0e1-4681-95fd-992ae3a018e5"
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
`data[attributes][order_id]` | **Uuid** <br>ID of the order for which the invoice needs to be revised.


### Includes

This request accepts the following includes:

`order`


`revised_invoice`


`revision_invoice`





