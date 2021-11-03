# Email templates

Email templates allow for creating pre-filled emails with dynamic data. Booqable comes with a default templates which can be updated but not deleted:

- `order_webshop_confirmation`
- `order_confirmation`
- `order_cancellation`
- `invoice_notify`
- `document_contract`
- `document_quote`
- `payment_sca_required`
- `user_confirmation_instructions`
- `user_invitation_instructions`
- `user_reset_password_instructions`
- `user_email_changed`
- `user_password_change`

For more information about using variables for dynamic data in e-mail templates see [our help center](https://help.booqable.com/en/articles/3832164-emails-types-and-templates)

## Endpoints
`GET /api/boomerang/email_templates`

`GET /api/boomerang/email_templates/{id}`

`POST /api/boomerang/email_templates`

`PUT /api/boomerang/email_templates/{id}`

`DELETE /api/boomerang/email_templates/{id}`

## Fields
Every email template has the following fields:

Name | Description
- | -
`id` | **Uuid** `readonly`<br>Primary key
`created_at` | **Datetime** `readonly`<br>When the resource was created
`updated_at` | **Datetime** `readonly`<br>When the resource was last updated
`name` | **String**<br>Name of the template
`identifier` | **String** `readonly`<br>A unique identifier assigned to this template
`subject` | **String**<br>Email subject line template
`context` | **String**<br>Which documents the template applies to. One of `order`, `invoice`, `document`, `all`, `payment`, `user`
`body` | **String**<br>Email body template
`default` | **Boolean** `readonly`<br>Whether this is a system default template, default templates can't be deleted


## Listing email templates



> How to fetch a list of email templates:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/email_templates' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "e56e39b0-445e-4f49-8d5f-8a0f838d05fb",
      "type": "email_templates",
      "attributes": {
        "name": "Webshop confirmation",
        "identifier": "webshop_confirmation",
        "subject": "We received your order",
        "context": "all",
        "body": "We'll get started on it right away",
        "default": false
      }
    }
  ],
  "links": {
    "self": "api/boomerang/email_templates?page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/email_templates?page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/email_templates?page%5Bnumber%5D=1&page%5Bsize%5D=25"
  },
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/email_templates`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[email_templates]=id,created_at,updated_at`
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-11-03T07:55:53Z`
`sort` | **String**<br>How to sort the data `?sort=-created_at`
`meta` | **Hash**<br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String**<br>The page to request
`page[per]` | **String**<br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
`id` | **Uuid**<br>`eq`, `not_eq`
`created_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`name` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`identifier` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`context` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`default` | **Boolean**<br>`eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array**<br>`count`


### Includes

This request does not accept any includes
## Fetching an email template



> How to fetch an email templates:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/email_templates/630f080d-3094-4661-870e-e7d88c91c2ea' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "630f080d-3094-4661-870e-e7d88c91c2ea",
    "type": "email_templates",
    "attributes": {
      "name": "Webshop confirmation",
      "identifier": "webshop_confirmation",
      "subject": "We received your order",
      "context": "all",
      "body": "We'll get started on it right away",
      "default": false
    }
  },
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/email_templates/{id}`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[email_templates]=id,created_at,updated_at`


### Includes

This request accepts the following includes:

`emails`






## Creating an email template



> How to create a email template:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/email_templates' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "email_templates",
        "attributes": {
          "name": "Webshop confirmation",
          "subject": "We received your order (#{{order.number}})",
          "body": "We'll get started on it right away. Your order number is #{{order.number}}.",
          "context": "order"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "2a82f7ea-0723-4253-bcce-322986ff97d3",
    "type": "email_templates",
    "attributes": {
      "name": "Webshop confirmation",
      "identifier": "webshop_confirmation",
      "subject": "We received your order (#{{order.number}})",
      "context": "order",
      "body": "We'll get started on it right away. Your order number is #{{order.number}}.",
      "default": false
    }
  },
  "links": {
    "self": "api/boomerang/email_templates?data%5Battributes%5D%5Bbody%5D=We%27ll+get+started+on+it+right+away.+Your+order+number+is+%23%7B%7Border.number%7D%7D.&data%5Battributes%5D%5Bcontext%5D=order&data%5Battributes%5D%5Bname%5D=Webshop+confirmation&data%5Battributes%5D%5Bsubject%5D=We+received+your+order+%28%23%7B%7Border.number%7D%7D%29&data%5Btype%5D=email_templates&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/email_templates?data%5Battributes%5D%5Bbody%5D=We%27ll+get+started+on+it+right+away.+Your+order+number+is+%23%7B%7Border.number%7D%7D.&data%5Battributes%5D%5Bcontext%5D=order&data%5Battributes%5D%5Bname%5D=Webshop+confirmation&data%5Battributes%5D%5Bsubject%5D=We+received+your+order+%28%23%7B%7Border.number%7D%7D%29&data%5Btype%5D=email_templates&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/email_templates?data%5Battributes%5D%5Bbody%5D=We%27ll+get+started+on+it+right+away.+Your+order+number+is+%23%7B%7Border.number%7D%7D.&data%5Battributes%5D%5Bcontext%5D=order&data%5Battributes%5D%5Bname%5D=Webshop+confirmation&data%5Battributes%5D%5Bsubject%5D=We+received+your+order+%28%23%7B%7Border.number%7D%7D%29&data%5Btype%5D=email_templates&page%5Bnumber%5D=1&page%5Bsize%5D=25"
  },
  "meta": {}
}
```

### HTTP Request

`POST /api/boomerang/email_templates`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[email_templates]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][name]` | **String**<br>Name of the template
`data[attributes][subject]` | **String**<br>Email subject line template
`data[attributes][context]` | **String**<br>Which documents the template applies to. One of `order`, `invoice`, `document`, `all`, `payment`, `user`
`data[attributes][body]` | **String**<br>Email body template


### Includes

This request does not accept any includes
## Updating an email template



> How to update an email template:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/email_templates/4bb48fe5-82dd-4a92-a650-29fd9e2ee5df' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "4bb48fe5-82dd-4a92-a650-29fd9e2ee5df",
        "type": "email_templates",
        "attributes": {
          "name": "Order confirmation"
        }
      }
    }'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "4bb48fe5-82dd-4a92-a650-29fd9e2ee5df",
    "type": "email_templates",
    "attributes": {
      "name": "Order confirmation",
      "identifier": "webshop_confirmation",
      "subject": "We received your order",
      "context": "all",
      "body": "We'll get started on it right away",
      "default": false
    }
  },
  "meta": {}
}
```


> How to update a default email template:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/email_templates/55fe9f9c-5c07-467e-b5b7-7160369270b0' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "55fe9f9c-5c07-467e-b5b7-7160369270b0",
        "type": "email_templates",
        "attributes": {
          "name": "Order confirmation"
        }
      }
    }'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "55fe9f9c-5c07-467e-b5b7-7160369270b0",
    "type": "email_templates",
    "attributes": {
      "name": "Order confirmation",
      "identifier": "webshop_confirmation",
      "subject": "We received your order",
      "context": "all",
      "body": "We'll get started on it right away",
      "default": true
    }
  },
  "meta": {}
}
```

### HTTP Request

`PUT /api/boomerang/email_templates/{id}`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[email_templates]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][name]` | **String**<br>Name of the template
`data[attributes][subject]` | **String**<br>Email subject line template
`data[attributes][context]` | **String**<br>Which documents the template applies to. One of `order`, `invoice`, `document`, `all`, `payment`, `user`
`data[attributes][body]` | **String**<br>Email body template


### Includes

This request does not accept any includes
## Deleting an email template



> How to delete a email template:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/email_templates/8c8e0236-93e8-47e4-baab-56a13d67d8e1' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "meta": {}
}
```


> Error trying to destroy a default email template:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/email_templates/be51ba0a-e065-43b6-94fb-3a5a33c07773' \
    --header 'content-type: application/json' \
```

> A 422 status response looks like this:

```json
  {
  "errors": [
    {
      "code": "unprocessable_entity",
      "status": "422",
      "title": "Unprocessable entity",
      "detail": "Can not destroy default templates",
      "meta": null
    }
  ]
}
```

### HTTP Request

`DELETE /api/boomerang/email_templates/{id}`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[email_templates]=id,created_at,updated_at`


### Includes

This request does not accept any includes