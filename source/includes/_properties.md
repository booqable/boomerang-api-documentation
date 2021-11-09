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
`name` | **String**<br>Name of the property (used as label and to compute identifier if left blank)
`identifier` | **String**<br>Key that will be used in exports, responses and custom field variables in templates
`position` | **Integer**<br>Which position the property has
`property_type` | **String**<br>One of `text_field`, `text_area`, `phone`, `email`, `date_field`, `select`, `address`
`show_on` | **Array**<br>Array of items to show this custom field on. Any of `packing`, `invoice`, `contract`, `quote`
`first_name` | **String**<br>For type `address`
`last_name` | **String**<br>For type `address`
`address1` | **String**<br>For type `address`
`address2` | **String**<br>For type `address`
`city` | **String**<br>For type `address`
`region` | **String**<br>For type `address`
`zipcode` | **String**<br>For type `address`
`country` | **String**<br>For type `address`
`value` | **String**<br>For type `text_field`, `text_area`, `phone`, `email`, `date_field`, `select`
`owner_id` | **Uuid**<br>ID of its owner
`owner_type` | **String**<br>The resource type of the owner. One of `Order`, `ProductGroup`, `Customer`, `User`, `StockItem`
`default_property_id` | **Uuid**<br>The associated Default property


## Relationships
Properties have the following relationships:

Name | Description
- | -
`default_property` | **Default properties** `readonly`<br>Associated Default property
`owner` | **Customer, Product group**<br>Associated Owner


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
      "id": "51f8ab5c-2f03-490c-9ab6-4182c27c3114",
      "type": "properties",
      "attributes": {
        "created_at": "2021-11-09T11:44:52+00:00",
        "updated_at": "2021-11-09T11:44:52+00:00",
        "name": "Phone",
        "identifier": "phone",
        "position": null,
        "property_type": "phone",
        "show_on": [],
        "value": "+316000000",
        "owner_id": "453ba076-bb2a-413f-a569-3a46fb6fe318",
        "owner_type": "Customer",
        "default_property_id": null
      },
      "relationships": {
        "default_property": {
          "links": {
            "related": null
          }
        },
        "owner": {
          "links": {
            "related": "api/boomerang/customers/453ba076-bb2a-413f-a569-3a46fb6fe318"
          },
          "data": {
            "type": "customers",
            "id": "453ba076-bb2a-413f-a569-3a46fb6fe318"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "453ba076-bb2a-413f-a569-3a46fb6fe318",
      "type": "customers",
      "attributes": {
        "created_at": "2021-11-09T11:44:52+00:00",
        "updated_at": "2021-11-09T11:44:52+00:00",
        "number": 1,
        "name": "Jacobson-Bins",
        "email": "jacobson.bins@jones.net",
        "archived": false,
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
            "related": "api/boomerang/properties?filter[owner_id]=453ba076-bb2a-413f-a569-3a46fb6fe318&filter[owner_type]=Customer"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=453ba076-bb2a-413f-a569-3a46fb6fe318"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[notable_id]=453ba076-bb2a-413f-a569-3a46fb6fe318&filter[notable_type]=Customer"
          }
        }
      }
    }
  ],
  "links": {
    "self": "api/boomerang/properties?include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/properties?include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/properties?include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25"
  },
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/properties`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=default_property,owner`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[properties]=id,created_at,updated_at`
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-11-09T11:43:40Z`
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
`name` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`identifier` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`owner_id` | **Uuid**<br>`eq`, `not_eq`
`owner_type` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`default_property_id` | **Uuid**<br>`eq`, `not_eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array**<br>`count`


### Includes

This request accepts the following includes:

`owner`






## Fetching a property



> How to fetch a properties:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/properties/2232ba79-e0ed-487e-92b0-ba5f3f1e0730?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "2232ba79-e0ed-487e-92b0-ba5f3f1e0730",
    "type": "properties",
    "attributes": {
      "created_at": "2021-11-09T11:44:53+00:00",
      "updated_at": "2021-11-09T11:44:53+00:00",
      "name": "Phone",
      "identifier": "phone",
      "position": null,
      "property_type": "phone",
      "show_on": [],
      "value": "+316000000",
      "owner_id": "da6e8806-b405-4caf-8608-a98ef2b9d70f",
      "owner_type": "Customer",
      "default_property_id": null
    },
    "relationships": {
      "default_property": {
        "links": {
          "related": null
        }
      },
      "owner": {
        "links": {
          "related": "api/boomerang/customers/da6e8806-b405-4caf-8608-a98ef2b9d70f"
        },
        "data": {
          "type": "customers",
          "id": "da6e8806-b405-4caf-8608-a98ef2b9d70f"
        }
      }
    }
  },
  "included": [
    {
      "id": "da6e8806-b405-4caf-8608-a98ef2b9d70f",
      "type": "customers",
      "attributes": {
        "created_at": "2021-11-09T11:44:53+00:00",
        "updated_at": "2021-11-09T11:44:53+00:00",
        "number": 1,
        "name": "Sauer-Satterfield",
        "email": "satterfield_sauer@lindgren.name",
        "archived": false,
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
            "related": "api/boomerang/properties?filter[owner_id]=da6e8806-b405-4caf-8608-a98ef2b9d70f&filter[owner_type]=Customer"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=da6e8806-b405-4caf-8608-a98ef2b9d70f"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[notable_id]=da6e8806-b405-4caf-8608-a98ef2b9d70f&filter[notable_type]=Customer"
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=default_property,owner`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[properties]=id,created_at,updated_at`


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
          "owner_id": "9622c9a5-2738-4c5e-86d8-b8fcf664caaa",
          "owner_type": "Customer"
        }
      },
      "include": "owner"
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "57a3497a-d021-4a92-9d78-6d7016937ba9",
    "type": "properties",
    "attributes": {
      "created_at": "2021-11-09T11:44:53+00:00",
      "updated_at": "2021-11-09T11:44:53+00:00",
      "name": "Phone",
      "identifier": "phone",
      "position": null,
      "property_type": "phone",
      "show_on": [],
      "value": "+316000000",
      "owner_id": "9622c9a5-2738-4c5e-86d8-b8fcf664caaa",
      "owner_type": "Customer",
      "default_property_id": null
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
          "id": "9622c9a5-2738-4c5e-86d8-b8fcf664caaa"
        }
      }
    }
  },
  "included": [
    {
      "id": "9622c9a5-2738-4c5e-86d8-b8fcf664caaa",
      "type": "customers",
      "attributes": {
        "created_at": "2021-11-09T11:44:53+00:00",
        "updated_at": "2021-11-09T11:44:53+00:00",
        "number": 2,
        "name": "Jane Doe",
        "email": "doe.jane@huel-dickinson.name",
        "archived": false,
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
  "links": {
    "self": "api/boomerang/properties?data%5Battributes%5D%5Bname%5D=Phone&data%5Battributes%5D%5Bowner_id%5D=9622c9a5-2738-4c5e-86d8-b8fcf664caaa&data%5Battributes%5D%5Bowner_type%5D=Customer&data%5Battributes%5D%5Bproperty_type%5D=phone&data%5Battributes%5D%5Bvalue%5D=%2B316000000&data%5Btype%5D=properties&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/properties?data%5Battributes%5D%5Bname%5D=Phone&data%5Battributes%5D%5Bowner_id%5D=9622c9a5-2738-4c5e-86d8-b8fcf664caaa&data%5Battributes%5D%5Bowner_type%5D=Customer&data%5Battributes%5D%5Bproperty_type%5D=phone&data%5Battributes%5D%5Bvalue%5D=%2B316000000&data%5Btype%5D=properties&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/properties?data%5Battributes%5D%5Bname%5D=Phone&data%5Battributes%5D%5Bowner_id%5D=9622c9a5-2738-4c5e-86d8-b8fcf664caaa&data%5Battributes%5D%5Bowner_type%5D=Customer&data%5Battributes%5D%5Bproperty_type%5D=phone&data%5Battributes%5D%5Bvalue%5D=%2B316000000&data%5Btype%5D=properties&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25"
  },
  "meta": {}
}
```

### HTTP Request

`POST /api/boomerang/properties`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=default_property,owner`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[properties]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][name]` | **String**<br>Name of the property (used as label and to compute identifier if left blank)
`data[attributes][identifier]` | **String**<br>Key that will be used in exports, responses and custom field variables in templates
`data[attributes][position]` | **Integer**<br>Which position the property has
`data[attributes][property_type]` | **String**<br>One of `text_field`, `text_area`, `phone`, `email`, `date_field`, `select`, `address`
`data[attributes][show_on][]` | **Array**<br>Array of items to show this custom field on. Any of `packing`, `invoice`, `contract`, `quote`
`data[attributes][first_name]` | **String**<br>For type `address`
`data[attributes][last_name]` | **String**<br>For type `address`
`data[attributes][address1]` | **String**<br>For type `address`
`data[attributes][address2]` | **String**<br>For type `address`
`data[attributes][city]` | **String**<br>For type `address`
`data[attributes][region]` | **String**<br>For type `address`
`data[attributes][zipcode]` | **String**<br>For type `address`
`data[attributes][country]` | **String**<br>For type `address`
`data[attributes][value]` | **String**<br>For type `text_field`, `text_area`, `phone`, `email`, `date_field`, `select`
`data[attributes][owner_id]` | **Uuid**<br>ID of its owner
`data[attributes][owner_type]` | **String**<br>The resource type of the owner. One of `Order`, `ProductGroup`, `Customer`, `User`, `StockItem`
`data[attributes][default_property_id]` | **Uuid**<br>The associated Default property


### Includes

This request accepts the following includes:

`owner`






## Updating a property



> How to update a property:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/properties/28ab9c7e-45db-42a4-a5f5-11ecc5d06853' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "28ab9c7e-45db-42a4-a5f5-11ecc5d06853",
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
    "id": "28ab9c7e-45db-42a4-a5f5-11ecc5d06853",
    "type": "properties",
    "attributes": {
      "created_at": "2021-11-09T11:44:53+00:00",
      "updated_at": "2021-11-09T11:44:53+00:00",
      "name": "Phone",
      "identifier": "phone",
      "position": null,
      "property_type": "phone",
      "show_on": [],
      "value": "+316000001",
      "owner_id": "f04aa857-ec99-4384-8644-ae8e6c4fd14e",
      "owner_type": "Customer",
      "default_property_id": null
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=default_property,owner`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[properties]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][name]` | **String**<br>Name of the property (used as label and to compute identifier if left blank)
`data[attributes][identifier]` | **String**<br>Key that will be used in exports, responses and custom field variables in templates
`data[attributes][position]` | **Integer**<br>Which position the property has
`data[attributes][property_type]` | **String**<br>One of `text_field`, `text_area`, `phone`, `email`, `date_field`, `select`, `address`
`data[attributes][show_on][]` | **Array**<br>Array of items to show this custom field on. Any of `packing`, `invoice`, `contract`, `quote`
`data[attributes][first_name]` | **String**<br>For type `address`
`data[attributes][last_name]` | **String**<br>For type `address`
`data[attributes][address1]` | **String**<br>For type `address`
`data[attributes][address2]` | **String**<br>For type `address`
`data[attributes][city]` | **String**<br>For type `address`
`data[attributes][region]` | **String**<br>For type `address`
`data[attributes][zipcode]` | **String**<br>For type `address`
`data[attributes][country]` | **String**<br>For type `address`
`data[attributes][value]` | **String**<br>For type `text_field`, `text_area`, `phone`, `email`, `date_field`, `select`
`data[attributes][owner_id]` | **Uuid**<br>ID of its owner
`data[attributes][owner_type]` | **String**<br>The resource type of the owner. One of `Order`, `ProductGroup`, `Customer`, `User`, `StockItem`
`data[attributes][default_property_id]` | **Uuid**<br>The associated Default property


### Includes

This request accepts the following includes:

`owner`






## Deleting a property



> How to delete a property:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/properties/f0a224e2-8487-4e23-9f11-6cf0202dc6c0' \
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=default_property,owner`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[properties]=id,created_at,updated_at`


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
    "id": "9878bce4-968d-4045-9ef9-15744b8f69e1",
    "type": "customers",
    "attributes": {
      "created_at": "2021-11-09T11:44:54+00:00",
      "updated_at": "2021-11-09T11:44:54+00:00",
      "number": 2,
      "name": "John Doe",
      "email": null,
      "archived": false,
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
  "links": {
    "self": "api/boomerang/customers?data%5Battributes%5D%5Bname%5D=John+Doe&data%5Battributes%5D%5Bproperties_attributes%5D%5B%5D%5Bidentifier%5D=phone&data%5Battributes%5D%5Bproperties_attributes%5D%5B%5D%5Bvalue%5D=%2B316000000&data%5Btype%5D=customers&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/customers?data%5Battributes%5D%5Bname%5D=John+Doe&data%5Battributes%5D%5Bproperties_attributes%5D%5B%5D%5Bidentifier%5D=phone&data%5Battributes%5D%5Bproperties_attributes%5D%5B%5D%5Bvalue%5D=%2B316000000&data%5Btype%5D=customers&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/customers?data%5Battributes%5D%5Bname%5D=John+Doe&data%5Battributes%5D%5Bproperties_attributes%5D%5B%5D%5Bidentifier%5D=phone&data%5Battributes%5D%5Bproperties_attributes%5D%5B%5D%5Bvalue%5D=%2B316000000&data%5Btype%5D=customers&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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
    "id": "099fd28c-fd89-4a69-b70d-36ca8816edb6",
    "type": "customers",
    "attributes": {
      "created_at": "2021-11-09T11:44:54+00:00",
      "updated_at": "2021-11-09T11:44:54+00:00",
      "number": 2,
      "name": "John Doe",
      "email": null,
      "archived": false,
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
  "links": {
    "self": "api/boomerang/customers?data%5Battributes%5D%5Bname%5D=John+Doe&data%5Battributes%5D%5Bproperties_attributes%5D%5B%5D%5Bname%5D=Phone&data%5Battributes%5D%5Bproperties_attributes%5D%5B%5D%5Bvalue%5D=%2B316000000&data%5Battributes%5D%5Bproperties_attributes%5D%5B%5D%5Bproperty_type%5D=phone&data%5Btype%5D=customers&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/customers?data%5Battributes%5D%5Bname%5D=John+Doe&data%5Battributes%5D%5Bproperties_attributes%5D%5B%5D%5Bname%5D=Phone&data%5Battributes%5D%5Bproperties_attributes%5D%5B%5D%5Bvalue%5D=%2B316000000&data%5Battributes%5D%5Bproperties_attributes%5D%5B%5D%5Bproperty_type%5D=phone&data%5Btype%5D=customers&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/customers?data%5Battributes%5D%5Bname%5D=John+Doe&data%5Battributes%5D%5Bproperties_attributes%5D%5B%5D%5Bname%5D=Phone&data%5Battributes%5D%5Bproperties_attributes%5D%5B%5D%5Bvalue%5D=%2B316000000&data%5Battributes%5D%5Bproperties_attributes%5D%5B%5D%5Bproperty_type%5D=phone&data%5Btype%5D=customers&page%5Bnumber%5D=1&page%5Bsize%5D=25"
  },
  "meta": {}
}
```


> Deleting a property while updating another one:

```shell
  curl --request  \
    --url 'https://example.booqable.com/api/boomerang/customers/94c072ea-74ce-4c57-8d51-2ba5ef4bf5d4' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "customers",
        "id": "94c072ea-74ce-4c57-8d51-2ba5ef4bf5d4",
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
    "id": "94c072ea-74ce-4c57-8d51-2ba5ef4bf5d4",
    "type": "customers",
    "attributes": {
      "created_at": "2021-11-09T11:44:55+00:00",
      "updated_at": "2021-11-09T11:44:55+00:00",
      "number": 2,
      "name": "John Doe",
      "email": "llc_becker@rice.name",
      "archived": false,
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