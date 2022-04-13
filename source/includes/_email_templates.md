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
      "id": "49d7c03d-9db6-4ab3-9e93-c1b5031b4467",
      "type": "email_templates",
      "attributes": {
        "created_at": "2022-04-13T06:34:24+00:00",
        "updated_at": "2022-04-13T06:34:24+00:00",
        "name": "Webshop confirmation",
        "identifier": "webshop_confirmation",
        "subject": "We received your order",
        "context": "all",
        "body": "We'll get started on it right away",
        "default": false
      }
    }
  ],
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-04-13T06:33:35Z`
`sort` | **String**<br>How to sort the data `?sort=-created_at`
`meta` | **Hash**<br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String**<br>The page to request
`page[size]` | **String**<br>The amount of items per page (max 100)


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
    --url 'https://example.booqable.com/api/boomerang/email_templates/32073efa-dcd0-402b-954d-34de260d1c76' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "32073efa-dcd0-402b-954d-34de260d1c76",
    "type": "email_templates",
    "attributes": {
      "created_at": "2022-04-13T06:34:25+00:00",
      "updated_at": "2022-04-13T06:34:25+00:00",
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
    "id": "55a77cdc-a9d9-45f2-93b4-784f886ea2aa",
    "type": "email_templates",
    "attributes": {
      "created_at": "2022-04-13T06:34:25+00:00",
      "updated_at": "2022-04-13T06:34:25+00:00",
      "name": "Webshop confirmation",
      "identifier": "webshop_confirmation",
      "subject": "We received your order (#{{order.number}})",
      "context": "order",
      "body": "We'll get started on it right away. Your order number is #{{order.number}}.",
      "default": false
    }
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
    --url 'https://example.booqable.com/api/boomerang/email_templates/9f6e4342-7001-4e09-85b4-0f53991a4a01' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "9f6e4342-7001-4e09-85b4-0f53991a4a01",
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
    "id": "9f6e4342-7001-4e09-85b4-0f53991a4a01",
    "type": "email_templates",
    "attributes": {
      "created_at": "2022-04-13T06:34:25+00:00",
      "updated_at": "2022-04-13T06:34:25+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/email_templates/844848d7-43fe-42b5-bbaa-ba803f67bd44' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "844848d7-43fe-42b5-bbaa-ba803f67bd44",
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
    "id": "844848d7-43fe-42b5-bbaa-ba803f67bd44",
    "type": "email_templates",
    "attributes": {
      "created_at": "2022-04-13T06:34:26+00:00",
      "updated_at": "2022-04-13T06:34:26+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/email_templates/3e608a0d-d239-4a4f-83f1-dbe818b5563c' \
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
    --url 'https://example.booqable.com/api/boomerang/email_templates/aeb97382-7310-468e-aeb9-2747072923e9' \
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