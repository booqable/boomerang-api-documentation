# Email templates

Email templates allow for creating pre-filled emails with dynamic data. Booqable comes with automated templates which can be updated but not deleted.

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
-- | --
`id` | **Uuid** `readonly`<br>Primary key
`created_at` | **Datetime** `readonly`<br>When the resource was created
`updated_at` | **Datetime** `readonly`<br>When the resource was last updated
`name` | **String** <br>Name of the template
`identifier` | **String** `readonly`<br>A unique identifier assigned to this template
`subject` | **String** <br>Email subject line template
`context` | **String** <br>Which resource or process the template applies to. One of `order`, `invoice`, `document`, `all`, `payment`, `user`
`body` | **String** <br>Email body template
`default` | **Boolean** `readonly`<br>Whether this is a system default template
`automated` | **Boolean** `readonly`<br>When `true`, this template is used by built-in features and can not be deleted. Updating is possible.


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
      "id": "34a8e9e9-1984-4282-8d54-5952f3153133",
      "type": "email_templates",
      "attributes": {
        "created_at": "2024-07-08T09:30:23.747664+00:00",
        "updated_at": "2024-07-08T09:30:23.747664+00:00",
        "name": "Webshop confirmation",
        "identifier": "webshop_confirmation",
        "subject": "We received your order",
        "context": "all",
        "body": "We'll get started on it right away",
        "default": false,
        "automated": false
      }
    }
  ],
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/email_templates`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[email_templates]=created_at,updated_at,name`
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
`name` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`identifier` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`context` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`default` | **Boolean** <br>`eq`
`automated` | **Boolean** <br>`eq`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **Array** <br>`count`


### Includes

This request does not accept any includes
## Fetching an email template



> How to fetch an email templates:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/email_templates/93c0ef41-6c90-4b3c-b953-39749063a564' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "93c0ef41-6c90-4b3c-b953-39749063a564",
    "type": "email_templates",
    "attributes": {
      "created_at": "2024-07-08T09:30:23.245174+00:00",
      "updated_at": "2024-07-08T09:30:23.245174+00:00",
      "name": "Webshop confirmation",
      "identifier": "webshop_confirmation",
      "subject": "We received your order",
      "context": "all",
      "body": "We'll get started on it right away",
      "default": false,
      "automated": false
    }
  },
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/email_templates/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=emails`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[email_templates]=created_at,updated_at,name`


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
    "id": "02de182f-9968-40c0-99f5-dc22696d589b",
    "type": "email_templates",
    "attributes": {
      "created_at": "2024-07-08T09:30:22.740162+00:00",
      "updated_at": "2024-07-08T09:30:22.740162+00:00",
      "name": "Webshop confirmation",
      "identifier": "webshop_confirmation",
      "subject": "We received your order (#{{order.number}})",
      "context": "order",
      "body": "We'll get started on it right away. Your order number is #{{order.number}}.",
      "default": false,
      "automated": false
    }
  },
  "meta": {}
}
```

### HTTP Request

`POST /api/boomerang/email_templates`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[email_templates]=created_at,updated_at,name`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][name]` | **String** <br>Name of the template
`data[attributes][subject]` | **String** <br>Email subject line template
`data[attributes][context]` | **String** <br>Which resource or process the template applies to. One of `order`, `invoice`, `document`, `all`, `payment`, `user`
`data[attributes][body]` | **String** <br>Email body template


### Includes

This request does not accept any includes
## Updating an email template



> How to update an email template:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/email_templates/fb764bf0-3960-4c17-8cac-c9d95966cb0f' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "fb764bf0-3960-4c17-8cac-c9d95966cb0f",
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
    "id": "fb764bf0-3960-4c17-8cac-c9d95966cb0f",
    "type": "email_templates",
    "attributes": {
      "created_at": "2024-07-08T09:30:21.557107+00:00",
      "updated_at": "2024-07-08T09:30:21.596405+00:00",
      "name": "Order confirmation",
      "identifier": "webshop_confirmation",
      "subject": "We received your order",
      "context": "all",
      "body": "We'll get started on it right away",
      "default": false,
      "automated": false
    }
  },
  "meta": {}
}
```


> How to update a default email template:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/email_templates/255ee9f3-4684-4023-aeaf-06d7c7c80dca' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "255ee9f3-4684-4023-aeaf-06d7c7c80dca",
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
    "id": "255ee9f3-4684-4023-aeaf-06d7c7c80dca",
    "type": "email_templates",
    "attributes": {
      "created_at": "2024-07-08T09:30:22.121413+00:00",
      "updated_at": "2024-07-08T09:30:22.179934+00:00",
      "name": "Order confirmation",
      "identifier": "webshop_confirmation",
      "subject": "We received your order",
      "context": "all",
      "body": "We'll get started on it right away",
      "default": true,
      "automated": false
    }
  },
  "meta": {}
}
```

### HTTP Request

`PUT /api/boomerang/email_templates/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[email_templates]=created_at,updated_at,name`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][name]` | **String** <br>Name of the template
`data[attributes][subject]` | **String** <br>Email subject line template
`data[attributes][context]` | **String** <br>Which resource or process the template applies to. One of `order`, `invoice`, `document`, `all`, `payment`, `user`
`data[attributes][body]` | **String** <br>Email body template


### Includes

This request does not accept any includes
## Deleting an email template



> How to delete a email template:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/email_templates/33878c91-44fb-486c-9e30-348f2fd6cbe8' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "33878c91-44fb-486c-9e30-348f2fd6cbe8",
    "type": "email_templates",
    "attributes": {
      "created_at": "2024-07-08T09:30:24.258857+00:00",
      "updated_at": "2024-07-08T09:30:24.258857+00:00",
      "name": "Sales Tax",
      "identifier": "sales_tax",
      "subject": "This is a subject!",
      "context": "all",
      "body": "Hi there user!",
      "default": false,
      "automated": false
    }
  },
  "meta": {}
}
```

### HTTP Request

`DELETE /api/boomerang/email_templates/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[email_templates]=created_at,updated_at,name`


### Includes

This request does not accept any includes