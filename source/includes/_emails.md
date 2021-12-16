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
      "id": "7c7a6890-58f6-423d-b9a2-091af4fdeb21",
      "type": "emails",
      "attributes": {
        "created_at": "2021-12-16T09:38:29+00:00",
        "updated_at": "2021-12-16T09:38:29+00:00",
        "subject": "Order confirmation",
        "body": "We hereby confirm your order with number #123",
        "recipients": "jon@doe.com",
        "document_ids": [],
        "order_id": null,
        "customer_id": "66ac79e5-cade-4bf1-b49d-8e3d12498b2c",
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
            "related": "api/boomerang/customers/66ac79e5-cade-4bf1-b49d-8e3d12498b2c"
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
    --url 'https://example.booqable.com/api/boomerang/emails?filter%5Border_id%5D=4d314276-201e-478a-8946-70b089b0a2b3' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "02d946fd-cca5-4433-9475-6616d2afcd0b",
      "type": "emails",
      "attributes": {
        "created_at": "2021-12-16T09:38:29+00:00",
        "updated_at": "2021-12-16T09:38:29+00:00",
        "subject": "Order confirmation",
        "body": "We hereby confirm your order with number #123",
        "recipients": "jon@doe.com",
        "document_ids": [],
        "order_id": "4d314276-201e-478a-8946-70b089b0a2b3",
        "customer_id": "35a713bb-f4e8-4ae1-a065-23722126e68c",
        "email_template_id": null,
        "employee_id": null
      },
      "relationships": {
        "order": {
          "links": {
            "related": "api/boomerang/orders/4d314276-201e-478a-8946-70b089b0a2b3"
          }
        },
        "customer": {
          "links": {
            "related": "api/boomerang/customers/35a713bb-f4e8-4ae1-a065-23722126e68c"
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
    "self": "api/boomerang/emails?filter%5Border_id%5D=4d314276-201e-478a-8946-70b089b0a2b3&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/emails?filter%5Border_id%5D=4d314276-201e-478a-8946-70b089b0a2b3&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/emails?filter%5Border_id%5D=4d314276-201e-478a-8946-70b089b0a2b3&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-12-16T09:37:45Z`
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
          "email_template_id": "1524e4e2-c82a-43da-a9ac-948422cbb6f4",
          "order_id": "4ea9704b-9be1-4516-aaa4-20fa2680c80b",
          "customer_id": "06ccab93-9883-47af-bea4-1107acc90061",
          "document_ids": [
            "de0efaa5-bdd5-4f38-a2bf-f1a65d28c544"
          ]
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "be109519-ebcc-4904-aa22-451e08d5eb66",
    "type": "emails",
    "attributes": {
      "created_at": "2021-12-16T09:38:30+00:00",
      "updated_at": "2021-12-16T09:38:30+00:00",
      "subject": "Order confirmation",
      "body": "Hi {{customer.name}}",
      "recipients": "customer1@example.com,customer2@example.com",
      "document_ids": [
        "de0efaa5-bdd5-4f38-a2bf-f1a65d28c544"
      ],
      "order_id": "4ea9704b-9be1-4516-aaa4-20fa2680c80b",
      "customer_id": "06ccab93-9883-47af-bea4-1107acc90061",
      "email_template_id": "1524e4e2-c82a-43da-a9ac-948422cbb6f4",
      "employee_id": "9902cd41-70a7-43fa-a437-42487fd75318"
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
    "self": "api/boomerang/emails?data%5Battributes%5D%5Bbody%5D=Hi+%7B%7Bcustomer.name%7D%7D&data%5Battributes%5D%5Bcustomer_id%5D=06ccab93-9883-47af-bea4-1107acc90061&data%5Battributes%5D%5Bdocument_ids%5D%5B%5D=de0efaa5-bdd5-4f38-a2bf-f1a65d28c544&data%5Battributes%5D%5Bemail_template_id%5D=1524e4e2-c82a-43da-a9ac-948422cbb6f4&data%5Battributes%5D%5Border_id%5D=4ea9704b-9be1-4516-aaa4-20fa2680c80b&data%5Battributes%5D%5Brecipients%5D=customer1%40example.com%2Ccustomer2%40example.com&data%5Battributes%5D%5Bsubject%5D=Order+confirmation&data%5Btype%5D=emails&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/emails?data%5Battributes%5D%5Bbody%5D=Hi+%7B%7Bcustomer.name%7D%7D&data%5Battributes%5D%5Bcustomer_id%5D=06ccab93-9883-47af-bea4-1107acc90061&data%5Battributes%5D%5Bdocument_ids%5D%5B%5D=de0efaa5-bdd5-4f38-a2bf-f1a65d28c544&data%5Battributes%5D%5Bemail_template_id%5D=1524e4e2-c82a-43da-a9ac-948422cbb6f4&data%5Battributes%5D%5Border_id%5D=4ea9704b-9be1-4516-aaa4-20fa2680c80b&data%5Battributes%5D%5Brecipients%5D=customer1%40example.com%2Ccustomer2%40example.com&data%5Battributes%5D%5Bsubject%5D=Order+confirmation&data%5Btype%5D=emails&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/emails?data%5Battributes%5D%5Bbody%5D=Hi+%7B%7Bcustomer.name%7D%7D&data%5Battributes%5D%5Bcustomer_id%5D=06ccab93-9883-47af-bea4-1107acc90061&data%5Battributes%5D%5Bdocument_ids%5D%5B%5D=de0efaa5-bdd5-4f38-a2bf-f1a65d28c544&data%5Battributes%5D%5Bemail_template_id%5D=1524e4e2-c82a-43da-a9ac-948422cbb6f4&data%5Battributes%5D%5Border_id%5D=4ea9704b-9be1-4516-aaa4-20fa2680c80b&data%5Battributes%5D%5Brecipients%5D=customer1%40example.com%2Ccustomer2%40example.com&data%5Battributes%5D%5Bsubject%5D=Order+confirmation&data%5Btype%5D=emails&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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





