# Invoice finalizations

Pro forma invoices are automatically generated and updated when changes
are made to an order. The `InvoiceFinalizationResource` resource allows
to request the finalization of the current pro forma invoice.
Further changes to the order will trigger a new pro forma invoice to be
generated with prorated changes.

## Relationships
Name | Description
-- | --
`document` | **[Document](#documents)** `required`<br>The invoice that needs to be finalized.


Check matching attributes under [Fields](#invoice-finalizations-fields) to see which relations can be written.
<br/ >
Check each individual operation to see which relations can be included as a sideload.
## Fields

 Name | Description
-- | --
`document_id` | **uuid** <br>The invoice that needs to be finalized.
`id` | **uuid** `readonly`<br>Primary key.


## Finalize invoice


> Finalize a pro forma invoice:

```shell
  curl --request POST \
       --url 'https://example.booqable.com/api/boomerang/invoice_finalizations'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "type": "invoice_finalization",
           "attributes": {
             "document_id": "ef4f4bbd-55b2-4355-8436-74a4dde8fe55"
           }
         }
       }'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "797e55bb-b625-41fd-876a-c97b5ed135b0",
      "type": "invoice_finalizations",
      "attributes": {
        "document_id": "ef4f4bbd-55b2-4355-8436-74a4dde8fe55"
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
`fields[]` | **array** <br>List of comma seperated fields to include `?fields[invoice_finalizations]=document_id`
`include` | **string** <br>List of comma seperated relationships `?include=document`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][document_id]` | **uuid** <br>The invoice that needs to be finalized.


### Includes

This request accepts the following includes:

`document` => 
`order` => 
`documents`









