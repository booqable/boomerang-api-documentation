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
          "order_id": "ecc950c7-9258-4c8a-af11-c113ebc28032"
        }
      }
    }'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "41aa4c36-6001-5548-9857-c5298c7754f3",
    "type": "invoice_revisions",
    "attributes": {
      "order_id": "ecc950c7-9258-4c8a-af11-c113ebc28032",
      "revised_invoice_id": "6359c520-13ba-4042-b791-3bf1484419aa",
      "revision_invoice_id": "e533c378-ce00-414f-a53b-6ba3400135c9"
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





