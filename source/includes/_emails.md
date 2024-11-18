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
      "id": "83bc50bb-d429-418a-b9cd-36157e0cadcf",
      "type": "emails",
      "attributes": {
        "created_at": "2024-11-18T09:24:36.598633+00:00",
        "updated_at": "2024-11-18T09:24:36.598633+00:00",
        "subject": "Order confirmation",
        "body": "We hereby confirm your order with number #123",
        "recipients": "jon@doe.com",
        "has_error": false,
        "sent": false,
        "document_ids": [],
        "order_id": null,
        "customer_id": "8e6aa32d-1435-4a70-bbef-501228f00bd0",
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
    --url 'https://example.booqable.com/api/boomerang/emails?filter%5Border_id%5D=7842da1b-991d-4c37-aae7-6a520653c9a6' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "8788daef-9728-4ff7-9486-a9210f1fb1ba",
      "type": "emails",
      "attributes": {
        "created_at": "2024-11-18T09:24:36.012151+00:00",
        "updated_at": "2024-11-18T09:24:36.069583+00:00",
        "subject": "Order confirmation",
        "body": "We hereby confirm your order with number #123",
        "recipients": "jon@doe.com",
        "has_error": false,
        "sent": false,
        "document_ids": [],
        "order_id": "7842da1b-991d-4c37-aae7-6a520653c9a6",
        "customer_id": "647bc1a0-2617-451e-885b-c295065bc207",
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
          "email_template_id": "dc972425-c1d6-4ebf-b82d-c7fe8a5218ce",
          "order_id": "f46d4ab2-fbfe-4792-b97e-62738d1abb94",
          "customer_id": "1e1ade55-39c2-4f3f-b47e-b5c597320262",
          "document_ids": [
            "f543d51d-4ef0-49d8-9ae0-f1571fd9169b"
          ]
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "f3ef879c-d1ce-4fe9-85bb-a6958e301f2f",
    "type": "emails",
    "attributes": {
      "created_at": "2024-11-18T09:24:37.344876+00:00",
      "updated_at": "2024-11-18T09:24:37.344876+00:00",
      "subject": "Order confirmation",
      "body": "Hi {{customer.name}}",
      "recipients": "customer1@example.com,customer2@example.com",
      "has_error": false,
      "sent": false,
      "document_ids": [
        "f543d51d-4ef0-49d8-9ae0-f1571fd9169b"
      ],
      "order_id": "f46d4ab2-fbfe-4792-b97e-62738d1abb94",
      "customer_id": "1e1ade55-39c2-4f3f-b47e-b5c597320262",
      "email_template_id": "dc972425-c1d6-4ebf-b82d-c7fe8a5218ce",
      "employee_id": "0489674e-9a2b-4185-a060-c780a3dd7df2"
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





