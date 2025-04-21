# Invoice revisions

Revises the last finalized invoice for an order by combining
it with the current pro forma invoice and creating a new
finalized invoice.

Creating a revision requires that there is a finalized invoice,
and that there is a pro forma invoice (i.e. changes must have been
made to the order since the last finalized invoice).

## Relationships
Name | Description
-- | --
`order` | **[Order](#orders)** `required`<br>The order for which the last invoice needs to be revised.
`revised_invoice` | **[Document](#documents)** `required`<br>The finalized invoice that was revised.
`revision_invoice` | **[Document](#documents)** `required`<br>The replacement invoice that was generated.


Check matching attributes under [Fields](#invoice-revisions-fields) to see which relations can be written.
<br/ >
Check each individual operation to see which relations can be included as a sideload.
## Fields

 Name | Description
-- | --
`id` | **uuid** `readonly`<br>Primary key.
`order_id` | **uuid** <br>The order for which the last invoice needs to be revised.
`revised_invoice_id` | **uuid** `readonly`<br>The finalized invoice that was revised.
`revision_invoice_id` | **uuid** `readonly`<br>The replacement invoice that was generated.


## Revise invoice


> Revise a finalized invoice:

```shell
  curl --request POST
       --url 'https://example.booqable.com/api/4/invoice_revisions'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "type": "invoice_revisions",
           "attributes": {
             "order_id": "7b026e88-c408-4d9b-8ff7-4dc889f66f8b"
           }
         }
       }'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "75c7effe-1ae6-409a-8cb4-4003f6e2f901",
      "type": "invoice_revisions",
      "attributes": {
        "order_id": "7b026e88-c408-4d9b-8ff7-4dc889f66f8b",
        "revised_invoice_id": "5c7bff8c-1cec-4027-8049-2d29ac25ee0e",
        "revision_invoice_id": "fcb6ea7b-1d93-482b-828e-ae3ab98226c0"
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
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[invoice_revisions]=order_id,revised_invoice_id,revision_invoice_id`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=order,revised_invoice,revision_invoice`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][order_id]` | **uuid** <br>The order for which the last invoice needs to be revised.


### Includes

This request accepts the following includes:

`order`


`revised_invoice`


`revision_invoice`





