# Customers

Customers are an essential part of your business. You can manage settings and custom data. Stored customer information like addresses, customer tax profiles, discounts, and customized security deposits are applied to associated orders when created or when assigned a new customer.

## Endpoints
`GET /api/boomerang/customers`

`GET /api/boomerang/customers/{id}`

`POST /api/boomerang/customers`

`PUT /api/boomerang/customers/{id}`

`DELETE /api/boomerang/customers/{id}`

## Fields
Every customer has the following fields:

Name | Description
- | -
`id` | **Uuid** `readonly`<br>Primary key
`created_at` | **Datetime** `readonly`<br>When the resource was created
`updated_at` | **Datetime** `readonly`<br>When the resource was last updated
`number` | **Integer** `readonly`<br>The assigned number
`name` | **String**<br>Person or Company name
`email` | **String** `nullable`<br>E-mail address used for communication
`archived` | **Boolean** `readonly`<br>Whether customer is archived
`deposit_type` | **String**<br>One of `default`, `none`, `percentage_total`, `percentage`, `fixed`
`deposit_value` | **Float**<br>The value to use for `deposit_type`
`discount_percentage` | **Float**<br>Default discount applied to each new order for this customer
`legal_type` | **String**<br>Either `person` or `commercial`
`properties` | **Hash** `readonly`<br>A hash containing all basic property values (include properties if you need more detailed information about properties)
`properties_attributes` | **Array** `writeonly`<br>Create or update multiple properties associated with this customer
`tag_list` | **Array**<br>Case insensitive tag list
`merge_suggestion_customer_id` | **Uuid** `readonly`<br>The associated Merge suggestion customer
`tax_region_id` | **Uuid** `nullable`<br>The associated Tax region


## Relationships
A customers has the following relationships:

Name | Description
- | -
`merge_suggestion_customer` | **Customers** `readonly`<br>Associated Merge suggestion customer
`tax_region` | **Tax regions**<br>Associated Tax region


## Listing customers

> How to fetch a list of customers:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/customers' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "b24d8f4e-0d51-479c-9503-7dd04a44ea13",
      "created_at": "2021-08-24T12:40:49+00:00",
      "updated_at": "2021-08-24T12:40:49+00:00",
      "number": 1,
      "name": "John Doe",
      "email": "john.doe@paucek.name",
      "archived": false,
      "deposit_type": "default",
      "deposit_value": 0.0,
      "discount_percentage": 0.0,
      "legal_type": "person",
      "properties": {},
      "tag_list": [],
      "merge_suggestion_customer_id": null,
      "tax_region_id": null
    }
  ]
}
```


### HTTP Request

`GET /api/boomerang/customers`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=merge_suggestion_customer,tax_region`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[customers]=id,created_at,updated_at`
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-08-24T12:40:42Z`
`sort` | **String**<br>How to sort the data `?sort=-created_at`
`meta` | **Hash**<br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String**<br>The page to request
`page[per]` | **String**<br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
`id` | **Uuid**<br>`eq`, `not_eq`
`created_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`number` | **Integer**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`name` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`email` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`deposit_type` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`deposit_value` | **Float**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`tag_list` | **Array**<br>`eq`
`merge_suggestion_customer_id` | **Uuid**<br>`eq`, `not_eq`
`tax_region_id` | **Uuid**<br>`eq`, `not_eq`
`q` | **String**<br>`eq`, `not_eq`, `prefix`, `match`


### Meta

Results can be aggregated on:

Name | Description
- | -
`archived` | **Array**<br>`count`
`discount_percentage` | **Array**<br>`maximum`, `minimum`, `average`
`legal_type` | **Array**<br>`count`
`total` | **Array**<br>`count`


### Includes

This request does not accept any includes
## Fetching a customer

> How to fetch a customers:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/customers/42b9c98a-e9c7-44e0-825c-ff235fa8bce4' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "42b9c98a-e9c7-44e0-825c-ff235fa8bce4",
    "created_at": "2021-08-24T12:40:52+00:00",
    "updated_at": "2021-08-24T12:40:52+00:00",
    "number": 1,
    "name": "John Doe",
    "email": "doe.john@swift.co",
    "archived": false,
    "deposit_type": "default",
    "deposit_value": 0.0,
    "discount_percentage": 0.0,
    "legal_type": "person",
    "properties": {},
    "tag_list": [],
    "merge_suggestion_customer_id": null,
    "tax_region_id": null
  }
}
```


### HTTP Request

`GET /api/boomerang/customers/{id}`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=merge_suggestion_customer,tax_region`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[customers]=id,created_at,updated_at`


### Includes

This request accepts the following includes:

`tax_region`


`properties`


`barcode`






## Creating a customer

> How to create a customer:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/customers' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "customers",
        "attributes": {
          "name": "John Doe",
          "email": "john@doe.com"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "0c29f4d7-9454-48bc-a6e4-d1e7fea23315",
    "type": "customers",
    "attributes": {
      "created_at": "2021-08-24T12:40:53+00:00",
      "updated_at": "2021-08-24T12:40:53+00:00",
      "number": 2,
      "name": "John Doe",
      "email": "john@doe.com",
      "archived": false,
      "deposit_type": "default",
      "deposit_value": 0.0,
      "discount_percentage": 0.0,
      "legal_type": "person",
      "properties": {},
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
      }
    }
  },
  "meta": {}
}
```


### HTTP Request

`POST /api/boomerang/customers`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=merge_suggestion_customer,tax_region`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[customers]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][name]` | **String**<br>Person or Company name
`data[attributes][email]` | **String**<br>E-mail address used for communication
`data[attributes][deposit_type]` | **String**<br>One of `default`, `none`, `percentage_total`, `percentage`, `fixed`
`data[attributes][deposit_value]` | **Float**<br>The value to use for `deposit_type`
`data[attributes][discount_percentage]` | **Float**<br>Default discount applied to each new order for this customer
`data[attributes][legal_type]` | **String**<br>Either `person` or `commercial`
`data[attributes][properties_attributes[]]` | **Array**<br>Create or update multiple properties associated with this customer
`data[attributes][tag_list[]]` | **Array**<br>Case insensitive tag list
`data[attributes][tax_region_id]` | **Uuid**<br>The associated Tax region


### Includes

This request accepts the following includes:

`tax_region`






## Updating a customer

> How to update a customer:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/customers/b63e3dfd-8d62-4eb3-bf4a-6e0a27c244cc' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "b63e3dfd-8d62-4eb3-bf4a-6e0a27c244cc",
        "type": "customers",
        "attributes": {
          "name": "Jane Doe"
        }
      }
    }'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "b63e3dfd-8d62-4eb3-bf4a-6e0a27c244cc",
    "type": "customers",
    "attributes": {
      "created_at": "2021-08-24T12:40:54+00:00",
      "updated_at": "2021-08-24T12:40:54+00:00",
      "number": 1,
      "name": "Jane Doe",
      "email": "doe.john@swaniawski.net",
      "archived": false,
      "deposit_type": "default",
      "deposit_value": 0.0,
      "discount_percentage": 0.0,
      "legal_type": "person",
      "properties": {},
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
      }
    }
  },
  "meta": {}
}
```


### HTTP Request

`PUT /api/boomerang/customers/{id}`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=merge_suggestion_customer,tax_region`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[customers]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][name]` | **String**<br>Person or Company name
`data[attributes][email]` | **String**<br>E-mail address used for communication
`data[attributes][deposit_type]` | **String**<br>One of `default`, `none`, `percentage_total`, `percentage`, `fixed`
`data[attributes][deposit_value]` | **Float**<br>The value to use for `deposit_type`
`data[attributes][discount_percentage]` | **Float**<br>Default discount applied to each new order for this customer
`data[attributes][legal_type]` | **String**<br>Either `person` or `commercial`
`data[attributes][properties_attributes[]]` | **Array**<br>Create or update multiple properties associated with this customer
`data[attributes][tag_list[]]` | **Array**<br>Case insensitive tag list
`data[attributes][tax_region_id]` | **Uuid**<br>The associated Tax region


### Includes

This request accepts the following includes:

`tax_region`






## Archiving a customer

> How to delete a customer:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/customers/fb413928-d0d7-4562-888b-363895bb3282' \
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

`DELETE /api/boomerang/customers/{id}`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=merge_suggestion_customer,tax_region`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[customers]=id,created_at,updated_at`


### Includes

This request does not accept any includes