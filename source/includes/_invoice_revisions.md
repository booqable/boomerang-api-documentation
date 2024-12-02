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
          "order_id": "0dbddadd-b252-43e0-b740-23e857d4d405"
        }
      }
    }'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "21f8f90b-2c6f-5323-a302-07cdace5658e",
    "type": "invoice_revisions",
    "attributes": {
      "order_id": "0dbddadd-b252-43e0-b740-23e857d4d405",
      "revised_invoice_id": "85f26227-e523-4fcb-aa6e-6551c43f25c5",
      "revision_invoice_id": "0be3158e-649d-4f85-b98f-21b55e685683"
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





