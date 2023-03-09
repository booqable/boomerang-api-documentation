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
- | -
`id` | **Uuid** `readonly`<br>Primary key
`created_at` | **Datetime** `readonly`<br>When the resource was created
`updated_at` | **Datetime** `readonly`<br>When the resource was last updated
`name` | **String** <br>Name of the property (used as label and to compute identifier if left blank)
`identifier` | **String** <br>Key that will be used in exports, responses and custom field variables in templates
`position` | **Integer** <br>Which position the property has
`property_type` | **String** <br>One of `text_field`, `text_area`, `phone`, `email`, `date_field`, `select`, `address`
`show_on` | **Array** <br>Array of items to show this custom field on. Any of `packing`, `invoice`, `contract`, `quote`
`first_name` | **String** <br>For type `address`
`last_name` | **String** <br>For type `address`
`address1` | **String** <br>For type `address`
`address2` | **String** <br>For type `address`
`city` | **String** <br>For type `address`
`region` | **String** <br>For type `address`
`zipcode` | **String** <br>For type `address`
`country` | **String** <br>For type `address`
`value` | **String** <br>For type `text_field`, `text_area`, `phone`, `email`, `date_field`, `select`
`default_property_id` | **Uuid** <br>The associated Default property
`owner_id` | **Uuid** <br>ID of its owner
`owner_type` | **String** <br>The resource type of the owner. One of `orders`, `product_groups`, `customers`, `users`, `stock_items`


## Relationships
Properties have the following relationships:

Name | Description
- | -
`default_property` | **Default properties** `readonly`<br>Associated Default property
`owner` | **Customer, Order, Product group, Stock item**<br>Associated Owner


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
      "id": "d87251ed-33ab-4d80-af7f-9edb55307b4f",
      "type": "properties",
      "attributes": {
        "created_at": "2023-03-09T13:52:04+00:00",
        "updated_at": "2023-03-09T13:52:04+00:00",
        "name": "Phone",
        "identifier": "phone",
        "position": 0,
        "property_type": "phone",
        "show_on": [],
        "value": "+316000000",
        "default_property_id": null,
        "owner_id": "d92b5daa-1272-41e0-a4e2-2e973c688680",
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
            "related": "api/boomerang/customers/d92b5daa-1272-41e0-a4e2-2e973c688680"
          },
          "data": {
            "type": "customers",
            "id": "d92b5daa-1272-41e0-a4e2-2e973c688680"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "d92b5daa-1272-41e0-a4e2-2e973c688680",
      "type": "customers",
      "attributes": {
        "created_at": "2023-03-09T13:52:04+00:00",
        "updated_at": "2023-03-09T13:52:04+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "John Doe",
        "email": "john-68@doe.test",
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
            "related": "api/boomerang/properties?filter[owner_id]=d92b5daa-1272-41e0-a4e2-2e973c688680&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=d92b5daa-1272-41e0-a4e2-2e973c688680&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=d92b5daa-1272-41e0-a4e2-2e973c688680&filter[owner_type]=customers"
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
- | -
`include` | **String** <br>List of comma seperated relationships `?include=default_property,owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[properties]=id,created_at,updated_at`
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-03-09T13:48:17Z`
`sort` | **String** <br>How to sort the data `?sort=-created_at`
`meta` | **Hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String** <br>The page to request
`page[size]` | **String** <br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
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
- | -
`total` | **Array** <br>`count`


### Includes

This request accepts the following includes:

`owner`






## Fetching a property



> How to fetch a properties:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/properties/2854fa4c-19ba-4cdc-8623-1ee420e4a168?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "2854fa4c-19ba-4cdc-8623-1ee420e4a168",
    "type": "properties",
    "attributes": {
      "created_at": "2023-03-09T13:52:05+00:00",
      "updated_at": "2023-03-09T13:52:05+00:00",
      "name": "Phone",
      "identifier": "phone",
      "position": 0,
      "property_type": "phone",
      "show_on": [],
      "value": "+316000000",
      "default_property_id": null,
      "owner_id": "7bfeeab2-f536-4c32-a635-9a26ea2eac90",
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
          "related": "api/boomerang/customers/7bfeeab2-f536-4c32-a635-9a26ea2eac90"
        },
        "data": {
          "type": "customers",
          "id": "7bfeeab2-f536-4c32-a635-9a26ea2eac90"
        }
      }
    }
  },
  "included": [
    {
      "id": "7bfeeab2-f536-4c32-a635-9a26ea2eac90",
      "type": "customers",
      "attributes": {
        "created_at": "2023-03-09T13:52:05+00:00",
        "updated_at": "2023-03-09T13:52:05+00:00",
        "archived": false,
        "archived_at": null,
        "number": 1,
        "name": "John Doe",
        "email": "john-69@doe.test",
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
            "related": "api/boomerang/properties?filter[owner_id]=7bfeeab2-f536-4c32-a635-9a26ea2eac90&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=7bfeeab2-f536-4c32-a635-9a26ea2eac90&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=7bfeeab2-f536-4c32-a635-9a26ea2eac90&filter[owner_type]=customers"
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
- | -
`include` | **String** <br>List of comma seperated relationships `?include=default_property,owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[properties]=id,created_at,updated_at`


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
          "owner_id": "be8bfc1c-c922-42c0-873b-01fea900cc51",
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
    "id": "5df5a0d3-7c9c-4fb8-a8cc-562b60e28656",
    "type": "properties",
    "attributes": {
      "created_at": "2023-03-09T13:52:05+00:00",
      "updated_at": "2023-03-09T13:52:05+00:00",
      "name": "Phone",
      "identifier": "phone",
      "position": 0,
      "property_type": "phone",
      "show_on": [],
      "value": "+316000000",
      "default_property_id": null,
      "owner_id": "be8bfc1c-c922-42c0-873b-01fea900cc51",
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
          "id": "be8bfc1c-c922-42c0-873b-01fea900cc51"
        }
      }
    }
  },
  "included": [
    {
      "id": "be8bfc1c-c922-42c0-873b-01fea900cc51",
      "type": "customers",
      "attributes": {
        "created_at": "2023-03-09T13:52:05+00:00",
        "updated_at": "2023-03-09T13:52:05+00:00",
        "archived": false,
        "archived_at": null,
        "number": 2,
        "name": "Jane Doe",
        "email": "john-71@doe.test",
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
- | -
`include` | **String** <br>List of comma seperated relationships `?include=default_property,owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[properties]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][name]` | **String** <br>Name of the property (used as label and to compute identifier if left blank)
`data[attributes][identifier]` | **String** <br>Key that will be used in exports, responses and custom field variables in templates
`data[attributes][position]` | **Integer** <br>Which position the property has
`data[attributes][property_type]` | **String** <br>One of `text_field`, `text_area`, `phone`, `email`, `date_field`, `select`, `address`
`data[attributes][show_on][]` | **Array** <br>Array of items to show this custom field on. Any of `packing`, `invoice`, `contract`, `quote`
`data[attributes][first_name]` | **String** <br>For type `address`
`data[attributes][last_name]` | **String** <br>For type `address`
`data[attributes][address1]` | **String** <br>For type `address`
`data[attributes][address2]` | **String** <br>For type `address`
`data[attributes][city]` | **String** <br>For type `address`
`data[attributes][region]` | **String** <br>For type `address`
`data[attributes][zipcode]` | **String** <br>For type `address`
`data[attributes][country]` | **String** <br>For type `address`
`data[attributes][value]` | **String** <br>For type `text_field`, `text_area`, `phone`, `email`, `date_field`, `select`
`data[attributes][default_property_id]` | **Uuid** <br>The associated Default property
`data[attributes][owner_id]` | **Uuid** <br>ID of its owner
`data[attributes][owner_type]` | **String** <br>The resource type of the owner. One of `orders`, `product_groups`, `customers`, `users`, `stock_items`


### Includes

This request accepts the following includes:

`owner`






## Updating a property



> How to update a property:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/properties/3cee6d85-8bb0-4773-94b1-352b07b2c992' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "3cee6d85-8bb0-4773-94b1-352b07b2c992",
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
    "id": "3cee6d85-8bb0-4773-94b1-352b07b2c992",
    "type": "properties",
    "attributes": {
      "created_at": "2023-03-09T13:52:06+00:00",
      "updated_at": "2023-03-09T13:52:06+00:00",
      "name": "Phone",
      "identifier": "phone",
      "position": 0,
      "property_type": "phone",
      "show_on": [],
      "value": "+316000001",
      "default_property_id": null,
      "owner_id": "4b4dd67e-03db-4f8f-9ff2-5890a1f21a0b",
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
- | -
`include` | **String** <br>List of comma seperated relationships `?include=default_property,owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[properties]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][name]` | **String** <br>Name of the property (used as label and to compute identifier if left blank)
`data[attributes][identifier]` | **String** <br>Key that will be used in exports, responses and custom field variables in templates
`data[attributes][position]` | **Integer** <br>Which position the property has
`data[attributes][property_type]` | **String** <br>One of `text_field`, `text_area`, `phone`, `email`, `date_field`, `select`, `address`
`data[attributes][show_on][]` | **Array** <br>Array of items to show this custom field on. Any of `packing`, `invoice`, `contract`, `quote`
`data[attributes][first_name]` | **String** <br>For type `address`
`data[attributes][last_name]` | **String** <br>For type `address`
`data[attributes][address1]` | **String** <br>For type `address`
`data[attributes][address2]` | **String** <br>For type `address`
`data[attributes][city]` | **String** <br>For type `address`
`data[attributes][region]` | **String** <br>For type `address`
`data[attributes][zipcode]` | **String** <br>For type `address`
`data[attributes][country]` | **String** <br>For type `address`
`data[attributes][value]` | **String** <br>For type `text_field`, `text_area`, `phone`, `email`, `date_field`, `select`
`data[attributes][default_property_id]` | **Uuid** <br>The associated Default property
`data[attributes][owner_id]` | **Uuid** <br>ID of its owner
`data[attributes][owner_type]` | **String** <br>The resource type of the owner. One of `orders`, `product_groups`, `customers`, `users`, `stock_items`


### Includes

This request accepts the following includes:

`owner`






## Deleting a property



> How to delete a property:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/properties/50ae0e2b-b753-4122-889a-9fcac5919f9c' \
    --header 'content-type: application/json' \
    --data '{}'
```

> A 200 status response looks like this:

```json
  {
  "meta": {}
}
```

### HTTP Request

`DELETE /api/boomerang/properties/{id}`

### Request params

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=default_property,owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[properties]=id,created_at,updated_at`


### Includes

This request does not accept any includes
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
    "id": "689aa9da-4e78-469b-b0ae-92c4b1b9fe17",
    "type": "customers",
    "attributes": {
      "created_at": "2023-03-09T13:52:07+00:00",
      "updated_at": "2023-03-09T13:52:07+00:00",
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
    "id": "df3aaa6b-094d-4186-865d-8e56ac847519",
    "type": "customers",
    "attributes": {
      "created_at": "2023-03-09T13:52:07+00:00",
      "updated_at": "2023-03-09T13:52:07+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/customers/3c49edb3-df2f-425d-9c48-cd886d12963a' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "customers",
        "id": "3c49edb3-df2f-425d-9c48-cd886d12963a",
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
    "id": "3c49edb3-df2f-425d-9c48-cd886d12963a",
    "type": "customers",
    "attributes": {
      "created_at": "2023-03-09T13:52:07+00:00",
      "updated_at": "2023-03-09T13:52:07+00:00",
      "archived": false,
      "archived_at": null,
      "number": 2,
      "name": "John Doe",
      "email": "john-77@doe.test",
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