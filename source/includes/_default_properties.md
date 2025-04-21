# Default properties

Booqable comes with standard fields but you can also add custom properties to capture additional data.

Default properties show up in forms within Booqable and can be connected
to [checkout fields](https://help.booqable.com/en/articles/2170728-can-i-create-custom-checkout-fields).

Default properties are searchable, show up in exports and can be used in email templates.
The actual values of those properties are stored in the [Property](#properties) resource.

Properties inherit their configuration from a default property when they are connected.

When creating properties they are connected with their default when one of the following fields match:
- `name`
- `identifier`
- `default_property_id`

## Fields

 Name | Description
-- | --
`created_at` | **datetime** `readonly`<br>When the resource was created.
`editable` | **boolean** `readonly`<br>Whether this property is editable. 
`id` | **uuid** `readonly`<br>Primary key.
`identifier` | **string** <br>Key that will be used in exports, responses and custom field variables in templates. 
`name` | **string** <br>Name of the property (used as label and to compute identifier if left blank). 
`owner_type` | **string** `readonly-after-create`<br>The type of resource this default property is intended for and derived properties can be added to. 
`position` | **integer** <br>Which position the property has. 
`property_type` | **enum** <br>Determines how the data is rendered and the kind of input shown to the user.<br> One of: `address`, `date_field`, `email`, `phone`, `select`, `text_area`, `text_field`.
`select_options` | **array** <br>For type `select`. The select options as array. 
`show_on` | **array[string]** <br>Array of items to show this custom field on. Zero or more from `contract`, `invoice`, `packing`, `quote`. 
`updated_at` | **datetime** `readonly`<br>When the resource was last updated.
`validation_required` | **boolean** <br>Whether this property has to be validated. 


## List default properties


> How to fetch a list of default properties:

```shell
  curl --get 'https://example.booqable.com/api/4/default_properties'
       --header 'content-type: application/json'
       --data-urlencode 'include=owner'
```

> A 200 status response looks like this:

```json
  {
    "data": [
      {
        "id": "5d959acd-b782-4ee2-858b-d53452746abe",
        "type": "default_properties",
        "attributes": {
          "created_at": "2016-08-06T16:53:03.000000+00:00",
          "updated_at": "2016-08-06T16:53:03.000000+00:00",
          "name": "Phone",
          "identifier": "phone",
          "position": 1,
          "property_type": "phone",
          "show_on": [],
          "validation_required": false,
          "owner_type": "customers",
          "select_options": [],
          "editable": true
        }
      }
    ],
    "meta": {}
  }
```

### HTTP Request

`GET /api/boomerang/default_properties`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[default_properties]=created_at,updated_at,name`
`filter` | **hash** <br>The filters to apply `?filter[attribute][eq]=value`
`meta` | **hash** <br>Metadata to send along. `?meta[total][]=count`
`page[number]` | **string** <br>The page to request.
`page[size]` | **string** <br>The amount of items per page.
`sort` | **string** <br>How to sort the data. `?sort=attribute1,-attribute2`


### Filters

This request can be filtered on:

Name | Description
-- | --
`created_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`editable` | **boolean** <br>`eq`
`id` | **uuid** <br>`eq`, `not_eq`
`identifier` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`name` | **string** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`owner_type` | **string** <br>`eq`, `not_eq`
`updated_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`validation_required` | **boolean** <br>`eq`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **array** <br>`count`


### Includes

This request does not accept any includes
## Fetch a default property


> How to fetch a default property:

```shell
  curl --get 'https://example.booqable.com/api/4/default_properties/e579fd95-e66a-48b3-8954-a1303f0d4543'
       --header 'content-type: application/json'
       --data-urlencode 'include=owner'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "e579fd95-e66a-48b3-8954-a1303f0d4543",
      "type": "default_properties",
      "attributes": {
        "created_at": "2016-06-28T12:50:01.000000+00:00",
        "updated_at": "2016-06-28T12:50:01.000000+00:00",
        "name": "Phone",
        "identifier": "phone",
        "position": 1,
        "property_type": "phone",
        "show_on": [],
        "validation_required": false,
        "owner_type": "customers",
        "select_options": [],
        "editable": true
      }
    },
    "meta": {}
  }
```

### HTTP Request

`GET /api/boomerang/default_properties/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[default_properties]=created_at,updated_at,name`


### Includes

This request does not accept any includes
## Create a default property


> How to create a default property and assign it to an owner:

```shell
  curl --request POST
       --url 'https://example.booqable.com/api/4/default_properties'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "type": "default_properties",
           "attributes": {
             "name": "Mobile phone",
             "property_type": "phone",
             "owner_type": "customers"
           }
         }
       }'
```

> A 201 status response looks like this:

```json
  {
    "data": {
      "id": "0be37be8-1023-49f4-838a-f1f4a10954ef",
      "type": "default_properties",
      "attributes": {
        "created_at": "2019-06-17T18:28:00.000000+00:00",
        "updated_at": "2019-06-17T18:28:00.000000+00:00",
        "name": "Mobile phone",
        "identifier": "mobile_phone",
        "position": 2,
        "property_type": "phone",
        "show_on": [],
        "validation_required": false,
        "owner_type": "customers",
        "select_options": [],
        "editable": true
      }
    },
    "meta": {}
  }
```

### HTTP Request

`POST /api/boomerang/default_properties`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[default_properties]=created_at,updated_at,name`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][identifier]` | **string** <br>Key that will be used in exports, responses and custom field variables in templates. 
`data[attributes][name]` | **string** <br>Name of the property (used as label and to compute identifier if left blank). 
`data[attributes][owner_type]` | **string** <br>The type of resource this default property is intended for and derived properties can be added to. 
`data[attributes][position]` | **integer** <br>Which position the property has. 
`data[attributes][property_type]` | **enum** <br>Determines how the data is rendered and the kind of input shown to the user.<br> One of: `address`, `date_field`, `email`, `phone`, `select`, `text_area`, `text_field`.
`data[attributes][select_options][]` | **array** <br>For type `select`. The select options as array. 
`data[attributes][show_on]` | **array[string]** <br>Array of items to show this custom field on. Zero or more from `contract`, `invoice`, `packing`, `quote`. 
`data[attributes][validation_required]` | **boolean** <br>Whether this property has to be validated. 


### Includes

This request does not accept any includes
## Update a default property


> How to update a default property:

```shell
  curl --request PUT
       --url 'https://example.booqable.com/api/4/default_properties/1d9d3f48-7bac-4b62-8f42-8018003cc95b'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "id": "1d9d3f48-7bac-4b62-8f42-8018003cc95b",
           "type": "default_properties",
           "attributes": {
             "property_type": "text_field"
           }
         }
       }'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "1d9d3f48-7bac-4b62-8f42-8018003cc95b",
      "type": "default_properties",
      "attributes": {
        "created_at": "2014-07-12T02:01:00.000000+00:00",
        "updated_at": "2014-07-12T02:01:00.000000+00:00",
        "name": "Phone",
        "identifier": "phone",
        "position": 1,
        "property_type": "text_field",
        "show_on": [],
        "validation_required": false,
        "owner_type": "customers",
        "select_options": [],
        "editable": true
      }
    },
    "meta": {}
  }
```

### HTTP Request

`PUT /api/boomerang/default_properties/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[default_properties]=created_at,updated_at,name`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][identifier]` | **string** <br>Key that will be used in exports, responses and custom field variables in templates. 
`data[attributes][name]` | **string** <br>Name of the property (used as label and to compute identifier if left blank). 
`data[attributes][owner_type]` | **string** <br>The type of resource this default property is intended for and derived properties can be added to. 
`data[attributes][position]` | **integer** <br>Which position the property has. 
`data[attributes][property_type]` | **enum** <br>Determines how the data is rendered and the kind of input shown to the user.<br> One of: `address`, `date_field`, `email`, `phone`, `select`, `text_area`, `text_field`.
`data[attributes][select_options][]` | **array** <br>For type `select`. The select options as array. 
`data[attributes][show_on]` | **array[string]** <br>Array of items to show this custom field on. Zero or more from `contract`, `invoice`, `packing`, `quote`. 
`data[attributes][validation_required]` | **boolean** <br>Whether this property has to be validated. 


### Includes

This request does not accept any includes
## Delete a default property


> How to delete a default property:

```shell
  curl --request DELETE
       --url 'https://example.booqable.com/api/4/default_properties/8d8ff086-4c54-40aa-84dd-28fc56d8b3dd'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "8d8ff086-4c54-40aa-84dd-28fc56d8b3dd",
      "type": "default_properties",
      "attributes": {
        "created_at": "2025-03-13T08:57:00.000000+00:00",
        "updated_at": "2025-03-13T08:57:00.000000+00:00",
        "name": "Phone",
        "identifier": "phone",
        "position": 1,
        "property_type": "phone",
        "show_on": [],
        "validation_required": false,
        "owner_type": "customers",
        "select_options": [],
        "editable": true
      }
    },
    "meta": {}
  }
```

### HTTP Request

`DELETE /api/boomerang/default_properties/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[default_properties]=created_at,updated_at,name`


### Includes

This request does not accept any includes