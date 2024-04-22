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
`POST /api/boomerang/properties`

`PUT /api/boomerang/properties/{id}`

`DELETE /api/boomerang/properties/{id}`

`GET /api/boomerang/properties`

`GET /api/boomerang/properties/{id}`

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
`value` | **String** <br>For type `text_field`, `text_area`, `phone`, `email`, `date_field`, `select`
`default_property_id` | **Uuid** <br>The associated Default property
`owner_id` | **Uuid** <br>ID of its owner
`owner_type` | **String** <br>The resource type of the owner. One of `companies`, `customers`, `locations`, `orders`, `product_groups`, `stock_items`, `users`


## Relationships
Properties have the following relationships:

Name | Description
-- | --
`default_property` | **Default properties** `readonly`<br>Associated Default property
`owner` | **Customer, Order, Product group, Stock item**<br>Associated Owner


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
          "owner_id": "9baca5f7-80eb-4065-b94a-6491c05d7b6e",
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
    "id": "d208143a-dbc1-43b6-b756-b97b8896d751",
    "type": "properties",
    "attributes": {
      "created_at": "2024-04-22T09:25:02+00:00",
      "updated_at": "2024-04-22T09:25:02+00:00",
      "name": "Phone",
      "identifier": "phone",
      "position": 0,
      "property_type": "phone",
      "show_on": [],
      "validation_required": false,
      "meets_validation_requirements": true,
      "value": "+316000000",
      "default_property_id": null,
      "owner_id": "9baca5f7-80eb-4065-b94a-6491c05d7b6e",
      "owner_type": "customers"
    },
    "relationships": {
      "default_property": {
        "meta": {
          "included": false
        }
      },
      "owner": {
        "data": {
          "type": "customers",
          "id": "9baca5f7-80eb-4065-b94a-6491c05d7b6e"
        }
      }
    }
  },
  "included": [
    {
      "id": "9baca5f7-80eb-4065-b94a-6491c05d7b6e",
      "type": "customers",
      "attributes": {
        "created_at": "2024-04-22T09:25:02+00:00",
        "updated_at": "2024-04-22T09:25:02+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "Jane Doe",
        "email": "john-53@doe.test",
        "deposit_type": "default",
        "deposit_value": 0.0,
        "discount_percentage": 0.0,
        "legal_type": "person",
        "properties": {
          "phone": "+316000000"
        },
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
    --url 'https://example.booqable.com/api/boomerang/properties/7d3883b0-32e4-455d-80a4-053fa203eee9' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "7d3883b0-32e4-455d-80a4-053fa203eee9",
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
    "id": "7d3883b0-32e4-455d-80a4-053fa203eee9",
    "type": "properties",
    "attributes": {
      "created_at": "2024-04-22T09:25:03+00:00",
      "updated_at": "2024-04-22T09:25:03+00:00",
      "name": "Phone",
      "identifier": "property_2",
      "position": 0,
      "property_type": "phone",
      "show_on": [],
      "validation_required": false,
      "meets_validation_requirements": true,
      "value": "+316000001",
      "default_property_id": null,
      "owner_id": "2597b118-ef64-4482-bdf6-356331b67017",
      "owner_type": "customers"
    },
    "relationships": {
      "default_property": {
        "meta": {
          "included": false
        }
      },
      "owner": {
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
`data[attributes][value]` | **String** <br>For type `text_field`, `text_area`, `phone`, `email`, `date_field`, `select`
`data[attributes][default_property_id]` | **Uuid** <br>The associated Default property
`data[attributes][owner_id]` | **Uuid** <br>ID of its owner
`data[attributes][owner_type]` | **String** <br>The resource type of the owner. One of `companies`, `customers`, `locations`, `orders`, `product_groups`, `stock_items`, `users`


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
    "id": "1e78cfb6-26dc-426d-8ff0-83bdceb4fcd9",
    "type": "customers",
    "attributes": {
      "created_at": "2024-04-22T09:25:04+00:00",
      "updated_at": "2024-04-22T09:25:04+00:00",
      "archived": false,
      "archived_at": null,
      "number": 2,
      "name": "John Doe",
      "email": null,
      "deposit_type": "default",
      "deposit_value": 0.0,
      "discount_percentage": 0.0,
      "legal_type": "person",
      "properties": {
        "phone": "+316000000"
      },
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
    "id": "ae4d6e15-ae3b-42d8-9448-29cd242fff1c",
    "type": "customers",
    "attributes": {
      "created_at": "2024-04-22T09:25:05+00:00",
      "updated_at": "2024-04-22T09:25:05+00:00",
      "archived": false,
      "archived_at": null,
      "number": 2,
      "name": "John Doe",
      "email": null,
      "deposit_type": "default",
      "deposit_value": 0.0,
      "discount_percentage": 0.0,
      "legal_type": "person",
      "properties": {
        "phone": "+316000000"
      },
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


> Deleting a property while updating another one:

```shell
  curl --request  \
    --url 'https://example.booqable.com/api/boomerang/customers/35c71606-d1ca-45a8-8373-f9d825fc7efe' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "customers",
        "id": "35c71606-d1ca-45a8-8373-f9d825fc7efe",
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
    "id": "35c71606-d1ca-45a8-8373-f9d825fc7efe",
    "type": "customers",
    "attributes": {
      "created_at": "2024-04-22T09:25:06+00:00",
      "updated_at": "2024-04-22T09:25:06+00:00",
      "archived": false,
      "archived_at": null,
      "number": 2,
      "name": "John Doe",
      "email": "john-58@doe.test",
      "deposit_type": "default",
      "deposit_value": 0.0,
      "discount_percentage": 0.0,
      "legal_type": "person",
      "properties": {
        "birthday": "01-01-1970"
      },
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

### Includes

All includes are allowed on this request
## Deleting a property



> How to delete a property:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/properties/4f45b86a-6923-41c1-be0e-d364c6a5029a' \
    --header 'content-type: application/json' \
    --data '{}'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "4f45b86a-6923-41c1-be0e-d364c6a5029a",
    "type": "properties",
    "attributes": {
      "created_at": "2024-04-22T09:25:07+00:00",
      "updated_at": "2024-04-22T09:25:07+00:00",
      "name": "Phone",
      "identifier": "property_6",
      "position": 0,
      "property_type": "phone",
      "show_on": [],
      "validation_required": false,
      "meets_validation_requirements": null,
      "value": "+316000000",
      "default_property_id": null,
      "owner_id": "42f0c46e-1cbf-4ecf-88e5-4f3fe050e00d",
      "owner_type": "customers"
    },
    "relationships": {
      "default_property": {
        "meta": {
          "included": false
        }
      },
      "owner": {
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
      "id": "2ffd6b6d-7aa4-4159-baba-5c36fc4e6e71",
      "type": "properties",
      "attributes": {
        "created_at": "2024-04-22T09:25:09+00:00",
        "updated_at": "2024-04-22T09:25:09+00:00",
        "name": "Phone",
        "identifier": "property_7",
        "position": 0,
        "property_type": "phone",
        "show_on": [],
        "validation_required": false,
        "meets_validation_requirements": true,
        "value": "+316000000",
        "default_property_id": null,
        "owner_id": "a8537d57-d512-49cf-a329-4b8322ab9f48",
        "owner_type": "customers"
      },
      "relationships": {
        "default_property": {
          "links": {
            "related": null
          }
        },
        "owner": {
          "links": {
            "related": "api/boomerang/customers/a8537d57-d512-49cf-a329-4b8322ab9f48"
          },
          "data": {
            "type": "customers",
            "id": "a8537d57-d512-49cf-a329-4b8322ab9f48"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "a8537d57-d512-49cf-a329-4b8322ab9f48",
      "type": "customers",
      "attributes": {
        "created_at": "2024-04-22T09:25:09+00:00",
        "updated_at": "2024-04-22T09:25:09+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "John Doe",
        "email": "john-60@doe.test",
        "deposit_type": "default",
        "deposit_value": 0.0,
        "discount_percentage": 0.0,
        "legal_type": "person",
        "properties": {
          "property_7": "+316000000"
        },
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
            "related": "api/boomerang/properties?filter[owner_id]=a8537d57-d512-49cf-a329-4b8322ab9f48&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=a8537d57-d512-49cf-a329-4b8322ab9f48&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=a8537d57-d512-49cf-a329-4b8322ab9f48&filter[owner_type]=customers"
          }
        }
      }
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
    --url 'https://example.booqable.com/api/boomerang/properties/dc32b596-aebe-4afe-bb9d-b650e7d837b7?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "dc32b596-aebe-4afe-bb9d-b650e7d837b7",
    "type": "properties",
    "attributes": {
      "created_at": "2024-04-22T09:25:12+00:00",
      "updated_at": "2024-04-22T09:25:12+00:00",
      "name": "Phone",
      "identifier": "property_8",
      "position": 0,
      "property_type": "phone",
      "show_on": [],
      "validation_required": false,
      "meets_validation_requirements": true,
      "value": "+316000000",
      "default_property_id": null,
      "owner_id": "e03f5534-c4fb-4f50-a1f0-0c5511b501ba",
      "owner_type": "customers"
    },
    "relationships": {
      "default_property": {
        "links": {
          "related": null
        }
      },
      "owner": {
        "links": {
          "related": "api/boomerang/customers/e03f5534-c4fb-4f50-a1f0-0c5511b501ba"
        },
        "data": {
          "type": "customers",
          "id": "e03f5534-c4fb-4f50-a1f0-0c5511b501ba"
        }
      }
    }
  },
  "included": [
    {
      "id": "e03f5534-c4fb-4f50-a1f0-0c5511b501ba",
      "type": "customers",
      "attributes": {
        "created_at": "2024-04-22T09:25:12+00:00",
        "updated_at": "2024-04-22T09:25:12+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "John Doe",
        "email": "john-61@doe.test",
        "deposit_type": "default",
        "deposit_value": 0.0,
        "discount_percentage": 0.0,
        "legal_type": "person",
        "properties": {
          "property_8": "+316000000"
        },
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
            "related": "api/boomerang/properties?filter[owner_id]=e03f5534-c4fb-4f50-a1f0-0c5511b501ba&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=e03f5534-c4fb-4f50-a1f0-0c5511b501ba&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=e03f5534-c4fb-4f50-a1f0-0c5511b501ba&filter[owner_type]=customers"
          }
        }
      }
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





