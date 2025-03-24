# Customers

Customers are an essential part of your business.

Stored customer information like addresses, customer tax profiles, discounts,
and customized security deposits are applied to an order when created
or when assigned a new customer.

## Relationships
Name | Description
-- | --
`barcode` | **[Barcode](#barcodes)** `optional`<br>The barcode pointing to this customer. 
`merge_suggestion_customer` | **[Customer](#customers)** `required`<br>Holds the customer this customer is a possible duplicate of. 
`notes` | **[Notes](#notes)** `hasmany`<br>Notes added about (and invisible for) customers. 
`payment_methods` | **[Payment methods](#payment-methods)** `hasmany`<br>[PaymentMethods](#payment-methods) associated with the customer. 
`properties` | **[Properties](#properties)** `hasmany`<br>Custom structured data about this customer, based on [DefaultProperties](#default-properties). Properties of customers can be updated in bulk by writing to the `properties_attributes` attribute. 
`tax_region` | **[Tax region](#tax-regions)** `optional`<br>Tax region assigned to new orders for this customer. 


Check matching attributes under [Fields](#customers-fields) to see which relations can be written.
<br/ >
Check each individual operation to see which relations can be included as a sideload.
## Fields

 Name | Description
-- | --
`archived` | **boolean** `readonly`<br>Whether customer is archived. 
`archived_at` | **datetime** `readonly` `nullable`<br>When the customer was archived. 
`created_at` | **datetime** `readonly`<br>When the resource was created.
`deposit_type` | **string** <br>The deposit added to new orders of this customer by default. 
`deposit_value` | **float** <br>The value to use for `deposit_type`. 
`discount_percentage` | **float** <br>Default discount applied to each new order for this customer. 
`email` | **string** `nullable`<br>Email address used for communication. 
`email_marketing_consent_updated_at` | **datetime** `readonly`<br>When the email marketing consent was last updated. 
`email_marketing_consented` | **boolean** <br>Whether the customer has consented to receive email marketing. 
`id` | **uuid** `readonly`<br>Primary key.
`legal_type` | **string** <br>Either `person` or `commercial`. 
`merge_suggestion_customer_id` | **uuid** <br>Holds the customer this customer is a possible duplicate of. 
`name` | **string** <br>Person or Company name. 
`number` | **integer** `readonly`<br>The assigned number. 
`properties` | **hash** `readonly`<br>A hash containing all basic property values. This is a simplified representation; sideload the properties relation if you need more detailed information of properties. 
`properties_attributes` | **array** `writeonly`<br>Create or update multiple properties to be associated with this customer. 
`tag_list` | **array[string]** <br>Case insensitive tag list. 
`tax_region_id` | **uuid** `nullable`<br>Tax region assigned to new orders for this customer. 
`updated_at` | **datetime** `readonly`<br>When the resource was last updated.


## List customers


> How to fetch a list of customers:

```shell
  curl --get 'https://example.booqable.com/api/boomerang/customers'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": [
      {
        "id": "b047cd19-e6ec-4914-8ddb-960e2ed984fa",
        "type": "customers",
        "attributes": {
          "created_at": "2018-06-02T01:12:12.000000+00:00",
          "updated_at": "2018-06-02T01:12:12.000000+00:00",
          "archived": false,
          "archived_at": null,
          "number": 1,
          "name": "John Doe",
          "email": "john-10@doe.test",
          "deposit_type": "default",
          "deposit_value": 0.0,
          "discount_percentage": 0.0,
          "legal_type": "person",
          "email_marketing_consented": false,
          "email_marketing_consent_updated_at": null,
          "properties": {},
          "tag_list": [],
          "merge_suggestion_customer_id": null,
          "tax_region_id": null
        },
        "relationships": {}
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
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[customers]=created_at,updated_at,archived`
`filter` | **hash** <br>The filters to apply `?filter[attribute][eq]=value`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=barcode,properties,tax_region`
`meta` | **hash** <br>Metadata to send along. `?meta[total][]=count`
`page[number]` | **string** <br>The page to request.
`page[size]` | **string** <br>The amount of items per page.
`sort` | **string** <br>How to sort the data. `?sort=attribute1,-attribute2`


### Filters

This request can be filtered on:

Name | Description
-- | --
`archived` | **boolean** <br>`eq`
`archived_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`conditions` | **hash** <br>`eq`
`created_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`deposit_type` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`deposit_value` | **float** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`discount_percentage` | **float** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`email` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`email_marketing_consented` | **boolean** <br>`eq`
`id` | **uuid** <br>`eq`, `not_eq`, `gt`
`legal_type` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`merge_suggestion_customer_id` | **uuid** <br>`eq`, `not_eq`
`name` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`number` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`q` | **string** <br>`eq`
`tag_list` | **string** <br>`eq`
`tax_region_id` | **uuid** <br>`eq`, `not_eq`
`updated_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`archived` | **array** <br>`count`
`discount_percentage` | **array** <br>`maximum`, `minimum`, `average`
`legal_type` | **array** <br>`count`
`tag_list` | **array** <br>`count`
`total` | **array** <br>`count`


### Includes

This request accepts the following includes:

`barcode`


`properties`


`tax_region`


`payment_methods`






## Search customers

Use advanced search to make logical filter groups with and/or operators.

> How to search for customers:

```shell
  curl --request POST
       --url 'https://example.booqable.com/api/boomerang/customers/search'
       --header 'content-type: application/json'
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
        "id": "fc31d64f-c136-4d37-8a09-e821bf52af93"
      },
      {
        "id": "987d8eb5-6236-4d00-8f7b-308f06d36519"
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
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[customers]=created_at,updated_at,archived`
`filter` | **hash** <br>The filters to apply `?filter[attribute][eq]=value`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=barcode,properties,tax_region`
`meta` | **hash** <br>Metadata to send along. `?meta[total][]=count`
`page[number]` | **string** <br>The page to request.
`page[size]` | **string** <br>The amount of items per page.
`sort` | **string** <br>How to sort the data. `?sort=attribute1,-attribute2`


### Filters

This request can be filtered on:

Name | Description
-- | --
`archived` | **boolean** <br>`eq`
`archived_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`conditions` | **hash** <br>`eq`
`created_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`deposit_type` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`deposit_value` | **float** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`discount_percentage` | **float** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`email` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`email_marketing_consented` | **boolean** <br>`eq`
`id` | **uuid** <br>`eq`, `not_eq`, `gt`
`legal_type` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`merge_suggestion_customer_id` | **uuid** <br>`eq`, `not_eq`
`name` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`number` | **integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`q` | **string** <br>`eq`
`tag_list` | **string** <br>`eq`
`tax_region_id` | **uuid** <br>`eq`, `not_eq`
`updated_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`archived` | **array** <br>`count`
`discount_percentage` | **array** <br>`maximum`, `minimum`, `average`
`legal_type` | **array** <br>`count`
`tag_list` | **array** <br>`count`
`total` | **array** <br>`count`


### Includes

This request accepts the following includes:

`barcode`


`properties`


`tax_region`


`payment_methods`






## Fetch a customer


> How to fetch a customers:

```shell
  curl --get 'https://example.booqable.com/api/boomerang/customers/2270a849-1797-436e-8b18-ef3fd6058a01'
       --header 'content-type: application/json'
       --data-urlencode 'include=barcode,properties'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "2270a849-1797-436e-8b18-ef3fd6058a01",
      "type": "customers",
      "attributes": {
        "created_at": "2028-05-22T08:53:00.000000+00:00",
        "updated_at": "2028-05-22T08:53:00.000000+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "John Doe",
        "email": "john-17@doe.test",
        "deposit_type": "default",
        "deposit_value": 0.0,
        "discount_percentage": 0.0,
        "legal_type": "person",
        "email_marketing_consented": false,
        "email_marketing_consent_updated_at": null,
        "properties": {},
        "tag_list": [],
        "merge_suggestion_customer_id": null,
        "tax_region_id": null
      },
      "relationships": {
        "properties": {
          "data": []
        },
        "barcode": {
          "data": null
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
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[customers]=created_at,updated_at,archived`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=barcode,properties,tax_region`


### Includes

This request accepts the following includes:

`barcode`


`properties`


`tax_region`


`payment_methods`






## Create a customer


> How to create a customer:

```shell
  curl --request POST
       --url 'https://example.booqable.com/api/boomerang/customers'
       --header 'content-type: application/json'
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
      "id": "81f21c77-e757-43d7-842f-41c5c184945e",
      "type": "customers",
      "attributes": {
        "created_at": "2015-09-14T16:31:01.000000+00:00",
        "updated_at": "2015-09-14T16:31:01.000000+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "John Doe",
        "email": "john@doe.com",
        "deposit_type": "default",
        "deposit_value": 0.0,
        "discount_percentage": 0.0,
        "legal_type": "person",
        "email_marketing_consented": false,
        "email_marketing_consent_updated_at": null,
        "properties": {},
        "tag_list": [],
        "merge_suggestion_customer_id": null,
        "tax_region_id": null
      },
      "relationships": {}
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
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[customers]=created_at,updated_at,archived`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=barcode,properties,tax_region`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][deposit_type]` | **string** <br>The deposit added to new orders of this customer by default. 
`data[attributes][deposit_value]` | **float** <br>The value to use for `deposit_type`. 
`data[attributes][discount_percentage]` | **float** <br>Default discount applied to each new order for this customer. 
`data[attributes][email]` | **string** <br>Email address used for communication. 
`data[attributes][email_marketing_consented]` | **boolean** <br>Whether the customer has consented to receive email marketing. 
`data[attributes][legal_type]` | **string** <br>Either `person` or `commercial`. 
`data[attributes][merge_suggestion_customer_id]` | **uuid** <br>Holds the customer this customer is a possible duplicate of. 
`data[attributes][name]` | **string** <br>Person or Company name. 
`data[attributes][properties_attributes][]` | **array** <br>Create or update multiple properties to be associated with this customer. 
`data[attributes][tag_list]` | **array[string]** <br>Case insensitive tag list. 
`data[attributes][tax_region_id]` | **uuid** <br>Tax region assigned to new orders for this customer. 


### Includes

This request accepts the following includes:

`barcode`


`properties`


`tax_region`


`payment_methods`






## Update a customer


> How to update a customer:

```shell
  curl --request PUT
       --url 'https://example.booqable.com/api/boomerang/customers/7eaf3c75-3143-4090-8ccf-32b899f324c9'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "id": "7eaf3c75-3143-4090-8ccf-32b899f324c9",
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
      "id": "7eaf3c75-3143-4090-8ccf-32b899f324c9",
      "type": "customers",
      "attributes": {
        "created_at": "2014-02-18T23:31:00.000000+00:00",
        "updated_at": "2014-02-18T23:31:00.000000+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "Jane Doe",
        "email": "john-19@doe.test",
        "deposit_type": "default",
        "deposit_value": 0.0,
        "discount_percentage": 0.0,
        "legal_type": "person",
        "email_marketing_consented": false,
        "email_marketing_consent_updated_at": null,
        "properties": {},
        "tag_list": [],
        "merge_suggestion_customer_id": null,
        "tax_region_id": null
      },
      "relationships": {}
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
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[customers]=created_at,updated_at,archived`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=barcode,properties,tax_region`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][deposit_type]` | **string** <br>The deposit added to new orders of this customer by default. 
`data[attributes][deposit_value]` | **float** <br>The value to use for `deposit_type`. 
`data[attributes][discount_percentage]` | **float** <br>Default discount applied to each new order for this customer. 
`data[attributes][email]` | **string** <br>Email address used for communication. 
`data[attributes][email_marketing_consented]` | **boolean** <br>Whether the customer has consented to receive email marketing. 
`data[attributes][legal_type]` | **string** <br>Either `person` or `commercial`. 
`data[attributes][merge_suggestion_customer_id]` | **uuid** <br>Holds the customer this customer is a possible duplicate of. 
`data[attributes][name]` | **string** <br>Person or Company name. 
`data[attributes][properties_attributes][]` | **array** <br>Create or update multiple properties to be associated with this customer. 
`data[attributes][tag_list]` | **array[string]** <br>Case insensitive tag list. 
`data[attributes][tax_region_id]` | **uuid** <br>Tax region assigned to new orders for this customer. 


### Includes

This request accepts the following includes:

`barcode`


`properties`


`tax_region`


`payment_methods`






## Archive a customer


> How to archive a customer:

```shell
  curl --request DELETE
       --url 'https://example.booqable.com/api/boomerang/customers/7a496d55-729c-43e0-8a6b-8d505e0f3c70'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "7a496d55-729c-43e0-8a6b-8d505e0f3c70",
      "type": "customers",
      "attributes": {
        "created_at": "2020-05-21T12:16:00.000000+00:00",
        "updated_at": "2020-05-21T12:16:00.000000+00:00",
        "archived": true,
        "archived_at": "2020-05-21T12:16:00.000000+00:00",
        "number": 1,
        "name": "John Doe",
        "email": "john-20@doe.test",
        "deposit_type": "default",
        "deposit_value": 0.0,
        "discount_percentage": 0.0,
        "legal_type": "person",
        "email_marketing_consented": false,
        "email_marketing_consent_updated_at": null,
        "properties": {},
        "tag_list": [],
        "merge_suggestion_customer_id": null,
        "tax_region_id": null
      },
      "relationships": {}
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
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[customers]=created_at,updated_at,archived`


### Includes

This request does not accept any includes