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
- | -
`id` | **Uuid** `readonly`<br>Primary key
`created_at` | **Datetime** `readonly`<br>When the resource was created
`updated_at` | **Datetime** `readonly`<br>When the resource was last updated
`name` | **String** `readonly`<br>Full name of the employee
`firstname` | **String**<br>First name of the employee
`lastname` | **String**<br>Last name of the employee
`email` | **String**<br>Employee's e-mail address
`unconfirmed_email` | **String** `readonly`<br>Unconfirmed e-mail address if present
`current_password` | **String** `writeonly`<br>Current password, needed to update password or email address
`password` | **String** `writeonly`<br>Set a new password
`password_confirmation` | **String** `writeonly`<br>Confirm new password
`active` | **Boolean**<br>Whether this employee is active (counts towards billing)
`owner` | **Boolean** `readonly`<br>Whether this employee is the account owner
`confirmed` | **Boolean** `readonly`<br>Wheter this employee confirmed it's email address
`time_to_confirm` | **Integer** `readonly`<br>Time in days left to confirm
`permissions` | **Array**<br>Any of: `reports`, `products`, `settings`, `account`, `cancel_orders`, `revert_orders`, `delete_invoices`, `make_invoice_revisions`. All permissions are always returned when this feature is not included in the current pricing plan or if the employee is the account owner
`avatar_base64` | **String** `writeonly`<br>Base64 encoded avatar
`remove_avatar` | **Boolean** `writeonly`<br>Remove current avatar
`avatar_url` | **String** `readonly`<br>Url to avatar
`large_avatar_url` | **String** `readonly`<br>Url to avatar (Large)


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
      "id": "b674d759-729f-4c7a-bde6-c32ee8a3fb28",
      "type": "employees",
      "attributes": {
        "name": "John Doe",
        "firstname": "John",
        "lastname": "Doe",
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
          "account",
          "cancel_orders",
          "revert_orders",
          "delete_invoices",
          "make_invoice_revisions"
        ],
        "avatar_url": "https://gravatar.com/avatar/6a6c19fea4a3676970167ce51f39e6ee.png?d=blank",
        "large_avatar_url": "https://gravatar.com/avatar/6a6c19fea4a3676970167ce51f39e6ee.png?d=mm&size=200"
      }
    }
  ],
  "links": {
    "self": "api/boomerang/employees?page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/employees?page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/employees?page%5Bnumber%5D=1&page%5Bsize%5D=25"
  },
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/employees`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[employees]=id,created_at,updated_at`
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-10-26T09:51:27Z`
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
`email` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`active` | **Boolean**<br>`eq`
`owner` | **Boolean**<br>`eq`
`confirmed` | **Boolean**<br>`eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array**<br>`count`


### Includes

This request does not accept any includes
## Fetching an employee



> How to fetch a employee:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/employees/0d538a66-5247-42e8-a581-1d0351a94be1' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "0d538a66-5247-42e8-a581-1d0351a94be1",
    "type": "employees",
    "attributes": {
      "name": "John Doe",
      "firstname": "John",
      "lastname": "Doe",
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
        "account",
        "cancel_orders",
        "revert_orders",
        "delete_invoices",
        "make_invoice_revisions"
      ],
      "avatar_url": "https://gravatar.com/avatar/6a6c19fea4a3676970167ce51f39e6ee.png?d=blank",
      "large_avatar_url": "https://gravatar.com/avatar/6a6c19fea4a3676970167ce51f39e6ee.png?d=mm&size=200"
    }
  },
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/employees/{id}`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[employees]=id,created_at,updated_at`


### Includes

This request does not accept any includes
## Updating an employee



> How to update an employee:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/employees/9956fdf8-c0ee-42a6-899a-dd9cc7d02982' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "9956fdf8-c0ee-42a6-899a-dd9cc7d02982",
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
    "id": "9956fdf8-c0ee-42a6-899a-dd9cc7d02982",
    "type": "employees",
    "attributes": {
      "name": "Jane Doe",
      "firstname": "Jane",
      "lastname": "Doe",
      "email": "john@doe.com",
      "unconfirmed_email": null,
      "active": true,
      "owner": false,
      "confirmed": true,
      "time_to_confirm": 0,
      "permissions": [
        "reports",
        "products",
        "settings",
        "account",
        "cancel_orders",
        "revert_orders",
        "delete_invoices",
        "make_invoice_revisions"
      ],
      "avatar_url": "https://gravatar.com/avatar/6a6c19fea4a3676970167ce51f39e6ee.png?d=blank",
      "large_avatar_url": "https://gravatar.com/avatar/6a6c19fea4a3676970167ce51f39e6ee.png?d=mm&size=200"
    }
  },
  "meta": {}
}
```


> How to de-activate an employee:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/employees/07679f25-fa0e-4950-890e-7dc5ce1bbd05' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "07679f25-fa0e-4950-890e-7dc5ce1bbd05",
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
    "id": "07679f25-fa0e-4950-890e-7dc5ce1bbd05",
    "type": "employees",
    "attributes": {
      "name": "John Doe",
      "firstname": "John",
      "lastname": "Doe",
      "email": "john@doe.com",
      "unconfirmed_email": null,
      "active": false,
      "owner": false,
      "confirmed": true,
      "time_to_confirm": 0,
      "permissions": [
        "reports",
        "products",
        "settings",
        "account",
        "cancel_orders",
        "revert_orders",
        "delete_invoices",
        "make_invoice_revisions"
      ],
      "avatar_url": "https://gravatar.com/avatar/6a6c19fea4a3676970167ce51f39e6ee.png?d=blank",
      "large_avatar_url": "https://gravatar.com/avatar/6a6c19fea4a3676970167ce51f39e6ee.png?d=mm&size=200"
    }
  },
  "meta": {}
}
```


> How to set permissions:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/employees/fc80d2bf-c787-4eba-9031-578e8f482043' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "fc80d2bf-c787-4eba-9031-578e8f482043",
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
    "id": "fc80d2bf-c787-4eba-9031-578e8f482043",
    "type": "employees",
    "attributes": {
      "name": "John Doe",
      "firstname": "John",
      "lastname": "Doe",
      "email": "john@doe.com",
      "unconfirmed_email": null,
      "active": true,
      "owner": false,
      "confirmed": true,
      "time_to_confirm": 0,
      "permissions": [
        "reports",
        "settings"
      ],
      "avatar_url": "https://gravatar.com/avatar/6a6c19fea4a3676970167ce51f39e6ee.png?d=blank",
      "large_avatar_url": "https://gravatar.com/avatar/6a6c19fea4a3676970167ce51f39e6ee.png?d=mm&size=200"
    }
  },
  "meta": {}
}
```

### HTTP Request

`PUT /api/boomerang/employees/{id}`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[employees]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][firstname]` | **String**<br>First name of the employee
`data[attributes][lastname]` | **String**<br>Last name of the employee
`data[attributes][email]` | **String**<br>Employee's e-mail address
`data[attributes][current_password]` | **String**<br>Current password, needed to update password or email address
`data[attributes][password]` | **String**<br>Set a new password
`data[attributes][password_confirmation]` | **String**<br>Confirm new password
`data[attributes][active]` | **Boolean**<br>Whether this employee is active (counts towards billing)
`data[attributes][permissions][]` | **Array**<br>Any of: `reports`, `products`, `settings`, `account`, `cancel_orders`, `revert_orders`, `delete_invoices`, `make_invoice_revisions`. All permissions are always returned when this feature is not included in the current pricing plan or if the employee is the account owner
`data[attributes][avatar_base64]` | **String**<br>Base64 encoded avatar
`data[attributes][remove_avatar]` | **Boolean**<br>Remove current avatar


### Includes

This request does not accept any includes