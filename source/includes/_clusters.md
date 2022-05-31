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
      "id": "e279c474-5bdc-4068-ae16-aad20e348ffd",
      "type": "clusters",
      "attributes": {
        "created_at": "2022-05-31T08:25:43+00:00",
        "updated_at": "2022-05-31T08:25:43+00:00",
        "name": "Main",
        "location_ids": []
      },
      "relationships": {
        "locations": {
          "links": {
            "related": "api/boomerang/locations?filter[cluster_id]=e279c474-5bdc-4068-ae16-aad20e348ffd"
          }
        }
      }
    }
  ],
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-05-31T08:25:19Z`
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
    --url 'https://example.booqable.com/api/boomerang/clusters/88b92077-3ba3-4b56-be2f-ded095f70201' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "88b92077-3ba3-4b56-be2f-ded095f70201",
    "type": "clusters",
    "attributes": {
      "created_at": "2022-05-31T08:25:43+00:00",
      "updated_at": "2022-05-31T08:25:43+00:00",
      "name": "Main",
      "location_ids": []
    },
    "relationships": {
      "locations": {
        "links": {
          "related": "api/boomerang/locations?filter[cluster_id]=88b92077-3ba3-4b56-be2f-ded095f70201"
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
    "id": "5166f7ee-8d1b-4c30-b000-23c93b2c6d72",
    "type": "clusters",
    "attributes": {
      "created_at": "2022-05-31T08:25:44+00:00",
      "updated_at": "2022-05-31T08:25:44+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/clusters/163ff767-d968-4016-b915-2f8e1569d04f' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "163ff767-d968-4016-b915-2f8e1569d04f",
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
    "id": "163ff767-d968-4016-b915-2f8e1569d04f",
    "type": "clusters",
    "attributes": {
      "created_at": "2022-05-31T08:25:44+00:00",
      "updated_at": "2022-05-31T08:25:44+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/clusters/54d5af89-b65b-4d6d-b674-359e53aa1b3b' \
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
    --url 'https://example.booqable.com/api/boomerang/clusters/34e9c819-035c-4051-82af-3eafe63e7a51' \
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
          "dd3a2db6-d698-436a-b96b-8b6378259fc9"
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