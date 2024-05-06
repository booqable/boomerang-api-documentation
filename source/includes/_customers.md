# Customers

Customers are an essential part of your business. You can manage settings and custom data. Stored customer information like addresses, customer tax profiles, discounts, and customized security deposits are applied to associated orders when created or when assigned a new customer.

## Endpoints
`GET /api/boomerang/customers/{id}`

`PUT /api/boomerang/customers/{id}`

`GET /api/boomerang/customers`

`POST /api/boomerang/customers`

`POST api/boomerang/customers/search`

`DELETE /api/boomerang/customers/{id}`

## Fields
Every customer has the following fields:

Name | Description
-- | --
`id` | **Uuid** `readonly`<br>Primary key
`created_at` | **Datetime** `readonly`<br>When the resource was created
`updated_at` | **Datetime** `readonly`<br>When the resource was last updated
`archived` | **Boolean** `readonly`<br>Whether customer is archived
`archived_at` | **Datetime** `nullable` `readonly`<br>When the customer was archived
`number` | **Integer** `readonly`<br>The assigned number
`name` | **String** <br>Person or Company name
`email` | **String** `nullable`<br>E-mail address used for communication
`deposit_type` | **String** <br>One of `default`, `none`, `percentage_total`, `percentage`, `fixed`
`deposit_value` | **Float** <br>The value to use for `deposit_type`
`discount_percentage` | **Float** <br>Default discount applied to each new order for this customer
`legal_type` | **String** <br>Either `person` or `commercial`
`properties` | **Hash** `readonly`<br>A hash containing all basic property values (include properties if you need more detailed information about properties)
`properties_attributes` | **Array** `writeonly`<br>Create or update multiple properties associated with this customer
`tag_list` | **Array** <br>Case insensitive tag list
`merge_suggestion_customer_id` | **Uuid** <br>The associated Merge suggestion customer
`tax_region_id` | **Uuid** `nullable`<br>The associated Tax region


## Relationships
Customers have the following relationships:

Name | Description
-- | --
`merge_suggestion_customer` | **Customers** `readonly`<br>Associated Merge suggestion customer
`tax_region` | **Tax regions** `readonly`<br>Associated Tax region
`properties` | **Properties** `readonly`<br>Associated Properties
`barcode` | **Barcodes**<br>Associated Barcode
`notes` | **Notes** `readonly`<br>Associated Notes


## Fetching a customer



> How to fetch a customers:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/customers/1c4af541-84a1-4c5b-8d51-e717c8d422af?include=barcode%2Cproperties' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "1c4af541-84a1-4c5b-8d51-e717c8d422af",
    "type": "customers",
    "attributes": {
      "created_at": "2024-05-06T09:26:06+00:00",
      "updated_at": "2024-05-06T09:26:06+00:00",
      "archived": false,
      "archived_at": null,
      "number": 1,
      "name": "John Doe",
      "email": "john-70@doe.test",
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
          "related": "api/boomerang/properties?filter[owner_id]=1c4af541-84a1-4c5b-8d51-e717c8d422af&filter[owner_type]=customers"
        },
        "data": []
      },
      "barcode": {
        "links": {
          "related": "api/boomerang/barcodes?filter[owner_id]=1c4af541-84a1-4c5b-8d51-e717c8d422af&filter[owner_type]=customers"
        },
        "data": null
      },
      "notes": {
        "links": {
          "related": "api/boomerang/notes?filter[owner_id]=1c4af541-84a1-4c5b-8d51-e717c8d422af&filter[owner_type]=customers"
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

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=barcode,properties,tax_region`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[customers]=created_at,updated_at,archived`


### Includes

This request accepts the following includes:

`barcode`


`properties`


`tax_region`






## Updating a customer



> How to update a customer:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/customers/0325d9fd-44be-4669-9e45-c5696ffd1ef6' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "0325d9fd-44be-4669-9e45-c5696ffd1ef6",
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
    "id": "0325d9fd-44be-4669-9e45-c5696ffd1ef6",
    "type": "customers",
    "attributes": {
      "created_at": "2024-05-06T09:26:07+00:00",
      "updated_at": "2024-05-06T09:26:07+00:00",
      "archived": false,
      "archived_at": null,
      "number": 1,
      "name": "Jane Doe",
      "email": "john-71@doe.test",
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

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=barcode,properties,tax_region`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[customers]=created_at,updated_at,archived`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][name]` | **String** <br>Person or Company name
`data[attributes][email]` | **String** <br>E-mail address used for communication
`data[attributes][deposit_type]` | **String** <br>One of `default`, `none`, `percentage_total`, `percentage`, `fixed`
`data[attributes][deposit_value]` | **Float** <br>The value to use for `deposit_type`
`data[attributes][discount_percentage]` | **Float** <br>Default discount applied to each new order for this customer
`data[attributes][legal_type]` | **String** <br>Either `person` or `commercial`
`data[attributes][properties_attributes][]` | **Array** <br>Create or update multiple properties associated with this customer
`data[attributes][tag_list][]` | **Array** <br>Case insensitive tag list
`data[attributes][merge_suggestion_customer_id]` | **Uuid** <br>The associated Merge suggestion customer
`data[attributes][tax_region_id]` | **Uuid** <br>The associated Tax region


### Includes

This request accepts the following includes:

`barcode`


`properties`


`tax_region`






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
      "id": "92f60395-9f54-4e54-8415-887a4282616c",
      "type": "customers",
      "attributes": {
        "created_at": "2024-05-06T09:26:08+00:00",
        "updated_at": "2024-05-06T09:26:08+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "John Doe",
        "email": "john-72@doe.test",
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
            "related": "api/boomerang/properties?filter[owner_id]=92f60395-9f54-4e54-8415-887a4282616c&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=92f60395-9f54-4e54-8415-887a4282616c&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=92f60395-9f54-4e54-8415-887a4282616c&filter[owner_type]=customers"
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

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=barcode,properties,tax_region`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[customers]=created_at,updated_at,archived`
`filter` | **Hash** <br>The filters to apply `?filter[attribute][eq]=value`
`sort` | **String** <br>How to sort the data `?sort=attribute1,-attribute2`
`meta` | **Hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String** <br>The page to request
`page[size]` | **String** <br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
-- | --
`id` | **Uuid** <br>`eq`, `not_eq`
`created_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`archived` | **Boolean** <br>`eq`
`archived_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`number` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`name` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`email` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`deposit_type` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`deposit_value` | **Float** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`discount_percentage` | **Float** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`legal_type` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`tag_list` | **String** <br>`eq`
`merge_suggestion_customer_id` | **Uuid** <br>`eq`, `not_eq`
`tax_region_id` | **Uuid** <br>`eq`, `not_eq`
`q` | **String** <br>`eq`
`conditions` | **Hash** <br>`eq`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **Array** <br>`count`
`archived` | **Array** <br>`count`
`legal_type` | **Array** <br>`count`
`tag_list` | **Array** <br>`count`
`discount_percentage` | **Array** <br>`maximum`, `minimum`, `average`


### Includes

This request accepts the following includes:

`barcode`


`properties`


`tax_region`






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
    "id": "3d36742c-61fe-4c94-bfc8-23963e5398a5",
    "type": "customers",
    "attributes": {
      "created_at": "2024-05-06T09:26:09+00:00",
      "updated_at": "2024-05-06T09:26:09+00:00",
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

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=barcode,properties,tax_region`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[customers]=created_at,updated_at,archived`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][name]` | **String** <br>Person or Company name
`data[attributes][email]` | **String** <br>E-mail address used for communication
`data[attributes][deposit_type]` | **String** <br>One of `default`, `none`, `percentage_total`, `percentage`, `fixed`
`data[attributes][deposit_value]` | **Float** <br>The value to use for `deposit_type`
`data[attributes][discount_percentage]` | **Float** <br>Default discount applied to each new order for this customer
`data[attributes][legal_type]` | **String** <br>Either `person` or `commercial`
`data[attributes][properties_attributes][]` | **Array** <br>Create or update multiple properties associated with this customer
`data[attributes][tag_list][]` | **Array** <br>Case insensitive tag list
`data[attributes][merge_suggestion_customer_id]` | **Uuid** <br>The associated Merge suggestion customer
`data[attributes][tax_region_id]` | **Uuid** <br>The associated Tax region


### Includes

This request accepts the following includes:

`barcode`


`properties`


`tax_region`






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
      "id": "7bc4da66-8b58-4fc5-ab97-443d8b33c4c8"
    },
    {
      "id": "181fd5fb-4c50-41aa-ba6a-ed6fdc0cbe33"
    }
  ]
}
```

### HTTP Request

`POST api/boomerang/customers/search`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=barcode,properties,tax_region`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[customers]=created_at,updated_at,archived`
`filter` | **Hash** <br>The filters to apply `?filter[attribute][eq]=value`
`sort` | **String** <br>How to sort the data `?sort=attribute1,-attribute2`
`meta` | **Hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String** <br>The page to request
`page[size]` | **String** <br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
-- | --
`id` | **Uuid** <br>`eq`, `not_eq`
`created_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`archived` | **Boolean** <br>`eq`
`archived_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`number` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`name` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`email` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`deposit_type` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`deposit_value` | **Float** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`discount_percentage` | **Float** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`legal_type` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`tag_list` | **String** <br>`eq`
`merge_suggestion_customer_id` | **Uuid** <br>`eq`, `not_eq`
`tax_region_id` | **Uuid** <br>`eq`, `not_eq`
`q` | **String** <br>`eq`
`conditions` | **Hash** <br>`eq`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **Array** <br>`count`
`archived` | **Array** <br>`count`
`legal_type` | **Array** <br>`count`
`tag_list` | **Array** <br>`count`
`discount_percentage` | **Array** <br>`maximum`, `minimum`, `average`


### Includes

This request accepts the following includes:

`barcode`


`properties`


`tax_region`






## Archiving a customer



> How to archive a customer:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/customers/e4d7c071-b0e7-4985-bf17-1caba14002e1' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "e4d7c071-b0e7-4985-bf17-1caba14002e1",
    "type": "customers",
    "attributes": {
      "created_at": "2024-05-06T09:26:11+00:00",
      "updated_at": "2024-05-06T09:26:11+00:00",
      "archived": true,
      "archived_at": "2024-05-06T09:26:11+00:00",
      "number": 1,
      "name": "John Doe",
      "email": "john-80@doe.test",
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
          "related": "api/boomerang/properties?filter[owner_id]=e4d7c071-b0e7-4985-bf17-1caba14002e1&filter[owner_type]=customers"
        }
      },
      "barcode": {
        "links": {
          "related": "api/boomerang/barcodes?filter[owner_id]=e4d7c071-b0e7-4985-bf17-1caba14002e1&filter[owner_type]=customers"
        }
      },
      "notes": {
        "links": {
          "related": "api/boomerang/notes?filter[owner_id]=e4d7c071-b0e7-4985-bf17-1caba14002e1&filter[owner_type]=customers"
        }
      }
    }
  },
  "meta": {}
}
```

### HTTP Request

`DELETE /api/boomerang/customers/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[customers]=created_at,updated_at,archived`


### Includes

This request does not accept any includes