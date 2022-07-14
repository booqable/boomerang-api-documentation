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
      "id": "0539bffc-9e79-4dd3-b98f-ba936e81294f",
      "type": "customers",
      "attributes": {
        "created_at": "2022-07-14T10:33:56+00:00",
        "updated_at": "2022-07-14T10:33:56+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "John Doe",
        "email": "john.doe@bergnaum.info",
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
            "related": "api/boomerang/properties?filter[owner_id]=0539bffc-9e79-4dd3-b98f-ba936e81294f&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=0539bffc-9e79-4dd3-b98f-ba936e81294f&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=0539bffc-9e79-4dd3-b98f-ba936e81294f&filter[owner_type]=customers"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-07-14T10:33:21Z`
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
      "id": "7d83152b-83e2-4ec5-a59c-f6c93f8695e5"
    },
    {
      "id": "8c835286-2a66-45f6-880a-5fd865c1cda7"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-07-14T10:33:21Z`
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
    --url 'https://example.booqable.com/api/boomerang/customers/3dcddccf-f5f9-4533-8e11-cf9b8ab8dc28?include=barcode%2Cproperties' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "3dcddccf-f5f9-4533-8e11-cf9b8ab8dc28",
    "type": "customers",
    "attributes": {
      "created_at": "2022-07-14T10:33:58+00:00",
      "updated_at": "2022-07-14T10:33:58+00:00",
      "archived": false,
      "archived_at": null,
      "number": 1,
      "name": "John Doe",
      "email": "john.doe@murphy-kuhlman.info",
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
          "related": "api/boomerang/properties?filter[owner_id]=3dcddccf-f5f9-4533-8e11-cf9b8ab8dc28&filter[owner_type]=customers"
        },
        "data": []
      },
      "barcode": {
        "links": {
          "related": "api/boomerang/barcodes?filter[owner_id]=3dcddccf-f5f9-4533-8e11-cf9b8ab8dc28&filter[owner_type]=customers"
        },
        "data": null
      },
      "notes": {
        "links": {
          "related": "api/boomerang/notes?filter[owner_id]=3dcddccf-f5f9-4533-8e11-cf9b8ab8dc28&filter[owner_type]=customers"
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
    "id": "8d3f3608-d2ba-491f-9862-a13283d29df9",
    "type": "customers",
    "attributes": {
      "created_at": "2022-07-14T10:33:58+00:00",
      "updated_at": "2022-07-14T10:33:58+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/customers/371dd1d8-e748-4f25-a577-37c510b6176a' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "371dd1d8-e748-4f25-a577-37c510b6176a",
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
    "id": "371dd1d8-e748-4f25-a577-37c510b6176a",
    "type": "customers",
    "attributes": {
      "created_at": "2022-07-14T10:33:59+00:00",
      "updated_at": "2022-07-14T10:33:59+00:00",
      "archived": false,
      "archived_at": null,
      "number": 1,
      "name": "Jane Doe",
      "email": "doe.john@kautzer.name",
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
    --url 'https://example.booqable.com/api/boomerang/customers/405ac886-59d0-4c9b-9d48-30e2a49288b3' \
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