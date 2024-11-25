# Emails

Emails allow you to easily communicate with your customers by using optional templates. Booqable keeps a history of e-mail being sent for orders or customers.

## Endpoints
`GET /api/boomerang/emails`

`POST /api/boomerang/emails`

## Fields
Every email has the following fields:

Name | Description
-- | --
`id` | **Uuid** `readonly`<br>Primary key
`created_at` | **Datetime** `readonly`<br>When the email was created by the user, or automatically by Booqable. At this time, the email has not been sent yet.
`updated_at` | **Datetime** `readonly`<br>The last time the email was updated. Typically this is updated after a delivery attempt has failed.
`subject` | **String** <br>Email subject
`body` | **String** <br>Email body
`recipients` | **String** <br>Comma seperated list of recipient email addresses, all addresses must be valid for the email to send.
`has_error` | **Boolean** `readonly`<br>Whether any errors occur when sending this email
`sent` | **Boolean** `readonly`<br>Whether the email was sent successfully
`document_ids` | **Array** <br>Documents to send as attachments to the email
`order_id` | **Uuid** <br>Order the email is associated with, will be used to fill template data
`customer_id` | **Uuid** <br>Customer the email is associated with, will be used to fill template data
`email_template_id` | **Uuid** <br>Which email template to use
`employee_id` | **Uuid** `readonly`<br>Employee who sent the email


## Relationships
Emails have the following relationships:

Name | Description
-- | --
`customer` | **Customers** `readonly`<br>Associated Customer
`email_template` | **Email templates** `readonly`<br>Associated Email template
`employee` | **Employees** `readonly`<br>Associated Employee
`order` | **Orders** `readonly`<br>Associated Order


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
      "id": "3b2ecbc4-18fa-4b7a-b261-f6323cb4841c",
      "type": "emails",
      "attributes": {
        "created_at": "2024-11-25T09:26:06.885844+00:00",
        "updated_at": "2024-11-25T09:26:06.885844+00:00",
        "subject": "Order confirmation",
        "body": "We hereby confirm your order with number #123",
        "recipients": "jon@doe.com",
        "has_error": false,
        "sent": false,
        "document_ids": [],
        "order_id": null,
        "customer_id": "6029b7d7-981c-436e-b963-c83e0d423556",
        "email_template_id": null,
        "employee_id": null
      },
      "relationships": {}
    }
  ],
  "meta": {}
}
```


> How to fetch a list of emails for a specific order:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/emails?filter%5Border_id%5D=7b053bdf-3759-4bfe-985e-90eea1ce948c' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "75efafd4-f9fd-449a-98a6-719cee9e8f8a",
      "type": "emails",
      "attributes": {
        "created_at": "2024-11-25T09:26:05.442643+00:00",
        "updated_at": "2024-11-25T09:26:05.488162+00:00",
        "subject": "Order confirmation",
        "body": "We hereby confirm your order with number #123",
        "recipients": "jon@doe.com",
        "has_error": false,
        "sent": false,
        "document_ids": [],
        "order_id": "7b053bdf-3759-4bfe-985e-90eea1ce948c",
        "customer_id": "ba578992-d8d9-4589-a97b-26ec70a5e85a",
        "email_template_id": null,
        "employee_id": null
      },
      "relationships": {}
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
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=customer,order`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[emails]=created_at,updated_at,subject`
`filter` | **Hash** <br>The filters to apply `?filter[attribute][eq]=value`
`sort` | **String** <br>How to sort the data `?sort=attribute1,-attribute2`
`meta` | **Hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String** <br>The page to request
`page[size]` | **String** <br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
-- | --
`id` | **Uuid** <br>`eq`, `not_eq`
`created_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`has_error` | **Boolean** <br>`eq`
`sent` | **Boolean** <br>`eq`
`order_id` | **Uuid** <br>`eq`, `not_eq`
`customer_id` | **Uuid** <br>`eq`, `not_eq`
`email_template_id` | **Uuid** <br>`eq`, `not_eq`
`employee_id` | **Uuid** <br>`eq`, `not_eq`


### Meta

Results can be aggregated on:

Name | Description
-- | --
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
          "email_template_id": "b1a45294-1ab8-4542-ae7e-fbe9fc11dc46",
          "order_id": "a9cff8fa-4762-4237-8432-a64faa4fadd9",
          "customer_id": "d39b7223-2589-4778-a945-df02f83000ae",
          "document_ids": [
            "0794e89a-195a-4563-89ac-1bc90af82124"
          ]
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "0e02491f-d38d-47a8-b340-5617f21634cf",
    "type": "emails",
    "attributes": {
      "created_at": "2024-11-25T09:25:54.461789+00:00",
      "updated_at": "2024-11-25T09:25:54.461789+00:00",
      "subject": "Order confirmation",
      "body": "Hi {{customer.name}}",
      "recipients": "customer1@example.com,customer2@example.com",
      "has_error": false,
      "sent": false,
      "document_ids": [
        "0794e89a-195a-4563-89ac-1bc90af82124"
      ],
      "order_id": "a9cff8fa-4762-4237-8432-a64faa4fadd9",
      "customer_id": "d39b7223-2589-4778-a945-df02f83000ae",
      "email_template_id": "b1a45294-1ab8-4542-ae7e-fbe9fc11dc46",
      "employee_id": "a6a40c01-4eca-4603-8d15-4b9c0b63afcd"
    },
    "relationships": {}
  },
  "meta": {}
}
```

### HTTP Request

`POST /api/boomerang/emails`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=customer,order,email_template`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[emails]=created_at,updated_at,subject`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][subject]` | **String** <br>Email subject
`data[attributes][body]` | **String** <br>Email body
`data[attributes][recipients]` | **String** <br>Comma seperated list of recipient email addresses, all addresses must be valid for the email to send.
`data[attributes][document_ids][]` | **Array** <br>Documents to send as attachments to the email
`data[attributes][order_id]` | **Uuid** <br>Order the email is associated with, will be used to fill template data
`data[attributes][customer_id]` | **Uuid** <br>Customer the email is associated with, will be used to fill template data
`data[attributes][email_template_id]` | **Uuid** <br>Which email template to use


### Includes

This request accepts the following includes:

`customer`


`order`


`email_template`





