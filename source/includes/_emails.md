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
      "id": "15c5da54-f8f7-450f-a8aa-41786694056b",
      "type": "emails",
      "attributes": {
        "subject": "Order confirmation",
        "body": "We hereby confirm your order with number #123",
        "recipients": "jon@doe.com",
        "document_ids": [],
        "order_id": null,
        "customer_id": "42fddd88-de39-4c42-a4e7-c85766f39ae0",
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
            "related": "api/boomerang/customers/42fddd88-de39-4c42-a4e7-c85766f39ae0"
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
    --url 'https://example.booqable.com/api/boomerang/emails?filter%5Border_id%5D=9861c4cc-b4aa-4063-9429-94b22ee58909' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "b00f698b-65c3-4dc0-8919-75799a90c31e",
      "type": "emails",
      "attributes": {
        "subject": "Order confirmation",
        "body": "We hereby confirm your order with number #123",
        "recipients": "jon@doe.com",
        "document_ids": [],
        "order_id": "9861c4cc-b4aa-4063-9429-94b22ee58909",
        "customer_id": "21870ba2-d380-4876-94ee-2d616a3d48fc",
        "email_template_id": null,
        "employee_id": null
      },
      "relationships": {
        "order": {
          "links": {
            "related": "api/boomerang/orders/9861c4cc-b4aa-4063-9429-94b22ee58909"
          }
        },
        "customer": {
          "links": {
            "related": "api/boomerang/customers/21870ba2-d380-4876-94ee-2d616a3d48fc"
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
    "self": "api/boomerang/emails?filter%5Border_id%5D=9861c4cc-b4aa-4063-9429-94b22ee58909&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/emails?filter%5Border_id%5D=9861c4cc-b4aa-4063-9429-94b22ee58909&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/emails?filter%5Border_id%5D=9861c4cc-b4aa-4063-9429-94b22ee58909&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-10-25T12:33:46Z`
`sort` | **String**<br>How to sort the data `?sort=-created_at`
`meta` | **Hash**<br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String**<br>The page to request
`page[per]` | **String**<br>The amount of items per page (max 100)


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
          "email_template_id": "2c593c5f-0c85-487b-9780-11f85e5c647d",
          "order_id": "b9017e7e-da63-4f33-b621-6ccfc4c2e7de",
          "customer_id": "2be3d8a9-33d6-499f-9219-70219179ad85",
          "document_ids": [
            "912cda74-052b-4cb0-806b-98027a5b2bd8"
          ]
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "6bccf8f5-8420-414a-9dd5-e5eb51da1e54",
    "type": "emails",
    "attributes": {
      "subject": "Order confirmation",
      "body": "Hi {{customer.name}}",
      "recipients": "customer1@example.com,customer2@example.com",
      "document_ids": [
        "912cda74-052b-4cb0-806b-98027a5b2bd8"
      ],
      "order_id": "b9017e7e-da63-4f33-b621-6ccfc4c2e7de",
      "customer_id": "2be3d8a9-33d6-499f-9219-70219179ad85",
      "email_template_id": "2c593c5f-0c85-487b-9780-11f85e5c647d",
      "employee_id": "2eadbedd-2c72-4266-89dd-2091ff8c24b1"
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
    "self": "api/boomerang/emails?data%5Battributes%5D%5Bbody%5D=Hi+%7B%7Bcustomer.name%7D%7D&data%5Battributes%5D%5Bcustomer_id%5D=2be3d8a9-33d6-499f-9219-70219179ad85&data%5Battributes%5D%5Bdocument_ids%5D%5B%5D=912cda74-052b-4cb0-806b-98027a5b2bd8&data%5Battributes%5D%5Bemail_template_id%5D=2c593c5f-0c85-487b-9780-11f85e5c647d&data%5Battributes%5D%5Border_id%5D=b9017e7e-da63-4f33-b621-6ccfc4c2e7de&data%5Battributes%5D%5Brecipients%5D=customer1%40example.com%2Ccustomer2%40example.com&data%5Battributes%5D%5Bsubject%5D=Order+confirmation&data%5Btype%5D=emails&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/emails?data%5Battributes%5D%5Bbody%5D=Hi+%7B%7Bcustomer.name%7D%7D&data%5Battributes%5D%5Bcustomer_id%5D=2be3d8a9-33d6-499f-9219-70219179ad85&data%5Battributes%5D%5Bdocument_ids%5D%5B%5D=912cda74-052b-4cb0-806b-98027a5b2bd8&data%5Battributes%5D%5Bemail_template_id%5D=2c593c5f-0c85-487b-9780-11f85e5c647d&data%5Battributes%5D%5Border_id%5D=b9017e7e-da63-4f33-b621-6ccfc4c2e7de&data%5Battributes%5D%5Brecipients%5D=customer1%40example.com%2Ccustomer2%40example.com&data%5Battributes%5D%5Bsubject%5D=Order+confirmation&data%5Btype%5D=emails&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/emails?data%5Battributes%5D%5Bbody%5D=Hi+%7B%7Bcustomer.name%7D%7D&data%5Battributes%5D%5Bcustomer_id%5D=2be3d8a9-33d6-499f-9219-70219179ad85&data%5Battributes%5D%5Bdocument_ids%5D%5B%5D=912cda74-052b-4cb0-806b-98027a5b2bd8&data%5Battributes%5D%5Bemail_template_id%5D=2c593c5f-0c85-487b-9780-11f85e5c647d&data%5Battributes%5D%5Border_id%5D=b9017e7e-da63-4f33-b621-6ccfc4c2e7de&data%5Battributes%5D%5Brecipients%5D=customer1%40example.com%2Ccustomer2%40example.com&data%5Battributes%5D%5Bsubject%5D=Order+confirmation&data%5Btype%5D=emails&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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





