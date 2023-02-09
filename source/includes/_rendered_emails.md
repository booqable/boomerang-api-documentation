# Rendered emails

A quick and simple way to fill out an email template with order data.

## Fields
Every rendered email has the following fields:

Name | Description
- | -
`id` | **Uuid** `readonly`<br>
`email_template_id` | **Uuid** <br>Email template to render
`order_id` | **Uuid** <br>Order data to use when rendering
`document_id` | **Uuid** <br>Document data to use when rendering
`subject` | **String** `readonly`<br>Rendered email subject
`body` | **String** <br>Rendered email body
`full_body` | **String** `readonly`<br>Email body wrapped with email layout


## Rendering email content



> How to render an email from a template:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/rendered_emails' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "rendered_emails",
        "attributes": {
          "order_id": "540ed7ef-cb1e-4bb1-9e1f-daa2a895702c",
          "email_template_id": "91f86695-ec5c-41bf-a83d-606e988fff89"
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
      "email_template_id": "91f86695-ec5c-41bf-a83d-606e988fff89",
      "order_id": "540ed7ef-cb1e-4bb1-9e1f-daa2a895702c",
      "document_id": null,
      "subject": "Order number 1",
      "body": "<p>Thank you for ordering with us!</p>\n",
      "full_body": null
    }
  },
  "meta": {}
}
```


> How to render an email with layout for preview:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/rendered_emails' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "rendered_emails",
        "attributes": {
          "order_id": "3d79842b-6b91-4c8c-8ffd-84c36355e94b",
          "email_template_id": "ccdbf4ae-9a1e-410b-9ff8-8f99140f081e",
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
      "email_template_id": "ccdbf4ae-9a1e-410b-9ff8-8f99140f081e",
      "order_id": "3d79842b-6b91-4c8c-8ffd-84c36355e94b",
      "document_id": null,
      "subject": "Order number 1",
      "body": "<p>Thank you for ordering with us!</p>\n",
      "full_body": "<!DOCTYPE html>\n<html mailer=\"company\">\n<head>\n<meta content=\"width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no\" name=\"viewport\">\n</head>\n<body>\n<div class=\"container\">\n<div id=\"top\">\n<h1>Company name 232</h1>\n</div>\n<div id=\"content\">\n<div id=\"email-content\"><p>Thank you for ordering with us!</p>\n</div>\n<div id=\"company-info\">\n<h3>Company name 232</h3>\n<a href=\"mailto:mail235@company.com\">mail235@company.com</a>\n<br>\n<a href=\"tel:0581234567\">0581234567</a>\n<br>\n<a>www.booqable.com</a>\n<br>\nBlokhuispoort\n<br>\nLeeuwarden\n<br>\n<br>\nBlokhuispoort\n<br>\nLeeuwarden\n<br>\nLeeuwarden\n<br>\nthe Netherlands\n</div>\n</div>\n</div>\n</body>\n</html>\n"
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
- | -
`include` | **String** <br>List of comma seperated relationships `?include=`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[rendered_emails]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][email_template_id]` | **Uuid** <br>Email template to render
`data[attributes][order_id]` | **Uuid** <br>Order data to use when rendering
`data[attributes][document_id]` | **Uuid** <br>Document data to use when rendering
`data[attributes][body]` | **String** <br>Rendered email body


### Includes

This request does not accept any includes