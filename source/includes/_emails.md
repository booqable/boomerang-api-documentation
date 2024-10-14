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
`created_at` | **Datetime** `readonly`<br>When the resource was created
`updated_at` | **Datetime** `readonly`<br>When the resource was last updated
`subject` | **String** <br>Email subject
`body` | **String** <br>Email body
`recipients` | **String** <br>Comma seperated list of recipient email addresses, all addresses must be valid for the email to send.
`has_error` | **Boolean** `readonly`<br>Whether any errors occur when sending this email
`sent` | **Boolean** `readonly`<br>Whether the email was sent successfully
`document_ids` | **Array** <br>Documents to send as attachments to the email
`order_id` | **Uuid** <br>The associated Order
`customer_id` | **Uuid** <br>The associated Customer
`email_template_id` | **Uuid** <br>The associated Email template
`employee_id` | **Uuid** `readonly`<br>The associated Employee


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
      "id": "6d307a80-0c44-45fc-8c7d-8c913dfcaec3",
      "type": "emails",
      "attributes": {
        "created_at": "2024-10-14T09:23:37.372829+00:00",
        "updated_at": "2024-10-14T09:23:37.372829+00:00",
        "subject": "Order confirmation",
        "body": "We hereby confirm your order with number #123",
        "recipients": "jon@doe.com",
        "has_error": false,
        "sent": false,
        "document_ids": [],
        "order_id": null,
        "customer_id": "4b656c0c-e71e-4a6f-a639-5d5a6165b255",
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
    --url 'https://example.booqable.com/api/boomerang/emails?filter%5Border_id%5D=05c3b42f-7310-451e-974c-314cd21a362f' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "5a7600cb-9f4c-478d-91bc-b3e1fd52ad13",
      "type": "emails",
      "attributes": {
        "created_at": "2024-10-14T09:23:36.895431+00:00",
        "updated_at": "2024-10-14T09:23:36.923676+00:00",
        "subject": "Order confirmation",
        "body": "We hereby confirm your order with number #123",
        "recipients": "jon@doe.com",
        "has_error": false,
        "sent": false,
        "document_ids": [],
        "order_id": "05c3b42f-7310-451e-974c-314cd21a362f",
        "customer_id": "e5c542b3-5ae0-4a3f-84a2-f8f02b0d766a",
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
          "email_template_id": "2e631e9d-1a05-4179-97ce-7baa1b7dd91f",
          "order_id": "d266d487-edaa-4493-bf78-7b3ec02bc60c",
          "customer_id": "024768da-78d4-4288-857d-6b6ba6396914",
          "document_ids": [
            "28fe11a5-1241-4bfd-9474-b00059721fe0"
          ]
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "257aa83d-2693-47f0-8a25-e8f6dfd5a3bb",
    "type": "emails",
    "attributes": {
      "created_at": "2024-10-14T09:22:56.900794+00:00",
      "updated_at": "2024-10-14T09:22:56.900794+00:00",
      "subject": "Order confirmation",
      "body": "Hi {{customer.name}}",
      "recipients": "customer1@example.com,customer2@example.com",
      "has_error": false,
      "sent": false,
      "document_ids": [
        "28fe11a5-1241-4bfd-9474-b00059721fe0"
      ],
      "order_id": "d266d487-edaa-4493-bf78-7b3ec02bc60c",
      "customer_id": "024768da-78d4-4288-857d-6b6ba6396914",
      "email_template_id": "2e631e9d-1a05-4179-97ce-7baa1b7dd91f",
      "employee_id": "38274faa-5247-4814-91b1-61c258f481f3"
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
`data[attributes][order_id]` | **Uuid** <br>The associated Order
`data[attributes][customer_id]` | **Uuid** <br>The associated Customer
`data[attributes][email_template_id]` | **Uuid** <br>The associated Email template


### Includes

This request accepts the following includes:

`customer`


`order`


`email_template`





