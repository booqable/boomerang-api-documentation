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
      "id": "24d7f64d-5d8b-438c-a865-d2727f93c147",
      "created_at": "2022-01-12T10:55:07+00:00",
      "updated_at": "2022-01-12T10:55:07+00:00",
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
          "24d7f64d-5d8b-438c-a865-d2727f93c147": 1
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
    "id": "fb763e14-3f91-4d37-9abc-104318f82037",
    "type": "categories",
    "attributes": {
      "created_at": "2022-01-12T10:55:08+00:00",
      "updated_at": "2022-01-12T10:55:08+00:00",
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
          "parent_id": "b4ec8d0a-7c7c-42e8-bfda-4a16b3d8df94"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "d529cfda-8870-4f2b-a43e-db9f913b907c",
    "type": "categories",
    "attributes": {
      "created_at": "2022-01-12T10:55:08+00:00",
      "updated_at": "2022-01-12T10:55:08+00:00",
      "name": "Nikon",
      "slug": "nikon",
      "position": null,
      "show_in_store": true,
      "parent_id": "b4ec8d0a-7c7c-42e8-bfda-4a16b3d8df94"
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
    "self": "api/boomerang/categories?data%5Battributes%5D%5Bname%5D=Nikon&data%5Battributes%5D%5Bparent_id%5D=b4ec8d0a-7c7c-42e8-bfda-4a16b3d8df94&data%5Btype%5D=categories&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/categories?data%5Battributes%5D%5Bname%5D=Nikon&data%5Battributes%5D%5Bparent_id%5D=b4ec8d0a-7c7c-42e8-bfda-4a16b3d8df94&data%5Btype%5D=categories&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/categories?data%5Battributes%5D%5Bname%5D=Nikon&data%5Battributes%5D%5Bparent_id%5D=b4ec8d0a-7c7c-42e8-bfda-4a16b3d8df94&data%5Btype%5D=categories&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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
    --url 'https://example.booqable.com/api/boomerang/categories/40147a69-5d40-4e27-ab83-1bdb5f79af08' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "40147a69-5d40-4e27-ab83-1bdb5f79af08",
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
    "id": "40147a69-5d40-4e27-ab83-1bdb5f79af08",
    "type": "categories",
    "attributes": {
      "created_at": "2022-01-12T10:55:08+00:00",
      "updated_at": "2022-01-12T10:55:08+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/categories/8385e715-ff79-43c1-b1f2-0cc7f9f07a8f' \
    --header 'content-type: application/json' \
    --data '{
      "includes": "items",
      "data": {
        "id": "8385e715-ff79-43c1-b1f2-0cc7f9f07a8f",
        "type": "categories",
        "attributes": {
          "item_ids": [
            "658307da-01a1-4ab5-a8f6-260c9c667163",
            "e5d20a17-73e6-4a44-ace5-0bf16ebafbab"
          ]
        }
      }
    }'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "8385e715-ff79-43c1-b1f2-0cc7f9f07a8f",
    "type": "categories",
    "attributes": {
      "created_at": "2022-01-12T10:55:09+00:00",
      "updated_at": "2022-01-12T10:55:09+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/categories/6732330d-4683-494e-a056-206dcb30d438' \
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