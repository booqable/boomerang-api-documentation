# Rendered emails

A quick and simple way to fill out an email template with order data.

## Fields
Every rendered email has the following fields:

Name | Description
-- | --
`id` | **Uuid** `readonly`<br>Primary key
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
          "order_id": "ca2405af-e021-46e3-bce8-954eaf68db60",
          "email_template_id": "10bddff7-06e9-449c-a5fc-518ed606ce95"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "43a2395b-7b5e-502a-9d45-0045b9f36c61",
    "type": "rendered_emails",
    "attributes": {
      "email_template_id": "10bddff7-06e9-449c-a5fc-518ed606ce95",
      "order_id": "ca2405af-e021-46e3-bce8-954eaf68db60",
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
          "order_id": "0c5c772d-989a-4979-80e3-84ee5eafd754",
          "email_template_id": "35186f8a-d36d-4175-a710-dcd371583cad",
          "body": "<p>Thank you for ordering with us!</p>\n"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "fda723a3-3bf4-5a65-9c8d-537fc6cb1066",
    "type": "rendered_emails",
    "attributes": {
      "email_template_id": "35186f8a-d36d-4175-a710-dcd371583cad",
      "order_id": "0c5c772d-989a-4979-80e3-84ee5eafd754",
      "document_id": null,
      "subject": "Order number 1",
      "body": "<p>Thank you for ordering with us!</p>\n",
      "full_body": "<!DOCTYPE html>\n<html mailer='company'>\n<head>\n<meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>\n</head>\n<body class='wrapper'>\n<table align='center' border='0' cellpadding='0' cellspacing='0' class='content' role='presentation' width='100%'>\n<tr>\n<td>\n<h1>Company name 85</h1>\n</td>\n</tr>\n</table>\n<table align='center' border='0' cellpadding='0' cellspacing='0' class='content body' role='presentation' width='100%'>\n<tr>\n<td>\n<p>Thank you for ordering with us!</p>\n\n</td>\n</tr>\n</table>\n<table align='center' border='0' cellpadding='0' cellspacing='0' class='content footer' role='presentation' width='100%'>\n<tr>\n<td>\n<h3>Company name 85</h3>\n</td>\n</tr>\n<tr>\n<td>\n<a href='mailto:mail85@company.com'>mail85@company.com</a>\n</td>\n</tr>\n<tr>\n<td>\n<a href='www.booqable.com'>www.booqable.com</a>\n</td>\n</tr>\n<tr>\n<td>\nBlokhuispoort\n</td>\n</tr>\n<tr>\n<td>\nLeeuwarden\n</td>\n</tr>\n<tr>\n<td>\nBlokhuispoort\n</td>\n</tr>\n<tr>\n<td>\nLeeuwarden\n</td>\n</tr>\n<tr>\n<td>\n8900AB Leeuwarden\n</td>\n</tr>\n<tr>\n<td>\nthe Netherlands\n</td>\n</tr>\n</table>\n</body>\n</html>\n"
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