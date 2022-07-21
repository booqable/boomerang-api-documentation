# Invoice finalizations

Pro forma invoices are automatically generated and updated when changes
are made to an order. The `InvoiceFinalizationResource` resource allows
to request the finalization of the current pro forma invoice.
Further changes to the order will trigger a new pro forma invoice to be
generated with prorated changes.

## Fields
Every invoice finalization has the following fields:

Name | Description
- | -
`id` | **Uuid** `readonly`<br>
`document_id` | **Uuid**<br>The associated Document


## Relationships
Invoice finalizations have the following relationships:

Name | Description
- | -
`document` | **Documents**<br>Associated Document


## Finalize invoice



> Finalize a pro forma invoice

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/invoice_finalizations' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "invoice_finalization",
        "attributes": {
          "document_id": "ddc8ade8-87fb-4e4e-82e3-a14297db27a9"
        }
      }
    }'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "3a2ae2a0-1ef9-50f9-b042-fee258d26bd2",
    "type": "invoice_finalizations",
    "attributes": {
      "document_id": "ddc8ade8-87fb-4e4e-82e3-a14297db27a9"
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=document`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[invoice_finalizations]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][document_id]` | **Uuid**<br>The associated Document


### Includes

This request accepts the following includes:

`document`





