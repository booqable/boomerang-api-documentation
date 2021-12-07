# Sortings

A convienient way to bulk update positions for supported models.

## Fields
Every sorting has the following fields:

Name | Description
- | -
`id` | **Uuid** `readonly`<br>
`type` | **String_enum** `writeonly`<br>Type of model to update. Any of `checkout_fields`, `bundle_items`, `categories`, `category_items`, `default_properties`, `lines`, `photos`, `properties`, `tax_rates`
`ids` | **Array_of_strings** `writeonly`<br>Array of ids, positions are determined by the order of the array


## Sorting a resource



> How to update positions:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/sortings' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "sorting",
        "attributes": {
          "type": "categories",
          "ids": [
            "5b48795e-4456-4d78-960a-a2006eb1127e",
            "d72b68d3-1b82-4801-9f55-8a377cc31b26",
            "87caa575-2c7d-419a-9d5c-1f40775e76e1",
            "a2d3dd7e-2836-405c-878c-3fa41e63d524",
            "29b8e8fd-ba9a-4eaf-bcb4-7711fb6648bd"
          ]
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "db9f64bb-6501-51ba-98b3-774f2c5e388f",
    "type": "sortings"
  },
  "links": {
    "self": "api/boomerang/sortings?data%5Battributes%5D%5Bids%5D%5B%5D=5b48795e-4456-4d78-960a-a2006eb1127e&data%5Battributes%5D%5Bids%5D%5B%5D=d72b68d3-1b82-4801-9f55-8a377cc31b26&data%5Battributes%5D%5Bids%5D%5B%5D=87caa575-2c7d-419a-9d5c-1f40775e76e1&data%5Battributes%5D%5Bids%5D%5B%5D=a2d3dd7e-2836-405c-878c-3fa41e63d524&data%5Battributes%5D%5Bids%5D%5B%5D=29b8e8fd-ba9a-4eaf-bcb4-7711fb6648bd&data%5Battributes%5D%5Btype%5D=categories&data%5Btype%5D=sorting&page%5Bnumber%5D=1&page%5Bsize%5D=25&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=5b48795e-4456-4d78-960a-a2006eb1127e&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=d72b68d3-1b82-4801-9f55-8a377cc31b26&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=87caa575-2c7d-419a-9d5c-1f40775e76e1&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=a2d3dd7e-2836-405c-878c-3fa41e63d524&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=29b8e8fd-ba9a-4eaf-bcb4-7711fb6648bd&sorting%5Bdata%5D%5Battributes%5D%5Btype%5D=categories&sorting%5Bdata%5D%5Btype%5D=sorting",
    "first": "api/boomerang/sortings?data%5Battributes%5D%5Bids%5D%5B%5D=5b48795e-4456-4d78-960a-a2006eb1127e&data%5Battributes%5D%5Bids%5D%5B%5D=d72b68d3-1b82-4801-9f55-8a377cc31b26&data%5Battributes%5D%5Bids%5D%5B%5D=87caa575-2c7d-419a-9d5c-1f40775e76e1&data%5Battributes%5D%5Bids%5D%5B%5D=a2d3dd7e-2836-405c-878c-3fa41e63d524&data%5Battributes%5D%5Bids%5D%5B%5D=29b8e8fd-ba9a-4eaf-bcb4-7711fb6648bd&data%5Battributes%5D%5Btype%5D=categories&data%5Btype%5D=sorting&page%5Bnumber%5D=1&page%5Bsize%5D=25&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=5b48795e-4456-4d78-960a-a2006eb1127e&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=d72b68d3-1b82-4801-9f55-8a377cc31b26&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=87caa575-2c7d-419a-9d5c-1f40775e76e1&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=a2d3dd7e-2836-405c-878c-3fa41e63d524&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=29b8e8fd-ba9a-4eaf-bcb4-7711fb6648bd&sorting%5Bdata%5D%5Battributes%5D%5Btype%5D=categories&sorting%5Bdata%5D%5Btype%5D=sorting",
    "last": "api/boomerang/sortings?data%5Battributes%5D%5Bids%5D%5B%5D=5b48795e-4456-4d78-960a-a2006eb1127e&data%5Battributes%5D%5Bids%5D%5B%5D=d72b68d3-1b82-4801-9f55-8a377cc31b26&data%5Battributes%5D%5Bids%5D%5B%5D=87caa575-2c7d-419a-9d5c-1f40775e76e1&data%5Battributes%5D%5Bids%5D%5B%5D=a2d3dd7e-2836-405c-878c-3fa41e63d524&data%5Battributes%5D%5Bids%5D%5B%5D=29b8e8fd-ba9a-4eaf-bcb4-7711fb6648bd&data%5Battributes%5D%5Btype%5D=categories&data%5Btype%5D=sorting&page%5Bnumber%5D=&page%5Bsize%5D=25&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=5b48795e-4456-4d78-960a-a2006eb1127e&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=d72b68d3-1b82-4801-9f55-8a377cc31b26&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=87caa575-2c7d-419a-9d5c-1f40775e76e1&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=a2d3dd7e-2836-405c-878c-3fa41e63d524&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=29b8e8fd-ba9a-4eaf-bcb4-7711fb6648bd&sorting%5Bdata%5D%5Battributes%5D%5Btype%5D=categories&sorting%5Bdata%5D%5Btype%5D=sorting",
    "next": "api/boomerang/sortings?data%5Battributes%5D%5Bids%5D%5B%5D=5b48795e-4456-4d78-960a-a2006eb1127e&data%5Battributes%5D%5Bids%5D%5B%5D=d72b68d3-1b82-4801-9f55-8a377cc31b26&data%5Battributes%5D%5Bids%5D%5B%5D=87caa575-2c7d-419a-9d5c-1f40775e76e1&data%5Battributes%5D%5Bids%5D%5B%5D=a2d3dd7e-2836-405c-878c-3fa41e63d524&data%5Battributes%5D%5Bids%5D%5B%5D=29b8e8fd-ba9a-4eaf-bcb4-7711fb6648bd&data%5Battributes%5D%5Btype%5D=categories&data%5Btype%5D=sorting&page%5Bnumber%5D=2&page%5Bsize%5D=25&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=5b48795e-4456-4d78-960a-a2006eb1127e&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=d72b68d3-1b82-4801-9f55-8a377cc31b26&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=87caa575-2c7d-419a-9d5c-1f40775e76e1&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=a2d3dd7e-2836-405c-878c-3fa41e63d524&sorting%5Bdata%5D%5Battributes%5D%5Bids%5D%5B%5D=29b8e8fd-ba9a-4eaf-bcb4-7711fb6648bd&sorting%5Bdata%5D%5Battributes%5D%5Btype%5D=categories&sorting%5Bdata%5D%5Btype%5D=sorting"
  },
  "meta": {}
}
```

### HTTP Request

`POST /api/boomerang/sortings`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[sortings]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][type]` | **String_enum**<br>Type of model to update. Any of `checkout_fields`, `bundle_items`, `categories`, `category_items`, `default_properties`, `lines`, `photos`, `properties`, `tax_rates`
`data[attributes][ids]` | **Array_of_strings**<br>Array of ids, positions are determined by the order of the array


### Includes

This request does not accept any includes