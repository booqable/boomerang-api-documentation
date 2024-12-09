# Employees

Employees give access to a Booqable account. You can set different permissions for each employee
and let other people use Booqable without giving them access to sensitive information.

Employees also allow you to streamline Booqable's interface for specific roles or use cases.
For example, if you create an account for someone dedicated to looking after your financials
and accounting, it wouldn't need to manage your products and stock levels.

<aside class="notice">
  The following depends on the current pricing plan:
  <ul>
    <li>The maximum number of seats for team members.</li>
    <li>The option to set employee permissions.</li>
  </ul>
</aside>

## Fields

 Name | Description
-- | --
`active` | **boolean** <br>Whether this employee is active (counts towards billing). 
`avatar_base64` | **string** `writeonly`<br>Base64 encoded avatar. 
`avatar_url` | **string** `readonly`<br>Url to avatar. 
`confirmed` | **boolean** `readonly`<br>Whether this employee confirmed it's email address. 
`created_at` | **datetime** `readonly`<br>When the resource was created.
`current_password` | **string** `writeonly`<br>Current password, needed to update password or email address. 
`deactivated_at` | **datetime** `writeonly`<br>Employee deactivation date. 
`email` | **string** <br>Employee's e-mail address. 
`firstname` | **string** <br>First name of the employee. 
`has_two_factor_autentication` | **boolean** `readonly`<br>Whether two factor authentication is enabled. 
`id` | **uuid** `readonly`<br>Primary key.
`large_avatar_url` | **string** `readonly`<br>Url to avatar (Large). 
`lastname` | **string** <br>Last name of the employee. 
`locale` | **string** <br>Locale of the employee, used as application locale. 
`name` | **string** `readonly`<br>Full name of the employee. 
`owner` | **boolean** `readonly`<br>Whether this employee is the account owner. 
`password` | **string** `writeonly`<br>Set a new password. 
`password_confirmation` | **string** `writeonly`<br>Confirm new password. 
`permissions` | **array** <br>Zero or more from: `reports`, `products`, `settings`, `security_settings`, `account`, `exports`, `cancel_orders`, `revert_orders`, `delete_invoices`, `make_invoice_revisions`, `override_rental_period`. All permissions are always returned when the roles & permissions feature is not included in the current pricing plan or if the employee is the account owner. 
`remove_avatar` | **boolean** `writeonly`<br>Remove current avatar. 
`third_party_id` | **string** `readonly`<br>ID used for third party tools. 
`time_to_confirm` | **integer** `readonly`<br>Time in days left to confirm. 
`unconfirmed_email` | **string** `readonly`<br>Unconfirmed e-mail address if present. 
`updated_at` | **datetime** `readonly`<br>When the resource was last updated.
`viewed_whats_new_at` | **datetime** <br>Date when this employee viewed product updates for the last time. 


## Listing employees


> How to fetch a list of employees:

```shell
  curl --get 'https://example.booqable.com/api/boomerang/employees'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": [
      {
        "id": "9e27ff9f-0909-42c7-81b2-3bb9f34ad507",
        "type": "employees",
        "attributes": {
          "created_at": "2021-09-07T07:00:00.000000+00:00",
          "updated_at": "2021-09-07T07:00:00.000000+00:00",
          "name": "John Doe",
          "firstname": "John",
          "lastname": "Doe",
          "locale": null,
          "email": "john@doe.com",
          "unconfirmed_email": null,
          "viewed_whats_new_at": "2021-09-07T07:00:00.000000+00:00",
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
`fields[]` | **array** <br>List of comma seperated fields to include `?fields[employees]=created_at,updated_at,name`
`filter` | **hash** <br>The filters to apply `?filter[attribute][eq]=value`
`meta` | **hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **string** <br>The page to request
`page[size]` | **string** <br>The amount of items per page (max 100)
`sort` | **string** <br>How to sort the data `?sort=attribute1,-attribute2`


### Filters

This request can be filtered on:

Name | Description
-- | --
`active` | **boolean** <br>`eq`
`confirmed` | **boolean** <br>`eq`
`created_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`deactivated_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`email` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`id` | **uuid** <br>`eq`, `not_eq`
`locale` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`owner` | **boolean** <br>`eq`
`updated_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **array** <br>`count`


### Includes

This request does not accept any includes
## Fetching an employee


> How to fetch a employee:

```shell
  curl --get 'https://example.booqable.com/api/boomerang/employees/4c367dac-4839-49f3-89e4-ff584a1f30e0'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "4c367dac-4839-49f3-89e4-ff584a1f30e0",
      "type": "employees",
      "attributes": {
        "created_at": "2015-05-14T01:40:00.000000+00:00",
        "updated_at": "2015-05-14T01:40:00.000000+00:00",
        "name": "John Doe",
        "firstname": "John",
        "lastname": "Doe",
        "locale": null,
        "email": "john@doe.com",
        "unconfirmed_email": null,
        "viewed_whats_new_at": "2015-05-14T01:40:00.000000+00:00",
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
`fields[]` | **array** <br>List of comma seperated fields to include `?fields[employees]=created_at,updated_at,name`


### Includes

This request does not accept any includes
## Updating an employee


> How to update an employee:

```shell
  curl --request PUT \
       --url 'https://example.booqable.com/api/boomerang/employees/cebcf411-1b2a-402f-8d77-43c67daf282f'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "id": "cebcf411-1b2a-402f-8d77-43c67daf282f",
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
      "id": "cebcf411-1b2a-402f-8d77-43c67daf282f",
      "type": "employees",
      "attributes": {
        "created_at": "2016-10-03T04:30:00.000000+00:00",
        "updated_at": "2016-10-03T04:30:00.000000+00:00",
        "name": "Jane Doe",
        "firstname": "Jane",
        "lastname": "Doe",
        "locale": null,
        "email": "jane@doe.com",
        "unconfirmed_email": null,
        "viewed_whats_new_at": "2016-10-03T04:30:00.000000+00:00",
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
       --url 'https://example.booqable.com/api/boomerang/employees/b40a7c1c-5190-4d54-8cea-405d36944a87'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "id": "b40a7c1c-5190-4d54-8cea-405d36944a87",
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
      "id": "b40a7c1c-5190-4d54-8cea-405d36944a87",
      "type": "employees",
      "attributes": {
        "created_at": "2014-10-16T17:49:01.000000+00:00",
        "updated_at": "2014-10-16T17:49:01.000000+00:00",
        "name": "John Doe",
        "firstname": "John",
        "lastname": "Doe",
        "locale": null,
        "email": "jane@doe.com",
        "unconfirmed_email": null,
        "viewed_whats_new_at": "2014-10-16T17:49:01.000000+00:00",
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
       --url 'https://example.booqable.com/api/boomerang/employees/94b3f0ff-ef32-49be-8f5f-7aa6916cc901'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "id": "94b3f0ff-ef32-49be-8f5f-7aa6916cc901",
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
      "id": "94b3f0ff-ef32-49be-8f5f-7aa6916cc901",
      "type": "employees",
      "attributes": {
        "created_at": "2027-04-16T02:37:01.000000+00:00",
        "updated_at": "2027-04-16T02:37:01.000000+00:00",
        "name": "John Doe",
        "firstname": "John",
        "lastname": "Doe",
        "locale": null,
        "email": "jane@doe.com",
        "unconfirmed_email": null,
        "viewed_whats_new_at": "2027-04-16T02:37:01.000000+00:00",
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
`fields[]` | **array** <br>List of comma seperated fields to include `?fields[employees]=created_at,updated_at,name`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][active]` | **boolean** <br>Whether this employee is active (counts towards billing). 
`data[attributes][avatar_base64]` | **string** <br>Base64 encoded avatar. 
`data[attributes][current_password]` | **string** <br>Current password, needed to update password or email address. 
`data[attributes][deactivated_at]` | **datetime** <br>Employee deactivation date. 
`data[attributes][email]` | **string** <br>Employee's e-mail address. 
`data[attributes][firstname]` | **string** <br>First name of the employee. 
`data[attributes][lastname]` | **string** <br>Last name of the employee. 
`data[attributes][locale]` | **string** <br>Locale of the employee, used as application locale. 
`data[attributes][password]` | **string** <br>Set a new password. 
`data[attributes][password_confirmation]` | **string** <br>Confirm new password. 
`data[attributes][permissions][]` | **array** <br>Zero or more from: `reports`, `products`, `settings`, `security_settings`, `account`, `exports`, `cancel_orders`, `revert_orders`, `delete_invoices`, `make_invoice_revisions`, `override_rental_period`. All permissions are always returned when the roles & permissions feature is not included in the current pricing plan or if the employee is the account owner. 
`data[attributes][remove_avatar]` | **boolean** <br>Remove current avatar. 
`data[attributes][viewed_whats_new_at]` | **datetime** <br>Date when this employee viewed product updates for the last time. 


### Includes

This request does not accept any includes