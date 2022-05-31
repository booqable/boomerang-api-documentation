# Customers

Customers are an essential part of your business. You can manage settings and custom data. Stored customer information like addresses, customer tax profiles, discounts, and customized security deposits are applied to associated orders when created or when assigned a new customer.

## Endpoints
`GET /api/boomerang/customers`

`POST api/boomerang/customers/search`

`GET /api/boomerang/customers/{id}`

`POST /api/boomerang/customers`

`PUT /api/boomerang/customers/{id}`

`DELETE /api/boomerang/customers/{id}`

## Fields
Every customer has the following fields:

Name | Description
- | -
`id` | **Uuid** `readonly`<br>Primary key
`created_at` | **Datetime** `readonly`<br>When the resource was created
`updated_at` | **Datetime** `readonly`<br>When the resource was last updated
`archived` | **Boolean** `readonly`<br>Whether customer is archived
`archived_at` | **Datetime** `nullable` `readonly`<br>When the customer was archived
`number` | **Integer** `readonly`<br>The assigned number
`name` | **String**<br>Person or Company name
`email` | **String** `nullable`<br>E-mail address used for communication
`deposit_type` | **String**<br>One of `default`, `none`, `percentage_total`, `percentage`, `fixed`
`deposit_value` | **Float**<br>The value to use for `deposit_type`
`discount_percentage` | **Float**<br>Default discount applied to each new order for this customer
`legal_type` | **String**<br>Either `person` or `commercial`
`properties` | **Hash** `readonly`<br>A hash containing all basic property values (include properties if you need more detailed information about properties)
`properties_attributes` | **Array** `writeonly`<br>Create or update multiple properties associated with this customer
`tag_list` | **Array**<br>Case insensitive tag list
`merge_suggestion_customer_id` | **Uuid**<br>The associated Merge suggestion customer
`tax_region_id` | **Uuid** `nullable`<br>The associated Tax region


## Relationships
Customers have the following relationships:

Name | Description
- | -
`merge_suggestion_customer` | **Customers** `readonly`<br>Associated Merge suggestion customer
`tax_region` | **Tax regions** `readonly`<br>Associated Tax region
`properties` | **Properties** `readonly`<br>Associated Properties
`barcode` | **Barcodes**<br>Associated Barcode
`notes` | **Notes** `readonly`<br>Associated Notes


## Listing customers



> How to fetch a list of customers:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/customers' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "bb11aa72-89f1-4d00-88da-95aeaad6b404",
      "type": "customers",
      "attributes": {
        "created_at": "2022-05-31T06:54:53+00:00",
        "updated_at": "2022-05-31T06:54:53+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "John Doe",
        "email": "doe_john@morar-harvey.io",
        "deposit_type": "default",
        "deposit_value": 0.0,
        "discount_percentage": 0.0,
        "legal_type": "person",
        "properties": {},
        "tag_list": [],
        "merge_suggestion_customer_id": null,
        "tax_region_id": null
      },
      "relationships": {
        "merge_suggestion_customer": {
          "links": {
            "related": null
          }
        },
        "tax_region": {
          "links": {
            "related": null
          }
        },
        "properties": {
          "links": {
            "related": "api/boomerang/properties?filter[owner_id]=bb11aa72-89f1-4d00-88da-95aeaad6b404&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=bb11aa72-89f1-4d00-88da-95aeaad6b404&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=bb11aa72-89f1-4d00-88da-95aeaad6b404&filter[owner_type]=customers"
          }
        }
      }
    }
  ],
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/customers`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=merge_suggestion_customer,tax_region,properties`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[customers]=id,created_at,updated_at`
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-05-31T06:54:18Z`
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
`archived` | **Boolean**<br>`eq`
`archived_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`number` | **Integer**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`name` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`email` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`deposit_type` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`deposit_value` | **Float**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`discount_percentage` | **Float**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`legal_type` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`tag_list` | **String**<br>`eq`
`merge_suggestion_customer_id` | **Uuid**<br>`eq`, `not_eq`
`tax_region_id` | **Uuid**<br>`eq`, `not_eq`
`q` | **String**<br>`eq`
`conditions` | **Hash**<br>`eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array**<br>`count`
`archived` | **Array**<br>`count`
`legal_type` | **Array**<br>`count`
`tag_list` | **Array**<br>`count`
`discount_percentage` | **Array**<br>`maximum`, `minimum`, `average`


### Includes

This request does not accept any includes
## Searching customers

Use advanced search to make logical filter groups with and/or operators.


> How to search for customers:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/customers/search' \
    --header 'content-type: application/json' \
    --data '{
      "fields": {
        "customers": "id"
      },
      "filter": {
        "conditions": {
          "operator": "and",
          "attributes": [
            {
              "operator": "or",
              "attributes": [
                {
                  "name": "john"
                },
                {
                  "name": "jane"
                }
              ]
            },
            {
              "operator": "and",
              "attributes": [
                {
                  "discount_percentage": {
                    "gte": 50
                  }
                },
                {
                  "deposit_type": "none"
                }
              ]
            }
          ]
        }
      }
    }'
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "6915d109-3837-4934-b7c9-2ffdb3fca101"
    },
    {
      "id": "fe8c347a-7abd-43a0-be42-f1e41ea75cb3"
    }
  ]
}
```

### HTTP Request

`POST api/boomerang/customers/search`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=merge_suggestion_customer,tax_region,properties`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[customers]=id,created_at,updated_at`
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-05-31T06:54:18Z`
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
`archived` | **Boolean**<br>`eq`
`archived_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`number` | **Integer**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`name` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`email` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`deposit_type` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`deposit_value` | **Float**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`discount_percentage` | **Float**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`legal_type` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`tag_list` | **String**<br>`eq`
`merge_suggestion_customer_id` | **Uuid**<br>`eq`, `not_eq`
`tax_region_id` | **Uuid**<br>`eq`, `not_eq`
`q` | **String**<br>`eq`
`conditions` | **Hash**<br>`eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array**<br>`count`
`archived` | **Array**<br>`count`
`legal_type` | **Array**<br>`count`
`tag_list` | **Array**<br>`count`
`discount_percentage` | **Array**<br>`maximum`, `minimum`, `average`


### Includes

This request does not accept any includes
## Fetching a customer



> How to fetch a customers:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/customers/1d069424-ccf2-4750-9834-8996a9bd28e5?include=barcode%2Cproperties' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "1d069424-ccf2-4750-9834-8996a9bd28e5",
    "type": "customers",
    "attributes": {
      "created_at": "2022-05-31T06:54:55+00:00",
      "updated_at": "2022-05-31T06:54:55+00:00",
      "archived": false,
      "archived_at": null,
      "number": 1,
      "name": "John Doe",
      "email": "john.doe@wolff.co",
      "deposit_type": "default",
      "deposit_value": 0.0,
      "discount_percentage": 0.0,
      "legal_type": "person",
      "properties": {},
      "tag_list": [],
      "merge_suggestion_customer_id": null,
      "tax_region_id": null
    },
    "relationships": {
      "merge_suggestion_customer": {
        "links": {
          "related": null
        }
      },
      "tax_region": {
        "links": {
          "related": null
        }
      },
      "properties": {
        "links": {
          "related": "api/boomerang/properties?filter[owner_id]=1d069424-ccf2-4750-9834-8996a9bd28e5&filter[owner_type]=customers"
        },
        "data": []
      },
      "barcode": {
        "links": {
          "related": "api/boomerang/barcodes?filter[owner_id]=1d069424-ccf2-4750-9834-8996a9bd28e5&filter[owner_type]=customers"
        },
        "data": null
      },
      "notes": {
        "links": {
          "related": "api/boomerang/notes?filter[owner_id]=1d069424-ccf2-4750-9834-8996a9bd28e5&filter[owner_type]=customers"
        }
      }
    }
  },
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/customers/{id}`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=merge_suggestion_customer,tax_region,properties`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[customers]=id,created_at,updated_at`


### Includes

This request accepts the following includes:

`tax_region`


`properties`


`barcode`






## Creating a customer



> How to create a customer:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/customers' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "customers",
        "attributes": {
          "name": "John Doe",
          "email": "john@doe.com"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "769c2433-bedc-4465-adba-6064d9ee5084",
    "type": "customers",
    "attributes": {
      "created_at": "2022-05-31T06:54:56+00:00",
      "updated_at": "2022-05-31T06:54:56+00:00",
      "archived": false,
      "archived_at": null,
      "number": 2,
      "name": "John Doe",
      "email": "john@doe.com",
      "deposit_type": "default",
      "deposit_value": 0.0,
      "discount_percentage": 0.0,
      "legal_type": "person",
      "properties": {},
      "tag_list": [],
      "merge_suggestion_customer_id": null,
      "tax_region_id": null
    },
    "relationships": {
      "merge_suggestion_customer": {
        "meta": {
          "included": false
        }
      },
      "tax_region": {
        "meta": {
          "included": false
        }
      },
      "properties": {
        "meta": {
          "included": false
        }
      },
      "barcode": {
        "meta": {
          "included": false
        }
      },
      "notes": {
        "meta": {
          "included": false
        }
      }
    }
  },
  "meta": {}
}
```

### HTTP Request

`POST /api/boomerang/customers`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=merge_suggestion_customer,tax_region,properties`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[customers]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][name]` | **String**<br>Person or Company name
`data[attributes][email]` | **String**<br>E-mail address used for communication
`data[attributes][deposit_type]` | **String**<br>One of `default`, `none`, `percentage_total`, `percentage`, `fixed`
`data[attributes][deposit_value]` | **Float**<br>The value to use for `deposit_type`
`data[attributes][discount_percentage]` | **Float**<br>Default discount applied to each new order for this customer
`data[attributes][legal_type]` | **String**<br>Either `person` or `commercial`
`data[attributes][properties_attributes][]` | **Array**<br>Create or update multiple properties associated with this customer
`data[attributes][tag_list][]` | **Array**<br>Case insensitive tag list
`data[attributes][merge_suggestion_customer_id]` | **Uuid**<br>The associated Merge suggestion customer
`data[attributes][tax_region_id]` | **Uuid**<br>The associated Tax region


### Includes

This request accepts the following includes:

`tax_region`


`properties`


`barcode`






## Updating a customer



> How to update a customer:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/customers/a439b858-5eab-4b14-b2d7-9e8f0fa0a49e' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "a439b858-5eab-4b14-b2d7-9e8f0fa0a49e",
        "type": "customers",
        "attributes": {
          "name": "Jane Doe"
        }
      }
    }'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "a439b858-5eab-4b14-b2d7-9e8f0fa0a49e",
    "type": "customers",
    "attributes": {
      "created_at": "2022-05-31T06:54:57+00:00",
      "updated_at": "2022-05-31T06:54:57+00:00",
      "archived": false,
      "archived_at": null,
      "number": 1,
      "name": "Jane Doe",
      "email": "doe_john@bednar.net",
      "deposit_type": "default",
      "deposit_value": 0.0,
      "discount_percentage": 0.0,
      "legal_type": "person",
      "properties": {},
      "tag_list": [],
      "merge_suggestion_customer_id": null,
      "tax_region_id": null
    },
    "relationships": {
      "merge_suggestion_customer": {
        "meta": {
          "included": false
        }
      },
      "tax_region": {
        "meta": {
          "included": false
        }
      },
      "properties": {
        "meta": {
          "included": false
        }
      },
      "barcode": {
        "meta": {
          "included": false
        }
      },
      "notes": {
        "meta": {
          "included": false
        }
      }
    }
  },
  "meta": {}
}
```

### HTTP Request

`PUT /api/boomerang/customers/{id}`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=merge_suggestion_customer,tax_region,properties`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[customers]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][name]` | **String**<br>Person or Company name
`data[attributes][email]` | **String**<br>E-mail address used for communication
`data[attributes][deposit_type]` | **String**<br>One of `default`, `none`, `percentage_total`, `percentage`, `fixed`
`data[attributes][deposit_value]` | **Float**<br>The value to use for `deposit_type`
`data[attributes][discount_percentage]` | **Float**<br>Default discount applied to each new order for this customer
`data[attributes][legal_type]` | **String**<br>Either `person` or `commercial`
`data[attributes][properties_attributes][]` | **Array**<br>Create or update multiple properties associated with this customer
`data[attributes][tag_list][]` | **Array**<br>Case insensitive tag list
`data[attributes][merge_suggestion_customer_id]` | **Uuid**<br>The associated Merge suggestion customer
`data[attributes][tax_region_id]` | **Uuid**<br>The associated Tax region


### Includes

This request accepts the following includes:

`tax_region`


`properties`


`barcode`






## Archiving a customer



> How to archive a customer:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/customers/054d3d28-7191-45d9-8679-09c53efd3617' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "meta": {}
}
```

### HTTP Request

`DELETE /api/boomerang/customers/{id}`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=merge_suggestion_customer,tax_region,properties`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[customers]=id,created_at,updated_at`


### Includes

This request does not accept any includes