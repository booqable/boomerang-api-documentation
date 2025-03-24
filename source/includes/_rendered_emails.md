# Rendered emails

A quick and simple way to fill out an email template with order data.

## Relationships
Name | Description
-- | --
`document` | **[Document](#documents)** `required`<br>[Document](#documents) data to use when rendering. 
`email_template` | **[Email template](#email-templates)** `required`<br>[EmailTemplate](#email-templates) to render. 
`order` | **[Order](#orders)** `required`<br>[Order](#orders) data to use when rendering. 


Check matching attributes under [Fields](#rendered-emails-fields) to see which relations can be written.
<br/ >
Check each individual operation to see which relations can be included as a sideload.
## Fields

 Name | Description
-- | --
`body` | **string** <br>Rendered email body.
`document_id` | **uuid** <br>[Document](#documents) data to use when rendering. 
`email_template_id` | **uuid** <br>[EmailTemplate](#email-templates) to render. 
`full_body` | **string** `readonly`<br>Email body wrapped with email layout.
`id` | **uuid** `readonly`<br>Primary key.
`order_id` | **uuid** <br>[Order](#orders) data to use when rendering. 
`subject` | **string** `readonly`<br>Rendered email subject.


## Render email content


> How to render an email from a template:

```shell
  curl --request POST
       --url 'https://example.booqable.com/api/boomerang/rendered_emails'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "type": "rendered_emails",
           "attributes": {
             "order_id": "e2e0efcc-a93b-40eb-8392-8d7948ec4efd",
             "email_template_id": "c8ab9cb9-1c86-4d0b-8699-672fa548d9a6"
           }
         }
       }'
```

> A 201 status response looks like this:

```json
  {
    "data": {
      "id": "069de8af-2ec5-4651-8c67-f2a46265f5da",
      "type": "rendered_emails",
      "attributes": {
        "subject": "Order number 1",
        "body": "<p>Thank you for ordering with us!</p>\n",
        "full_body": null,
        "email_template_id": "c8ab9cb9-1c86-4d0b-8699-672fa548d9a6",
        "order_id": "e2e0efcc-a93b-40eb-8392-8d7948ec4efd",
        "document_id": null
      },
      "relationships": {}
    },
    "meta": {}
  }
```

> How to render an email with layout for preview:

```shell
  curl --request POST
       --url 'https://example.booqable.com/api/boomerang/rendered_emails'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "type": "rendered_emails",
           "attributes": {
             "order_id": "2fa9613f-a388-41e7-80fb-0a6964a7b930",
             "email_template_id": "0d3355b0-d437-4476-8d54-fa2cc6c4af88",
             "body": "<p>Thank you for ordering with us!</p>\n"
           }
         }
       }'
```

> A 201 status response looks like this:

```json
  {
    "data": {
      "id": "d3b9eaf9-f7ed-441a-8695-a539084b7776",
      "type": "rendered_emails",
      "attributes": {
        "subject": "Order number 1",
        "body": "<p>Thank you for ordering with us!</p>\n",
        "full_body": "<!DOCTYPE html>\n<html mailer='company'>\n<head>\n<link rel=\"stylesheet\" href=\"/assets/back_office/mailers-75c34f60e3828f7cba8061e7ac403a53328c3fe887cda073d076fd6a74c65f3a.css\" />\n<meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>\n</head>\n<body class='wrapper'>\n<table align='center' border='0' cellpadding='0' cellspacing='0' class='content' role='presentation' width='100%'>\n<tr>\n<td>\n<h1>Company name 266</h1>\n</td>\n</tr>\n</table>\n<table align='center' border='0' cellpadding='0' cellspacing='0' class='content body' role='presentation' width='100%'>\n<tr>\n<td>\n<p>Thank you for ordering with us!</p>\n\n</td>\n</tr>\n</table>\n<table align='center' border='0' cellpadding='0' cellspacing='0' class='content footer' role='presentation' width='100%'>\n<tr>\n<td>\n<h3>Company name 266</h3>\n</td>\n</tr>\n<tr>\n<td>\n<a href='mailto:mail269@company.com'>mail269@company.com</a>\n</td>\n</tr>\n<tr>\n<td>\n<a href='www.booqable.com'>www.booqable.com</a>\n</td>\n</tr>\n<tr>\n<td>\nBlokhuispoort\n</td>\n</tr>\n<tr>\n<td>\nLeeuwarden\n</td>\n</tr>\n<tr>\n<td>\nBlokhuispoort\n</td>\n</tr>\n<tr>\n<td>\nLeeuwarden\n</td>\n</tr>\n<tr>\n<td>\n8900AB Leeuwarden\n</td>\n</tr>\n<tr>\n<td>\nNetherlands\n</td>\n</tr>\n</table>\n</body>\n</html>\n",
        "email_template_id": "0d3355b0-d437-4476-8d54-fa2cc6c4af88",
        "order_id": "2fa9613f-a388-41e7-80fb-0a6964a7b930",
        "document_id": null
      },
      "relationships": {}
    },
    "meta": {}
  }
```

### HTTP Request

`POST /api/boomerang/rendered_emails`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[rendered_emails]=subject,body,full_body`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][body]` | **string** <br>Rendered email body.
`data[attributes][document_id]` | **uuid** <br>[Document](#documents) data to use when rendering. 
`data[attributes][email_template_id]` | **uuid** <br>[EmailTemplate](#email-templates) to render. 
`data[attributes][order_id]` | **uuid** <br>[Order](#orders) data to use when rendering. 


### Includes

This request does not accept any includes