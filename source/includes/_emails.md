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
      "id": "c344c211-f39f-45cc-a23f-33c2bd4ce883",
      "type": "emails",
      "attributes": {
        "created_at": "2024-07-22T09:30:26.539034+00:00",
        "updated_at": "2024-07-22T09:30:26.539034+00:00",
        "subject": "Order confirmation",
        "body": "We hereby confirm your order with number #123",
        "recipients": "jon@doe.com",
        "has_error": false,
        "sent": false,
        "document_ids": [],
        "order_id": null,
        "customer_id": "9a503028-9561-47f5-97e5-2f3518943da1",
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
    --url 'https://example.booqable.com/api/boomerang/emails?filter%5Border_id%5D=60126d9b-33ff-4e66-b21a-a37c4cd1649f' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "d0f47d7a-4753-483f-aecb-820aeb6f0438",
      "type": "emails",
      "attributes": {
        "created_at": "2024-07-22T09:30:25.829310+00:00",
        "updated_at": "2024-07-22T09:30:25.896134+00:00",
        "subject": "Order confirmation",
        "body": "We hereby confirm your order with number #123",
        "recipients": "jon@doe.com",
        "has_error": false,
        "sent": false,
        "document_ids": [],
        "order_id": "60126d9b-33ff-4e66-b21a-a37c4cd1649f",
        "customer_id": "94dd31db-c176-4f71-9350-6b400a7f74ea",
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
          "email_template_id": "c3aedb93-f573-4500-9f24-9b5bbcf84c7f",
          "order_id": "1f1fd98d-b854-4162-835f-b180f7fdd24f",
          "customer_id": "64d14a98-3423-4651-b759-18e8f3db601b",
          "document_ids": [
            "d86a72bc-6476-4694-a0a2-478748644856"
          ]
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "ac589d04-022d-4316-a4b7-eebd19aea917",
    "type": "emails",
    "attributes": {
      "created_at": "2024-07-22T09:30:27.876369+00:00",
      "updated_at": "2024-07-22T09:30:27.876369+00:00",
      "subject": "Order confirmation",
      "body": "Hi {{customer.name}}",
      "recipients": "customer1@example.com,customer2@example.com",
      "has_error": false,
      "sent": false,
      "document_ids": [
        "d86a72bc-6476-4694-a0a2-478748644856"
      ],
      "order_id": "1f1fd98d-b854-4162-835f-b180f7fdd24f",
      "customer_id": "64d14a98-3423-4651-b759-18e8f3db601b",
      "email_template_id": "c3aedb93-f573-4500-9f24-9b5bbcf84c7f",
      "employee_id": "05e9b6cd-c291-4d1c-aa0e-25112346fb42"
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





