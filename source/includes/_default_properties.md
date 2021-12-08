# Default properties

Booqable comes with standard fields but you can also add custom properties to capture additional data. Default properties show up in forms within Booqable and can be connected to [checkout fields](https://help.booqable.com/en/articles/2170728-can-i-create-custom-checkout-fields). Default properties are searchable, show up in exports and can be used in email templates. The actual values of those properties are stored in the [Property](#properties) resource.

Properties inherit their fields from a default property when they are connected. When creating properties, they are mapped with their default when one of the following fields correspond:

- `name`
- `identifier`
- `default_property_id`

## Endpoints
`GET /api/boomerang/default_properties`

`GET /api/boomerang/default_properties/{id}`

`POST /api/boomerang/default_properties`

`PUT /api/boomerang/default_properties/{id}`

`DELETE /api/boomerang/default_properties/{id}`

## Fields
Every default property has the following fields:

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
`owner_type` | **String**<br>The resource type of the owner. One of `orders`, `product_groups`, `customers`, `users`
`select_options` | **Array**<br>For type `select`. The select options as array.
`editable` | **Boolean** `readonly`<br>Whether this property is editable


## Listing default properties



> How to fetch a list of default properties:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/default_properties?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "dcc47932-ef65-44c3-b949-532d0841055a",
      "type": "default_properties",
      "attributes": {
        "created_at": "2021-12-08T11:24:53+00:00",
        "updated_at": "2021-12-08T11:24:53+00:00",
        "name": "Phone",
        "identifier": "phone",
        "position": 1,
        "property_type": "phone",
        "show_on": [],
        "owner_type": "customers",
        "select_options": [],
        "editable": true
      }
    }
  ],
  "links": {
    "self": "api/boomerang/default_properties?include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/default_properties?include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/default_properties?include=owner&page%5Bnumber%5D=1&page%5Bsize%5D=25"
  },
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/default_properties`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[default_properties]=id,created_at,updated_at`
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-12-08T11:24:18Z`
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
`owner_type` | **String**<br>`eq`, `not_eq`
`editable` | **Boolean**<br>`eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array**<br>`count`


### Includes

This request does not accept any includes
## Fetching a default property



> How to fetch a default properties:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/default_properties/6886f6dc-e775-494e-a7c1-e85a7f72f2cd?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "6886f6dc-e775-494e-a7c1-e85a7f72f2cd",
    "type": "default_properties",
    "attributes": {
      "created_at": "2021-12-08T11:24:53+00:00",
      "updated_at": "2021-12-08T11:24:53+00:00",
      "name": "Phone",
      "identifier": "phone",
      "position": 1,
      "property_type": "phone",
      "show_on": [],
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[default_properties]=id,created_at,updated_at`


### Includes

This request does not accept any includes
## Creating a default property



> How to create a default property and assign it to an owner:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/default_properties' \
    --header 'content-type: application/json' \
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
    "id": "6efdc6b4-ae17-40b4-b90b-386b36c64acf",
    "type": "default_properties",
    "attributes": {
      "created_at": "2021-12-08T11:24:54+00:00",
      "updated_at": "2021-12-08T11:24:54+00:00",
      "name": "Mobile phone",
      "identifier": "mobile_phone",
      "position": 2,
      "property_type": "phone",
      "show_on": [],
      "owner_type": "customers",
      "select_options": [],
      "editable": true
    }
  },
  "links": {
    "self": "api/boomerang/default_properties?data%5Battributes%5D%5Bname%5D=Mobile+phone&data%5Battributes%5D%5Bowner_type%5D=customers&data%5Battributes%5D%5Bproperty_type%5D=phone&data%5Btype%5D=default_properties&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/default_properties?data%5Battributes%5D%5Bname%5D=Mobile+phone&data%5Battributes%5D%5Bowner_type%5D=customers&data%5Battributes%5D%5Bproperty_type%5D=phone&data%5Btype%5D=default_properties&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/default_properties?data%5Battributes%5D%5Bname%5D=Mobile+phone&data%5Battributes%5D%5Bowner_type%5D=customers&data%5Battributes%5D%5Bproperty_type%5D=phone&data%5Btype%5D=default_properties&page%5Bnumber%5D=1&page%5Bsize%5D=25"
  },
  "meta": {}
}
```

### HTTP Request

`POST /api/boomerang/default_properties`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[default_properties]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][name]` | **String**<br>Name of the property (used as label and to compute identifier if left blank)
`data[attributes][identifier]` | **String**<br>Key that will be used in exports, responses and custom field variables in templates
`data[attributes][position]` | **Integer**<br>Which position the property has
`data[attributes][property_type]` | **String**<br>One of `text_field`, `text_area`, `phone`, `email`, `date_field`, `select`, `address`
`data[attributes][show_on][]` | **Array**<br>Array of items to show this custom field on. Any of `packing`, `invoice`, `contract`, `quote`
`data[attributes][owner_type]` | **String**<br>The resource type of the owner. One of `orders`, `product_groups`, `customers`, `users`
`data[attributes][select_options][]` | **Array**<br>For type `select`. The select options as array.


### Includes

This request does not accept any includes
## Updating a default property



> How to update a default property:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/default_properties/bccd1582-72d0-488b-a77e-3ee033425114' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "bccd1582-72d0-488b-a77e-3ee033425114",
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
    "id": "bccd1582-72d0-488b-a77e-3ee033425114",
    "type": "default_properties",
    "attributes": {
      "created_at": "2021-12-08T11:24:54+00:00",
      "updated_at": "2021-12-08T11:24:54+00:00",
      "name": "Phone",
      "identifier": "phone",
      "position": 1,
      "property_type": "text_field",
      "show_on": [],
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[default_properties]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][name]` | **String**<br>Name of the property (used as label and to compute identifier if left blank)
`data[attributes][identifier]` | **String**<br>Key that will be used in exports, responses and custom field variables in templates
`data[attributes][position]` | **Integer**<br>Which position the property has
`data[attributes][property_type]` | **String**<br>One of `text_field`, `text_area`, `phone`, `email`, `date_field`, `select`, `address`
`data[attributes][show_on][]` | **Array**<br>Array of items to show this custom field on. Any of `packing`, `invoice`, `contract`, `quote`
`data[attributes][owner_type]` | **String**<br>The resource type of the owner. One of `orders`, `product_groups`, `customers`, `users`
`data[attributes][select_options][]` | **Array**<br>For type `select`. The select options as array.


### Includes

This request does not accept any includes
## Deleting a default property



> How to delete a default property:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/default_properties/50738a39-ccfe-45a3-9b49-1f6ef92a0822' \
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

`DELETE /api/boomerang/default_properties/{id}`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[default_properties]=id,created_at,updated_at`


### Includes

This request does not accept any includes