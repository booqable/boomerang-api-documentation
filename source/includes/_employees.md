# Employees

Employees give access to a Booqable account. You can set different permissions for each employee and let other people use Booqable without giving them access to sensitive information (or taking other unwanted actions).

Employees also allow you to streamline Booqable's interface for specific roles or use cases. For example, if you create an account for someone dedicated to looking after your financials and accounting, it wouldn't need to manage your products and stock levels.

<aside class="notice">
  Note: The maximum number of seats for team members depends on the current pricing plan.
</aside>

## Endpoints
`GET /api/boomerang/employees`

`GET /api/boomerang/employees/{id}`

`PUT /api/boomerang/employees/{id}`

## Fields
Every employee has the following fields:

Name | Description
-- | --
`id` | **Uuid** `readonly`<br>Primary key
`created_at` | **Datetime** `readonly`<br>When the resource was created
`updated_at` | **Datetime** `readonly`<br>When the resource was last updated
`name` | **String** `readonly`<br>Full name of the employee
`firstname` | **String** <br>First name of the employee
`lastname` | **String** <br>Last name of the employee
`locale` | **String** <br>Locale of the employee, used as application locale
`email` | **String** <br>Employee's e-mail address
`unconfirmed_email` | **String** `readonly`<br>Unconfirmed e-mail address if present
`current_password` | **String** `writeonly`<br>Current password, needed to update password or email address
`password` | **String** `writeonly`<br>Set a new password
`password_confirmation` | **String** `writeonly`<br>Confirm new password
`active` | **Boolean** <br>Whether this employee is active (counts towards billing)
`deactivated_at` | **Datetime** `writeonly`<br>Employee deactivation date
`owner` | **Boolean** `readonly`<br>Whether this employee is the account owner
`confirmed` | **Boolean** `readonly`<br>Wheter this employee confirmed it's email address
`time_to_confirm` | **Integer** `readonly`<br>Time in days left to confirm
`permissions` | **Array** <br>Any of: `reports`, `products`, `settings`, `security_settings`, `account`, `exports`, `cancel_orders`, `revert_orders`, `delete_invoices`, `make_invoice_revisions`, `override_rental_period`. All permissions are always returned when this feature is not included in the current pricing plan or if the employee is the account owner
`avatar_base64` | **String** `writeonly`<br>Base64 encoded avatar
`remove_avatar` | **Boolean** `writeonly`<br>Remove current avatar
`has_two_factor_autentication` | **Boolean** `readonly`<br>Wheter two factor authentication is enabled
`avatar_url` | **String** `readonly`<br>Url to avatar
`large_avatar_url` | **String** `readonly`<br>Url to avatar (Large)
`third_party_id` | **String** `readonly`<br>ID used for third party tools


## Listing employees



> How to fetch a list of employees:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/employees' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "02da3259-5f2a-421a-a914-d1d9667e8cf8",
      "type": "employees",
      "attributes": {
        "created_at": "2023-07-10T09:16:50+00:00",
        "updated_at": "2023-07-10T09:16:50+00:00",
        "name": "John Doe",
        "firstname": "John",
        "lastname": "Doe",
        "locale": null,
        "email": "john@doe.com",
        "unconfirmed_email": null,
        "active": true,
        "owner": true,
        "confirmed": true,
        "time_to_confirm": 0,
        "permissions": [
          "reports",
          "products",
          "settings",
          "security_settings",
          "account",
          "exports",
          "cancel_orders",
          "revert_orders",
          "delete_invoices",
          "make_invoice_revisions",
          "override_rental_period"
        ],
        "has_two_factor_autentication": false,
        "avatar_url": "https://gravatar.com/avatar/6a6c19fea4a3676970167ce51f39e6ee.png?d=404",
        "large_avatar_url": "https://gravatar.com/avatar/6a6c19fea4a3676970167ce51f39e6ee.png?d=mm&size=200"
      }
    }
  ],
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/employees`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[employees]=created_at,updated_at,name`
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
`locale` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`email` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`active` | **Boolean** <br>`eq`
`deactivated_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`owner` | **Boolean** <br>`eq`
`confirmed` | **Boolean** <br>`eq`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **Array** <br>`count`


### Includes

This request does not accept any includes
## Fetching an employee



> How to fetch a employee:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/employees/ff806c1c-f3c0-4ae1-b856-c34745f08ae1' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "ff806c1c-f3c0-4ae1-b856-c34745f08ae1",
    "type": "employees",
    "attributes": {
      "created_at": "2023-07-10T09:16:51+00:00",
      "updated_at": "2023-07-10T09:16:51+00:00",
      "name": "John Doe",
      "firstname": "John",
      "lastname": "Doe",
      "locale": null,
      "email": "john@doe.com",
      "unconfirmed_email": null,
      "active": true,
      "owner": true,
      "confirmed": true,
      "time_to_confirm": 0,
      "permissions": [
        "reports",
        "products",
        "settings",
        "security_settings",
        "account",
        "exports",
        "cancel_orders",
        "revert_orders",
        "delete_invoices",
        "make_invoice_revisions",
        "override_rental_period"
      ],
      "has_two_factor_autentication": false,
      "avatar_url": "https://gravatar.com/avatar/6a6c19fea4a3676970167ce51f39e6ee.png?d=404",
      "large_avatar_url": "https://gravatar.com/avatar/6a6c19fea4a3676970167ce51f39e6ee.png?d=mm&size=200"
    }
  },
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/employees/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[employees]=created_at,updated_at,name`


### Includes

This request does not accept any includes
## Updating an employee



> How to update an employee:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/employees/2b1ffebf-e6b6-407c-ae19-814dd94174b4' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "2b1ffebf-e6b6-407c-ae19-814dd94174b4",
        "type": "employees",
        "attributes": {
          "firstname": "Jane"
        }
      }
    }'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "2b1ffebf-e6b6-407c-ae19-814dd94174b4",
    "type": "employees",
    "attributes": {
      "created_at": "2023-07-10T09:16:51+00:00",
      "updated_at": "2023-07-10T09:16:51+00:00",
      "name": "Jane Doe",
      "firstname": "Jane",
      "lastname": "Doe",
      "locale": null,
      "email": "jane@doe.com",
      "unconfirmed_email": null,
      "active": true,
      "owner": false,
      "confirmed": true,
      "time_to_confirm": 0,
      "permissions": [
        "reports",
        "products",
        "settings",
        "security_settings",
        "account",
        "exports",
        "cancel_orders",
        "revert_orders",
        "delete_invoices",
        "make_invoice_revisions",
        "override_rental_period"
      ],
      "has_two_factor_autentication": false,
      "avatar_url": "https://gravatar.com/avatar/35f5782642e9fa0f6cfff5a552e2ae97.png?d=404",
      "large_avatar_url": "https://gravatar.com/avatar/35f5782642e9fa0f6cfff5a552e2ae97.png?d=mm&size=200"
    }
  },
  "meta": {}
}
```


> How to de-activate an employee:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/employees/4ce19d07-860e-410b-bd52-5df030c5c694' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "4ce19d07-860e-410b-bd52-5df030c5c694",
        "type": "employees",
        "attributes": {
          "active": false
        }
      }
    }'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "4ce19d07-860e-410b-bd52-5df030c5c694",
    "type": "employees",
    "attributes": {
      "created_at": "2023-07-10T09:16:52+00:00",
      "updated_at": "2023-07-10T09:16:53+00:00",
      "name": "John Doe",
      "firstname": "John",
      "lastname": "Doe",
      "locale": null,
      "email": "jane@doe.com",
      "unconfirmed_email": null,
      "active": false,
      "owner": false,
      "confirmed": true,
      "time_to_confirm": 0,
      "permissions": [
        "reports",
        "products",
        "settings",
        "security_settings",
        "account",
        "exports",
        "cancel_orders",
        "revert_orders",
        "delete_invoices",
        "make_invoice_revisions",
        "override_rental_period"
      ],
      "has_two_factor_autentication": false,
      "avatar_url": "https://gravatar.com/avatar/35f5782642e9fa0f6cfff5a552e2ae97.png?d=404",
      "large_avatar_url": "https://gravatar.com/avatar/35f5782642e9fa0f6cfff5a552e2ae97.png?d=mm&size=200"
    }
  },
  "meta": {}
}
```


> How to set permissions:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/employees/7972a43c-fa32-41a8-908d-58d94e588dd7' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "7972a43c-fa32-41a8-908d-58d94e588dd7",
        "type": "employees",
        "attributes": {
          "permissions": [
            "reports",
            "settings"
          ]
        }
      }
    }'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "7972a43c-fa32-41a8-908d-58d94e588dd7",
    "type": "employees",
    "attributes": {
      "created_at": "2023-07-10T09:16:53+00:00",
      "updated_at": "2023-07-10T09:16:53+00:00",
      "name": "John Doe",
      "firstname": "John",
      "lastname": "Doe",
      "locale": null,
      "email": "jane@doe.com",
      "unconfirmed_email": null,
      "active": true,
      "owner": false,
      "confirmed": true,
      "time_to_confirm": 0,
      "permissions": [
        "reports",
        "settings"
      ],
      "has_two_factor_autentication": false,
      "avatar_url": "https://gravatar.com/avatar/35f5782642e9fa0f6cfff5a552e2ae97.png?d=404",
      "large_avatar_url": "https://gravatar.com/avatar/35f5782642e9fa0f6cfff5a552e2ae97.png?d=mm&size=200"
    }
  },
  "meta": {}
}
```

### HTTP Request

`PUT /api/boomerang/employees/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[employees]=created_at,updated_at,name`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][firstname]` | **String** <br>First name of the employee
`data[attributes][lastname]` | **String** <br>Last name of the employee
`data[attributes][locale]` | **String** <br>Locale of the employee, used as application locale
`data[attributes][email]` | **String** <br>Employee's e-mail address
`data[attributes][current_password]` | **String** <br>Current password, needed to update password or email address
`data[attributes][password]` | **String** <br>Set a new password
`data[attributes][password_confirmation]` | **String** <br>Confirm new password
`data[attributes][active]` | **Boolean** <br>Whether this employee is active (counts towards billing)
`data[attributes][deactivated_at]` | **Datetime** <br>Employee deactivation date
`data[attributes][permissions][]` | **Array** <br>Any of: `reports`, `products`, `settings`, `security_settings`, `account`, `exports`, `cancel_orders`, `revert_orders`, `delete_invoices`, `make_invoice_revisions`, `override_rental_period`. All permissions are always returned when this feature is not included in the current pricing plan or if the employee is the account owner
`data[attributes][avatar_base64]` | **String** <br>Base64 encoded avatar
`data[attributes][remove_avatar]` | **Boolean** <br>Remove current avatar


### Includes

This request does not accept any includes