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
      "id": "8af369f7-6e44-46e3-b244-26f532d18279",
      "type": "emails",
      "attributes": {
        "created_at": "2023-02-01T13:00:01+00:00",
        "updated_at": "2023-02-01T13:00:01+00:00",
        "subject": "Order confirmation",
        "body": "We hereby confirm your order with number #123",
        "recipients": "jon@doe.com",
        "document_ids": [],
        "order_id": null,
        "customer_id": "53474ffd-8139-4aec-96da-e5a859729185",
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
            "related": "api/boomerang/customers/53474ffd-8139-4aec-96da-e5a859729185"
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
    --url 'https://example.booqable.com/api/boomerang/emails?filter%5Border_id%5D=4dd1fe48-5fe4-4992-953c-76a198e5610c' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "049bc73d-ba7b-4dbf-b5b0-4fa0d5869e02",
      "type": "emails",
      "attributes": {
        "created_at": "2023-02-01T13:00:01+00:00",
        "updated_at": "2023-02-01T13:00:01+00:00",
        "subject": "Order confirmation",
        "body": "We hereby confirm your order with number #123",
        "recipients": "jon@doe.com",
        "document_ids": [],
        "order_id": "4dd1fe48-5fe4-4992-953c-76a198e5610c",
        "customer_id": "afa171cc-73d5-4b00-90db-8fc6f2132c8c",
        "email_template_id": null,
        "employee_id": null
      },
      "relationships": {
        "order": {
          "links": {
            "related": "api/boomerang/orders/4dd1fe48-5fe4-4992-953c-76a198e5610c"
          }
        },
        "customer": {
          "links": {
            "related": "api/boomerang/customers/afa171cc-73d5-4b00-90db-8fc6f2132c8c"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-01T12:58:46Z`
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
          "email_template_id": "c3b356f9-56d5-46c7-bd31-4dc372aff069",
          "order_id": "224335a6-03a6-4f11-a7e9-b8ec732ea4eb",
          "customer_id": "52ea5daa-164a-477f-8982-b466ade215d9",
          "document_ids": [
            "d7b3b2ca-bd6c-4211-9701-e60eff67f029"
          ]
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "bfa5786c-7954-4891-91e0-cda1a8af24e5",
    "type": "emails",
    "attributes": {
      "created_at": "2023-02-01T13:00:02+00:00",
      "updated_at": "2023-02-01T13:00:02+00:00",
      "subject": "Order confirmation",
      "body": "Hi {{customer.name}}",
      "recipients": "customer1@example.com,customer2@example.com",
      "document_ids": [
        "d7b3b2ca-bd6c-4211-9701-e60eff67f029"
      ],
      "order_id": "224335a6-03a6-4f11-a7e9-b8ec732ea4eb",
      "customer_id": "52ea5daa-164a-477f-8982-b466ade215d9",
      "email_template_id": "c3b356f9-56d5-46c7-bd31-4dc372aff069",
      "employee_id": "5392e389-3aa2-4906-985d-12ac2f6954f3"
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





