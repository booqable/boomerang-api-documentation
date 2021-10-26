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
`firstname` | **String** `writeonly`<br>First name of the employee
`lastname` | **String** `writeonly`<br>Last name of the employee
`email` | **String** `writeonly`<br>Employee's e-mail address
`permissions` | **Array** `writeonly`<br>Any of: `reports`, `products`, `settings`, `account`, `cancel_orders`, `revert_orders`, `delete_invoices`, `make_invoice_revisions`
`employee_id` | **Uuid**<br>The associated Employee


## Relationships
Employee invitations have the following relationships:

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
    "id": "386d4549-ba89-5441-b553-dd4dbcee1dde",
    "type": "employee_invitations",
    "attributes": {
      "employee_id": "1db79e3b-1e28-4c3e-8d9a-dc2136401e65"
    },
    "relationships": {
      "employee": {
        "data": {
          "type": "employees",
          "id": "1db79e3b-1e28-4c3e-8d9a-dc2136401e65"
        }
      }
    }
  },
  "included": [
    {
      "id": "1db79e3b-1e28-4c3e-8d9a-dc2136401e65",
      "type": "employees",
      "attributes": {
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
  "links": {
    "self": "api/boomerang/employee_invitations?data%5Battributes%5D%5Bemail%5D=john%40doe.com&data%5Battributes%5D%5Bfirstname%5D=John&data%5Battributes%5D%5Blastname%5D=Doe&data%5Btype%5D=employee_invitations&employee_invitation%5Bdata%5D%5Battributes%5D%5Bemail%5D=john%40doe.com&employee_invitation%5Bdata%5D%5Battributes%5D%5Bfirstname%5D=John&employee_invitation%5Bdata%5D%5Battributes%5D%5Blastname%5D=Doe&employee_invitation%5Bdata%5D%5Btype%5D=employee_invitations&employee_invitation%5Binclude%5D=employee&include=employee&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/employee_invitations?data%5Battributes%5D%5Bemail%5D=john%40doe.com&data%5Battributes%5D%5Bfirstname%5D=John&data%5Battributes%5D%5Blastname%5D=Doe&data%5Btype%5D=employee_invitations&employee_invitation%5Bdata%5D%5Battributes%5D%5Bemail%5D=john%40doe.com&employee_invitation%5Bdata%5D%5Battributes%5D%5Bfirstname%5D=John&employee_invitation%5Bdata%5D%5Battributes%5D%5Blastname%5D=Doe&employee_invitation%5Bdata%5D%5Btype%5D=employee_invitations&employee_invitation%5Binclude%5D=employee&include=employee&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/employee_invitations?data%5Battributes%5D%5Bemail%5D=john%40doe.com&data%5Battributes%5D%5Bfirstname%5D=John&data%5Battributes%5D%5Blastname%5D=Doe&data%5Btype%5D=employee_invitations&employee_invitation%5Bdata%5D%5Battributes%5D%5Bemail%5D=john%40doe.com&employee_invitation%5Bdata%5D%5Battributes%5D%5Bfirstname%5D=John&employee_invitation%5Bdata%5D%5Battributes%5D%5Blastname%5D=Doe&employee_invitation%5Bdata%5D%5Btype%5D=employee_invitations&employee_invitation%5Binclude%5D=employee&include=employee&page%5Bnumber%5D=&page%5Bsize%5D=25",
    "next": "api/boomerang/employee_invitations?data%5Battributes%5D%5Bemail%5D=john%40doe.com&data%5Battributes%5D%5Bfirstname%5D=John&data%5Battributes%5D%5Blastname%5D=Doe&data%5Btype%5D=employee_invitations&employee_invitation%5Bdata%5D%5Battributes%5D%5Bemail%5D=john%40doe.com&employee_invitation%5Bdata%5D%5Battributes%5D%5Bfirstname%5D=John&employee_invitation%5Bdata%5D%5Battributes%5D%5Blastname%5D=Doe&employee_invitation%5Bdata%5D%5Btype%5D=employee_invitations&employee_invitation%5Binclude%5D=employee&include=employee&page%5Bnumber%5D=2&page%5Bsize%5D=25"
  },
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
          "id": "d55c290c-2454-4d7f-86ef-25c7391c9ec6",
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
    "id": "d55c290c-2454-4d7f-86ef-25c7391c9ec6",
    "type": "employee_invitations",
    "attributes": {
      "employee_id": "d55c290c-2454-4d7f-86ef-25c7391c9ec6"
    },
    "relationships": {
      "employee": {
        "data": {
          "type": "employees",
          "id": "d55c290c-2454-4d7f-86ef-25c7391c9ec6"
        }
      }
    }
  },
  "included": [
    {
      "id": "d55c290c-2454-4d7f-86ef-25c7391c9ec6",
      "type": "employees",
      "attributes": {
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
  "links": {
    "self": "api/boomerang/employee_invitations?data%5Battributes%5D%5Bemail%5D=jane%40doe.com&data%5Battributes%5D%5Bid%5D=d55c290c-2454-4d7f-86ef-25c7391c9ec6&data%5Btype%5D=employee_invitations&employee_invitation%5Bdata%5D%5Battributes%5D%5Bemail%5D=jane%40doe.com&employee_invitation%5Bdata%5D%5Battributes%5D%5Bid%5D=d55c290c-2454-4d7f-86ef-25c7391c9ec6&employee_invitation%5Bdata%5D%5Btype%5D=employee_invitations&employee_invitation%5Binclude%5D=employee&include=employee&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/employee_invitations?data%5Battributes%5D%5Bemail%5D=jane%40doe.com&data%5Battributes%5D%5Bid%5D=d55c290c-2454-4d7f-86ef-25c7391c9ec6&data%5Btype%5D=employee_invitations&employee_invitation%5Bdata%5D%5Battributes%5D%5Bemail%5D=jane%40doe.com&employee_invitation%5Bdata%5D%5Battributes%5D%5Bid%5D=d55c290c-2454-4d7f-86ef-25c7391c9ec6&employee_invitation%5Bdata%5D%5Btype%5D=employee_invitations&employee_invitation%5Binclude%5D=employee&include=employee&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/employee_invitations?data%5Battributes%5D%5Bemail%5D=jane%40doe.com&data%5Battributes%5D%5Bid%5D=d55c290c-2454-4d7f-86ef-25c7391c9ec6&data%5Btype%5D=employee_invitations&employee_invitation%5Bdata%5D%5Battributes%5D%5Bemail%5D=jane%40doe.com&employee_invitation%5Bdata%5D%5Battributes%5D%5Bid%5D=d55c290c-2454-4d7f-86ef-25c7391c9ec6&employee_invitation%5Bdata%5D%5Btype%5D=employee_invitations&employee_invitation%5Binclude%5D=employee&include=employee&page%5Bnumber%5D=&page%5Bsize%5D=25",
    "next": "api/boomerang/employee_invitations?data%5Battributes%5D%5Bemail%5D=jane%40doe.com&data%5Battributes%5D%5Bid%5D=d55c290c-2454-4d7f-86ef-25c7391c9ec6&data%5Btype%5D=employee_invitations&employee_invitation%5Bdata%5D%5Battributes%5D%5Bemail%5D=jane%40doe.com&employee_invitation%5Bdata%5D%5Battributes%5D%5Bid%5D=d55c290c-2454-4d7f-86ef-25c7391c9ec6&employee_invitation%5Bdata%5D%5Btype%5D=employee_invitations&employee_invitation%5Binclude%5D=employee&include=employee&page%5Bnumber%5D=2&page%5Bsize%5D=25"
  },
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




