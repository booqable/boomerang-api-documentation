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
`subject` | **String** <br>Email subject
`body` | **String** <br>Email body
`recipients` | **String** <br>Comma seperated list of recipient email addresses, all addresses must be valid for the email to send.
`document_ids` | **Array** <br>Documents to send as attachments to the email
`order_id` | **Uuid** <br>The associated Order
`customer_id` | **Uuid** <br>The associated Customer
`email_template_id` | **Uuid** <br>The associated Email template
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
      "id": "fbbc1416-b355-42d8-bff3-9acff285ff18",
      "type": "emails",
      "attributes": {
        "created_at": "2023-02-07T14:50:52+00:00",
        "updated_at": "2023-02-07T14:50:52+00:00",
        "subject": "Order confirmation",
        "body": "We hereby confirm your order with number #123",
        "recipients": "jon@doe.com",
        "document_ids": [],
        "order_id": null,
        "customer_id": "21823fee-e129-4515-97a4-fbea529e9b04",
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
            "related": "api/boomerang/customers/21823fee-e129-4515-97a4-fbea529e9b04"
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
  "meta": {}
}
```


> How to fetch a list of emails for a specific order:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/emails?filter%5Border_id%5D=48d0e574-56da-4394-a796-81742710ceb7' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "82f1a6bb-4514-44ad-8226-a69d35428415",
      "type": "emails",
      "attributes": {
        "created_at": "2023-02-07T14:50:53+00:00",
        "updated_at": "2023-02-07T14:50:53+00:00",
        "subject": "Order confirmation",
        "body": "We hereby confirm your order with number #123",
        "recipients": "jon@doe.com",
        "document_ids": [],
        "order_id": "48d0e574-56da-4394-a796-81742710ceb7",
        "customer_id": "c2b121dd-6b6b-43e5-a2b5-8859094a075e",
        "email_template_id": null,
        "employee_id": null
      },
      "relationships": {
        "order": {
          "links": {
            "related": "api/boomerang/orders/48d0e574-56da-4394-a796-81742710ceb7"
          }
        },
        "customer": {
          "links": {
            "related": "api/boomerang/customers/c2b121dd-6b6b-43e5-a2b5-8859094a075e"
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
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/emails`

### Request params

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=order,customer,email_template`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[emails]=id,created_at,updated_at`
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-07T14:49:43Z`
`sort` | **String** <br>How to sort the data `?sort=-created_at`
`meta` | **Hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String** <br>The page to request
`page[size]` | **String** <br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
`id` | **Uuid** <br>`eq`, `not_eq`
`created_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`order_id` | **Uuid** <br>`eq`, `not_eq`
`customer_id` | **Uuid** <br>`eq`, `not_eq`
`email_template_id` | **Uuid** <br>`eq`, `not_eq`
`employee_id` | **Uuid** <br>`eq`, `not_eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array** <br>`count`
`has_error` | **Array** <br>`count`


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
          "email_template_id": "a468fbdc-1712-473a-b7f3-9b0c39829a87",
          "order_id": "a854a588-8e38-491c-82a0-f56a39ef3975",
          "customer_id": "0bfc3e87-cac6-4e25-885e-33b414affb5d",
          "document_ids": [
            "a7dc9990-5256-41c6-9f60-005cd3919dd4"
          ]
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "7c5fd399-003d-4f45-90df-2f5656bd8a94",
    "type": "emails",
    "attributes": {
      "created_at": "2023-02-07T14:50:54+00:00",
      "updated_at": "2023-02-07T14:50:54+00:00",
      "subject": "Order confirmation",
      "body": "Hi {{customer.name}}",
      "recipients": "customer1@example.com,customer2@example.com",
      "document_ids": [
        "a7dc9990-5256-41c6-9f60-005cd3919dd4"
      ],
      "order_id": "a854a588-8e38-491c-82a0-f56a39ef3975",
      "customer_id": "0bfc3e87-cac6-4e25-885e-33b414affb5d",
      "email_template_id": "a468fbdc-1712-473a-b7f3-9b0c39829a87",
      "employee_id": "946ae82d-6727-4ba7-85e8-ca3e341f7aad"
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
  "meta": {}
}
```

### HTTP Request

`POST /api/boomerang/emails`

### Request params

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=order,customer,email_template`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[emails]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][subject]` | **String** <br>Email subject
`data[attributes][body]` | **String** <br>Email body
`data[attributes][recipients]` | **String** <br>Comma seperated list of recipient email addresses, all addresses must be valid for the email to send.
`data[attributes][document_ids][]` | **Array** <br>Documents to send as attachments to the email
`data[attributes][order_id]` | **Uuid** <br>The associated Order
`data[attributes][customer_id]` | **Uuid** <br>The associated Customer
`data[attributes][email_template_id]` | **Uuid** <br>The associated Email template


### Includes

This request accepts the following includes:

`customer`


`order`


`email_template`





