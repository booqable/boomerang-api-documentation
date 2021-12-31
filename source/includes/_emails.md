# Emails

Emails allow you to easily communicate with your customers by using optional templates. Booqable keeps a history of e-mail being sent for orders or customers.

## Endpoints
`GET /api/boomerang/emails`

`POST /api/boomerang/emails`

## Fields
Every email has the following fields:

Name | Description
- | -
`id` | **Uuid** `readonly`<br>Primary key
`created_at` | **Datetime** `readonly`<br>When the resource was created
`updated_at` | **Datetime** `readonly`<br>When the resource was last updated
`subject` | **String**<br>Email subject
`body` | **String**<br>Email body
`recipients` | **String**<br>Comma seperated list of recipient email addresses, all addresses must be valid for the email to send.
`document_ids` | **Array**<br>Documents to send as attachments to the email
`order_id` | **Uuid**<br>The associated Order
`customer_id` | **Uuid**<br>The associated Customer
`email_template_id` | **Uuid**<br>The associated Email template
`employee_id` | **Uuid** `readonly`<br>The associated Employee


## Relationships
Emails have the following relationships:

Name | Description
- | -
`order` | **Orders** `readonly`<br>Associated Order
`customer` | **Customers** `readonly`<br>Associated Customer
`email_template` | **Email templates** `readonly`<br>Associated Email template
`employee` | **Employees** `readonly`<br>Associated Employee


## Listing emails



> How to fetch a list of emails:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/emails' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "b00f95fe-ad4e-4538-a62a-9a10686e5f42",
      "type": "emails",
      "attributes": {
        "created_at": "2021-12-30T11:21:33+00:00",
        "updated_at": "2021-12-30T11:21:33+00:00",
        "subject": "Order confirmation",
        "body": "We hereby confirm your order with number #123",
        "recipients": "jon@doe.com",
        "document_ids": [],
        "order_id": null,
        "customer_id": "80905810-9c30-4721-bc34-caee4284dbe6",
        "email_template_id": null,
        "employee_id": null
      },
      "relationships": {
        "order": {
          "links": {
            "related": null
          }
        },
        "customer": {
          "links": {
            "related": "api/boomerang/customers/80905810-9c30-4721-bc34-caee4284dbe6"
          }
        },
        "email_template": {
          "links": {
            "related": null
          }
        },
        "employee": {
          "links": {
            "related": null
          }
        }
      }
    }
  ],
  "links": {
    "self": "api/boomerang/emails?page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/emails?page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/emails?page%5Bnumber%5D=1&page%5Bsize%5D=25"
  },
  "meta": {}
}
```


> How to fetch a list of emails for a specific order:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/emails?filter%5Border_id%5D=440ea58c-01a4-4aea-b64d-6f33ac7a5e00' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "87610bd5-b182-435e-9822-eb915d3bf6e4",
      "type": "emails",
      "attributes": {
        "created_at": "2021-12-30T11:21:34+00:00",
        "updated_at": "2021-12-30T11:21:34+00:00",
        "subject": "Order confirmation",
        "body": "We hereby confirm your order with number #123",
        "recipients": "jon@doe.com",
        "document_ids": [],
        "order_id": "440ea58c-01a4-4aea-b64d-6f33ac7a5e00",
        "customer_id": "efae9b88-ad75-4918-8f64-01eaa053a9ee",
        "email_template_id": null,
        "employee_id": null
      },
      "relationships": {
        "order": {
          "links": {
            "related": "api/boomerang/orders/440ea58c-01a4-4aea-b64d-6f33ac7a5e00"
          }
        },
        "customer": {
          "links": {
            "related": "api/boomerang/customers/efae9b88-ad75-4918-8f64-01eaa053a9ee"
          }
        },
        "email_template": {
          "links": {
            "related": null
          }
        },
        "employee": {
          "links": {
            "related": null
          }
        }
      }
    }
  ],
  "links": {
    "self": "api/boomerang/emails?filter%5Border_id%5D=440ea58c-01a4-4aea-b64d-6f33ac7a5e00&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/emails?filter%5Border_id%5D=440ea58c-01a4-4aea-b64d-6f33ac7a5e00&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/emails?filter%5Border_id%5D=440ea58c-01a4-4aea-b64d-6f33ac7a5e00&page%5Bnumber%5D=1&page%5Bsize%5D=25"
  },
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/emails`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=order,customer,email_template`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[emails]=id,created_at,updated_at`
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-12-30T11:20:24Z`
`sort` | **String**<br>How to sort the data `?sort=-created_at`
`meta` | **Hash**<br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String**<br>The page to request
`page[size]` | **String**<br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
`id` | **Uuid**<br>`eq`, `not_eq`
`created_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`order_id` | **Uuid**<br>`eq`, `not_eq`
`customer_id` | **Uuid**<br>`eq`, `not_eq`
`email_template_id` | **Uuid**<br>`eq`, `not_eq`
`employee_id` | **Uuid**<br>`eq`, `not_eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array**<br>`count`


### Includes

This request accepts the following includes:

`customer`


`order`






## Creating and sending an email



> How to create and send an email:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/emails' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "emails",
        "attributes": {
          "recipients": "customer1@example.com,customer2@example.com",
          "subject": "Order confirmation",
          "body": "Hi {{customer.name}}",
          "email_template_id": "46aab192-cefe-4d55-92ee-158c558f2ee1",
          "order_id": "cbe3ad32-feb1-484e-a5bd-9d52d5c34d8a",
          "customer_id": "794b79fc-7f69-4a5c-a873-dd31a423e428",
          "document_ids": [
            "61b6289f-d172-41b0-81c4-f3c5f4a21a1f"
          ]
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "7c27ba41-cf85-434f-80e5-6288b70b1e99",
    "type": "emails",
    "attributes": {
      "created_at": "2021-12-30T11:21:34+00:00",
      "updated_at": "2021-12-30T11:21:34+00:00",
      "subject": "Order confirmation",
      "body": "Hi {{customer.name}}",
      "recipients": "customer1@example.com,customer2@example.com",
      "document_ids": [
        "61b6289f-d172-41b0-81c4-f3c5f4a21a1f"
      ],
      "order_id": "cbe3ad32-feb1-484e-a5bd-9d52d5c34d8a",
      "customer_id": "794b79fc-7f69-4a5c-a873-dd31a423e428",
      "email_template_id": "46aab192-cefe-4d55-92ee-158c558f2ee1",
      "employee_id": "4cfa2d30-9a09-4c12-b11b-68440f1aabd0"
    },
    "relationships": {
      "order": {
        "meta": {
          "included": false
        }
      },
      "customer": {
        "meta": {
          "included": false
        }
      },
      "email_template": {
        "meta": {
          "included": false
        }
      },
      "employee": {
        "meta": {
          "included": false
        }
      }
    }
  },
  "links": {
    "self": "api/boomerang/emails?data%5Battributes%5D%5Bbody%5D=Hi+%7B%7Bcustomer.name%7D%7D&data%5Battributes%5D%5Bcustomer_id%5D=794b79fc-7f69-4a5c-a873-dd31a423e428&data%5Battributes%5D%5Bdocument_ids%5D%5B%5D=61b6289f-d172-41b0-81c4-f3c5f4a21a1f&data%5Battributes%5D%5Bemail_template_id%5D=46aab192-cefe-4d55-92ee-158c558f2ee1&data%5Battributes%5D%5Border_id%5D=cbe3ad32-feb1-484e-a5bd-9d52d5c34d8a&data%5Battributes%5D%5Brecipients%5D=customer1%40example.com%2Ccustomer2%40example.com&data%5Battributes%5D%5Bsubject%5D=Order+confirmation&data%5Btype%5D=emails&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/emails?data%5Battributes%5D%5Bbody%5D=Hi+%7B%7Bcustomer.name%7D%7D&data%5Battributes%5D%5Bcustomer_id%5D=794b79fc-7f69-4a5c-a873-dd31a423e428&data%5Battributes%5D%5Bdocument_ids%5D%5B%5D=61b6289f-d172-41b0-81c4-f3c5f4a21a1f&data%5Battributes%5D%5Bemail_template_id%5D=46aab192-cefe-4d55-92ee-158c558f2ee1&data%5Battributes%5D%5Border_id%5D=cbe3ad32-feb1-484e-a5bd-9d52d5c34d8a&data%5Battributes%5D%5Brecipients%5D=customer1%40example.com%2Ccustomer2%40example.com&data%5Battributes%5D%5Bsubject%5D=Order+confirmation&data%5Btype%5D=emails&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/emails?data%5Battributes%5D%5Bbody%5D=Hi+%7B%7Bcustomer.name%7D%7D&data%5Battributes%5D%5Bcustomer_id%5D=794b79fc-7f69-4a5c-a873-dd31a423e428&data%5Battributes%5D%5Bdocument_ids%5D%5B%5D=61b6289f-d172-41b0-81c4-f3c5f4a21a1f&data%5Battributes%5D%5Bemail_template_id%5D=46aab192-cefe-4d55-92ee-158c558f2ee1&data%5Battributes%5D%5Border_id%5D=cbe3ad32-feb1-484e-a5bd-9d52d5c34d8a&data%5Battributes%5D%5Brecipients%5D=customer1%40example.com%2Ccustomer2%40example.com&data%5Battributes%5D%5Bsubject%5D=Order+confirmation&data%5Btype%5D=emails&page%5Bnumber%5D=1&page%5Bsize%5D=25"
  },
  "meta": {}
}
```

### HTTP Request

`POST /api/boomerang/emails`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=order,customer,email_template`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[emails]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][subject]` | **String**<br>Email subject
`data[attributes][body]` | **String**<br>Email body
`data[attributes][recipients]` | **String**<br>Comma seperated list of recipient email addresses, all addresses must be valid for the email to send.
`data[attributes][document_ids][]` | **Array**<br>Documents to send as attachments to the email
`data[attributes][order_id]` | **Uuid**<br>The associated Order
`data[attributes][customer_id]` | **Uuid**<br>The associated Customer
`data[attributes][email_template_id]` | **Uuid**<br>The associated Email template


### Includes

This request accepts the following includes:

`customer`


`order`


`email_template`





