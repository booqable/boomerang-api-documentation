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
      "id": "8fd07145-846c-4d4b-becd-cd6b12c6635a",
      "type": "emails",
      "attributes": {
        "created_at": "2022-01-10T13:51:02+00:00",
        "updated_at": "2022-01-10T13:51:02+00:00",
        "subject": "Order confirmation",
        "body": "We hereby confirm your order with number #123",
        "recipients": "jon@doe.com",
        "document_ids": [],
        "order_id": null,
        "customer_id": "160e9c12-a371-4686-81e2-3abdde24c4d6",
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
            "related": "api/boomerang/customers/160e9c12-a371-4686-81e2-3abdde24c4d6"
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
    --url 'https://example.booqable.com/api/boomerang/emails?filter%5Border_id%5D=871be0a0-b9fa-45f6-b807-fc5459f8e8e8' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "0a5bb073-9846-42e6-8067-663b65b9e31e",
      "type": "emails",
      "attributes": {
        "created_at": "2022-01-10T13:51:02+00:00",
        "updated_at": "2022-01-10T13:51:02+00:00",
        "subject": "Order confirmation",
        "body": "We hereby confirm your order with number #123",
        "recipients": "jon@doe.com",
        "document_ids": [],
        "order_id": "871be0a0-b9fa-45f6-b807-fc5459f8e8e8",
        "customer_id": "c56d3a27-a887-469a-8141-a1c7b7e33d93",
        "email_template_id": null,
        "employee_id": null
      },
      "relationships": {
        "order": {
          "links": {
            "related": "api/boomerang/orders/871be0a0-b9fa-45f6-b807-fc5459f8e8e8"
          }
        },
        "customer": {
          "links": {
            "related": "api/boomerang/customers/c56d3a27-a887-469a-8141-a1c7b7e33d93"
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
    "self": "api/boomerang/emails?filter%5Border_id%5D=871be0a0-b9fa-45f6-b807-fc5459f8e8e8&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/emails?filter%5Border_id%5D=871be0a0-b9fa-45f6-b807-fc5459f8e8e8&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/emails?filter%5Border_id%5D=871be0a0-b9fa-45f6-b807-fc5459f8e8e8&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-01-10T13:49:50Z`
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
          "email_template_id": "b10e025c-d661-44e3-8a3c-725168c9b199",
          "order_id": "7cd2611e-0836-4b1e-aabf-4ca65122aae9",
          "customer_id": "9f921ffe-7c7c-4f90-b2d3-fc1febaf7648",
          "document_ids": [
            "ce143ea2-ae29-4724-bb7c-c8b897990aef"
          ]
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "6ea8b19c-1d50-4098-8eb3-908ecc663702",
    "type": "emails",
    "attributes": {
      "created_at": "2022-01-10T13:51:03+00:00",
      "updated_at": "2022-01-10T13:51:03+00:00",
      "subject": "Order confirmation",
      "body": "Hi {{customer.name}}",
      "recipients": "customer1@example.com,customer2@example.com",
      "document_ids": [
        "ce143ea2-ae29-4724-bb7c-c8b897990aef"
      ],
      "order_id": "7cd2611e-0836-4b1e-aabf-4ca65122aae9",
      "customer_id": "9f921ffe-7c7c-4f90-b2d3-fc1febaf7648",
      "email_template_id": "b10e025c-d661-44e3-8a3c-725168c9b199",
      "employee_id": "60e86e66-3d77-441f-b1ec-35030e2cecba"
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
    "self": "api/boomerang/emails?data%5Battributes%5D%5Bbody%5D=Hi+%7B%7Bcustomer.name%7D%7D&data%5Battributes%5D%5Bcustomer_id%5D=9f921ffe-7c7c-4f90-b2d3-fc1febaf7648&data%5Battributes%5D%5Bdocument_ids%5D%5B%5D=ce143ea2-ae29-4724-bb7c-c8b897990aef&data%5Battributes%5D%5Bemail_template_id%5D=b10e025c-d661-44e3-8a3c-725168c9b199&data%5Battributes%5D%5Border_id%5D=7cd2611e-0836-4b1e-aabf-4ca65122aae9&data%5Battributes%5D%5Brecipients%5D=customer1%40example.com%2Ccustomer2%40example.com&data%5Battributes%5D%5Bsubject%5D=Order+confirmation&data%5Btype%5D=emails&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/emails?data%5Battributes%5D%5Bbody%5D=Hi+%7B%7Bcustomer.name%7D%7D&data%5Battributes%5D%5Bcustomer_id%5D=9f921ffe-7c7c-4f90-b2d3-fc1febaf7648&data%5Battributes%5D%5Bdocument_ids%5D%5B%5D=ce143ea2-ae29-4724-bb7c-c8b897990aef&data%5Battributes%5D%5Bemail_template_id%5D=b10e025c-d661-44e3-8a3c-725168c9b199&data%5Battributes%5D%5Border_id%5D=7cd2611e-0836-4b1e-aabf-4ca65122aae9&data%5Battributes%5D%5Brecipients%5D=customer1%40example.com%2Ccustomer2%40example.com&data%5Battributes%5D%5Bsubject%5D=Order+confirmation&data%5Btype%5D=emails&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/emails?data%5Battributes%5D%5Bbody%5D=Hi+%7B%7Bcustomer.name%7D%7D&data%5Battributes%5D%5Bcustomer_id%5D=9f921ffe-7c7c-4f90-b2d3-fc1febaf7648&data%5Battributes%5D%5Bdocument_ids%5D%5B%5D=ce143ea2-ae29-4724-bb7c-c8b897990aef&data%5Battributes%5D%5Bemail_template_id%5D=b10e025c-d661-44e3-8a3c-725168c9b199&data%5Battributes%5D%5Border_id%5D=7cd2611e-0836-4b1e-aabf-4ca65122aae9&data%5Battributes%5D%5Brecipients%5D=customer1%40example.com%2Ccustomer2%40example.com&data%5Battributes%5D%5Bsubject%5D=Order+confirmation&data%5Btype%5D=emails&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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





