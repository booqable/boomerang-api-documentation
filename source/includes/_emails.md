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
      "id": "e3d80fef-198a-44e9-b610-1f45c93e14b9",
      "type": "emails",
      "attributes": {
        "created_at": "2023-01-25T12:35:06+00:00",
        "updated_at": "2023-01-25T12:35:06+00:00",
        "subject": "Order confirmation",
        "body": "We hereby confirm your order with number #123",
        "recipients": "jon@doe.com",
        "document_ids": [],
        "order_id": null,
        "customer_id": "dd2baa77-9c12-4c91-a499-dd16213024b9",
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
            "related": "api/boomerang/customers/dd2baa77-9c12-4c91-a499-dd16213024b9"
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
    --url 'https://example.booqable.com/api/boomerang/emails?filter%5Border_id%5D=78496572-b92c-444a-97d2-9efc663836e5' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "b014be16-dabe-4071-a602-9de18a6d4ce2",
      "type": "emails",
      "attributes": {
        "created_at": "2023-01-25T12:35:07+00:00",
        "updated_at": "2023-01-25T12:35:08+00:00",
        "subject": "Order confirmation",
        "body": "We hereby confirm your order with number #123",
        "recipients": "jon@doe.com",
        "document_ids": [],
        "order_id": "78496572-b92c-444a-97d2-9efc663836e5",
        "customer_id": "3677dd7d-c2ea-41a0-a471-2a47781e8e72",
        "email_template_id": null,
        "employee_id": null
      },
      "relationships": {
        "order": {
          "links": {
            "related": "api/boomerang/orders/78496572-b92c-444a-97d2-9efc663836e5"
          }
        },
        "customer": {
          "links": {
            "related": "api/boomerang/customers/3677dd7d-c2ea-41a0-a471-2a47781e8e72"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-01-25T12:33:37Z`
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
          "email_template_id": "1ed0ede0-7151-4055-942f-49bd8f6fec2f",
          "order_id": "9e96d37f-9e43-4337-abbe-ceb9e0693da3",
          "customer_id": "b55dafc1-0d53-4250-b001-5f51a076d3a3",
          "document_ids": [
            "2eda324d-1908-4375-8e6f-69e6afbab720"
          ]
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "34535b87-3225-4ce0-af50-4ecb9ef47299",
    "type": "emails",
    "attributes": {
      "created_at": "2023-01-25T12:35:08+00:00",
      "updated_at": "2023-01-25T12:35:08+00:00",
      "subject": "Order confirmation",
      "body": "Hi {{customer.name}}",
      "recipients": "customer1@example.com,customer2@example.com",
      "document_ids": [
        "2eda324d-1908-4375-8e6f-69e6afbab720"
      ],
      "order_id": "9e96d37f-9e43-4337-abbe-ceb9e0693da3",
      "customer_id": "b55dafc1-0d53-4250-b001-5f51a076d3a3",
      "email_template_id": "1ed0ede0-7151-4055-942f-49bd8f6fec2f",
      "employee_id": "707d2ce7-657f-4d18-9ee8-82a21fc5ce3d"
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





