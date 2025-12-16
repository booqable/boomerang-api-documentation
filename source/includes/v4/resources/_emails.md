# Emails

Emails allow you to easily communicate with your customers by using optional templates.
Booqable keeps a complete history of all emails sent for orders or customers, making it
easy to track customer communications and maintain a clear audit trail.

## Creating Emails

Emails can be created manually through the API or automatically triggered by certain
system events. When creating an email, you can either provide the content directly
(subject and body) or reference an [EmailTemplate](#email-templates) that will be
rendered using data from associated resources.

## Sending Process

After an email is created and validated, it's automatically queued for delivery through
Booqable's email service. The `sent` attribute indicates whether the email was successfully
handed off to the mail server, while `has_error` shows if any problems occurred during
the sending process. Emails are processed asynchronously to ensure fast API responses.

## Relationships
Name | Description
-- | --
`customer` | **[Customer](#customers)** `required`<br>The [Customer](#customers) this email is associated with. When specified and using an [EmailTemplate](#email-templates), customer data is available during template rendering. This relationship is useful for customer-specific communications that aren't tied to a particular order, or for providing customer context when an order relationship is also present. The customer's email address is typically used as the default recipient. 
`email_template` | **[Email template](#email-templates)** `required`<br>The [EmailTemplate](#email-templates) used to generate this email's content. When specified, the template is rendered with data from the associated resources to populate the email's subject and body. Templates allow for consistent, branded communication with dynamic content. 
`employee` | **[Employee](#employees)** `required`<br>The [Employee](#employees) who created and sent this email. This is automatically set to the current user when the email is created and cannot be modified. The employee relationship tracks who initiated the communication and may be used for reply-to addresses or signature information in the email content. 
`order` | **[Order](#orders)** `required`<br>The [Order](#orders) this email is associated with. When an email is linked to an order and uses an [EmailTemplate](#email-templates), the template can access order data during rendering. Linking an email to an order also helps maintain a clear communication history for that rental transaction. 


Check matching attributes under [Fields](#emails-fields) to see which relations can be written.
<br/ >
Check each individual operation to see which relations can be included as a sideload.
## Fields

 Name | Description
-- | --
`body` | **string** <br>The main content of the email. When providing the body directly (without using an [EmailTemplate](#email-templates)), this is the final text that will be sent. When using a template, this field is automatically populated by rendering the template with data from associated resources. 
`created_at` | **datetime** `readonly`<br>When the email was created by the user or automatically by Booqable. At this time, the email has not been sent yet and may still be in the process of being prepared. Once the email is created and validated, it will be queued for delivery. 
`customer_id` | **uuid** `readonly-after-create`<br>The [Customer](#customers) this email is associated with. When specified and using an [EmailTemplate](#email-templates), customer data is available during template rendering. This relationship is useful for customer-specific communications that aren't tied to a particular order, or for providing customer context when an order relationship is also present. The customer's email address is typically used as the default recipient. 
`document_id` | **uuid** `writeonly`<br>Single [Document](#documents) ID to use for template variable rendering. When provided along with an [EmailTemplate](#email-templates), the document's data becomes available for use in template variables (e.g., `{{document.number}}`). This is useful for sending document-specific notifications where the document details should appear in the email content. Note that this is different from `document_ids`, which attaches documents as PDF files. 
`document_ids` | **array** <br>Array of [Document](#documents) IDs to attach to the email as PDF attachments. When the email is sent, each document will be rendered as a PDF and included as an attachment. Common use cases include attaching quotes, contracts, or invoices to customer communications. Note that this is different from `document_id`, which is used for template variable rendering. 
`email_template_id` | **uuid** `readonly-after-create`<br>The [EmailTemplate](#email-templates) used to generate this email's content. When specified, the template is rendered with data from the associated resources to populate the email's subject and body. Templates allow for consistent, branded communication with dynamic content. 
`employee_id` | **uuid** `readonly`<br>The [Employee](#employees) who created and sent this email. This is automatically set to the current user when the email is created and cannot be modified. The employee relationship tracks who initiated the communication and may be used for reply-to addresses or signature information in the email content. 
`has_error` | **boolean** `readonly`<br>Whether any errors occurred when attempting to send this email. Returns `true` if the email encountered problems during sending (such as invalid addresses, server issues, or other delivery failures). When `true`, additional error details may be available to help diagnose the issue. 
`id` | **uuid** `readonly`<br>Primary key.
`order_id` | **uuid** `readonly-after-create`<br>The [Order](#orders) this email is associated with. When an email is linked to an order and uses an [EmailTemplate](#email-templates), the template can access order data during rendering. Linking an email to an order also helps maintain a clear communication history for that rental transaction. 
`payment_id` | **uuid** `writeonly`<br>Payment to use when rendering an [EmailTemplate](#email-templates). When provided, payment data is available during template rendering, which is useful for sending payment requests or payment confirmation emails with payment-specific information such as payment links. 
`recipients` | **string** <br>Comma-separated list of recipient email addresses. All addresses must be valid and properly formatted for the email to be sent. The system validates each address before sending. Multiple recipients can be specified, but there is a limit on the maximum number of recipients per email to prevent abuse. The limit is 10 recipients per email. 
`sent` | **boolean** `readonly`<br>Whether the email was sent successfully. Returns `true` if the email has been delivered to the mail server, `false` if it hasn't been sent yet or if sending failed. Note that this indicates successful handoff to the mail server, not necessarily that the recipient received the email. 
`subject` | **string** <br>The subject line of the email. When providing the subject directly (without using an [EmailTemplate](#email-templates)), this is the exact text that will appear in the recipient's inbox. When using a template, this field is automatically populated by rendering the template's subject with the available data from associated resources. 
`updated_at` | **datetime** `readonly`<br>The last time the email was updated. This timestamp changes when the email status is modified, such as after a delivery attempt succeeds or fails. Updates may also occur when error information is recorded or when the email is retried after a failed delivery attempt. 


## List emails


> How to fetch a list of emails:

```shell
  curl --get 'https://example.booqable.com/api/4/emails'
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
  curl --get 'https://example.booqable.com/api/4/emails'
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

`GET /api/4/emails`

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

<ul>
  <li><code>customer</code></li>
  <li><code>order</code></li>
</ul>


## Create and sending an email


> How to create and send an email:

```shell
  curl --request POST
       --url 'https://example.booqable.com/api/4/emails'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "type": "emails",
           "attributes": {
             "recipients": "customer1@example.com,customer2@example.com",
             "subject": "Order confirmation",
             "body": "Hi {{customer.name}}",
             "order_id": "4b2e6043-c307-4b1c-8f2d-872b85d20fc4",
             "customer_id": "c504d320-966c-4b0d-88fb-9490bc6483e5"
           }
         }
       }'
```

> A 201 status response looks like this:

```json
  {
    "data": {
      "id": "c353e670-ad55-43ad-803b-3e12456726de",
      "type": "emails",
      "attributes": {
        "created_at": "2025-09-16T16:16:01.000000+00:00",
        "updated_at": "2025-09-16T16:16:01.000000+00:00",
        "subject": "Order confirmation",
        "body": "Hi {{customer.name}}",
        "recipients": "customer1@example.com,customer2@example.com",
        "has_error": false,
        "sent": false,
        "document_ids": [],
        "order_id": "4b2e6043-c307-4b1c-8f2d-872b85d20fc4",
        "customer_id": "c504d320-966c-4b0d-88fb-9490bc6483e5",
        "email_template_id": null,
        "employee_id": "b308505b-b1cb-485c-8d0e-7d937d2f38a5"
      },
      "relationships": {}
    },
    "meta": {}
  }
```

> How to create an email with document attachments:

```shell
  curl --request POST
       --url 'https://example.booqable.com/api/4/emails'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "type": "emails",
           "attributes": {
             "recipients": "customer@example.com",
             "subject": "Your documents",
             "body": "Please find your contract and invoice attached.",
             "order_id": "d5ff0679-a951-40b3-8992-5e24d9d1fed6",
             "document_ids": [
               "50671ff8-1979-4d54-870d-6be618a45e02",
               "65e1703c-23b4-4308-8060-dd2907fc31f1"
             ]
           }
         }
       }'
```

> A 201 status response looks like this:

```json
  {
    "data": {
      "id": "45705775-955c-424f-827d-74195d93ef5c",
      "type": "emails",
      "attributes": {
        "created_at": "2020-08-08T15:59:01.000000+00:00",
        "updated_at": "2020-08-08T15:59:01.000000+00:00",
        "subject": "Your documents",
        "body": "Please find your contract and invoice attached.",
        "recipients": "customer@example.com",
        "has_error": false,
        "sent": false,
        "document_ids": [
          "50671ff8-1979-4d54-870d-6be618a45e02",
          "65e1703c-23b4-4308-8060-dd2907fc31f1"
        ],
        "order_id": "d5ff0679-a951-40b3-8992-5e24d9d1fed6",
        "customer_id": null,
        "email_template_id": null,
        "employee_id": "f079a7d1-a859-4ce4-8eba-2bfb94e6368b"
      },
      "relationships": {}
    },
    "meta": {}
  }
```

> How to create an email with document data for template variables:

```shell
  curl --request POST
       --url 'https://example.booqable.com/api/4/emails'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "type": "emails",
           "attributes": {
             "recipients": "customer@example.com",
             "order_id": "98e52620-64f4-4a5f-8c97-d0f8c805356a",
             "email_template_id": "9b479f1c-f504-4326-82f2-03e10f8610a5",
             "document_id": "47da83dc-a5fe-4551-8f1a-928020e2315e"
           }
         }
       }'
```

> A 201 status response looks like this:

```json
  {
    "data": {
      "id": "aabceaef-b518-4ac9-8857-16e80c5c0932",
      "type": "emails",
      "attributes": {
        "created_at": "2018-04-11T19:57:01.000000+00:00",
        "updated_at": "2018-04-11T19:57:01.000000+00:00",
        "subject": "Invoice 1",
        "body": "<p>Your invoice 1 is ready.</p>\n",
        "recipients": "customer@example.com",
        "has_error": false,
        "sent": false,
        "document_ids": [],
        "order_id": "98e52620-64f4-4a5f-8c97-d0f8c805356a",
        "customer_id": null,
        "email_template_id": "9b479f1c-f504-4326-82f2-03e10f8610a5",
        "employee_id": "5ce314b7-cf2f-473c-8d7f-325e488fb7a4"
      },
      "relationships": {}
    },
    "meta": {}
  }
```

### HTTP Request

`POST /api/4/emails`

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
`data[attributes][body]` | **string** <br>The main content of the email. When providing the body directly (without using an [EmailTemplate](#email-templates)), this is the final text that will be sent. When using a template, this field is automatically populated by rendering the template with data from associated resources. 
`data[attributes][customer_id]` | **uuid** <br>The [Customer](#customers) this email is associated with. When specified and using an [EmailTemplate](#email-templates), customer data is available during template rendering. This relationship is useful for customer-specific communications that aren't tied to a particular order, or for providing customer context when an order relationship is also present. The customer's email address is typically used as the default recipient. 
`data[attributes][document_id]` | **uuid** <br>Single [Document](#documents) ID to use for template variable rendering. When provided along with an [EmailTemplate](#email-templates), the document's data becomes available for use in template variables (e.g., `{{document.number}}`). This is useful for sending document-specific notifications where the document details should appear in the email content. Note that this is different from `document_ids`, which attaches documents as PDF files. 
`data[attributes][document_ids][]` | **array** <br>Array of [Document](#documents) IDs to attach to the email as PDF attachments. When the email is sent, each document will be rendered as a PDF and included as an attachment. Common use cases include attaching quotes, contracts, or invoices to customer communications. Note that this is different from `document_id`, which is used for template variable rendering. 
`data[attributes][email_template_id]` | **uuid** <br>The [EmailTemplate](#email-templates) used to generate this email's content. When specified, the template is rendered with data from the associated resources to populate the email's subject and body. Templates allow for consistent, branded communication with dynamic content. 
`data[attributes][order_id]` | **uuid** <br>The [Order](#orders) this email is associated with. When an email is linked to an order and uses an [EmailTemplate](#email-templates), the template can access order data during rendering. Linking an email to an order also helps maintain a clear communication history for that rental transaction. 
`data[attributes][payment_id]` | **uuid** <br>Payment to use when rendering an [EmailTemplate](#email-templates). When provided, payment data is available during template rendering, which is useful for sending payment requests or payment confirmation emails with payment-specific information such as payment links. 
`data[attributes][recipients]` | **string** <br>Comma-separated list of recipient email addresses. All addresses must be valid and properly formatted for the email to be sent. The system validates each address before sending. Multiple recipients can be specified, but there is a limit on the maximum number of recipients per email to prevent abuse. The limit is 10 recipients per email. 
`data[attributes][subject]` | **string** <br>The subject line of the email. When providing the subject directly (without using an [EmailTemplate](#email-templates)), this is the exact text that will appear in the recipient's inbox. When using a template, this field is automatically populated by rendering the template's subject with the available data from associated resources. 


### Includes

This request accepts the following includes:

<ul>
  <li><code>customer</code></li>
  <li><code>email_template</code></li>
  <li><code>order</code></li>
</ul>

