# Default properties

Booqable comes with standard fields but you can also add custom properties to capture additional data. Default properties show up in forms within Booqable and can be connected to [checkout fields](https://help.booqable.com/en/articles/2170728-can-i-create-custom-checkout-fields). Default properties are searchable, show up in exports and can be used in email templates. The actual values of those properties are stored in the [Property](#properties) resource.

Properties inherit their fields from a default property when they are connected. When creating properties, they are mapped with their default when one of the following fields correspond:

- `name`
- `identifier`
- `default_property_id`

## Endpoints
`GET /api/boomerang/default_properties`

`DELETE /api/boomerang/default_properties/{id}`

`PUT /api/boomerang/default_properties/{id}`

`GET /api/boomerang/default_properties/{id}`

`POST /api/boomerang/default_properties`

## Fields
Every default property has the following fields:

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
`owner_type` | **String** <br>The resource type of the owner. One of `orders`, `product_groups`, `customers`, `users`
`select_options` | **Array** <br>For type `select`. The select options as array.
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
      "id": "52398b4a-ba8a-42ef-b2e3-f8eb8e692570",
      "type": "default_properties",
      "attributes": {
        "created_at": "2024-05-27T09:26:37.437160+00:00",
        "updated_at": "2024-05-27T09:26:37.437160+00:00",
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
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[default_properties]=created_at,updated_at,name`
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
`validation_required` | **Boolean** <br>`eq`
`owner_type` | **String** <br>`eq`, `not_eq`
`editable` | **Boolean** <br>`eq`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **Array** <br>`count`


### Includes

This request does not accept any includes
## Deleting a default property



> How to delete a default property:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/default_properties/e081154b-9b7b-4664-91ba-784765419d1c' \
    --header 'content-type: application/json' \
    --data '{}'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "e081154b-9b7b-4664-91ba-784765419d1c",
    "type": "default_properties",
    "attributes": {
      "created_at": "2024-05-27T09:26:38.886486+00:00",
      "updated_at": "2024-05-27T09:26:38.886486+00:00",
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
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[default_properties]=created_at,updated_at,name`


### Includes

This request does not accept any includes
## Updating a default property



> How to update a default property:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/default_properties/62f759c7-cfa3-4195-a1a6-50d6815592b7' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "62f759c7-cfa3-4195-a1a6-50d6815592b7",
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
    "id": "62f759c7-cfa3-4195-a1a6-50d6815592b7",
    "type": "default_properties",
    "attributes": {
      "created_at": "2024-05-27T09:26:39.870702+00:00",
      "updated_at": "2024-05-27T09:26:39.929421+00:00",
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
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[default_properties]=created_at,updated_at,name`


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
`data[attributes][owner_type]` | **String** <br>The resource type of the owner. One of `orders`, `product_groups`, `customers`, `users`
`data[attributes][select_options][]` | **Array** <br>For type `select`. The select options as array.


### Includes

This request does not accept any includes
## Fetching a default property



> How to fetch a default properties:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/default_properties/df5ba002-c8b7-4371-8046-b8155fd7cd93?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "df5ba002-c8b7-4371-8046-b8155fd7cd93",
    "type": "default_properties",
    "attributes": {
      "created_at": "2024-05-27T09:26:40.964236+00:00",
      "updated_at": "2024-05-27T09:26:40.964236+00:00",
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
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[default_properties]=created_at,updated_at,name`


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
    "id": "b645f96c-8487-4bc4-ad21-45be8657d82b",
    "type": "default_properties",
    "attributes": {
      "created_at": "2024-05-27T09:26:41.798975+00:00",
      "updated_at": "2024-05-27T09:26:41.798975+00:00",
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
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[default_properties]=created_at,updated_at,name`


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
`data[attributes][owner_type]` | **String** <br>The resource type of the owner. One of `orders`, `product_groups`, `customers`, `users`
`data[attributes][select_options][]` | **Array** <br>For type `select`. The select options as array.


### Includes

This request does not accept any includes