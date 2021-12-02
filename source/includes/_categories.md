# Categories

Categories allow for easier organising and browsing of items in the online store. Categories can have sub-categories as well as procuct groups and bundles associated with them.

## Endpoints
`GET /api/boomerang/categories`

`POST /api/boomerang/categories`

`PUT /api/boomerang/categories/{id}`

`DELETE /api/boomerang/categories/{id}`

## Fields
Every category has the following fields:

Name | Description
- | -
`id` | **Uuid** `readonly`<br>Primary key
`created_at` | **Datetime** `readonly`<br>When the resource was created
`updated_at` | **Datetime** `readonly`<br>When the resource was last updated
`name` | **String**<br>Category name
`slug` | **String**<br>Code used to embed categories in the online store, generated automatically
`position` | **Integer**<br>Determines category order in the category list
`show_in_store` | **Boolean**<br>Determines if the category should be shown in the category list component
`parent_id` | **Uuid**<br>The associated Parent
`item_ids` | **Array** `writeonly`<br>Items that belong to this category


## Relationships
Categories have the following relationships:

Name | Description
- | -
`items` | **Items** `readonly`<br>Associated Items
`parent` | **Categories** `readonly`<br>Associated Parent
`children` | **Categories** `readonly`<br>Associated Children


## Listing categories



> How to fetch a list of categories:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/categories?filter%5Bparent_id%5D=null&includes=children&stats%5Bchildren%5D=count_each' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "f03257d8-00f6-4254-99a1-eeec97f2b445",
      "created_at": "2021-12-02T23:48:39+00:00",
      "updated_at": "2021-12-02T23:48:39+00:00",
      "name": "Cameras",
      "slug": "cameras",
      "position": 1,
      "show_in_store": true,
      "parent_id": null
    }
  ],
  "meta": {
    "stats": {
      "children": {
        "count_each": {
          "f03257d8-00f6-4254-99a1-eeec97f2b445": 1
        }
      }
    }
  }
}
```

### HTTP Request

`GET /api/boomerang/categories`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=items,parent,children`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[categories]=id,created_at,updated_at`
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-12-02T23:48:19Z`
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
`slug` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`position` | **Integer**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`show_in_store` | **Boolean**<br>`eq`
`parent_id` | **Uuid**<br>`eq`, `not_eq`
`item_ids` | **Array**<br>`eq`
`item_id` | **Uuid**<br>`eq`, `not_eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array**<br>`count`
`children` | **Array**<br>`count_each!`, `count_each`


### Includes

This request accepts the following includes:

`parent`


`children`






## Creating a category



> How to create a category:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/categories' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "categories",
        "attributes": {
          "name": "Accesories"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "715d9858-6fe6-48d0-afaf-0a02aa3dc888",
    "type": "categories",
    "attributes": {
      "created_at": "2021-12-02T23:48:39+00:00",
      "updated_at": "2021-12-02T23:48:39+00:00",
      "name": "Accesories",
      "slug": "accesories",
      "position": null,
      "show_in_store": true,
      "parent_id": null
    },
    "relationships": {
      "items": {
        "meta": {
          "included": false
        }
      },
      "parent": {
        "meta": {
          "included": false
        }
      },
      "children": {
        "meta": {
          "included": false
        }
      }
    }
  },
  "links": {
    "self": "api/boomerang/categories?data%5Battributes%5D%5Bname%5D=Accesories&data%5Btype%5D=categories&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/categories?data%5Battributes%5D%5Bname%5D=Accesories&data%5Btype%5D=categories&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/categories?data%5Battributes%5D%5Bname%5D=Accesories&data%5Btype%5D=categories&page%5Bnumber%5D=1&page%5Bsize%5D=25"
  },
  "meta": {}
}
```


> How to set a parent category:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/categories' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "categories",
        "attributes": {
          "name": "Nikon",
          "parent_id": "1ddda5c2-910d-4844-a8d0-8333f265db17"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "8cd71b4c-bfd9-449b-aa6e-b86f9f7014c3",
    "type": "categories",
    "attributes": {
      "created_at": "2021-12-02T23:48:40+00:00",
      "updated_at": "2021-12-02T23:48:40+00:00",
      "name": "Nikon",
      "slug": "nikon",
      "position": null,
      "show_in_store": true,
      "parent_id": "1ddda5c2-910d-4844-a8d0-8333f265db17"
    },
    "relationships": {
      "items": {
        "meta": {
          "included": false
        }
      },
      "parent": {
        "meta": {
          "included": false
        }
      },
      "children": {
        "meta": {
          "included": false
        }
      }
    }
  },
  "links": {
    "self": "api/boomerang/categories?data%5Battributes%5D%5Bname%5D=Nikon&data%5Battributes%5D%5Bparent_id%5D=1ddda5c2-910d-4844-a8d0-8333f265db17&data%5Btype%5D=categories&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/categories?data%5Battributes%5D%5Bname%5D=Nikon&data%5Battributes%5D%5Bparent_id%5D=1ddda5c2-910d-4844-a8d0-8333f265db17&data%5Btype%5D=categories&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/categories?data%5Battributes%5D%5Bname%5D=Nikon&data%5Battributes%5D%5Bparent_id%5D=1ddda5c2-910d-4844-a8d0-8333f265db17&data%5Btype%5D=categories&page%5Bnumber%5D=1&page%5Bsize%5D=25"
  },
  "meta": {}
}
```

### HTTP Request

`POST /api/boomerang/categories`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=items,parent,children`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[categories]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][name]` | **String**<br>Category name
`data[attributes][slug]` | **String**<br>Code used to embed categories in the online store, generated automatically
`data[attributes][position]` | **Integer**<br>Determines category order in the category list
`data[attributes][show_in_store]` | **Boolean**<br>Determines if the category should be shown in the category list component
`data[attributes][parent_id]` | **Uuid**<br>The associated Parent
`data[attributes][item_ids][]` | **Array**<br>Items that belong to this category


### Includes

This request accepts the following includes:

`parent`


`children`






## Updating a category



> How to update a category:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/categories/f660b2b7-ea53-4902-92d5-c2744f127602' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "f660b2b7-ea53-4902-92d5-c2744f127602",
        "type": "categories",
        "attributes": {
          "name": "Photo cameras"
        }
      }
    }'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "f660b2b7-ea53-4902-92d5-c2744f127602",
    "type": "categories",
    "attributes": {
      "created_at": "2021-12-02T23:48:40+00:00",
      "updated_at": "2021-12-02T23:48:40+00:00",
      "name": "Photo cameras",
      "slug": "cameras",
      "position": 1,
      "show_in_store": true,
      "parent_id": null
    },
    "relationships": {
      "items": {
        "meta": {
          "included": false
        }
      },
      "parent": {
        "meta": {
          "included": false
        }
      },
      "children": {
        "meta": {
          "included": false
        }
      }
    }
  },
  "meta": {}
}
```


> Adding items to a category:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/categories/ba91c693-35d1-4ef3-b577-4c37344038d4' \
    --header 'content-type: application/json' \
    --data '{
      "includes": "items",
      "data": {
        "id": "ba91c693-35d1-4ef3-b577-4c37344038d4",
        "type": "categories",
        "attributes": {
          "item_ids": [
            "4077e961-9579-4d51-b33d-eaebd9e69490",
            "97a66ec2-57de-4572-be04-36150a3cb8e6"
          ]
        }
      }
    }'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "ba91c693-35d1-4ef3-b577-4c37344038d4",
    "type": "categories",
    "attributes": {
      "created_at": "2021-12-02T23:48:40+00:00",
      "updated_at": "2021-12-02T23:48:40+00:00",
      "name": "Cameras",
      "slug": "cameras",
      "position": 1,
      "show_in_store": true,
      "parent_id": null
    },
    "relationships": {
      "items": {
        "meta": {
          "included": false
        }
      },
      "parent": {
        "meta": {
          "included": false
        }
      },
      "children": {
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

`PUT /api/boomerang/categories/{id}`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=items,parent,children`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[categories]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][name]` | **String**<br>Category name
`data[attributes][slug]` | **String**<br>Code used to embed categories in the online store, generated automatically
`data[attributes][position]` | **Integer**<br>Determines category order in the category list
`data[attributes][show_in_store]` | **Boolean**<br>Determines if the category should be shown in the category list component
`data[attributes][parent_id]` | **Uuid**<br>The associated Parent
`data[attributes][item_ids][]` | **Array**<br>Items that belong to this category


### Includes

This request accepts the following includes:

`parent`


`children`






## Deleting a category



> How to delete a category:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/categories/a5493075-e46c-49c6-803d-a58f863b09ac' \
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

`DELETE /api/boomerang/categories/{id}`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=items,parent,children`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[categories]=id,created_at,updated_at`


### Includes

This request does not accept any includes