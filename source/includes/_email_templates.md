# Email templates

Email templates allow for creating pre-filled emails with dynamic data.
Booqable comes with a couple of default templates which can be updated but not deleted.

For more information about using variables for dynamic data in e-mail templates
see [our help center](https://help.booqable.com/en/articles/3832164-emails-types-and-templates)

## Fields

 Name | Description
-- | --
`automated` | **boolean** `readonly`<br>When `true`, this template is used by built-in features and can not be deleted. Updating is possible.
`body` | **string** <br>Email body template.
`context` | **enum** <br>Which resource or process the template applies to.<br>One of: `order`, `invoice`, `document`, `all`, `payment`, `user`.
`created_at` | **datetime** `readonly`<br>When the resource was created.
`default` | **boolean** `readonly`<br>Whether this is a system default template.
`id` | **uuid** `readonly`<br>Primary key.
`identifier` | **string** `readonly`<br>A unique identifier assigned to this template.
`name` | **string** <br>Name of the template.
`subject` | **string** <br>Email subject line template.
`updated_at` | **datetime** `readonly`<br>When the resource was last updated.


## List email templates


> How to fetch a list of email templates:

```shell
  curl --get 'https://example.booqable.com/api/boomerang/email_templates'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": [
      {
        "id": "e0a7c360-45c6-4a04-81c5-8886d3aeb275",
        "type": "email_templates",
        "attributes": {
          "created_at": "2018-07-14T00:07:00.000000+00:00",
          "updated_at": "2018-07-14T00:07:00.000000+00:00",
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
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[email_templates]=created_at,updated_at,name`
`filter` | **hash** <br>The filters to apply `?filter[attribute][eq]=value`
`meta` | **hash** <br>Metadata to send along. `?meta[total][]=count`
`page[number]` | **string** <br>The page to request.
`page[size]` | **string** <br>The amount of items per page.
`sort` | **string** <br>How to sort the data. `?sort=attribute1,-attribute2`


### Filters

This request can be filtered on:

Name | Description
-- | --
`automated` | **boolean** <br>`eq`
`context` | **enum** <br>`eq`
`created_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`default` | **boolean** <br>`eq`
`id` | **uuid** <br>`eq`, `not_eq`
`identifier` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`name` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`updated_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **array** <br>`count`


### Includes

This request does not accept any includes
## Fetch an email template


> How to fetch an email template:

```shell
  curl --get 'https://example.booqable.com/api/boomerang/email_templates/95b3a72d-9c05-4c26-8679-d2ecd5ff2739'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "95b3a72d-9c05-4c26-8679-d2ecd5ff2739",
      "type": "email_templates",
      "attributes": {
        "created_at": "2023-09-05T22:46:01.000000+00:00",
        "updated_at": "2023-09-05T22:46:01.000000+00:00",
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
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[email_templates]=created_at,updated_at,name`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=emails`


### Includes

This request accepts the following includes:

`emails`






## Create an email template


> How to create a email template:

```shell
  curl --request POST
       --url 'https://example.booqable.com/api/boomerang/email_templates'
       --header 'content-type: application/json'
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
      "id": "fdb97b9d-4542-44dc-856e-510228b6d83a",
      "type": "email_templates",
      "attributes": {
        "created_at": "2019-09-07T19:36:01.000000+00:00",
        "updated_at": "2019-09-07T19:36:01.000000+00:00",
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
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[email_templates]=created_at,updated_at,name`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][body]` | **string** <br>Email body template.
`data[attributes][context]` | **enum** <br>Which resource or process the template applies to.<br>One of: `order`, `invoice`, `document`, `all`, `payment`, `user`.
`data[attributes][name]` | **string** <br>Name of the template.
`data[attributes][subject]` | **string** <br>Email subject line template.


### Includes

This request does not accept any includes
## Update an email template


> How to update an email template:

```shell
  curl --request PUT
       --url 'https://example.booqable.com/api/boomerang/email_templates/8cc919ef-bada-48fa-8d22-1ee523f0e88f'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "id": "8cc919ef-bada-48fa-8d22-1ee523f0e88f",
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
      "id": "8cc919ef-bada-48fa-8d22-1ee523f0e88f",
      "type": "email_templates",
      "attributes": {
        "created_at": "2027-11-19T06:26:00.000000+00:00",
        "updated_at": "2027-11-19T06:26:00.000000+00:00",
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
  curl --request PUT
       --url 'https://example.booqable.com/api/boomerang/email_templates/f4304c84-6349-470c-875b-7bc8ac0dd626'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "id": "f4304c84-6349-470c-875b-7bc8ac0dd626",
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
      "id": "f4304c84-6349-470c-875b-7bc8ac0dd626",
      "type": "email_templates",
      "attributes": {
        "created_at": "2017-06-27T23:42:00.000000+00:00",
        "updated_at": "2017-06-27T23:42:00.000000+00:00",
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
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[email_templates]=created_at,updated_at,name`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][body]` | **string** <br>Email body template.
`data[attributes][context]` | **enum** <br>Which resource or process the template applies to.<br>One of: `order`, `invoice`, `document`, `all`, `payment`, `user`.
`data[attributes][name]` | **string** <br>Name of the template.
`data[attributes][subject]` | **string** <br>Email subject line template.


### Includes

This request does not accept any includes
## Delete an email template


> How to delete a email template:

```shell
  curl --request DELETE
       --url 'https://example.booqable.com/api/boomerang/email_templates/1353d9c3-b214-4b45-8153-505e3ab4d573'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "1353d9c3-b214-4b45-8153-505e3ab4d573",
      "type": "email_templates",
      "attributes": {
        "created_at": "2019-10-07T17:21:00.000000+00:00",
        "updated_at": "2019-10-07T17:21:00.000000+00:00",
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
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[email_templates]=created_at,updated_at,name`


### Includes

This request does not accept any includes