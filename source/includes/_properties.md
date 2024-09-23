# Properties

While Booqable comes with standard fields, like a customer's name and a product's SKU, you can add custom properties to capture additional information that's important for you or your customers.

### Types

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

| **date** | Renders a date picker |
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

## Endpoints
`GET /api/boomerang/properties`

`GET /api/boomerang/properties/{id}`

`POST /api/boomerang/properties`

`PUT /api/boomerang/properties/{id}`

`DELETE /api/boomerang/properties/{id}`

## Fields
Every property has the following fields:

Name | Description
-- | --
`id` | **Uuid** `readonly`<br>Primary key
`created_at` | **Datetime** `readonly`<br>When the resource was created
`updated_at` | **Datetime** `readonly`<br>When the resource was last updated
`name` | **String** <br>Name of the property (used as label and to compute identifier if left blank)
`identifier` | **String** <br>Key that will be used in exports, responses and custom field variables in templates
`position` | **Integer** <br>Which position the property has
`property_type` | **String** <br>One of `address`, `date_field`, `email`, `phone`, `select`, `text_area`, `text_field`
`show_on` | **Array** <br>Array of items to show this custom field on. Any of `contract`, `invoice`, `packing`, `quote`
`validation_required` | **Boolean** <br>Whether this property has to be validated
`meets_validation_requirements` | **Boolean** <br>Whether this property meets the validation requirements
`first_name` | **String** <br>For type `address`
`last_name` | **String** <br>For type `address`
`address1` | **String** <br>For type `address`
`address2` | **String** <br>For type `address`
`city` | **String** <br>For type `address`
`region` | **String** <br>For type `address`
`zipcode` | **String** <br>For type `address`
`country` | **String** <br>For type `address`
`country_id` | **String** <br>For type `address`
`province_id` | **String** <br>For type `address`
`latitude` | **String** <br>For type `address`
`longitude` | **String** <br>For type `address`
`value` | **String** <br>For type `text_field`, `text_area`, `phone`, `email`, `date_field`, `select`
`default_property_id` | **Uuid** <br>The associated Default property
`owner_id` | **Uuid** <br>ID of its owner
`owner_type` | **String** <br>The resource type of the owner. One of `companies`, `customers`, `locations`, `orders`, `product_groups`, `stock_items`, `users`


## Relationships
Properties have the following relationships:

Name | Description
-- | --
`default_property` | **Default properties** `readonly`<br>Associated Default property
`owner` | **Customer, Order, Product group, Stock item** <br>Associated Owner


## Listing properties



> How to fetch a list of properties:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/properties?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "5bcc1d7d-3202-4891-9898-019dfd3c6aaf",
      "type": "properties",
      "attributes": {
        "created_at": "2024-09-23T09:23:38.052686+00:00",
        "updated_at": "2024-09-23T09:23:38.052686+00:00",
        "name": "Phone",
        "identifier": "property_7",
        "position": 0,
        "property_type": "phone",
        "show_on": [],
        "validation_required": false,
        "meets_validation_requirements": true,
        "value": "+316000000",
        "default_property_id": null,
        "owner_id": "813d030d-bb8a-4018-bbff-c97e659e9307",
        "owner_type": "customers"
      },
      "relationships": {
        "owner": {
          "data": {
            "type": "customers",
            "id": "813d030d-bb8a-4018-bbff-c97e659e9307"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "813d030d-bb8a-4018-bbff-c97e659e9307",
      "type": "customers",
      "attributes": {
        "created_at": "2024-09-23T09:23:37.930651+00:00",
        "updated_at": "2024-09-23T09:23:38.054578+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "John Doe",
        "email": "john-43@doe.test",
        "deposit_type": "default",
        "deposit_value": 0.0,
        "discount_percentage": 0.0,
        "legal_type": "person",
        "email_marketing_consented": false,
        "email_marketing_consent_updated_at": null,
        "properties": {
          "property_7": "+316000000"
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
`include` | **String** <br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[properties]=created_at,updated_at,name`
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
`name` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`identifier` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`default_property_id` | **Uuid** <br>`eq`, `not_eq`
`owner_id` | **Uuid** <br>`eq`, `not_eq`
`owner_type` | **String** <br>`eq`, `not_eq`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **Array** <br>`count`


### Includes

This request accepts the following includes:

`owner`






## Fetching a property



> How to fetch a properties:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/properties/8c987200-2f88-48ba-b487-2e366378a10d?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "8c987200-2f88-48ba-b487-2e366378a10d",
    "type": "properties",
    "attributes": {
      "created_at": "2024-09-23T09:23:38.512501+00:00",
      "updated_at": "2024-09-23T09:23:38.512501+00:00",
      "name": "Phone",
      "identifier": "property_8",
      "position": 0,
      "property_type": "phone",
      "show_on": [],
      "validation_required": false,
      "meets_validation_requirements": true,
      "value": "+316000000",
      "default_property_id": null,
      "owner_id": "75e5dafc-e4a9-42b8-b5b3-7146deab70e9",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "customers",
          "id": "75e5dafc-e4a9-42b8-b5b3-7146deab70e9"
        }
      }
    }
  },
  "included": [
    {
      "id": "75e5dafc-e4a9-42b8-b5b3-7146deab70e9",
      "type": "customers",
      "attributes": {
        "created_at": "2024-09-23T09:23:38.474234+00:00",
        "updated_at": "2024-09-23T09:23:38.514335+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "John Doe",
        "email": "john-44@doe.test",
        "deposit_type": "default",
        "deposit_value": 0.0,
        "discount_percentage": 0.0,
        "legal_type": "person",
        "email_marketing_consented": false,
        "email_marketing_consent_updated_at": null,
        "properties": {
          "property_8": "+316000000"
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
`include` | **String** <br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[properties]=created_at,updated_at,name`


### Includes

This request accepts the following includes:

`owner`






## Creating a property



> How to create a property and assign it to an owner:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/properties' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "properties",
        "attributes": {
          "name": "Phone",
          "property_type": "phone",
          "value": "+316000000",
          "owner_id": "3588e476-a83a-4c81-9dcb-f2e32eaf282d",
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
    "id": "aa55fb1f-3f35-432c-86c2-1263c2e0b4b8",
    "type": "properties",
    "attributes": {
      "created_at": "2024-09-23T09:23:37.419374+00:00",
      "updated_at": "2024-09-23T09:23:37.419374+00:00",
      "name": "Phone",
      "identifier": "phone",
      "position": 0,
      "property_type": "phone",
      "show_on": [],
      "validation_required": false,
      "meets_validation_requirements": true,
      "value": "+316000000",
      "default_property_id": null,
      "owner_id": "3588e476-a83a-4c81-9dcb-f2e32eaf282d",
      "owner_type": "customers"
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "customers",
          "id": "3588e476-a83a-4c81-9dcb-f2e32eaf282d"
        }
      }
    }
  },
  "included": [
    {
      "id": "3588e476-a83a-4c81-9dcb-f2e32eaf282d",
      "type": "customers",
      "attributes": {
        "created_at": "2024-09-23T09:23:37.371376+00:00",
        "updated_at": "2024-09-23T09:23:37.421244+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "Jane Doe",
        "email": "john-42@doe.test",
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
`include` | **String** <br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[properties]=created_at,updated_at,name`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][name]` | **String** <br>Name of the property (used as label and to compute identifier if left blank)
`data[attributes][identifier]` | **String** <br>Key that will be used in exports, responses and custom field variables in templates
`data[attributes][position]` | **Integer** <br>Which position the property has
`data[attributes][property_type]` | **String** <br>One of `address`, `date_field`, `email`, `phone`, `select`, `text_area`, `text_field`
`data[attributes][show_on][]` | **Array** <br>Array of items to show this custom field on. Any of `contract`, `invoice`, `packing`, `quote`
`data[attributes][validation_required]` | **Boolean** <br>Whether this property has to be validated
`data[attributes][meets_validation_requirements]` | **Boolean** <br>Whether this property meets the validation requirements
`data[attributes][first_name]` | **String** <br>For type `address`
`data[attributes][last_name]` | **String** <br>For type `address`
`data[attributes][address1]` | **String** <br>For type `address`
`data[attributes][address2]` | **String** <br>For type `address`
`data[attributes][city]` | **String** <br>For type `address`
`data[attributes][region]` | **String** <br>For type `address`
`data[attributes][zipcode]` | **String** <br>For type `address`
`data[attributes][country]` | **String** <br>For type `address`
`data[attributes][country_id]` | **String** <br>For type `address`
`data[attributes][province_id]` | **String** <br>For type `address`
`data[attributes][latitude]` | **String** <br>For type `address`
`data[attributes][longitude]` | **String** <br>For type `address`
`data[attributes][value]` | **String** <br>For type `text_field`, `text_area`, `phone`, `email`, `date_field`, `select`
`data[attributes][default_property_id]` | **Uuid** <br>The associated Default property
`data[attributes][owner_id]` | **Uuid** <br>ID of its owner
`data[attributes][owner_type]` | **String** <br>The resource type of the owner. One of `companies`, `customers`, `locations`, `orders`, `product_groups`, `stock_items`, `users`


### Includes

This request accepts the following includes:

`owner`






## Updating a property



> How to update a property:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/properties/6fd8b4e4-cfd1-4dce-89bc-3248a668dad4' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "6fd8b4e4-cfd1-4dce-89bc-3248a668dad4",
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
    "id": "6fd8b4e4-cfd1-4dce-89bc-3248a668dad4",
    "type": "properties",
    "attributes": {
      "created_at": "2024-09-23T09:23:34.068665+00:00",
      "updated_at": "2024-09-23T09:23:34.133089+00:00",
      "name": "Phone",
      "identifier": "property_1",
      "position": 0,
      "property_type": "phone",
      "show_on": [],
      "validation_required": false,
      "meets_validation_requirements": true,
      "value": "+316000001",
      "default_property_id": null,
      "owner_id": "e6764de1-61b4-4c83-af30-e62eb9f83220",
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
`include` | **String** <br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[properties]=created_at,updated_at,name`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][name]` | **String** <br>Name of the property (used as label and to compute identifier if left blank)
`data[attributes][identifier]` | **String** <br>Key that will be used in exports, responses and custom field variables in templates
`data[attributes][position]` | **Integer** <br>Which position the property has
`data[attributes][property_type]` | **String** <br>One of `address`, `date_field`, `email`, `phone`, `select`, `text_area`, `text_field`
`data[attributes][show_on][]` | **Array** <br>Array of items to show this custom field on. Any of `contract`, `invoice`, `packing`, `quote`
`data[attributes][validation_required]` | **Boolean** <br>Whether this property has to be validated
`data[attributes][meets_validation_requirements]` | **Boolean** <br>Whether this property meets the validation requirements
`data[attributes][first_name]` | **String** <br>For type `address`
`data[attributes][last_name]` | **String** <br>For type `address`
`data[attributes][address1]` | **String** <br>For type `address`
`data[attributes][address2]` | **String** <br>For type `address`
`data[attributes][city]` | **String** <br>For type `address`
`data[attributes][region]` | **String** <br>For type `address`
`data[attributes][zipcode]` | **String** <br>For type `address`
`data[attributes][country]` | **String** <br>For type `address`
`data[attributes][country_id]` | **String** <br>For type `address`
`data[attributes][province_id]` | **String** <br>For type `address`
`data[attributes][latitude]` | **String** <br>For type `address`
`data[attributes][longitude]` | **String** <br>For type `address`
`data[attributes][value]` | **String** <br>For type `text_field`, `text_area`, `phone`, `email`, `date_field`, `select`
`data[attributes][default_property_id]` | **Uuid** <br>The associated Default property
`data[attributes][owner_id]` | **Uuid** <br>ID of its owner
`data[attributes][owner_type]` | **String** <br>The resource type of the owner. One of `companies`, `customers`, `locations`, `orders`, `product_groups`, `stock_items`, `users`


### Includes

This request accepts the following includes:

`owner`






## Deleting a property



> How to delete a property:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/properties/1cf842ae-9510-4927-aa03-2e77fc55b6b5' \
    --header 'content-type: application/json' \
    --data '{}'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "1cf842ae-9510-4927-aa03-2e77fc55b6b5",
    "type": "properties",
    "attributes": {
      "created_at": "2024-09-23T09:23:36.772147+00:00",
      "updated_at": "2024-09-23T09:23:36.772147+00:00",
      "name": "Phone",
      "identifier": "property_5",
      "position": 0,
      "property_type": "phone",
      "show_on": [],
      "validation_required": false,
      "meets_validation_requirements": null,
      "value": "+316000000",
      "default_property_id": null,
      "owner_id": "4d2a6b2b-47a9-475a-ba00-447c57e4cedd",
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
`include` | **String** <br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[properties]=created_at,updated_at,name`


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
    --url 'https://example.booqable.com/api/boomerang/customers' \
    --header 'content-type: application/json' \
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
    "id": "2b632797-93a6-42cc-be6d-aab796c935c6",
    "type": "customers",
    "attributes": {
      "created_at": "2024-09-23T09:23:36.174052+00:00",
      "updated_at": "2024-09-23T09:23:36.177947+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/customers' \
    --header 'content-type: application/json' \
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
    "id": "4cfee548-497a-4e7a-b8dd-a40fcc675a07",
    "type": "customers",
    "attributes": {
      "created_at": "2024-09-23T09:23:35.527368+00:00",
      "updated_at": "2024-09-23T09:23:35.530926+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/customers/6efe1e5c-df39-49aa-a711-4a65241bbd94' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "customers",
        "id": "6efe1e5c-df39-49aa-a711-4a65241bbd94",
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
    "id": "6efe1e5c-df39-49aa-a711-4a65241bbd94",
    "type": "customers",
    "attributes": {
      "created_at": "2024-09-23T09:23:34.760792+00:00",
      "updated_at": "2024-09-23T09:23:34.837461+00:00",
      "archived": false,
      "archived_at": null,
      "number": 2,
      "name": "John Doe",
      "email": "john-37@doe.test",
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