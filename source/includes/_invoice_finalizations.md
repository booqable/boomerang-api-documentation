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
`document` | **Documents** <br>Associated Document


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
          "document_id": "fb6f8f48-6c07-4687-8b30-0b045d9c1dc3"
        }
      }
    }'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "8ae3db1a-91a6-5841-82d4-cbf4c65fd5f7",
    "type": "invoice_finalizations",
    "attributes": {
      "document_id": "fb6f8f48-6c07-4687-8b30-0b045d9c1dc3"
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









