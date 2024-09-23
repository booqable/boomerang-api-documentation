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
    "id": "2bbed8dd-c8ed-5f25-9ca4-f31eef32b051",
    "type": "employee_invitations",
    "attributes": {
      "employee_id": "581df8b6-c5d7-457e-9537-280204058c7e"
    },
    "relationships": {
      "employee": {
        "data": {
          "type": "employees",
          "id": "581df8b6-c5d7-457e-9537-280204058c7e"
        }
      }
    }
  },
  "included": [
    {
      "id": "581df8b6-c5d7-457e-9537-280204058c7e",
      "type": "employees",
      "attributes": {
        "created_at": "2024-09-23T09:24:28.274518+00:00",
        "updated_at": "2024-09-23T09:24:28.277262+00:00",
        "name": "John Doe",
        "firstname": "John",
        "lastname": "Doe",
        "locale": null,
        "email": "john@doe.com",
        "unconfirmed_email": null,
        "viewed_whats_new_at": "2024-09-23T09:24:28.276021+00:00",
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
          "id": "52019045-aa6e-47e6-b4a3-9ec3da8a0465",
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
    "id": "52019045-aa6e-47e6-b4a3-9ec3da8a0465",
    "type": "employee_invitations",
    "attributes": {
      "employee_id": "52019045-aa6e-47e6-b4a3-9ec3da8a0465"
    },
    "relationships": {
      "employee": {
        "data": {
          "type": "employees",
          "id": "52019045-aa6e-47e6-b4a3-9ec3da8a0465"
        }
      }
    }
  },
  "included": [
    {
      "id": "52019045-aa6e-47e6-b4a3-9ec3da8a0465",
      "type": "employees",
      "attributes": {
        "created_at": "2024-09-23T09:24:27.639187+00:00",
        "updated_at": "2024-09-23T09:24:27.727569+00:00",
        "name": "John Doe",
        "firstname": "John",
        "lastname": "Doe",
        "locale": null,
        "email": "jane@doe.com",
        "unconfirmed_email": null,
        "viewed_whats_new_at": "2024-09-23T09:24:27.641440+00:00",
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





