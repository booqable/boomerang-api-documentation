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
          "document_id": "40c3c3c1-83e6-4d79-ad78-4057a2fb7e92"
        }
      }
    }'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "97de7077-c679-5894-9174-cc43ede2ebc9",
    "type": "invoice_finalizations",
    "attributes": {
      "document_id": "40c3c3c1-83e6-4d79-ad78-4057a2fb7e92"
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

`document`





