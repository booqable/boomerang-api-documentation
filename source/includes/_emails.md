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
      "id": "8ec8ebeb-4ea1-4079-93d1-82d86f8e9682",
      "type": "emails",
      "attributes": {
        "created_at": "2024-07-01T09:25:43.372686+00:00",
        "updated_at": "2024-07-01T09:25:43.372686+00:00",
        "subject": "Order confirmation",
        "body": "We hereby confirm your order with number #123",
        "recipients": "jon@doe.com",
        "document_ids": [],
        "order_id": null,
        "customer_id": "5fdd2ac7-f5fe-44b2-a306-85548bb05257",
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
    --url 'https://example.booqable.com/api/boomerang/emails?filter%5Border_id%5D=b2b580ee-d30a-4504-9e88-525da84780fc' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "abaabebd-7401-43fd-9eee-e559e500468e",
      "type": "emails",
      "attributes": {
        "created_at": "2024-07-01T09:25:44.096684+00:00",
        "updated_at": "2024-07-01T09:25:44.155670+00:00",
        "subject": "Order confirmation",
        "body": "We hereby confirm your order with number #123",
        "recipients": "jon@doe.com",
        "document_ids": [],
        "order_id": "b2b580ee-d30a-4504-9e88-525da84780fc",
        "customer_id": "63dd18ee-e1f0-46c9-b923-08a1ee959667",
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
          "email_template_id": "433949bc-cc53-4bdc-a81f-66105e7974ce",
          "order_id": "7dbb8d2e-240a-4fd9-be40-82f66edc43c5",
          "customer_id": "91697d01-f4d4-42e5-93fd-5e8f79edac11",
          "document_ids": [
            "86c58769-d662-434a-8083-eb3379b049da"
          ]
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "5787be16-515c-41a7-95c5-b0a759e2c6df",
    "type": "emails",
    "attributes": {
      "created_at": "2024-07-01T09:25:01.111118+00:00",
      "updated_at": "2024-07-01T09:25:01.111118+00:00",
      "subject": "Order confirmation",
      "body": "Hi {{customer.name}}",
      "recipients": "customer1@example.com,customer2@example.com",
      "document_ids": [
        "86c58769-d662-434a-8083-eb3379b049da"
      ],
      "order_id": "7dbb8d2e-240a-4fd9-be40-82f66edc43c5",
      "customer_id": "91697d01-f4d4-42e5-93fd-5e8f79edac11",
      "email_template_id": "433949bc-cc53-4bdc-a81f-66105e7974ce",
      "employee_id": "dad38b51-42d0-4a64-8914-f6ab72ffbe5a"
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





