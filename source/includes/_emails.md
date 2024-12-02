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
      "id": "57108f1b-c258-4d72-982b-29e04958128b",
      "type": "emails",
      "attributes": {
        "created_at": "2024-12-02T13:01:17.035201+00:00",
        "updated_at": "2024-12-02T13:01:17.035201+00:00",
        "subject": "Order confirmation",
        "body": "We hereby confirm your order with number #123",
        "recipients": "jon@doe.com",
        "has_error": false,
        "sent": false,
        "document_ids": [],
        "order_id": null,
        "customer_id": "3fca858c-a558-4744-8dfa-86edb31d1b25",
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
    --url 'https://example.booqable.com/api/boomerang/emails?filter%5Border_id%5D=a4901100-a6ff-4bb9-b0c3-2c8c3d375f44' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "dd774093-7930-4630-aceb-a65197d05c05",
      "type": "emails",
      "attributes": {
        "created_at": "2024-12-02T13:01:17.996320+00:00",
        "updated_at": "2024-12-02T13:01:18.052627+00:00",
        "subject": "Order confirmation",
        "body": "We hereby confirm your order with number #123",
        "recipients": "jon@doe.com",
        "has_error": false,
        "sent": false,
        "document_ids": [],
        "order_id": "a4901100-a6ff-4bb9-b0c3-2c8c3d375f44",
        "customer_id": "bb93c723-0469-4e01-89c8-5f09641f25c8",
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
          "email_template_id": "c51f8228-e99a-4b04-809a-3e90fba3c126",
          "order_id": "7f35a9d4-8bd5-4045-929a-76299e064a19",
          "customer_id": "36895cf0-b2f2-4fca-9408-f72e0439e217",
          "document_ids": [
            "58dfabfa-0dd9-40fa-b7a0-a9436de3826a"
          ]
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "f9f71582-4243-441f-a469-70641628db53",
    "type": "emails",
    "attributes": {
      "created_at": "2024-12-02T13:01:07.450189+00:00",
      "updated_at": "2024-12-02T13:01:07.450189+00:00",
      "subject": "Order confirmation",
      "body": "Hi {{customer.name}}",
      "recipients": "customer1@example.com,customer2@example.com",
      "has_error": false,
      "sent": false,
      "document_ids": [
        "58dfabfa-0dd9-40fa-b7a0-a9436de3826a"
      ],
      "order_id": "7f35a9d4-8bd5-4045-929a-76299e064a19",
      "customer_id": "36895cf0-b2f2-4fca-9408-f72e0439e217",
      "email_template_id": "c51f8228-e99a-4b04-809a-3e90fba3c126",
      "employee_id": "4e62b0c4-821e-4e00-93d1-7f89de5a95f6"
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





