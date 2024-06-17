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
`id` | **Uuid** `readonly`<br>
`document_id` | **Uuid** <br>The associated Document


## Relationships
Invoice finalizations have the following relationships:

Name | Description
-- | --
`document` | **Documents**<br>Associated Document


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
          "document_id": "57f7f488-cc25-45b4-9db6-71cb959b71ac"
        }
      }
    }'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "f25121cf-2de9-5cb4-b521-fce5c2c6cb17",
    "type": "invoice_finalizations",
    "attributes": {
      "document_id": "57f7f488-cc25-45b4-9db6-71cb959b71ac"
    },
    "relationships": {
      "document": {
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
`data[attributes][document_id]` | **Uuid** <br>The associated Document


### Includes

This request accepts the following includes:

`document` => 
`order` => 
`documents`









