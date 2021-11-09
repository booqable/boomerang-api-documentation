# Emails

Emails allow you to easily communicate with your customers by using optional templates. Booqable keeps a history of e-mail being sent for orders or customers.

## Endpoints
`GET /api/boomerang/emails`

`POST /api/boomerang/emails`

## Fields
Every email has the following fields:

Name | Description
- | -
`id` | **Uuid** `readonly`<br>Primary key
`created_at` | **Datetime** `readonly`<br>When the resource was created
`updated_at` | **Datetime** `readonly`<br>When the resource was last updated
`subject` | **String**<br>Email subject
`body` | **String**<br>Email body
`recipients` | **String**<br>Comma seperated list of recipient email addresses, all addresses must be valid for the email to send.
`document_ids` | **Array**<br>Documents to send as attachments to the email
`order_id` | **Uuid**<br>The associated Order
`customer_id` | **Uuid**<br>The associated Customer
`email_template_id` | **Uuid**<br>The associated Email template
`employee_id` | **Uuid** `readonly`<br>The associated Employee


## Relationships
Emails have the following relationships:

Name | Description
- | -
`order` | **Orders** `readonly`<br>Associated Order
`customer` | **Customers** `readonly`<br>Associated Customer
`email_template` | **Email templates** `readonly`<br>Associated Email template
`employee` | **Employees** `readonly`<br>Associated Employee


## Listing emails



> How to fetch a list of emails:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/emails' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "893a59c2-0e6f-4ce7-93da-67f27d84305b",
      "type": "emails",
      "attributes": {
        "created_at": "2021-11-09T00:08:39+00:00",
        "updated_at": "2021-11-09T00:08:39+00:00",
        "subject": "Order confirmation",
        "body": "We hereby confirm your order with number #123",
        "recipients": "jon@doe.com",
        "document_ids": [],
        "order_id": null,
        "customer_id": "17412cc7-ce16-421a-943e-dd5dbb4a4041",
        "email_template_id": null,
        "employee_id": null
      },
      "relationships": {
        "order": {
          "links": {
            "related": null
          }
        },
        "customer": {
          "links": {
            "related": "api/boomerang/customers/17412cc7-ce16-421a-943e-dd5dbb4a4041"
          }
        },
        "email_template": {
          "links": {
            "related": null
          }
        },
        "employee": {
          "links": {
            "related": null
          }
        }
      }
    }
  ],
  "links": {
    "self": "api/boomerang/emails?page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/emails?page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/emails?page%5Bnumber%5D=1&page%5Bsize%5D=25"
  },
  "meta": {}
}
```


> How to fetch a list of emails for a specific order:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/emails?filter%5Border_id%5D=71ee6a90-f67b-4100-a6a5-74af61c85a3f' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "dd563942-2631-4885-965c-96d9145dfde6",
      "type": "emails",
      "attributes": {
        "created_at": "2021-11-09T00:08:39+00:00",
        "updated_at": "2021-11-09T00:08:40+00:00",
        "subject": "Order confirmation",
        "body": "We hereby confirm your order with number #123",
        "recipients": "jon@doe.com",
        "document_ids": [],
        "order_id": "71ee6a90-f67b-4100-a6a5-74af61c85a3f",
        "customer_id": "474d289f-ede1-466d-a2b0-651806a3b115",
        "email_template_id": null,
        "employee_id": null
      },
      "relationships": {
        "order": {
          "links": {
            "related": "api/boomerang/orders/71ee6a90-f67b-4100-a6a5-74af61c85a3f"
          }
        },
        "customer": {
          "links": {
            "related": "api/boomerang/customers/474d289f-ede1-466d-a2b0-651806a3b115"
          }
        },
        "email_template": {
          "links": {
            "related": null
          }
        },
        "employee": {
          "links": {
            "related": null
          }
        }
      }
    }
  ],
  "links": {
    "self": "api/boomerang/emails?filter%5Border_id%5D=71ee6a90-f67b-4100-a6a5-74af61c85a3f&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/emails?filter%5Border_id%5D=71ee6a90-f67b-4100-a6a5-74af61c85a3f&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/emails?filter%5Border_id%5D=71ee6a90-f67b-4100-a6a5-74af61c85a3f&page%5Bnumber%5D=1&page%5Bsize%5D=25"
  },
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/emails`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=order,customer,email_template`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[emails]=id,created_at,updated_at`
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-11-09T00:07:58Z`
`sort` | **String**<br>How to sort the data `?sort=-created_at`
`meta` | **Hash**<br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String**<br>The page to request
`page[size]` | **String**<br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
`id` | **Uuid**<br>`eq`, `not_eq`
`created_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`order_id` | **Uuid**<br>`eq`, `not_eq`
`customer_id` | **Uuid**<br>`eq`, `not_eq`
`email_template_id` | **Uuid**<br>`eq`, `not_eq`
`employee_id` | **Uuid**<br>`eq`, `not_eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array**<br>`count`


### Includes

This request accepts the following includes:

`customer`


`order`






## Creating and sending an email



> How to create and send an email:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/emails' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "emails",
        "attributes": {
          "recipients": "customer1@example.com,customer2@example.com",
          "subject": "Order confirmation",
          "body": "Hi {{customer.name}}",
          "email_template_id": "3e0b8fd0-7da3-43a1-a07e-8560a42e2362",
          "order_id": "e2bd29ec-0a52-4dc9-bf59-9825d9b05bf3",
          "customer_id": "c64fb473-51aa-4d45-86b2-feea4bd4975f",
          "document_ids": [
            "2c73dc30-c868-42e5-bc49-8136032cc408"
          ]
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "6ecfcfea-a4cf-4223-acec-a2624e6bc961",
    "type": "emails",
    "attributes": {
      "created_at": "2021-11-09T00:08:40+00:00",
      "updated_at": "2021-11-09T00:08:40+00:00",
      "subject": "Order confirmation",
      "body": "Hi {{customer.name}}",
      "recipients": "customer1@example.com,customer2@example.com",
      "document_ids": [
        "2c73dc30-c868-42e5-bc49-8136032cc408"
      ],
      "order_id": "e2bd29ec-0a52-4dc9-bf59-9825d9b05bf3",
      "customer_id": "c64fb473-51aa-4d45-86b2-feea4bd4975f",
      "email_template_id": "3e0b8fd0-7da3-43a1-a07e-8560a42e2362",
      "employee_id": "fa7eda97-1410-4421-8264-ee95e1a82925"
    },
    "relationships": {
      "order": {
        "meta": {
          "included": false
        }
      },
      "customer": {
        "meta": {
          "included": false
        }
      },
      "email_template": {
        "meta": {
          "included": false
        }
      },
      "employee": {
        "meta": {
          "included": false
        }
      }
    }
  },
  "links": {
    "self": "api/boomerang/emails?data%5Battributes%5D%5Bbody%5D=Hi+%7B%7Bcustomer.name%7D%7D&data%5Battributes%5D%5Bcustomer_id%5D=c64fb473-51aa-4d45-86b2-feea4bd4975f&data%5Battributes%5D%5Bdocument_ids%5D%5B%5D=2c73dc30-c868-42e5-bc49-8136032cc408&data%5Battributes%5D%5Bemail_template_id%5D=3e0b8fd0-7da3-43a1-a07e-8560a42e2362&data%5Battributes%5D%5Border_id%5D=e2bd29ec-0a52-4dc9-bf59-9825d9b05bf3&data%5Battributes%5D%5Brecipients%5D=customer1%40example.com%2Ccustomer2%40example.com&data%5Battributes%5D%5Bsubject%5D=Order+confirmation&data%5Btype%5D=emails&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/emails?data%5Battributes%5D%5Bbody%5D=Hi+%7B%7Bcustomer.name%7D%7D&data%5Battributes%5D%5Bcustomer_id%5D=c64fb473-51aa-4d45-86b2-feea4bd4975f&data%5Battributes%5D%5Bdocument_ids%5D%5B%5D=2c73dc30-c868-42e5-bc49-8136032cc408&data%5Battributes%5D%5Bemail_template_id%5D=3e0b8fd0-7da3-43a1-a07e-8560a42e2362&data%5Battributes%5D%5Border_id%5D=e2bd29ec-0a52-4dc9-bf59-9825d9b05bf3&data%5Battributes%5D%5Brecipients%5D=customer1%40example.com%2Ccustomer2%40example.com&data%5Battributes%5D%5Bsubject%5D=Order+confirmation&data%5Btype%5D=emails&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/emails?data%5Battributes%5D%5Bbody%5D=Hi+%7B%7Bcustomer.name%7D%7D&data%5Battributes%5D%5Bcustomer_id%5D=c64fb473-51aa-4d45-86b2-feea4bd4975f&data%5Battributes%5D%5Bdocument_ids%5D%5B%5D=2c73dc30-c868-42e5-bc49-8136032cc408&data%5Battributes%5D%5Bemail_template_id%5D=3e0b8fd0-7da3-43a1-a07e-8560a42e2362&data%5Battributes%5D%5Border_id%5D=e2bd29ec-0a52-4dc9-bf59-9825d9b05bf3&data%5Battributes%5D%5Brecipients%5D=customer1%40example.com%2Ccustomer2%40example.com&data%5Battributes%5D%5Bsubject%5D=Order+confirmation&data%5Btype%5D=emails&page%5Bnumber%5D=1&page%5Bsize%5D=25"
  },
  "meta": {}
}
```

### HTTP Request

`POST /api/boomerang/emails`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=order,customer,email_template`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[emails]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][subject]` | **String**<br>Email subject
`data[attributes][body]` | **String**<br>Email body
`data[attributes][recipients]` | **String**<br>Comma seperated list of recipient email addresses, all addresses must be valid for the email to send.
`data[attributes][document_ids][]` | **Array**<br>Documents to send as attachments to the email
`data[attributes][order_id]` | **Uuid**<br>The associated Order
`data[attributes][customer_id]` | **Uuid**<br>The associated Customer
`data[attributes][email_template_id]` | **Uuid**<br>The associated Email template


### Includes

This request accepts the following includes:

`customer`


`order`


`email_template`





