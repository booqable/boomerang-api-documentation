# Invoice finalizations

Pro forma invoices are automatically generated and updated when changes
are made to an order. The `InvoiceFinalizationResource` resource allows
to request the finalization of the current pro forma invoice.
Further changes to the order will trigger a new pro forma invoice to be
generated with prorated changes.

## Fields
Every invoice finalization has the following fields:

Name | Description
-- | --
`id` | **Uuid** `readonly`<br>Primary key
`document_id` | **Uuid** <br>ID of the invoice that needs to be finalized.


## Relationships
Invoice finalizations have the following relationships:

Name | Description
-- | --
`document` | **[Document](#documents)** <br>Associated Document


## Finalize invoice



> Finalize a pro forma invoice:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/invoice_finalizations' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "invoice_finalization",
        "attributes": {
          "document_id": "8cf18fc6-17a3-40ef-9311-f017600db306"
        }
      }
    }'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "d24ad7b8-d056-5508-b1d3-1be18fca26c8",
    "type": "invoice_finalizations",
    "attributes": {
      "document_id": "8cf18fc6-17a3-40ef-9311-f017600db306"
    },
    "relationships": {}
  },
  "meta": {}
}
```

### HTTP Request

`POST /api/boomerang/invoice_finalizations`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=document`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[invoice_finalizations]=document_id`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][document_id]` | **Uuid** <br>ID of the invoice that needs to be finalized.


### Includes

This request accepts the following includes:

`document` => 
`order` => 
`documents`









