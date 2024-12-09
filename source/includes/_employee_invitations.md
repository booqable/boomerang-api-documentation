# Employee invitations

Employees give access to a Booqable account. You can invite employees by sending an invitation.
For more info about employees see [Employees](#employees).

<aside class="notice">
  Note: The maximum number of seats for team members depends on the current pricing plan.
</aside>

## Relationships
Name | Description
-- | --
`employee` | **[Employee](#employees)** `optional`<br>The employee that is invited. 


Check matching attributes under [Fields](#employee-invitations-fields) to see which relations can be written.
<br/ >
Check each individual operation to see which relations can be included as a sideload.
## Fields

 Name | Description
-- | --
`email` | **string** `writeonly`<br>Employee's e-mail address. 
`employee_id` | **uuid** `nullable`<br>The employee that is invited. 
`firstname` | **string** `writeonly`<br>First name of the employee. 
`id` | **uuid** <br>Specify employee ID to re-send invitation. 
`lastname` | **string** `writeonly`<br>Last name of the employee. 
`permissions` | **array[string]** `writeonly`<br>Zero or more from: `reports`, `products`, `settings`, `security_settings`, `account`, `exports`, `cancel_orders`, `revert_orders`, `delete_invoices`, `make_invoice_revisions`, `override_rental_period`. 


## Sending invitations


> How to create an invitation:

```shell
  curl --request POST \
       --url 'https://example.booqable.com/api/boomerang/employee_invitations'
       --header 'content-type: application/json'
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
      "id": "bb80bf32-f049-4ea9-8090-006821195ab4",
      "type": "employee_invitations",
      "attributes": {
        "employee_id": "1ccdaa36-f317-4feb-8a06-003668fc0c59"
      },
      "relationships": {
        "employee": {
          "data": {
            "type": "employees",
            "id": "1ccdaa36-f317-4feb-8a06-003668fc0c59"
          }
        }
      }
    },
    "included": [
      {
        "id": "1ccdaa36-f317-4feb-8a06-003668fc0c59",
        "type": "employees",
        "attributes": {
          "created_at": "2020-01-26T19:11:05.000000+00:00",
          "updated_at": "2020-01-26T19:11:05.000000+00:00",
          "name": "John Doe",
          "firstname": "John",
          "lastname": "Doe",
          "locale": null,
          "email": "john@doe.com",
          "unconfirmed_email": null,
          "viewed_whats_new_at": "2020-01-26T19:11:05.000000+00:00",
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
       --url 'https://example.booqable.com/api/boomerang/employee_invitations'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "type": "employee_invitations",
           "attributes": {
             "id": "a5f55cdd-7e5a-46ea-84db-1c8352c8fa06",
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
      "id": "a5f55cdd-7e5a-46ea-84db-1c8352c8fa06",
      "type": "employee_invitations",
      "attributes": {
        "employee_id": "a5f55cdd-7e5a-46ea-84db-1c8352c8fa06"
      },
      "relationships": {
        "employee": {
          "data": {
            "type": "employees",
            "id": "a5f55cdd-7e5a-46ea-84db-1c8352c8fa06"
          }
        }
      }
    },
    "included": [
      {
        "id": "a5f55cdd-7e5a-46ea-84db-1c8352c8fa06",
        "type": "employees",
        "attributes": {
          "created_at": "2020-05-11T21:58:00.000000+00:00",
          "updated_at": "2020-05-11T21:58:00.000000+00:00",
          "name": "John Doe",
          "firstname": "John",
          "lastname": "Doe",
          "locale": null,
          "email": "jane@doe.com",
          "unconfirmed_email": null,
          "viewed_whats_new_at": "2020-05-11T21:58:00.000000+00:00",
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
`fields[]` | **array** <br>List of comma seperated fields to include `?fields[employee_invitations]=employee_id`
`include` | **string** <br>List of comma seperated relationships `?include=employee`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][email]` | **string** <br>Employee's e-mail address. 
`data[attributes][employee_id]` | **uuid** <br>The employee that is invited. 
`data[attributes][firstname]` | **string** <br>First name of the employee. 
`data[attributes][id]` | **uuid** <br>Specify employee ID to re-send invitation. 
`data[attributes][lastname]` | **string** <br>Last name of the employee. 
`data[attributes][permissions]` | **array[string]** <br>Zero or more from: `reports`, `products`, `settings`, `security_settings`, `account`, `exports`, `cancel_orders`, `revert_orders`, `delete_invoices`, `make_invoice_revisions`, `override_rental_period`. 


### Includes

This request accepts the following includes:

`employee`





