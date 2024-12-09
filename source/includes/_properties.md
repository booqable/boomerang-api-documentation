# Properties

While Booqable comes with standard fields, like a customer's name and a product's SKU, you can add custom properties to capture additional information that's important for you or your customers.

## Types

Properties can have different types and behave differently. These are the `values` you can supply for each type:

| **text_field** | Renders a text field |
| :------ | :-------- |
| `value` | String |

| **text_area** | Renders a text area |
| :------ | :-------- |
|`value` | String |

| **phone** | Renders a phone field |
| :------ | :-------- |
| `value` | String |

| **email** | Renders an email field |
| :------ | :-------- |
| `value` | String |

| **date_field** | Renders a date picker |
| :------ | :-------- |
| `value` | String |

| **select** | Renders a dropdown select |
| :------ | :-------- |
| `value` | String |

| **address** | Renders multiple fields |
| :------ | :-------- |
| `first_name`| String |
| `last_name` | String |
| `address1` | String |
| `address2` | String |
| `city` | String |
| `region` | String |
| `zipcode` | String |
| `country` | String |
| `country_id` | UUID |
| `province_id` | UUID |

Properties inherit their configuration fields from a default property when they are connected. When creating properties, they are mapped with their default when one of the following fields correspond:

- `name`
- `identifier`
- `default_property_id`

## Relationships
Name | Description
-- | --
`default_property` | **[Default property](#default-properties)** `optional`<br>The default property this property is linked to. Properties without default property are called "one-off" properties. 
`owner` | **[Customer](#customers), [Order](#orders), [Product group](#product-groups), [Stock item](#stock-items), [Order delivery rate](#order-delivery-rates)** `required`<br>The resource this property is about. 


Check matching attributes under [Fields](#properties-fields) to see which relations can be written.
<br/ >
Check each individual operation to see which relations can be included as a sideload.
## Fields

 Name | Description
-- | --
`address1` | **string** <br>For type `address`. 
`address2` | **string** <br>For type `address`. 
`city` | **string** <br>For type `address`. 
`country` | **string** <br>For property_type `address`. 
`country_id` | **string** <br>For property_type `address`. 
`created_at` | **datetime** `readonly`<br>When the resource was created.
`default_property_id` | **uuid** `nullable`<br>The default property this property is linked to. Properties without default property are called "one-off" properties. 
`first_name` | **string** <br>For type `address`. 
`id` | **uuid** `readonly`<br>Primary key.
`identifier` | **string** <br>Key that will be used in exports, responses and custom field variables in templates. 
`last_name` | **string** <br>For type `address`. 
`latitude` | **string** <br>For property_type `address`. 
`longitude` | **string** <br>For property_type `address`. 
`meets_validation_requirements` | **boolean** <br>Whether this property meets the validation requirements. 
`name` | **string** <br>Name of the property (used as label and to compute identifier if left blank). 
`owner_id` | **uuid** <br>The resource this property is about. 
`owner_type` | **string** <br>The resource type of the owner.
`position` | **integer** <br>Which position the property has relative to other properties of the same owner. This determines the sorting of properties when they are displayed. 
`property_type` | **enum** <br>Determines how the data is rendered and the kind of input shown to the user.<br> One of: `address`, `date_field`, `email`, `phone`, `select`, `text_area`, `text_field`.
`province_id` | **string** <br>For property_type `address`. 
`region` | **string** <br>For property_type `address`. 
`show_on` | **array[string]** <br>Array of items to show this custom field on. Zero or more from `contract`, `invoice`, `packing`, `quote`. 
`updated_at` | **datetime** `readonly`<br>When the resource was last updated.
`validation_required` | **boolean** <br>Whether this property has to be validated. 
`value` | **string** <br>For property_type `text_field`, `text_area`, `phone`, `email`, `date_field`, `select`. 
`zipcode` | **string** <br>For property_type `address`. 


## Listing properties


> How to fetch a list of properties:

```shell
  curl --get 'https://example.booqable.com/api/boomerang/properties'
       --header 'content-type: application/json'
       --data-urlencode 'include=owner'
```

> A 200 status response looks like this:

```json
  {
    "data": [
      {
        "id": "e3140ee7-66da-44b5-827f-a62c7f18110d",
        "type": "properties",
        "attributes": {
          "created_at": "2015-06-08T16:26:00.000000+00:00",
          "updated_at": "2015-06-08T16:26:00.000000+00:00",
          "name": "Phone",
          "identifier": "property_9",
          "position": 0,
          "property_type": "phone",
          "show_on": [],
          "validation_required": false,
          "meets_validation_requirements": true,
          "value": "+316000000",
          "default_property_id": null,
          "owner_id": "b4833bd7-fc68-444f-8965-b78a8ca805e5",
          "owner_type": "customers"
        },
        "relationships": {
          "owner": {
            "data": {
              "type": "customers",
              "id": "b4833bd7-fc68-444f-8965-b78a8ca805e5"
            }
          }
        }
      }
    ],
    "included": [
      {
        "id": "b4833bd7-fc68-444f-8965-b78a8ca805e5",
        "type": "customers",
        "attributes": {
          "created_at": "2015-06-08T16:26:00.000000+00:00",
          "updated_at": "2015-06-08T16:26:00.000000+00:00",
          "archived": false,
          "archived_at": null,
          "number": 1,
          "name": "John Doe",
          "email": "john-69@doe.test",
          "deposit_type": "default",
          "deposit_value": 0.0,
          "discount_percentage": 0.0,
          "legal_type": "person",
          "email_marketing_consented": false,
          "email_marketing_consent_updated_at": null,
          "properties": {
            "property_9": "+316000000"
          },
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

`GET /api/boomerang/properties`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma seperated fields to include `?fields[properties]=created_at,updated_at,name`
`filter` | **hash** <br>The filters to apply `?filter[attribute][eq]=value`
`include` | **string** <br>List of comma seperated relationships `?include=owner`
`meta` | **hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **string** <br>The page to request
`page[size]` | **string** <br>The amount of items per page (max 100)
`sort` | **string** <br>How to sort the data `?sort=attribute1,-attribute2`


### Filters

This request can be filtered on:

Name | Description
-- | --
`created_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`default_property_id` | **uuid** <br>`eq`, `not_eq`
`id` | **uuid** <br>`eq`, `not_eq`
`identifier` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`name` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`owner_id` | **uuid** <br>`eq`, `not_eq`
`owner_type` | **string** <br>`eq`, `not_eq`
`updated_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **array** <br>`count`


### Includes

This request accepts the following includes:

`owner`






## Fetching a property


> How to fetch a properties:

```shell
  curl --get 'https://example.booqable.com/api/boomerang/properties/bf39d273-20f0-4ee7-8d27-d759310a96ff'
       --header 'content-type: application/json'
       --data-urlencode 'include=owner'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "bf39d273-20f0-4ee7-8d27-d759310a96ff",
      "type": "properties",
      "attributes": {
        "created_at": "2023-03-01T10:14:02.000000+00:00",
        "updated_at": "2023-03-01T10:14:02.000000+00:00",
        "name": "Phone",
        "identifier": "property_10",
        "position": 0,
        "property_type": "phone",
        "show_on": [],
        "validation_required": false,
        "meets_validation_requirements": true,
        "value": "+316000000",
        "default_property_id": null,
        "owner_id": "6d22d0ac-1eb9-470f-8daa-9f198a9e3fc6",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "data": {
            "type": "customers",
            "id": "6d22d0ac-1eb9-470f-8daa-9f198a9e3fc6"
          }
        }
      }
    },
    "included": [
      {
        "id": "6d22d0ac-1eb9-470f-8daa-9f198a9e3fc6",
        "type": "customers",
        "attributes": {
          "created_at": "2023-03-01T10:14:02.000000+00:00",
          "updated_at": "2023-03-01T10:14:02.000000+00:00",
          "archived": false,
          "archived_at": null,
          "number": 1,
          "name": "John Doe",
          "email": "john-70@doe.test",
          "deposit_type": "default",
          "deposit_value": 0.0,
          "discount_percentage": 0.0,
          "legal_type": "person",
          "email_marketing_consented": false,
          "email_marketing_consent_updated_at": null,
          "properties": {
            "property_10": "+316000000"
          },
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

`GET /api/boomerang/properties/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma seperated fields to include `?fields[properties]=created_at,updated_at,name`
`include` | **string** <br>List of comma seperated relationships `?include=owner`


### Includes

This request accepts the following includes:

`owner`






## Creating a property


> How to create a property and assign it to an owner:

```shell
  curl --request POST \
       --url 'https://example.booqable.com/api/boomerang/properties'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "type": "properties",
           "attributes": {
             "name": "Phone",
             "property_type": "phone",
             "value": "+316000000",
             "owner_id": "7e69a28e-0d76-4024-81cc-bf5354f84c2e",
             "owner_type": "customers"
           }
         },
         "include": "owner"
       }'
```

> A 201 status response looks like this:

```json
  {
    "data": {
      "id": "a0e53cf2-3711-46d7-86f4-ff9422e2c069",
      "type": "properties",
      "attributes": {
        "created_at": "2023-03-09T00:06:01.000000+00:00",
        "updated_at": "2023-03-09T00:06:01.000000+00:00",
        "name": "Phone",
        "identifier": "phone",
        "position": 0,
        "property_type": "phone",
        "show_on": [],
        "validation_required": false,
        "meets_validation_requirements": true,
        "value": "+316000000",
        "default_property_id": null,
        "owner_id": "7e69a28e-0d76-4024-81cc-bf5354f84c2e",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "data": {
            "type": "customers",
            "id": "7e69a28e-0d76-4024-81cc-bf5354f84c2e"
          }
        }
      }
    },
    "included": [
      {
        "id": "7e69a28e-0d76-4024-81cc-bf5354f84c2e",
        "type": "customers",
        "attributes": {
          "created_at": "2023-03-09T00:06:01.000000+00:00",
          "updated_at": "2023-03-09T00:06:01.000000+00:00",
          "archived": false,
          "archived_at": null,
          "number": 2,
          "name": "Jane Doe",
          "email": "john-72@doe.test",
          "deposit_type": "default",
          "deposit_value": 0.0,
          "discount_percentage": 0.0,
          "legal_type": "person",
          "email_marketing_consented": false,
          "email_marketing_consent_updated_at": null,
          "properties": {
            "phone": "+316000000"
          },
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

`POST /api/boomerang/properties`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma seperated fields to include `?fields[properties]=created_at,updated_at,name`
`include` | **string** <br>List of comma seperated relationships `?include=owner`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][address1]` | **string** <br>For type `address`. 
`data[attributes][address2]` | **string** <br>For type `address`. 
`data[attributes][city]` | **string** <br>For type `address`. 
`data[attributes][country]` | **string** <br>For property_type `address`. 
`data[attributes][country_id]` | **string** <br>For property_type `address`. 
`data[attributes][default_property_id]` | **uuid** <br>The default property this property is linked to. Properties without default property are called "one-off" properties. 
`data[attributes][first_name]` | **string** <br>For type `address`. 
`data[attributes][identifier]` | **string** <br>Key that will be used in exports, responses and custom field variables in templates. 
`data[attributes][last_name]` | **string** <br>For type `address`. 
`data[attributes][latitude]` | **string** <br>For property_type `address`. 
`data[attributes][longitude]` | **string** <br>For property_type `address`. 
`data[attributes][meets_validation_requirements]` | **boolean** <br>Whether this property meets the validation requirements. 
`data[attributes][name]` | **string** <br>Name of the property (used as label and to compute identifier if left blank). 
`data[attributes][owner_id]` | **uuid** <br>The resource this property is about. 
`data[attributes][owner_type]` | **string** <br>The resource type of the owner.
`data[attributes][position]` | **integer** <br>Which position the property has relative to other properties of the same owner. This determines the sorting of properties when they are displayed. 
`data[attributes][property_type]` | **enum** <br>Determines how the data is rendered and the kind of input shown to the user.<br> One of: `address`, `date_field`, `email`, `phone`, `select`, `text_area`, `text_field`.
`data[attributes][province_id]` | **string** <br>For property_type `address`. 
`data[attributes][region]` | **string** <br>For property_type `address`. 
`data[attributes][show_on]` | **array[string]** <br>Array of items to show this custom field on. Zero or more from `contract`, `invoice`, `packing`, `quote`. 
`data[attributes][validation_required]` | **boolean** <br>Whether this property has to be validated. 
`data[attributes][value]` | **string** <br>For property_type `text_field`, `text_area`, `phone`, `email`, `date_field`, `select`. 
`data[attributes][zipcode]` | **string** <br>For property_type `address`. 


### Includes

This request accepts the following includes:

`owner`






## Updating a property


> How to update a property:

```shell
  curl --request PUT \
       --url 'https://example.booqable.com/api/boomerang/properties/a08be1e9-e4aa-4b1e-8a1c-ac9d6fa79d78'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "id": "a08be1e9-e4aa-4b1e-8a1c-ac9d6fa79d78",
           "type": "properties",
           "attributes": {
             "value": "+316000001"
           }
         }
       }'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "a08be1e9-e4aa-4b1e-8a1c-ac9d6fa79d78",
      "type": "properties",
      "attributes": {
        "created_at": "2028-10-19T14:18:00.000000+00:00",
        "updated_at": "2028-10-19T14:18:00.000000+00:00",
        "name": "Phone",
        "identifier": "property_12",
        "position": 0,
        "property_type": "phone",
        "show_on": [],
        "validation_required": false,
        "meets_validation_requirements": true,
        "value": "+316000001",
        "default_property_id": null,
        "owner_id": "4e6e1abc-ddfd-434a-89eb-921b87839aff",
        "owner_type": "customers"
      },
      "relationships": {}
    },
    "meta": {}
  }
```

### HTTP Request

`PUT /api/boomerang/properties/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma seperated fields to include `?fields[properties]=created_at,updated_at,name`
`include` | **string** <br>List of comma seperated relationships `?include=owner`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][address1]` | **string** <br>For type `address`. 
`data[attributes][address2]` | **string** <br>For type `address`. 
`data[attributes][city]` | **string** <br>For type `address`. 
`data[attributes][country]` | **string** <br>For property_type `address`. 
`data[attributes][country_id]` | **string** <br>For property_type `address`. 
`data[attributes][default_property_id]` | **uuid** <br>The default property this property is linked to. Properties without default property are called "one-off" properties. 
`data[attributes][first_name]` | **string** <br>For type `address`. 
`data[attributes][identifier]` | **string** <br>Key that will be used in exports, responses and custom field variables in templates. 
`data[attributes][last_name]` | **string** <br>For type `address`. 
`data[attributes][latitude]` | **string** <br>For property_type `address`. 
`data[attributes][longitude]` | **string** <br>For property_type `address`. 
`data[attributes][meets_validation_requirements]` | **boolean** <br>Whether this property meets the validation requirements. 
`data[attributes][name]` | **string** <br>Name of the property (used as label and to compute identifier if left blank). 
`data[attributes][owner_id]` | **uuid** <br>The resource this property is about. 
`data[attributes][owner_type]` | **string** <br>The resource type of the owner.
`data[attributes][position]` | **integer** <br>Which position the property has relative to other properties of the same owner. This determines the sorting of properties when they are displayed. 
`data[attributes][property_type]` | **enum** <br>Determines how the data is rendered and the kind of input shown to the user.<br> One of: `address`, `date_field`, `email`, `phone`, `select`, `text_area`, `text_field`.
`data[attributes][province_id]` | **string** <br>For property_type `address`. 
`data[attributes][region]` | **string** <br>For property_type `address`. 
`data[attributes][show_on]` | **array[string]** <br>Array of items to show this custom field on. Zero or more from `contract`, `invoice`, `packing`, `quote`. 
`data[attributes][validation_required]` | **boolean** <br>Whether this property has to be validated. 
`data[attributes][value]` | **string** <br>For property_type `text_field`, `text_area`, `phone`, `email`, `date_field`, `select`. 
`data[attributes][zipcode]` | **string** <br>For property_type `address`. 


### Includes

This request accepts the following includes:

`owner`






## Deleting a property


> How to delete a property:

```shell
  curl --request DELETE \
       --url 'https://example.booqable.com/api/boomerang/properties/eab99cab-3fac-4afa-88a3-1ce18a98889e'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "eab99cab-3fac-4afa-88a3-1ce18a98889e",
      "type": "properties",
      "attributes": {
        "created_at": "2023-03-23T09:40:01.000000+00:00",
        "updated_at": "2023-03-23T09:40:01.000000+00:00",
        "name": "Phone",
        "identifier": "property_13",
        "position": 0,
        "property_type": "phone",
        "show_on": [],
        "validation_required": false,
        "meets_validation_requirements": null,
        "value": "+316000000",
        "default_property_id": null,
        "owner_id": "229fb004-46fc-4b3f-8564-613cc13d86db",
        "owner_type": "customers"
      },
      "relationships": {}
    },
    "meta": {}
  }
```

### HTTP Request

`DELETE /api/boomerang/properties/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma seperated fields to include `?fields[properties]=created_at,updated_at,name`
`include` | **string** <br>List of comma seperated relationships `?include=owner`


### Includes

This request accepts the following includes:

`owner`






## Managing multiple properties on a resource

On the following resources you can manage multiple properties at once:

- Customers
- Product groups
- Orders
- Stock items

> Creating properties that correspond with an existing default property (we've already created a default phone property for a customer):

```shell
  curl --request  \
       --url 'https://example.booqable.com/api/boomerang/customers'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "type": "customers",
           "attributes": {
             "name": "John Doe",
             "properties_attributes": [
               {
                 "identifier": "phone",
                 "value": "+316000000"
               }
             ]
           }
         }
       }'
```

> A 201 status response looks like this:

```json
  {
    "data": {
      "id": "81175bbc-d6be-4b49-8652-703376d0dcf3",
      "type": "customers",
      "attributes": {
        "created_at": "2016-09-16T16:16:00.000000+00:00",
        "updated_at": "2016-09-16T16:16:00.000000+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "John Doe",
        "email": null,
        "deposit_type": "default",
        "deposit_value": 0.0,
        "discount_percentage": 0.0,
        "legal_type": "person",
        "email_marketing_consented": false,
        "email_marketing_consent_updated_at": null,
        "properties": {
          "phone": "+316000000"
        },
        "tag_list": [],
        "merge_suggestion_customer_id": null,
        "tax_region_id": null
      },
      "relationships": {}
    },
    "meta": {}
  }
```

> Creating one-off properties (no corresponding default property):

```shell
  curl --request  \
       --url 'https://example.booqable.com/api/boomerang/customers'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "type": "customers",
           "attributes": {
             "name": "John Doe",
             "properties_attributes": [
               {
                 "name": "Phone",
                 "value": "+316000000",
                 "property_type": "phone"
               }
             ]
           }
         }
       }'
```

> A 201 status response looks like this:

```json
  {
    "data": {
      "id": "cd10348e-02f9-4463-8ccb-91cab20a4957",
      "type": "customers",
      "attributes": {
        "created_at": "2026-07-15T11:51:02.000000+00:00",
        "updated_at": "2026-07-15T11:51:02.000000+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "John Doe",
        "email": null,
        "deposit_type": "default",
        "deposit_value": 0.0,
        "discount_percentage": 0.0,
        "legal_type": "person",
        "email_marketing_consented": false,
        "email_marketing_consent_updated_at": null,
        "properties": {
          "phone": "+316000000"
        },
        "tag_list": [],
        "merge_suggestion_customer_id": null,
        "tax_region_id": null
      },
      "relationships": {}
    },
    "meta": {}
  }
```

> Deleting a property while updating another one:

```shell
  curl --request  \
       --url 'https://example.booqable.com/api/boomerang/customers/273e87b8-f7db-4315-8d74-4371f489b516'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "type": "customers",
           "id": "273e87b8-f7db-4315-8d74-4371f489b516",
           "attributes": {
             "name": "John Doe",
             "properties_attributes": [
               {
                 "identifier": "phone",
                 "_destroy": true
               },
               {
                 "identifier": "birthday",
                 "value": "01-01-1970"
               }
             ]
           }
         }
       }'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "273e87b8-f7db-4315-8d74-4371f489b516",
      "type": "customers",
      "attributes": {
        "created_at": "2022-01-05T06:05:01.000000+00:00",
        "updated_at": "2022-01-05T06:05:01.000000+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "John Doe",
        "email": "john-78@doe.test",
        "deposit_type": "default",
        "deposit_value": 0.0,
        "discount_percentage": 0.0,
        "legal_type": "person",
        "email_marketing_consented": false,
        "email_marketing_consent_updated_at": null,
        "properties": {
          "birthday": "01-01-1970"
        },
        "tag_list": [],
        "merge_suggestion_customer_id": null,
        "tax_region_id": null
      },
      "relationships": {}
    },
    "meta": {}
  }
```

### Includes

All includes are allowed on this request