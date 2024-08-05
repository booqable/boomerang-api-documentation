# Employee invitations

Employees give access to a Booqable account. You can invite employees by sending an invitation. For more info about employees see [Employees](#employees).

<aside class="notice">
  Note: The maximum number of seats for team members depends on the current pricing plan.
</aside>

## Fields
Every employee invitation has the following fields:

Name | Description
-- | --
`id` | **Uuid** <br>Specify employee ID to re-send invitation
`firstname` | **String** `writeonly`<br>First name of the employee
`lastname` | **String** `writeonly`<br>Last name of the employee
`email` | **String** `writeonly`<br>Employee's e-mail address
`permissions` | **Array** `writeonly`<br>Any of: `reports`, `products`, `settings`, `security_settings`, `account`, `exports`, `cancel_orders`, `revert_orders`, `delete_invoices`, `make_invoice_revisions`, `override_rental_period`
`employee_id` | **Uuid** <br>The associated Employee


## Relationships
Employee invitations have the following relationships:

Name | Description
-- | --
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
    "id": "4b63f482-969b-55d6-a6b7-0de0bb9aeb4e",
    "type": "employee_invitations",
    "attributes": {
      "employee_id": "b2df0732-c5c9-4e72-8e1d-6d2b5845139f"
    },
    "relationships": {
      "employee": {
        "data": {
          "type": "employees",
          "id": "b2df0732-c5c9-4e72-8e1d-6d2b5845139f"
        }
      }
    }
  },
  "included": [
    {
      "id": "b2df0732-c5c9-4e72-8e1d-6d2b5845139f",
      "type": "employees",
      "attributes": {
        "created_at": "2024-08-05T09:27:45.989308+00:00",
        "updated_at": "2024-08-05T09:27:45.991955+00:00",
        "name": "John Doe",
        "firstname": "John",
        "lastname": "Doe",
        "locale": null,
        "email": "john@doe.com",
        "unconfirmed_email": null,
        "viewed_whats_new_at": "2024-08-05T09:27:45.990764+00:00",
        "active": true,
        "owner": false,
        "confirmed": false,
        "time_to_confirm": 0,
        "permissions": [],
        "has_two_factor_autentication": false,
        "avatar_url": "https://gravatar.com/avatar/6a6c19fea4a3676970167ce51f39e6ee.png?d=404",
        "large_avatar_url": "https://gravatar.com/avatar/6a6c19fea4a3676970167ce51f39e6ee.png?d=mm&size=200"
      }
    }
  ],
  "meta": {}
}
```


> To re-send an invitation we supply the ID the employee for which the invitation was sent.
Note that you can also update other fields.:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/employee_invitations' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "employee_invitations",
        "attributes": {
          "id": "5a967017-7214-4309-bb07-4246bcbe3a4b",
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
    "id": "5a967017-7214-4309-bb07-4246bcbe3a4b",
    "type": "employee_invitations",
    "attributes": {
      "employee_id": "5a967017-7214-4309-bb07-4246bcbe3a4b"
    },
    "relationships": {
      "employee": {
        "data": {
          "type": "employees",
          "id": "5a967017-7214-4309-bb07-4246bcbe3a4b"
        }
      }
    }
  },
  "included": [
    {
      "id": "5a967017-7214-4309-bb07-4246bcbe3a4b",
      "type": "employees",
      "attributes": {
        "created_at": "2024-08-05T09:27:46.526307+00:00",
        "updated_at": "2024-08-05T09:27:46.571349+00:00",
        "name": "John Doe",
        "firstname": "John",
        "lastname": "Doe",
        "locale": null,
        "email": "jane@doe.com",
        "unconfirmed_email": null,
        "viewed_whats_new_at": "2024-08-05T09:27:46.528356+00:00",
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
        "avatar_url": "https://gravatar.com/avatar/35f5782642e9fa0f6cfff5a552e2ae97.png?d=404",
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

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=employee`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[employee_invitations]=employee_id`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][id]` | **Uuid** <br>Specify employee ID to re-send invitation
`data[attributes][firstname]` | **String** <br>First name of the employee
`data[attributes][lastname]` | **String** <br>Last name of the employee
`data[attributes][email]` | **String** <br>Employee's e-mail address
`data[attributes][permissions][]` | **Array** <br>Any of: `reports`, `products`, `settings`, `security_settings`, `account`, `exports`, `cancel_orders`, `revert_orders`, `delete_invoices`, `make_invoice_revisions`, `override_rental_period`
`data[attributes][employee_id]` | **Uuid** <br>The associated Employee


### Includes

This request accepts the following includes:

`employee`





