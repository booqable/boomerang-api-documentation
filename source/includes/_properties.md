# Properties

While Booqable comes with standard fields, like a customer's name and a product's SKU,
you can add custom properties to capture additional information that's important for you
or your customers.

<aside class="notice">
  You can query and manage properties through the Property endpoints, but usually it is
  easier to read them using the <code>properties</code> attribute and create/update them through
  the <code>properties_attributes</code> attribute of the resource they belong to.
  <ul>
    <li>When you need more details than provided by the <code>properties</code> attribute,
    use <code>?include=properties</code> to sideload properties instead of querying them separately.</li>
    <li>Have a look at <a href="#properties-manage-properties-through-their-owner">Manage properties through their owner</a>
    to see how to use <code>properties_attributes</code>.</li>
  </ul>
</aside>

## Linking to default properties

Properties inherit their configuration from a default property.
When creating properties, they are linked to a default when one of the following fields matches:

- `name` (case insensitive)
- `identifier`
- `default_property_id`

## Owners

- Customers
- Orders
- Product groups
  Properties belong to products groups, and are the same for all products in a product group.
  The `properties` relation and attribute of the Product resource contain the properties of the group,
  and you can sideload them as resource by using `products?include=properties`. But because properties
  actually belong to product groups, filtering properties by `product.id` does _not_ work.

## Types

Properties can have different types and behave differently. These are the `values` you can supply for each type:

| **text_field** | Renders a text field |
| :------ | :-------- |
| `value` | **`string`** |

| **text_area** | Renders a text area |
| :------ | :-------- |
|`value` | **`string`** |

| **phone** | Renders a phone field |
| :------ | :-------- |
| `value` | **`string`** |

| **email** | Renders an email field |
| :------ | :-------- |
| `value` | **`string`** |

| **date_field** | Renders a date picker |
| :------ | :-------- |
| `value` | **`string`** |

| **select** | Renders a dropdown select |
| :------ | :-------- |
| `value` | **`string`** |

| **address** | Renders multiple fields |
| :------ | :-------- |
| `first_name`| **`string`** |
| `last_name` | **`string`** |
| `address1` | **`string`** |
| `address2` | **`string`** |
| `city` | **`string`** |
| `region` | **`string`** |
| `zipcode` | **`string`** |
| `country` | **`string`** |
| `country_id` | **`uuid`** |
| `province_id` | **`uuid`** |

## Relationships
Name | Description
-- | --
`default_property` | **[Default property](#default-properties)** `optional`<br>The [DefaultProperty](#default-properties) this property is linked to. Properties without default property are called "one-off" properties. 
`owner` | **[Customer](#customers), [Order](#orders), [Product group](#product-groups), [Stock item](#stock-items)** `required`<br>The resource this property is about. 


Check matching attributes under [Fields](#properties-fields) to see which relations can be written.
<br/ >
Check each individual operation to see which relations can be included as a sideload.
## Fields

 Name | Description
-- | --
`address1` | **string** <br>For type `address`. 
`address2` | **string** <br>For type `address`. 
`city` | **string** <br>For type `address`. 
`country` | **string** <br>For type `address`. 
`country_id` | **string** <br>For type `address`. 
`created_at` | **datetime** `readonly`<br>When the resource was created.
`default_property_id` | **uuid** `nullable`<br>The [DefaultProperty](#default-properties) this property is linked to. Properties without default property are called "one-off" properties. 
`first_name` | **string** <br>For type `address`. 
`id` | **uuid** `readonly`<br>Primary key.
`identifier` | **string** <br>Key that will be used in exports, responses and custom field variables in templates. 
`last_name` | **string** <br>For type `address`. 
`latitude` | **string** <br>For type `address`. 
`longitude` | **string** <br>For type `address`. 
`meets_validation_requirements` | **boolean** `readonly`<br>Whether this property meets the validation requirements. 
`name` | **string** <br>Name of the property (used as label and to compute identifier if left blank). 
`owner_id` | **uuid** `readonly-after-create`<br>The resource this property is about. 
`owner_type` | **enum** `readonly-after-create`<br>The resource type of the owner.<br>One of: `customers`, `orders`, `product_groups`, `stock_items`.
`position` | **integer** <br>Which position the property has relative to other properties of the same owner. This determines the sorting of properties when they are displayed. 
`property_type` | **enum** <br>Determines how the data is rendered and the kind of input shown to the user.<br> One of: `address`, `date_field`, `email`, `phone`, `select`, `text_area`, `text_field`.
`province_id` | **string** <br>For type `address`. 
`region` | **string** <br>For type `address`. 
`show_on` | **array[string]** <br>Array of document types to show this custom field on. Zero or more from `contract`, `invoice`, `packing`, `quote`. For properties that are linked to a default property, always the value from the default property will be used and the `show_on` attribute of the individual property is ignored. 
`updated_at` | **datetime** `readonly`<br>When the resource was last updated.
`validation_required` | **boolean** <br>Whether this property has to be validated. 
`value` | **string** <br>For type `text_field`, `text_area`, `phone`, `email`, `date_field`, or `select`. 
`zipcode` | **string** <br>For type `address`. 


## Manage properties through their owner

On the following resources you can manage properties
by setting the `properties_attribute` attribute:

- Customers
- Product groups
- Orders

> Create a property that corresponds with an existing default property (assuming a default phone property exists):

```shell
  curl --request 
       --url 'https://example.booqable.com/api/4/customers'
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
      "id": "78172414-b6f5-44e3-874c-3ca4eafe1a02",
      "type": "customers",
      "attributes": {
        "created_at": "2027-08-03T07:47:02.000000+00:00",
        "updated_at": "2027-08-03T07:47:02.000000+00:00",
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

> Create a one-off property (no corresponding default property):

```shell
  curl --request 
       --url 'https://example.booqable.com/api/4/customers'
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
      "id": "48b9cace-e329-4be8-809a-d997d34eb388",
      "type": "customers",
      "attributes": {
        "created_at": "2026-04-01T06:11:06.000000+00:00",
        "updated_at": "2026-04-01T06:11:06.000000+00:00",
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
  curl --request 
       --url 'https://example.booqable.com/api/4/customers/273e87b8-f7db-4315-8d74-4371f489b516'
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
        "email": "john-72@doe.test",
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

This request does not accept any includes
## List properties


> How to fetch a list of properties:

```shell
  curl --get 'https://example.booqable.com/api/4/properties'
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
          "identifier": "property_12",
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
          "email": "john-73@doe.test",
          "deposit_type": "default",
          "deposit_value": 0.0,
          "discount_percentage": 0.0,
          "legal_type": "person",
          "email_marketing_consented": false,
          "email_marketing_consent_updated_at": null,
          "properties": {
            "property_12": "+316000000"
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
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[properties]=created_at,updated_at,name`
`filter` | **hash** <br>The filters to apply `?filter[attribute][eq]=value`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=owner`
`meta` | **hash** <br>Metadata to send along. `?meta[total][]=count`
`page[number]` | **string** <br>The page to request.
`page[size]` | **string** <br>The amount of items per page.
`sort` | **string** <br>How to sort the data. `?sort=attribute1,-attribute2`


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
`owner_type` | **enum** <br>`eq`, `not_eq`
`updated_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **array** <br>`count`


### Includes

This request accepts the following includes:

<ul>
  <li><code>owner</code></li>
</ul>


## Fetch a property


> How to fetch a property:

```shell
  curl --get 'https://example.booqable.com/api/4/properties/65f05300-83b5-4cd8-8a15-36bc907ecfe1'
       --header 'content-type: application/json'
       --data-urlencode 'include=owner'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "65f05300-83b5-4cd8-8a15-36bc907ecfe1",
      "type": "properties",
      "attributes": {
        "created_at": "2026-04-19T17:00:00.000000+00:00",
        "updated_at": "2026-04-19T17:00:00.000000+00:00",
        "name": "Phone",
        "identifier": "property_13",
        "position": 0,
        "property_type": "phone",
        "show_on": [],
        "validation_required": false,
        "meets_validation_requirements": true,
        "value": "+316000000",
        "default_property_id": null,
        "owner_id": "bef24f9a-d753-437a-8b76-468be9985412",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "data": {
            "type": "customers",
            "id": "bef24f9a-d753-437a-8b76-468be9985412"
          }
        }
      }
    },
    "included": [
      {
        "id": "bef24f9a-d753-437a-8b76-468be9985412",
        "type": "customers",
        "attributes": {
          "created_at": "2026-04-19T17:00:00.000000+00:00",
          "updated_at": "2026-04-19T17:00:00.000000+00:00",
          "archived": false,
          "archived_at": null,
          "number": 1,
          "name": "John Doe",
          "email": "john-74@doe.test",
          "deposit_type": "default",
          "deposit_value": 0.0,
          "discount_percentage": 0.0,
          "legal_type": "person",
          "email_marketing_consented": false,
          "email_marketing_consent_updated_at": null,
          "properties": {
            "property_13": "+316000000"
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
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[properties]=created_at,updated_at,name`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=owner`


### Includes

This request accepts the following includes:

<ul>
  <li><code>owner</code></li>
</ul>


## Create a property


> How to create a property and assign it to an owner:

```shell
  curl --request POST
       --url 'https://example.booqable.com/api/4/properties'
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
          "email": "john-76@doe.test",
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
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[properties]=created_at,updated_at,name`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=owner`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][address1]` | **string** <br>For type `address`. 
`data[attributes][address2]` | **string** <br>For type `address`. 
`data[attributes][city]` | **string** <br>For type `address`. 
`data[attributes][country]` | **string** <br>For type `address`. 
`data[attributes][country_id]` | **string** <br>For type `address`. 
`data[attributes][default_property_id]` | **uuid** <br>The [DefaultProperty](#default-properties) this property is linked to. Properties without default property are called "one-off" properties. 
`data[attributes][first_name]` | **string** <br>For type `address`. 
`data[attributes][identifier]` | **string** <br>Key that will be used in exports, responses and custom field variables in templates. 
`data[attributes][last_name]` | **string** <br>For type `address`. 
`data[attributes][latitude]` | **string** <br>For type `address`. 
`data[attributes][longitude]` | **string** <br>For type `address`. 
`data[attributes][name]` | **string** <br>Name of the property (used as label and to compute identifier if left blank). 
`data[attributes][owner_id]` | **uuid** <br>The resource this property is about. 
`data[attributes][owner_type]` | **enum** <br>The resource type of the owner.<br>One of: `customers`, `orders`, `product_groups`, `stock_items`.
`data[attributes][position]` | **integer** <br>Which position the property has relative to other properties of the same owner. This determines the sorting of properties when they are displayed. 
`data[attributes][property_type]` | **enum** <br>Determines how the data is rendered and the kind of input shown to the user.<br> One of: `address`, `date_field`, `email`, `phone`, `select`, `text_area`, `text_field`.
`data[attributes][province_id]` | **string** <br>For type `address`. 
`data[attributes][region]` | **string** <br>For type `address`. 
`data[attributes][show_on]` | **array[string]** <br>Array of document types to show this custom field on. Zero or more from `contract`, `invoice`, `packing`, `quote`. For properties that are linked to a default property, always the value from the default property will be used and the `show_on` attribute of the individual property is ignored. 
`data[attributes][validation_required]` | **boolean** <br>Whether this property has to be validated. 
`data[attributes][value]` | **string** <br>For type `text_field`, `text_area`, `phone`, `email`, `date_field`, or `select`. 
`data[attributes][zipcode]` | **string** <br>For type `address`. 


### Includes

This request accepts the following includes:

<ul>
  <li><code>owner</code></li>
</ul>


## Update a property


> How to update a property:

```shell
  curl --request PUT
       --url 'https://example.booqable.com/api/4/properties/a08be1e9-e4aa-4b1e-8a1c-ac9d6fa79d78'
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
        "identifier": "property_15",
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
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[properties]=created_at,updated_at,name`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=owner`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][address1]` | **string** <br>For type `address`. 
`data[attributes][address2]` | **string** <br>For type `address`. 
`data[attributes][city]` | **string** <br>For type `address`. 
`data[attributes][country]` | **string** <br>For type `address`. 
`data[attributes][country_id]` | **string** <br>For type `address`. 
`data[attributes][default_property_id]` | **uuid** <br>The [DefaultProperty](#default-properties) this property is linked to. Properties without default property are called "one-off" properties. 
`data[attributes][first_name]` | **string** <br>For type `address`. 
`data[attributes][identifier]` | **string** <br>Key that will be used in exports, responses and custom field variables in templates. 
`data[attributes][last_name]` | **string** <br>For type `address`. 
`data[attributes][latitude]` | **string** <br>For type `address`. 
`data[attributes][longitude]` | **string** <br>For type `address`. 
`data[attributes][name]` | **string** <br>Name of the property (used as label and to compute identifier if left blank). 
`data[attributes][owner_id]` | **uuid** <br>The resource this property is about. 
`data[attributes][owner_type]` | **enum** <br>The resource type of the owner.<br>One of: `customers`, `orders`, `product_groups`, `stock_items`.
`data[attributes][position]` | **integer** <br>Which position the property has relative to other properties of the same owner. This determines the sorting of properties when they are displayed. 
`data[attributes][property_type]` | **enum** <br>Determines how the data is rendered and the kind of input shown to the user.<br> One of: `address`, `date_field`, `email`, `phone`, `select`, `text_area`, `text_field`.
`data[attributes][province_id]` | **string** <br>For type `address`. 
`data[attributes][region]` | **string** <br>For type `address`. 
`data[attributes][show_on]` | **array[string]** <br>Array of document types to show this custom field on. Zero or more from `contract`, `invoice`, `packing`, `quote`. For properties that are linked to a default property, always the value from the default property will be used and the `show_on` attribute of the individual property is ignored. 
`data[attributes][validation_required]` | **boolean** <br>Whether this property has to be validated. 
`data[attributes][value]` | **string** <br>For type `text_field`, `text_area`, `phone`, `email`, `date_field`, or `select`. 
`data[attributes][zipcode]` | **string** <br>For type `address`. 


### Includes

This request accepts the following includes:

<ul>
  <li><code>owner</code></li>
</ul>


## Delete a property


> How to delete a property:

```shell
  curl --request DELETE
       --url 'https://example.booqable.com/api/4/properties/eab99cab-3fac-4afa-88a3-1ce18a98889e'
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
        "identifier": "property_16",
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
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[properties]=created_at,updated_at,name`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=owner`


### Includes

This request accepts the following includes:

<ul>
  <li><code>owner</code></li>
</ul>

