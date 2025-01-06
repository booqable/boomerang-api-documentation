# Emails

Emails allow you to easily communicate with your customers by using optional templates.
Booqable keeps a history of e-mail being sent for orders or customers.

## Relationships
Name | Description
-- | --
`customer` | **[Customer](#customers)** `required`<br>Customer this email is associated with. Attributes from this order are available when rendering the template. 
`email_template` | **[Email template](#email-templates)** `required`<br>The template used to generate this email. 
`employee` | **[Employee](#employees)** `required`<br>Employee who sent the email. 
`order` | **[Order](#orders)** `required`<br>The order this email is associated with. Attributes from this order are available when rendering the template. 


Check matching attributes under [Fields](#emails-fields) to see which relations can be written.
<br/ >
Check each individual operation to see which relations can be included as a sideload.
## Fields

 Name | Description
-- | --
`body` | **string** <br>Email body. 
`created_at` | **datetime** `readonly`<br>When the email was created by the user, or automatically by Booqable. At this time, the email has not been sent yet. 
`customer_id` | **uuid** `readonly-after-create`<br>Customer this email is associated with. Attributes from this order are available when rendering the template. 
`document_ids` | **array** <br>Documents to send as attachments to the email. 
`email_template_id` | **uuid** `readonly-after-create`<br>The template used to generate this email. 
`employee_id` | **uuid** `readonly`<br>Employee who sent the email. 
`has_error` | **boolean** `readonly`<br>Whether any errors occur when sending this email. 
`id` | **uuid** `readonly`<br>Primary key.
`order_id` | **uuid** `readonly-after-create`<br>The order this email is associated with. Attributes from this order are available when rendering the template. 
`recipients` | **string** <br>Comma seperated list of recipient email addresses, all addresses must be valid for the email to send. 
`sent` | **boolean** `readonly`<br>Whether the email was sent successfully. 
`subject` | **string** <br>Email subject. 
`updated_at` | **datetime** `readonly`<br>The last time the email was updated. Typically this is updated after a delivery attempt has failed. 


## List emails


> How to fetch a list of emails:

```shell
  curl --get 'https://example.booqable.com/api/boomerang/emails'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": [
      {
        "id": "b882543c-57cc-4fcf-8a1e-dc471e664ac4",
        "type": "emails",
        "attributes": {
          "created_at": "2016-11-24T02:24:00.000000+00:00",
          "updated_at": "2016-11-24T02:24:00.000000+00:00",
          "subject": "Order confirmation",
          "body": "We hereby confirm your order with number #123",
          "recipients": "jon@doe.com",
          "has_error": false,
          "sent": false,
          "document_ids": [],
          "order_id": null,
          "customer_id": "878c23b8-3fa0-44b1-856f-7fd95560fabc",
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
  curl --get 'https://example.booqable.com/api/boomerang/emails'
       --header 'content-type: application/json'
       --data-urlencode 'filter[order_id]=f97ca4a9-7d59-46d9-8df1-6cc7dae11393'
```

> A 200 status response looks like this:

```json
  {
    "data": [
      {
        "id": "a1b5a25c-bd16-4249-8052-72ebda9c133d",
        "type": "emails",
        "attributes": {
          "created_at": "2024-08-21T09:09:01.000000+00:00",
          "updated_at": "2024-08-21T09:09:01.000000+00:00",
          "subject": "Order confirmation",
          "body": "We hereby confirm your order with number #123",
          "recipients": "jon@doe.com",
          "has_error": false,
          "sent": false,
          "document_ids": [],
          "order_id": "f97ca4a9-7d59-46d9-8df1-6cc7dae11393",
          "customer_id": "659dbd01-2c4c-42b8-890e-afe1f60d29ec",
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
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[emails]=created_at,updated_at,subject`
`filter` | **hash** <br>The filters to apply `?filter[attribute][eq]=value`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=customer,order`
`meta` | **hash** <br>Metadata to send along. `?meta[total][]=count`
`page[number]` | **string** <br>The page to request.
`page[size]` | **string** <br>The amount of items per page.
`sort` | **string** <br>How to sort the data. `?sort=attribute1,-attribute2`


### Filters

This request can be filtered on:

Name | Description
-- | --
`created_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`customer_id` | **uuid** <br>`eq`, `not_eq`
`email_template_id` | **uuid** <br>`eq`, `not_eq`
`employee_id` | **uuid** <br>`eq`, `not_eq`
`has_error` | **boolean** <br>`eq`
`id` | **uuid** <br>`eq`, `not_eq`
`order_id` | **uuid** <br>`eq`, `not_eq`
`sent` | **boolean** <br>`eq`
`updated_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`has_error` | **array** <br>`count`
`total` | **array** <br>`count`


### Includes

This request accepts the following includes:

`customer`


`order`






## Create and sending an email


> How to create and send an email:

```shell
  curl --request POST
       --url 'https://example.booqable.com/api/boomerang/emails'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "type": "emails",
           "attributes": {
             "recipients": "customer1@example.com,customer2@example.com",
             "subject": "Order confirmation",
             "body": "Hi {{customer.name}}",
             "email_template_id": "4b2e6043-c307-4b1c-8f2d-872b85d20fc4",
             "order_id": "c504d320-966c-4b0d-88fb-9490bc6483e5",
             "customer_id": "c353e670-ad55-43ad-803b-3e12456726de",
             "document_ids": [
               "b308505b-b1cb-485c-8d0e-7d937d2f38a5"
             ]
           }
         }
       }'
```

> A 201 status response looks like this:

```json
  {
    "data": {
      "id": "b0779013-b390-48c6-8286-123716b0a3e1",
      "type": "emails",
      "attributes": {
        "created_at": "2025-09-16T16:16:01.000000+00:00",
        "updated_at": "2025-09-16T16:16:01.000000+00:00",
        "subject": "Order confirmation",
        "body": "Hi {{customer.name}}",
        "recipients": "customer1@example.com,customer2@example.com",
        "has_error": false,
        "sent": false,
        "document_ids": [
          "b308505b-b1cb-485c-8d0e-7d937d2f38a5"
        ],
        "order_id": "c504d320-966c-4b0d-88fb-9490bc6483e5",
        "customer_id": "c353e670-ad55-43ad-803b-3e12456726de",
        "email_template_id": "4b2e6043-c307-4b1c-8f2d-872b85d20fc4",
        "employee_id": "1a34d41c-d99a-49de-8090-cb632e9ef172"
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
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[emails]=created_at,updated_at,subject`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=customer,order,email_template`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][body]` | **string** <br>Email body. 
`data[attributes][customer_id]` | **uuid** <br>Customer this email is associated with. Attributes from this order are available when rendering the template. 
`data[attributes][document_ids][]` | **array** <br>Documents to send as attachments to the email. 
`data[attributes][email_template_id]` | **uuid** <br>The template used to generate this email. 
`data[attributes][order_id]` | **uuid** <br>The order this email is associated with. Attributes from this order are available when rendering the template. 
`data[attributes][recipients]` | **string** <br>Comma seperated list of recipient email addresses, all addresses must be valid for the email to send. 
`data[attributes][subject]` | **string** <br>Email subject. 


### Includes

This request accepts the following includes:

`customer`


`order`


`email_template`





