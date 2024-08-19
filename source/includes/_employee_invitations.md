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
    "id": "14abff28-8f7d-59e1-9ade-7dd674a56827",
    "type": "employee_invitations",
    "attributes": {
      "employee_id": "c82b27f7-1bb2-4b92-b55e-9e6347c2b660"
    },
    "relationships": {
      "employee": {
        "data": {
          "type": "employees",
          "id": "c82b27f7-1bb2-4b92-b55e-9e6347c2b660"
        }
      }
    }
  },
  "included": [
    {
      "id": "c82b27f7-1bb2-4b92-b55e-9e6347c2b660",
      "type": "employees",
      "attributes": {
        "created_at": "2024-08-19T09:27:38.796420+00:00",
        "updated_at": "2024-08-19T09:27:38.799281+00:00",
        "name": "John Doe",
        "firstname": "John",
        "lastname": "Doe",
        "locale": null,
        "email": "john@doe.com",
        "unconfirmed_email": null,
        "viewed_whats_new_at": "2024-08-19T09:27:38.797866+00:00",
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
          "id": "14d2d9be-63e2-4719-aee1-3a39d62fbf7d",
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
    "id": "14d2d9be-63e2-4719-aee1-3a39d62fbf7d",
    "type": "employee_invitations",
    "attributes": {
      "employee_id": "14d2d9be-63e2-4719-aee1-3a39d62fbf7d"
    },
    "relationships": {
      "employee": {
        "data": {
          "type": "employees",
          "id": "14d2d9be-63e2-4719-aee1-3a39d62fbf7d"
        }
      }
    }
  },
  "included": [
    {
      "id": "14d2d9be-63e2-4719-aee1-3a39d62fbf7d",
      "type": "employees",
      "attributes": {
        "created_at": "2024-08-19T09:27:39.400312+00:00",
        "updated_at": "2024-08-19T09:27:39.456110+00:00",
        "name": "John Doe",
        "firstname": "John",
        "lastname": "Doe",
        "locale": null,
        "email": "jane@doe.com",
        "unconfirmed_email": null,
        "viewed_whats_new_at": "2024-08-19T09:27:39.402636+00:00",
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





