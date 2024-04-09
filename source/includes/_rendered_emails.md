# Rendered emails

A quick and simple way to fill out an email template with order data.

## Fields
Every rendered email has the following fields:

Name | Description
-- | --
`id` | **Uuid** `readonly`<br>
`email_template_id` | **Uuid** <br>Email template to render
`order_id` | **Uuid** <br>Order data to use when rendering
`document_id` | **Uuid** <br>Document data to use when rendering
`subject` | **String** `readonly`<br>Rendered email subject
`body` | **String** <br>Rendered email body
`full_body` | **String** `readonly`<br>Email body wrapped with email layout


## Rendering email content



> How to render an email with layout for preview:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/rendered_emails' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "rendered_emails",
        "attributes": {
          "order_id": "b718aabe-4ba1-402e-84b9-4d85579463ce",
          "email_template_id": "740002f6-bea0-4b56-8302-68485d52d1be",
          "body": "<p>Thank you for ordering with us!</p>\n"
        }
      }
    }'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "",
    "type": "rendered_emails",
    "attributes": {
      "email_template_id": "740002f6-bea0-4b56-8302-68485d52d1be",
      "order_id": "b718aabe-4ba1-402e-84b9-4d85579463ce",
      "document_id": null,
      "subject": "Order number 1",
      "body": "<p>Thank you for ordering with us!</p>\n",
      "full_body": "<!DOCTYPE html>\n<html mailer='company'>\n<head>\n<meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>\n</head>\n<body class='wrapper'>\n<table align='center' border='0' cellpadding='0' cellspacing='0' class='content' role='presentation' width='100%'>\n<tr>\n<td>\n<h1>Company name 126</h1>\n</td>\n</tr>\n</table>\n<table align='center' border='0' cellpadding='0' cellspacing='0' class='content body' role='presentation' width='100%'>\n<tr>\n<td>\n<p>Thank you for ordering with us!</p>\n\n</td>\n</tr>\n</table>\n<table align='center' border='0' cellpadding='0' cellspacing='0' class='content footer' role='presentation' width='100%'>\n<tr>\n<td>\n<h3>Company name 126</h3>\n</td>\n</tr>\n<tr>\n<td>\n<a href='mailto:mail129@company.com'>mail129@company.com</a>\n</td>\n</tr>\n<tr>\n<td>\n<a href='tel:0581234567'>0581234567</a>\n</td>\n</tr>\n<tr>\n<td>\n<a>www.booqable.com</a>\n</td>\n</tr>\n<tr>\n<td>\nBlokhuispoort\n</td>\n</tr>\n<tr>\n<td>\nLeeuwarden\n</td>\n</tr>\n<tr>\n<td>\nBlokhuispoort\n</td>\n</tr>\n<tr>\n<td>\nLeeuwarden\n</td>\n</tr>\n<tr>\n<td>\n8900AB Leeuwarden\n</td>\n</tr>\n<tr>\n<td>\nthe Netherlands\n</td>\n</tr>\n</table>\n</body>\n</html>\n"
    }
  },
  "meta": {}
}
```


> How to render an email from a template:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/rendered_emails' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "rendered_emails",
        "attributes": {
          "order_id": "9ef79487-b8c8-4fd5-a585-ae3022846b5a",
          "email_template_id": "d144aace-f15c-4867-8bc2-f048c9853c03"
        }
      }
    }'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "",
    "type": "rendered_emails",
    "attributes": {
      "email_template_id": "d144aace-f15c-4867-8bc2-f048c9853c03",
      "order_id": "9ef79487-b8c8-4fd5-a585-ae3022846b5a",
      "document_id": null,
      "subject": "Order number 1",
      "body": "<p>Thank you for ordering with us!</p>\n",
      "full_body": null
    }
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
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[rendered_emails]=email_template_id,order_id,document_id`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][email_template_id]` | **Uuid** <br>Email template to render
`data[attributes][order_id]` | **Uuid** <br>Order data to use when rendering
`data[attributes][document_id]` | **Uuid** <br>Document data to use when rendering
`data[attributes][body]` | **String** <br>Rendered email body


### Includes

This request does not accept any includes