# Customers

Customers are an essential part of your business. You can manage settings and custom data. Stored customer information like addresses, customer tax profiles, discounts, and customized security deposits are applied to associated orders when created or when assigned a new customer.

## Endpoints
`GET /api/boomerang/customers`

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
      "id": "33c88e7c-ebd8-414f-9b5c-cc7273236bc9",
      "type": "customers",
      "attributes": {
        "created_at": "2022-04-08T18:19:41+00:00",
        "updated_at": "2022-04-08T18:19:41+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "John Doe",
        "email": "john_doe@considine-rosenbaum.info",
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
            "related": "api/boomerang/properties?filter[owner_id]=33c88e7c-ebd8-414f-9b5c-cc7273236bc9&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=33c88e7c-ebd8-414f-9b5c-cc7273236bc9&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=33c88e7c-ebd8-414f-9b5c-cc7273236bc9&filter[owner_type]=customers"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-04-08T18:19:12Z`
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
    --url 'https://example.booqable.com/api/boomerang/customers/06db35da-de58-4944-8e1d-5980355cd5bd?include=barcode%2Cproperties' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "06db35da-de58-4944-8e1d-5980355cd5bd",
    "type": "customers",
    "attributes": {
      "created_at": "2022-04-08T18:19:42+00:00",
      "updated_at": "2022-04-08T18:19:42+00:00",
      "archived": false,
      "archived_at": null,
      "number": 1,
      "name": "John Doe",
      "email": "john.doe@kemmer-dare.info",
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
          "related": "api/boomerang/properties?filter[owner_id]=06db35da-de58-4944-8e1d-5980355cd5bd&filter[owner_type]=customers"
        },
        "data": []
      },
      "barcode": {
        "links": {
          "related": "api/boomerang/barcodes?filter[owner_id]=06db35da-de58-4944-8e1d-5980355cd5bd&filter[owner_type]=customers"
        },
        "data": null
      },
      "notes": {
        "links": {
          "related": "api/boomerang/notes?filter[owner_id]=06db35da-de58-4944-8e1d-5980355cd5bd&filter[owner_type]=customers"
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
    "id": "0b53fc64-d5d4-4974-ac56-633bf2f5c549",
    "type": "customers",
    "attributes": {
      "created_at": "2022-04-08T18:19:43+00:00",
      "updated_at": "2022-04-08T18:19:43+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/customers/34787e03-c9ce-4fcd-a55a-3538ca60151a' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "34787e03-c9ce-4fcd-a55a-3538ca60151a",
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
    "id": "34787e03-c9ce-4fcd-a55a-3538ca60151a",
    "type": "customers",
    "attributes": {
      "created_at": "2022-04-08T18:19:44+00:00",
      "updated_at": "2022-04-08T18:19:44+00:00",
      "archived": false,
      "archived_at": null,
      "number": 1,
      "name": "Jane Doe",
      "email": "john_doe@dietrich.com",
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
    --url 'https://example.booqable.com/api/boomerang/customers/590ca8c1-fe93-4150-abe8-79407dc2329f' \
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