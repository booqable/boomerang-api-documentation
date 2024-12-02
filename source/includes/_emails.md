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
`order_id` | **Uuid** `readonly-after-create`<br>Order the email is associated with, will be used to fill template data
`customer_id` | **Uuid** `readonly-after-create`<br>Customer the email is associated with, will be used to fill template data
`email_template_id` | **Uuid** `readonly-after-create`<br>Which email template to use
`employee_id` | **Uuid** `readonly`<br>Employee who sent the email


## Relationships
Emails have the following relationships:

Name | Description
-- | --
`customer` | **[Customer](#customers)** <br>Associated Customer
`email_template` | **[Email template](#email-templates)** <br>Associated Email template
`employee` | **[Employee](#employees)** <br>Associated Employee
`order` | **[Order](#orders)** <br>Associated Order


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
      "id": "9a456d03-2fdf-44d3-99b7-e7cf5080fb18",
      "type": "emails",
      "attributes": {
        "created_at": "2024-12-02T09:24:50.908477+00:00",
        "updated_at": "2024-12-02T09:24:50.908477+00:00",
        "subject": "Order confirmation",
        "body": "We hereby confirm your order with number #123",
        "recipients": "jon@doe.com",
        "has_error": false,
        "sent": false,
        "document_ids": [],
        "order_id": null,
        "customer_id": "208b781f-d8bf-42a5-9636-572d5803d7d8",
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
    --url 'https://example.booqable.com/api/boomerang/emails?filter%5Border_id%5D=91e54734-552a-4c1a-a1b7-e366f8418b68' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "212ebf19-a01e-4c22-b546-6b5c5a45ad4b",
      "type": "emails",
      "attributes": {
        "created_at": "2024-12-02T09:24:51.352812+00:00",
        "updated_at": "2024-12-02T09:24:51.381300+00:00",
        "subject": "Order confirmation",
        "body": "We hereby confirm your order with number #123",
        "recipients": "jon@doe.com",
        "has_error": false,
        "sent": false,
        "document_ids": [],
        "order_id": "91e54734-552a-4c1a-a1b7-e366f8418b68",
        "customer_id": "13f5e89e-d320-4167-8295-e0be4106082b",
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
          "email_template_id": "05ea6cd2-fc74-4cb3-8bd3-9c22d1146131",
          "order_id": "aacf9fd2-7d7c-4e17-bdad-514046b03025",
          "customer_id": "5a2a8db3-7921-414d-b0c0-b81f20ddd5ae",
          "document_ids": [
            "ac3e5fa4-84c8-4434-893e-db61b5c05ed3"
          ]
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "f731f557-c09e-4634-8235-3e3d37c0e156",
    "type": "emails",
    "attributes": {
      "created_at": "2024-12-02T09:24:52.008898+00:00",
      "updated_at": "2024-12-02T09:24:52.008898+00:00",
      "subject": "Order confirmation",
      "body": "Hi {{customer.name}}",
      "recipients": "customer1@example.com,customer2@example.com",
      "has_error": false,
      "sent": false,
      "document_ids": [
        "ac3e5fa4-84c8-4434-893e-db61b5c05ed3"
      ],
      "order_id": "aacf9fd2-7d7c-4e17-bdad-514046b03025",
      "customer_id": "5a2a8db3-7921-414d-b0c0-b81f20ddd5ae",
      "email_template_id": "05ea6cd2-fc74-4cb3-8bd3-9c22d1146131",
      "employee_id": "cb3e21d8-053f-4336-9cec-d7bf9fb52327"
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





