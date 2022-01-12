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
`default_property_id` | **Uuid**<br>The associated Default property
`owner_id` | **Uuid**<br>ID of its owner
`owner_type` | **String**<br>The resource type of the owner. One of `orders`, `product_groups`, `customers`, `users`, `stock_items`


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
      "id": "6824429d-1112-4228-affc-e40043a59311",
      "type": "properties",
      "attributes": {
        "created_at": "2022-01-12T10:56:53+00:00",
        "updated_at": "2022-01-12T10:56:53+00:00",
        "name": "Phone",
        "identifier": "phone",
        "position": null,
        "property_type": "phone",
        "show_on": [],
        "value": "+316000000",
        "default_property_id": null,
        "owner_id": "b9e70b61-8c35-4041-85e6-057ef91ea4b5",
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
            "related": "api/boomerang/customers/b9e70b61-8c35-4041-85e6-057ef91ea4b5"
          },
          "data": {
            "type": "customers",
            "id": "b9e70b61-8c35-4041-85e6-057ef91ea4b5"
          }
        }
      }
    }
  ],
  "included": [
    {
      "id": "b9e70b61-8c35-4041-85e6-057ef91ea4b5",
      "type": "customers",
      "attributes": {
        "created_at": "2022-01-12T10:56:53+00:00",
        "updated_at": "2022-01-12T10:56:53+00:00",
        "number": 1,
        "name": "Abbott Inc",
        "email": "abbott.inc@nienow.org",
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
            "related": "api/boomerang/properties?filter[owner_id]=b9e70b61-8c35-4041-85e6-057ef91ea4b5&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=b9e70b61-8c35-4041-85e6-057ef91ea4b5&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=b9e70b61-8c35-4041-85e6-057ef91ea4b5&filter[owner_type]=customers"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-01-12T10:54:49Z`
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
`default_property_id` | **Uuid**<br>`eq`, `not_eq`
`owner_id` | **Uuid**<br>`eq`, `not_eq`
`owner_type` | **String**<br>`eq`, `not_eq`


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
    --url 'https://example.booqable.com/api/boomerang/properties/e9b1b24f-e209-4761-88fd-07470f60f9a9?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "e9b1b24f-e209-4761-88fd-07470f60f9a9",
    "type": "properties",
    "attributes": {
      "created_at": "2022-01-12T10:56:53+00:00",
      "updated_at": "2022-01-12T10:56:53+00:00",
      "name": "Phone",
      "identifier": "phone",
      "position": null,
      "property_type": "phone",
      "show_on": [],
      "value": "+316000000",
      "default_property_id": null,
      "owner_id": "046938e5-290b-4e87-91c0-97da423b1336",
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
          "related": "api/boomerang/customers/046938e5-290b-4e87-91c0-97da423b1336"
        },
        "data": {
          "type": "customers",
          "id": "046938e5-290b-4e87-91c0-97da423b1336"
        }
      }
    }
  },
  "included": [
    {
      "id": "046938e5-290b-4e87-91c0-97da423b1336",
      "type": "customers",
      "attributes": {
        "created_at": "2022-01-12T10:56:53+00:00",
        "updated_at": "2022-01-12T10:56:53+00:00",
        "number": 1,
        "name": "Koelpin, Williamson and Jones",
        "email": "and_williamson_jones_koelpin@tromp.biz",
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
            "related": "api/boomerang/properties?filter[owner_id]=046938e5-290b-4e87-91c0-97da423b1336&filter[owner_type]=customers"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=046938e5-290b-4e87-91c0-97da423b1336&filter[owner_type]=customers"
          }
        },
        "notes": {
          "links": {
            "related": "api/boomerang/notes?filter[owner_id]=046938e5-290b-4e87-91c0-97da423b1336&filter[owner_type]=customers"
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
          "owner_id": "d53f8ae5-e88f-4fb0-9336-4e5535e28525",
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
    "id": "3130d6a6-717c-4537-990f-6a4a03db54b5",
    "type": "properties",
    "attributes": {
      "created_at": "2022-01-12T10:56:53+00:00",
      "updated_at": "2022-01-12T10:56:53+00:00",
      "name": "Phone",
      "identifier": "phone",
      "position": null,
      "property_type": "phone",
      "show_on": [],
      "value": "+316000000",
      "default_property_id": null,
      "owner_id": "d53f8ae5-e88f-4fb0-9336-4e5535e28525",
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
          "id": "d53f8ae5-e88f-4fb0-9336-4e5535e28525"
        }
      }
    }
  },
  "included": [
    {
      "id": "d53f8ae5-e88f-4fb0-9336-4e5535e28525",
      "type": "customers",
      "attributes": {
        "created_at": "2022-01-12T10:56:53+00:00",
        "updated_at": "2022-01-12T10:56:53+00:00",
        "number": 2,
        "name": "Jane Doe",
        "email": "doe_jane@kihn-christiansen.io",
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
    "self": "api/boomerang/properties?data%5Battributes%5D%5Bname%5D=Phone&data%5Battributes%5D%5Bowner_id%5D=d53f8ae5-e88f-4fb0-9336-4e5535e28525&data%5Battributes%5D%5Bowner_type%5D=customers&data%5Battributes%5D%5Bproperty_type%5D=phone&data%5Battributes%5D%5Bvalue%5D=%2B316000000&data%5Btype%5D=properties&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/properties?data%5Battributes%5D%5Bname%5D=Phone&data%5Battributes%5D%5Bowner_id%5D=d53f8ae5-e88f-4fb0-9336-4e5535e28525&data%5Battributes%5D%5Bowner_type%5D=customers&data%5Battributes%5D%5Bproperty_type%5D=phone&data%5Battributes%5D%5Bvalue%5D=%2B316000000&data%5Btype%5D=properties&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/properties?data%5Battributes%5D%5Bname%5D=Phone&data%5Battributes%5D%5Bowner_id%5D=d53f8ae5-e88f-4fb0-9336-4e5535e28525&data%5Battributes%5D%5Bowner_type%5D=customers&data%5Battributes%5D%5Bproperty_type%5D=phone&data%5Battributes%5D%5Bvalue%5D=%2B316000000&data%5Btype%5D=properties&include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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
`data[attributes][default_property_id]` | **Uuid**<br>The associated Default property
`data[attributes][owner_id]` | **Uuid**<br>ID of its owner
`data[attributes][owner_type]` | **String**<br>The resource type of the owner. One of `orders`, `product_groups`, `customers`, `users`, `stock_items`


### Includes

This request accepts the following includes:

`owner`






## Updating a property



> How to update a property:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/properties/14e01b9c-e320-424e-b3a8-93b98ce46113' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "14e01b9c-e320-424e-b3a8-93b98ce46113",
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
    "id": "14e01b9c-e320-424e-b3a8-93b98ce46113",
    "type": "properties",
    "attributes": {
      "created_at": "2022-01-12T10:56:54+00:00",
      "updated_at": "2022-01-12T10:56:54+00:00",
      "name": "Phone",
      "identifier": "phone",
      "position": null,
      "property_type": "phone",
      "show_on": [],
      "value": "+316000001",
      "default_property_id": null,
      "owner_id": "13988d52-47d7-48a5-9467-4f26c9239c10",
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
`data[attributes][default_property_id]` | **Uuid**<br>The associated Default property
`data[attributes][owner_id]` | **Uuid**<br>ID of its owner
`data[attributes][owner_type]` | **String**<br>The resource type of the owner. One of `orders`, `product_groups`, `customers`, `users`, `stock_items`


### Includes

This request accepts the following includes:

`owner`






## Deleting a property



> How to delete a property:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/properties/1b6d419c-b4ea-4ee5-93ca-cd616007946a' \
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
    "id": "31a1079f-9076-4530-b9e4-6a4901fcd443",
    "type": "customers",
    "attributes": {
      "created_at": "2022-01-12T10:56:54+00:00",
      "updated_at": "2022-01-12T10:56:54+00:00",
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
    "id": "28f1b183-74a3-4a17-a29d-f2f33540eee9",
    "type": "customers",
    "attributes": {
      "created_at": "2022-01-12T10:56:55+00:00",
      "updated_at": "2022-01-12T10:56:55+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/customers/63221948-21e3-49da-a9d6-931b50994cf9' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "customers",
        "id": "63221948-21e3-49da-a9d6-931b50994cf9",
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
    "id": "63221948-21e3-49da-a9d6-931b50994cf9",
    "type": "customers",
    "attributes": {
      "created_at": "2022-01-12T10:56:55+00:00",
      "updated_at": "2022-01-12T10:56:55+00:00",
      "number": 2,
      "name": "John Doe",
      "email": "nicolas.kuvalis@vonrueden-koch.org",
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