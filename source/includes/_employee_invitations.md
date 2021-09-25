# Employee invitations

Employees give access to a Booqable account. You can invite employees by sending an invitation. For more info about employees see [Employees](#employees).

<aside class="notice">
  Note: The maximum number of seats for team members depends on the current pricing plan.
</aside>

## Endpoints
`POST /api/boomerang/employee_invitations`

## Fields
Every employee invitation has the following fields:

Name | Description
- | -
`id` | **Uuid**<br>Specify employee ID to re-send invitation
`created_at` | **Datetime** `readonly`<br>When the resource was created
`updated_at` | **Datetime** `readonly`<br>When the resource was last updated
`firstname` | **String** `writeonly`<br>First name of the employee
`lastname` | **String** `writeonly`<br>Last name of the employee
`email` | **String** `writeonly`<br>Employee's e-mail address
`permissions` | **Array** `writeonly`<br>Any of: `reports`, `products`, `settings`, `account`, `cancel_orders`, `revert_orders`, `delete_invoices`, `make_invoice_revisions`
`employee_id` | **Uuid**<br>The associated Employee


## Relationships
A employee invitations has the following relationships:

Name | Description
- | -
`employee` | **Employees** `readonly`<br>Associated Employee


## Sending invitations

> How to create an invitation:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/employee_invitations' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "employee_invitations",
        "attributes": {
          "firstname": "John",
          "lastname": "Doe",
          "email": "john@doe.com"
        }
      },
      "include": "employee"
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "23934691-c17b-5841-b50c-23dc9ebcc03f",
    "type": "employee_invitations",
    "attributes": {
      "created_at": null,
      "updated_at": null,
      "employee_id": "cb4e3e7c-078f-4b1a-a29c-7c76e8e4a9fd"
    },
    "relationships": {
      "employee": {
        "data": {
          "type": "employees",
          "id": "cb4e3e7c-078f-4b1a-a29c-7c76e8e4a9fd"
        }
      }
    }
  },
  "included": [
    {
      "id": "cb4e3e7c-078f-4b1a-a29c-7c76e8e4a9fd",
      "type": "employees",
      "attributes": {
        "created_at": "2021-09-25T11:37:00+00:00",
        "updated_at": "2021-09-25T11:37:00+00:00",
        "name": "John Doe",
        "firstname": "John",
        "lastname": "Doe",
        "email": "john@doe.com",
        "unconfirmed_email": null,
        "active": true,
        "owner": false,
        "confirmed": false,
        "time_to_confirm": 0,
        "permissions": [],
        "avatar_url": "https://gravatar.com/avatar/6a6c19fea4a3676970167ce51f39e6ee.png?d=blank",
        "large_avatar_url": "https://gravatar.com/avatar/6a6c19fea4a3676970167ce51f39e6ee.png?d=mm&size=200"
      }
    }
  ],
  "meta": {}
}
```


> To re-send an invitation we supply the ID the employee for which the invitation was sent.
Note that you can also update other fields.

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/employee_invitations' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "employee_invitations",
        "attributes": {
          "id": "f05d5676-d7e9-4b9b-9a9a-7af4736c9aec",
          "email": "jane@doe.com"
        }
      },
      "include": "employee"
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "f05d5676-d7e9-4b9b-9a9a-7af4736c9aec",
    "type": "employee_invitations",
    "attributes": {
      "created_at": null,
      "updated_at": null,
      "employee_id": "f05d5676-d7e9-4b9b-9a9a-7af4736c9aec"
    },
    "relationships": {
      "employee": {
        "data": {
          "type": "employees",
          "id": "f05d5676-d7e9-4b9b-9a9a-7af4736c9aec"
        }
      }
    }
  },
  "included": [
    {
      "id": "f05d5676-d7e9-4b9b-9a9a-7af4736c9aec",
      "type": "employees",
      "attributes": {
        "created_at": "2021-09-25T11:37:00+00:00",
        "updated_at": "2021-09-25T11:37:00+00:00",
        "name": "John Doe",
        "firstname": "John",
        "lastname": "Doe",
        "email": "jane@doe.com",
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
        "avatar_url": "https://gravatar.com/avatar/35f5782642e9fa0f6cfff5a552e2ae97.png?d=blank",
        "large_avatar_url": "https://gravatar.com/avatar/35f5782642e9fa0f6cfff5a552e2ae97.png?d=mm&size=200"
      }
    }
  ],
  "meta": {}
}
```


### HTTP Request

`POST /api/boomerang/employee_invitations`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=employee`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[employee_invitations]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][id]` | **Uuid**<br>Specify employee ID to re-send invitation
`data[attributes][firstname]` | **String**<br>First name of the employee
`data[attributes][lastname]` | **String**<br>Last name of the employee
`data[attributes][email]` | **String**<br>Employee's e-mail address
`data[attributes][permissions][]` | **Array**<br>Any of: `reports`, `products`, `settings`, `account`, `cancel_orders`, `revert_orders`, `delete_invoices`, `make_invoice_revisions`
`data[attributes][employee_id]` | **Uuid**<br>The associated Employee


### Includes

This request accepts the following includes:

`employee`





