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
      "id": "25ffeb52-5e0a-4fb9-bbf6-7a2682524595",
      "type": "emails",
      "attributes": {
        "created_at": "2022-05-05T09:13:11+00:00",
        "updated_at": "2022-05-05T09:13:11+00:00",
        "subject": "Order confirmation",
        "body": "We hereby confirm your order with number #123",
        "recipients": "jon@doe.com",
        "document_ids": [],
        "order_id": null,
        "customer_id": "48c984e2-b5f4-4af4-a4f6-4594f51971ad",
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
            "related": "api/boomerang/customers/48c984e2-b5f4-4af4-a4f6-4594f51971ad"
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
    --url 'https://example.booqable.com/api/boomerang/emails?filter%5Border_id%5D=2395a5b0-bf5b-45b2-b0c3-c000ace3210a' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "7a8433bc-7baf-4f90-b928-01f479b93d96",
      "type": "emails",
      "attributes": {
        "created_at": "2022-05-05T09:13:11+00:00",
        "updated_at": "2022-05-05T09:13:11+00:00",
        "subject": "Order confirmation",
        "body": "We hereby confirm your order with number #123",
        "recipients": "jon@doe.com",
        "document_ids": [],
        "order_id": "2395a5b0-bf5b-45b2-b0c3-c000ace3210a",
        "customer_id": "201be010-0678-4c6c-8244-6c4a1c12903e",
        "email_template_id": null,
        "employee_id": null
      },
      "relationships": {
        "order": {
          "links": {
            "related": "api/boomerang/orders/2395a5b0-bf5b-45b2-b0c3-c000ace3210a"
          }
        },
        "customer": {
          "links": {
            "related": "api/boomerang/customers/201be010-0678-4c6c-8244-6c4a1c12903e"
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=order,customer,email_template`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[emails]=id,created_at,updated_at`
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-05-05T09:12:14Z`
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
          "email_template_id": "af1e8833-eced-4f33-a0e8-b5721285987d",
          "order_id": "b6b285c6-babd-46a3-985b-034430c5107f",
          "customer_id": "49c6c874-8451-4339-b2f2-7ade30ba175c",
          "document_ids": [
            "c0cef9cc-45c2-4da9-9f4f-62d5ddce60b9"
          ]
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "c316b23c-13f9-466a-894b-de6deabd41e1",
    "type": "emails",
    "attributes": {
      "created_at": "2022-05-05T09:13:12+00:00",
      "updated_at": "2022-05-05T09:13:12+00:00",
      "subject": "Order confirmation",
      "body": "Hi {{customer.name}}",
      "recipients": "customer1@example.com,customer2@example.com",
      "document_ids": [
        "c0cef9cc-45c2-4da9-9f4f-62d5ddce60b9"
      ],
      "order_id": "b6b285c6-babd-46a3-985b-034430c5107f",
      "customer_id": "49c6c874-8451-4339-b2f2-7ade30ba175c",
      "email_template_id": "af1e8833-eced-4f33-a0e8-b5721285987d",
      "employee_id": "e60c6801-df0f-4e39-952b-001e8441b6d5"
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





