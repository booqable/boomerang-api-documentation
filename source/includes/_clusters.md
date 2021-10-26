# Clusters

A cluster is a group of locations that share their inventory (and availability). Stock can move between locations within the same cluster, meaning they can be picked up at one location and returned to another.

## Endpoints
`GET /api/boomerang/clusters`

`GET /api/boomerang/clusters/{id}`

`POST /api/boomerang/clusters`

`PUT /api/boomerang/clusters/{id}`

`DELETE /api/boomerang/clusters/{id}`

## Fields
Every cluster has the following fields:

Name | Description
- | -
`id` | **Uuid** `readonly`<br>Primary key
`created_at` | **Datetime** `readonly`<br>When the resource was created
`updated_at` | **Datetime** `readonly`<br>When the resource was last updated
`name` | **String**<br>Name of the cluster
`location_ids` | **Array**<br>The locations that belong to this cluster


## Relationships
Clusters have the following relationships:

Name | Description
- | -
`locations` | **Locations** `readonly`<br>Associated Locations


## Listing clusters



> How to fetch clusters

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/clusters' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "0ca220c2-12f1-4211-9a30-a3628bb9a025",
      "type": "clusters",
      "attributes": {
        "name": "Main",
        "location_ids": []
      },
      "relationships": {
        "locations": {
          "links": {
            "related": "api/boomerang/locations?filter[cluster_id]=0ca220c2-12f1-4211-9a30-a3628bb9a025"
          }
        }
      }
    }
  ],
  "links": {
    "self": "api/boomerang/clusters?page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/clusters?page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/clusters?page%5Bnumber%5D=1&page%5Bsize%5D=25"
  },
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/clusters`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=locations`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[clusters]=id,created_at,updated_at`
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-10-26T09:51:27Z`
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
`name` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`location_id` | **Uuid**<br>`eq`, `not_eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array**<br>`count`


### Includes

This request accepts the following includes:

`locations`






## Fetching a cluster



> How to fetch a single cluster:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/clusters/e2919e34-d37e-45c2-a56b-eaa7fad43331' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "e2919e34-d37e-45c2-a56b-eaa7fad43331",
    "type": "clusters",
    "attributes": {
      "name": "Main",
      "location_ids": []
    },
    "relationships": {
      "locations": {
        "links": {
          "related": "api/boomerang/locations?filter[cluster_id]=e2919e34-d37e-45c2-a56b-eaa7fad43331"
        }
      }
    }
  },
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/clusters/{id}`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=locations`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[clusters]=id,created_at,updated_at`


### Includes

This request accepts the following includes:

`locations`






## Creating a cluster



> How to create a cluster:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/clusters' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "clusters",
        "attributes": {
          "name": "Amsterdam"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "c4cd80e5-6357-4343-a101-788aa2709a11",
    "type": "clusters",
    "attributes": {
      "name": "Amsterdam",
      "location_ids": []
    },
    "relationships": {
      "locations": {
        "meta": {
          "included": false
        }
      }
    }
  },
  "links": {
    "self": "api/boomerang/clusters?data%5Battributes%5D%5Bname%5D=Amsterdam&data%5Btype%5D=clusters&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/clusters?data%5Battributes%5D%5Bname%5D=Amsterdam&data%5Btype%5D=clusters&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/clusters?data%5Battributes%5D%5Bname%5D=Amsterdam&data%5Btype%5D=clusters&page%5Bnumber%5D=1&page%5Bsize%5D=25"
  },
  "meta": {}
}
```

### HTTP Request

`POST /api/boomerang/clusters`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=locations`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[clusters]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][name]` | **String**<br>Name of the cluster
`data[attributes][location_ids][]` | **Array**<br>The locations that belong to this cluster


### Includes

This request accepts the following includes:

`locations`






## Updating a cluster



> How to update a cluster:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/clusters/8c97df4b-63d8-4c2c-92b3-815cc8c72405' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "8c97df4b-63d8-4c2c-92b3-815cc8c72405",
        "type": "clusters",
        "attributes": {
          "name": "Rotterdam"
        }
      }
    }'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "8c97df4b-63d8-4c2c-92b3-815cc8c72405",
    "type": "clusters",
    "attributes": {
      "name": "Rotterdam",
      "location_ids": []
    },
    "relationships": {
      "locations": {
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

`PUT /api/boomerang/clusters/{id}`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=locations`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[clusters]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][name]` | **String**<br>Name of the cluster
`data[attributes][location_ids][]` | **Array**<br>The locations that belong to this cluster


### Includes

This request accepts the following includes:

`locations`






## Deleting a cluster

To delete a cluster make sure no active locations are associated with it anymore.


> How to delete a cluster:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/clusters/f8b7b59a-96c9-4914-a808-cea3bb155b84' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "meta": {}
}
```


> A failure due to a cluster still being assocatied with locations:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/clusters/845195ae-ad7a-4cf6-87d0-ff46ca2d8e7d' \
    --header 'content-type: application/json' \
```

> A 422 status response looks like this:

```json
  {
  "errors": [
    {
      "code": "cluster_has_locations",
      "status": "422",
      "title": "Cluster has locations",
      "detail": "This cluster has 1 or more active locations",
      "meta": {
        "location_ids": [
          "a5fc7fa5-e273-4280-a337-e2e1b2c7ff6e"
        ]
      }
    }
  ]
}
```

### HTTP Request

`DELETE /api/boomerang/clusters/{id}`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=locations`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[clusters]=id,created_at,updated_at`


### Includes

This request does not accept any includes