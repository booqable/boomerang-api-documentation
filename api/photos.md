# Photos

Photos are displayed on documents and in the online store to let customers see how products look.

## Relationships
Name | Description
-- | --
`owner` | **[Product group](#product-groups), [Bundle](#bundles)** `required`<br>The thing pictured in this photo. 


Check matching attributes under [Fields](#photos-fields) to see which relations can be written.
<br/ >
Check each individual operation to see which relations can be included as a sideload.
## Fields

 Name | Description
-- | --
`alt_text` | **string** <br>Alternative text for the image, used for accessibility and SEO purposes. This text is displayed when the image cannot be loaded and is read by screen readers. 
`coordinates` | **hash** <br>Focal point coordinates (`{ x: 10, y: 100 }`). To ensure that a key part of an image stays visible, you can set the image's focal point. The focal point sets the focus of an image, giving you control over where the image is centered. 
`created_at` | **datetime** `readonly`<br>When the resource was created.
`height` | **integer** `readonly`<br>Height of the photo in pixels. 
`id` | **uuid** `readonly`<br>Primary key.
`large_url` | **string** `readonly`<br>URL to large stored image (max 500x500). 
`original_filename` | **string** `writeonly`<br>The original filename of the uploaded image. This is used to preserve the user's original filename when uploading images via base64. The extension may be corrected based on the actual image format detected from the file content. 
`original_url` | **string** `readonly`<br>URL to original stored image. 
`owner_id` | **uuid** `readonly-after-create`<br>The thing pictured in this photo. 
`owner_type` | **enum** `readonly-after-create`<br>The resource type of the owner.<br>One of: `product_groups`, `bundles`.
`photo` | **carrierwave_file** <br>An object describing the photo. 
`photo_base64` | **string** `writeonly`<br>Base64 encoded photo. 
`position` | **integer** <br>Which position the photo has in the album. 
`preview` | **string** `readonly`<br>Base64 encoded preview. 
`remote_photo_url` | **string** `writeonly`<br>URL to an image on the web. 
`updated_at` | **datetime** `readonly`<br>When the resource was last updated.
`width` | **integer** `readonly`<br>Width of the photo in pixels. 
`xlarge_url` | **string** `readonly`<br>URL to xlarge stored image (max 2000x2000). 


## List photos


> How to fetch a list of photos:

```shell
  curl --get 'https://example.booqable.com/api/4/photos'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": [
      {
        "id": "1ba0ace1-dcf6-4d18-8296-444c10c904b1",
        "type": "photos",
        "attributes": {
          "created_at": "2015-06-17T07:25:01.000000+00:00",
          "updated_at": "2015-06-17T07:25:01.000000+00:00",
          "original_url": "/uploads/84696b61e5664464f6ccb00e1fda1b0b/photo/photo/1ba0ace1-dcf6-4d18-8296-444c10c904b1/upload.png",
          "large_url": "/uploads/84696b61e5664464f6ccb00e1fda1b0b/photo/photo/1ba0ace1-dcf6-4d18-8296-444c10c904b1/large_upload.jpg",
          "xlarge_url": "/uploads/84696b61e5664464f6ccb00e1fda1b0b/photo/photo/1ba0ace1-dcf6-4d18-8296-444c10c904b1/xlarge_upload.jpg",
          "coordinates": {
            "x": "0.00",
            "y": "0.00"
          },
          "alt_text": null,
          "preview": "iVBORw0KGgoAAAANSUhEUgAAABkAAAAZCAMAAADzN3VRAAAAIGNIUk0AAHomAACAhAAA+gAAAIDoAAB1MAAA6mAAADqYAAAXcJy6UTwAAAFWUExURf////7///j+/9ry/4fc/mHY/nzj/tD2//n8/7Ta/1e5/Ta2/S++/SnG/TzS/Zzq/vT9/+7y/5m8/lWd/kmh/kSq/T6x/Te5/S/B/S3J/XHf/uP5/+Xm/4+d/2KF/1yN/1aV/1Cd/0mk/kKs/Tyz/TW7/S3D/VnV/dP0/+Td/45/8mVi3FxlzVZpyVBvzFSB3F+b9lGh/kal/kGu/Tu2/TG9/VDN/c3y/+rh+o1p1GBEsFlHo1NKoVFQonZ8t7zE3uHo+MTb/3y0/k2h/kWn/T+w/Ta3/VXJ/dr0//r4/KB6yWUzpGI6ol08ompVrK2o0/Hx+PL3/63O/2Cl/kih/jqx/XjO/vb8/+nd8X06q2ooomw1ppFxvtrT6tfm/4O1/lGe/kWi/k6w/dvw//bx+q5/yp1nv8mw3ffz+vX4/73W/4O2/o7E/u/4//37/vz6/fr8//v8/yD7uT4AAAABYktHRACIBR1IAAAAB3RJTUUH6gIMDjER7W501gAAACV0RVh0ZGF0ZTpjcmVhdGUAMjAyNi0wMi0xMlQxNDo0OToxNyswMDowMBKoORsAAAAldEVYdGRhdGU6bW9kaWZ5ADIwMjYtMDItMTJUMTQ6NDk6MTcrMDA6MDBj9YGnAAAAKHRFWHRkYXRlOnRpbWVzdGFtcAAyMDI2LTAyLTEyVDE0OjQ5OjE3KzAwOjAwNOCgeAAAAJ9JREFUKM9jYBjqgJGJEbsEMwsrGzsWcQ5OLm4eXj5+AXQJQSFhEVExcQlJKWlUCRlZOXkFRSVlFVU1dQ1kCU0tbR1dPX0DQyNjE1Mzc4SEhaWVtY2tnb2Do5Ozi6ubuwdMwtPL28fXzz8AyAwMCg4RDQ0Lh8pEREZFx8RCOXHxCYlJyVBOSmpaegbc6Mys7JxcGCcvH8WhBYUDHRvkAwBOtRlAVFW3EgAAAABJRU5ErkJggg==",
          "position": 1,
          "width": null,
          "height": null,
          "photo": {
            "url": "/uploads/84696b61e5664464f6ccb00e1fda1b0b/photo/photo/1ba0ace1-dcf6-4d18-8296-444c10c904b1/upload.png"
          },
          "owner_id": "182cbf22-6a51-4729-81a3-190d3cbb3c57",
          "owner_type": "product_groups"
        },
        "relationships": {}
      }
    ],
    "meta": {}
  }
```

### HTTP Request

`GET /api/4/photos`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[photos]=created_at,updated_at,original_url`
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
`id` | **uuid** <br>`eq`, `not_eq`
`owner_id` | **uuid** <br>`eq`, `not_eq`
`owner_type` | **enum** <br>`eq`, `not_eq`
`updated_at` | **datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **array** <br>`count`


### Includes

This request does not accept any includes
## Fetch a photo


> How to fetch a photo:

```shell
  curl --get 'https://example.booqable.com/api/4/photos/93237a3f-2869-4ac3-8dbb-fabd864e9f81'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "93237a3f-2869-4ac3-8dbb-fabd864e9f81",
      "type": "photos",
      "attributes": {
        "created_at": "2022-08-01T02:59:00.000000+00:00",
        "updated_at": "2022-08-01T02:59:00.000000+00:00",
        "original_url": "/uploads/ed619234e7d3d43630945e706eff6913/photo/photo/93237a3f-2869-4ac3-8dbb-fabd864e9f81/upload.png",
        "large_url": "/uploads/ed619234e7d3d43630945e706eff6913/photo/photo/93237a3f-2869-4ac3-8dbb-fabd864e9f81/large_upload.jpg",
        "xlarge_url": "/uploads/ed619234e7d3d43630945e706eff6913/photo/photo/93237a3f-2869-4ac3-8dbb-fabd864e9f81/xlarge_upload.jpg",
        "coordinates": {
          "x": "0.00",
          "y": "0.00"
        },
        "alt_text": null,
        "preview": "iVBORw0KGgoAAAANSUhEUgAAABkAAAAZCAMAAADzN3VRAAAAIGNIUk0AAHomAACAhAAA+gAAAIDoAAB1MAAA6mAAADqYAAAXcJy6UTwAAAFWUExURf////7///j+/9ry/4fc/mHY/nzj/tD2//n8/7Ta/1e5/Ta2/S++/SnG/TzS/Zzq/vT9/+7y/5m8/lWd/kmh/kSq/T6x/Te5/S/B/S3J/XHf/uP5/+Xm/4+d/2KF/1yN/1aV/1Cd/0mk/kKs/Tyz/TW7/S3D/VnV/dP0/+Td/45/8mVi3FxlzVZpyVBvzFSB3F+b9lGh/kal/kGu/Tu2/TG9/VDN/c3y/+rh+o1p1GBEsFlHo1NKoVFQonZ8t7zE3uHo+MTb/3y0/k2h/kWn/T+w/Ta3/VXJ/dr0//r4/KB6yWUzpGI6ol08ompVrK2o0/Hx+PL3/63O/2Cl/kih/jqx/XjO/vb8/+nd8X06q2ooomw1ppFxvtrT6tfm/4O1/lGe/kWi/k6w/dvw//bx+q5/yp1nv8mw3ffz+vX4/73W/4O2/o7E/u/4//37/vz6/fr8//v8/yD7uT4AAAABYktHRACIBR1IAAAAB3RJTUUH6gIMDjESdGclbAAAACV0RVh0ZGF0ZTpjcmVhdGUAMjAyNi0wMi0xMlQxNDo0OToxOCswMDowMOTgSfIAAAAldEVYdGRhdGU6bW9kaWZ5ADIwMjYtMDItMTJUMTQ6NDk6MTgrMDA6MDCVvfFOAAAAKHRFWHRkYXRlOnRpbWVzdGFtcAAyMDI2LTAyLTEyVDE0OjQ5OjE4KzAwOjAwwqjQkQAAAJ9JREFUKM9jYBjqgJGJEbsEMwsrGzsWcQ5OLm4eXj5+AXQJQSFhEVExcQlJKWlUCRlZOXkFRSVlFVU1dQ1kCU0tbR1dPX0DQyNjE1Mzc4SEhaWVtY2tnb2Do5Ozi6ubuwdMwtPL28fXzz8AyAwMCg4RDQ0Lh8pEREZFx8RCOXHxCYlJyVBOSmpaegbc6Mys7JxcGCcvH8WhBYUDHRvkAwBOtRlAVFW3EgAAAABJRU5ErkJggg==",
        "position": 1,
        "width": null,
        "height": null,
        "photo": {
          "url": "/uploads/ed619234e7d3d43630945e706eff6913/photo/photo/93237a3f-2869-4ac3-8dbb-fabd864e9f81/upload.png"
        },
        "owner_id": "850b4eb4-0a7a-4316-8eef-e66a40d0e055",
        "owner_type": "product_groups"
      },
      "relationships": {}
    },
    "meta": {}
  }
```

### HTTP Request

`GET /api/4/photos/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[photos]=created_at,updated_at,original_url`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=owner`


### Includes

This request accepts the following includes:

<ul>
  <li><code>owner</code></li>
</ul>


## Create a photo


> How to create a photo:

```shell
  curl --request POST
       --url 'https://example.booqable.com/api/4/photos'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "type": "photos",
           "attributes": {
             "owner_id": "5ef74fb8-c1c9-47af-8fac-bcab35a7a867",
             "owner_type": "product_groups",
             "photo_base64": "data:image/png;base64,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\n",
             "original_filename": "my_product_image.png"
           }
         }
       }'
```

> A 201 status response looks like this:

```json
  {
    "data": {
      "id": "a8eb63bc-693b-4335-865c-8dbf5462fc14",
      "type": "photos",
      "attributes": {
        "created_at": "2024-05-28T22:17:00.000000+00:00",
        "updated_at": "2024-05-28T22:17:00.000000+00:00",
        "original_url": "/uploads/354d68b26fcffd8f9a3c21cae0ba8d0d/photo/photo/a8eb63bc-693b-4335-865c-8dbf5462fc14/my_product_image.png",
        "large_url": "/uploads/354d68b26fcffd8f9a3c21cae0ba8d0d/photo/photo/a8eb63bc-693b-4335-865c-8dbf5462fc14/large_my_product_image.jpg",
        "xlarge_url": "/uploads/354d68b26fcffd8f9a3c21cae0ba8d0d/photo/photo/a8eb63bc-693b-4335-865c-8dbf5462fc14/xlarge_my_product_image.jpg",
        "coordinates": {
          "x": 0,
          "y": 0
        },
        "alt_text": null,
        "preview": "iVBORw0KGgoAAAANSUhEUgAAABkAAAAZCAMAAADzN3VRAAAAIGNIUk0AAHomAACAhAAA+gAAAIDoAAB1MAAA6mAAADqYAAAXcJy6UTwAAAFWUExURf////7///j+/9ry/4fc/mHY/nzj/tD2//n8/7Ta/1e5/Ta2/S++/SnG/TzS/Zzq/vT9/+7y/5m8/lWd/kmh/kSq/T6x/Te5/S/B/S3J/XHf/uP5/+Xm/4+d/2KF/1yN/1aV/1Cd/0mk/kKs/Tyz/TW7/S3D/VnV/dP0/+Td/45/8mVi3FxlzVZpyVBvzFSB3F+b9lGh/kal/kGu/Tu2/TG9/VDN/c3y/+rh+o1p1GBEsFlHo1NKoVFQonZ8t7zE3uHo+MTb/3y0/k2h/kWn/T+w/Ta3/VXJ/dr0//r4/KB6yWUzpGI6ol08ompVrK2o0/Hx+PL3/63O/2Cl/kih/jqx/XjO/vb8/+nd8X06q2ooomw1ppFxvtrT6tfm/4O1/lGe/kWi/k6w/dvw//bx+q5/yp1nv8mw3ffz+vX4/73W/4O2/o7E/u/4//37/vz6/fr8//v8/yD7uT4AAAABYktHRACIBR1IAAAAB3RJTUUH6gIMDjEUnQSAWQAAACV0RVh0ZGF0ZTpjcmVhdGUAMjAyNi0wMi0xMlQxNDo0OToyMCswMDowMFmAAHYAAAAldEVYdGRhdGU6bW9kaWZ5ADIwMjYtMDItMTJUMTQ6NDk6MjArMDA6MDAo3bjKAAAAKHRFWHRkYXRlOnRpbWVzdGFtcAAyMDI2LTAyLTEyVDE0OjQ5OjIwKzAwOjAwf8iZFQAAAJ9JREFUKM9jYBjqgJGJEbsEMwsrGzsWcQ5OLm4eXj5+AXQJQSFhEVExcQlJKWlUCRlZOXkFRSVlFVU1dQ1kCU0tbR1dPX0DQyNjE1Mzc4SEhaWVtY2tnb2Do5Ozi6ubuwdMwtPL28fXzz8AyAwMCg4RDQ0Lh8pEREZFx8RCOXHxCYlJyVBOSmpaegbc6Mys7JxcGCcvH8WhBYUDHRvkAwBOtRlAVFW3EgAAAABJRU5ErkJggg==",
        "position": 2,
        "width": null,
        "height": null,
        "photo": {
          "url": "/uploads/354d68b26fcffd8f9a3c21cae0ba8d0d/photo/photo/a8eb63bc-693b-4335-865c-8dbf5462fc14/my_product_image.png"
        },
        "owner_id": "5ef74fb8-c1c9-47af-8fac-bcab35a7a867",
        "owner_type": "product_groups"
      },
      "relationships": {}
    },
    "meta": {}
  }
```

### HTTP Request

`POST /api/4/photos`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[photos]=created_at,updated_at,original_url`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=owner`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][alt_text]` | **string** <br>Alternative text for the image, used for accessibility and SEO purposes. This text is displayed when the image cannot be loaded and is read by screen readers. 
`data[attributes][coordinates]` | **hash** <br>Focal point coordinates (`{ x: 10, y: 100 }`). To ensure that a key part of an image stays visible, you can set the image's focal point. The focal point sets the focus of an image, giving you control over where the image is centered. 
`data[attributes][original_filename]` | **string** <br>The original filename of the uploaded image. This is used to preserve the user's original filename when uploading images via base64. The extension may be corrected based on the actual image format detected from the file content. 
`data[attributes][owner_id]` | **uuid** <br>The thing pictured in this photo. 
`data[attributes][owner_type]` | **enum** <br>The resource type of the owner.<br>One of: `product_groups`, `bundles`.
`data[attributes][photo]` | **carrierwave_file** <br>An object describing the photo. 
`data[attributes][photo_base64]` | **string** <br>Base64 encoded photo. 
`data[attributes][position]` | **integer** <br>Which position the photo has in the album. 
`data[attributes][remote_photo_url]` | **string** <br>URL to an image on the web. 


### Includes

This request accepts the following includes:

<ul>
  <li><code>owner</code></li>
</ul>


## Update a photo


> How to update a photo:

```shell
  curl --request PUT
       --url 'https://example.booqable.com/api/4/photos/f25879e9-ea1c-4b0f-8cc7-9b2eb23b96c0'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "id": "f25879e9-ea1c-4b0f-8cc7-9b2eb23b96c0",
           "type": "photos",
           "attributes": {
             "coordinates": {
               "x": 10,
               "y": 100
             },
             "alt_text": "Red bike, front view"
           }
         }
       }'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "f25879e9-ea1c-4b0f-8cc7-9b2eb23b96c0",
      "type": "photos",
      "attributes": {
        "created_at": "2024-12-16T09:31:00.000000+00:00",
        "updated_at": "2024-12-16T09:31:00.000000+00:00",
        "original_url": "/uploads/8188eebd3991392b266b288655dfde98/photo/photo/f25879e9-ea1c-4b0f-8cc7-9b2eb23b96c0/upload.png",
        "large_url": "/uploads/8188eebd3991392b266b288655dfde98/photo/photo/f25879e9-ea1c-4b0f-8cc7-9b2eb23b96c0/large_upload.jpg",
        "xlarge_url": "/uploads/8188eebd3991392b266b288655dfde98/photo/photo/f25879e9-ea1c-4b0f-8cc7-9b2eb23b96c0/xlarge_upload.jpg",
        "coordinates": {
          "x": 10,
          "y": 100
        },
        "alt_text": "Red bike, front view",
        "preview": "iVBORw0KGgoAAAANSUhEUgAAABkAAAAZCAMAAADzN3VRAAAAIGNIUk0AAHomAACAhAAA+gAAAIDoAAB1MAAA6mAAADqYAAAXcJy6UTwAAAFWUExURf////7///j+/9ry/4fc/mHY/nzj/tD2//n8/7Ta/1e5/Ta2/S++/SnG/TzS/Zzq/vT9/+7y/5m8/lWd/kmh/kSq/T6x/Te5/S/B/S3J/XHf/uP5/+Xm/4+d/2KF/1yN/1aV/1Cd/0mk/kKs/Tyz/TW7/S3D/VnV/dP0/+Td/45/8mVi3FxlzVZpyVBvzFSB3F+b9lGh/kal/kGu/Tu2/TG9/VDN/c3y/+rh+o1p1GBEsFlHo1NKoVFQonZ8t7zE3uHo+MTb/3y0/k2h/kWn/T+w/Ta3/VXJ/dr0//r4/KB6yWUzpGI6ol08ompVrK2o0/Hx+PL3/63O/2Cl/kih/jqx/XjO/vb8/+nd8X06q2ooomw1ppFxvtrT6tfm/4O1/lGe/kWi/k6w/dvw//bx+q5/yp1nv8mw3ffz+vX4/73W/4O2/o7E/u/4//37/vz6/fr8//v8/yD7uT4AAAABYktHRACIBR1IAAAAB3RJTUUH6gIMDjEV6gOwzwAAACV0RVh0ZGF0ZTpjcmVhdGUAMjAyNi0wMi0xMlQxNDo0OToyMSswMDowMP/3C8IAAAAldEVYdGRhdGU6bW9kaWZ5ADIwMjYtMDItMTJUMTQ6NDk6MjErMDA6MDCOqrN+AAAAKHRFWHRkYXRlOnRpbWVzdGFtcAAyMDI2LTAyLTEyVDE0OjQ5OjIxKzAwOjAw2b+SoQAAAJ9JREFUKM9jYBjqgJGJEbsEMwsrGzsWcQ5OLm4eXj5+AXQJQSFhEVExcQlJKWlUCRlZOXkFRSVlFVU1dQ1kCU0tbR1dPX0DQyNjE1Mzc4SEhaWVtY2tnb2Do5Ozi6ubuwdMwtPL28fXzz8AyAwMCg4RDQ0Lh8pEREZFx8RCOXHxCYlJyVBOSmpaegbc6Mys7JxcGCcvH8WhBYUDHRvkAwBOtRlAVFW3EgAAAABJRU5ErkJggg==",
        "position": 1,
        "width": null,
        "height": null,
        "photo": {
          "url": "/uploads/8188eebd3991392b266b288655dfde98/photo/photo/f25879e9-ea1c-4b0f-8cc7-9b2eb23b96c0/upload.png"
        },
        "owner_id": "266622d8-4266-4054-8c2c-617ae1a4b11e",
        "owner_type": "product_groups"
      },
      "relationships": {}
    },
    "meta": {}
  }
```

### HTTP Request

`PUT /api/4/photos/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[photos]=created_at,updated_at,original_url`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=owner`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][alt_text]` | **string** <br>Alternative text for the image, used for accessibility and SEO purposes. This text is displayed when the image cannot be loaded and is read by screen readers. 
`data[attributes][coordinates]` | **hash** <br>Focal point coordinates (`{ x: 10, y: 100 }`). To ensure that a key part of an image stays visible, you can set the image's focal point. The focal point sets the focus of an image, giving you control over where the image is centered. 
`data[attributes][original_filename]` | **string** <br>The original filename of the uploaded image. This is used to preserve the user's original filename when uploading images via base64. The extension may be corrected based on the actual image format detected from the file content. 
`data[attributes][owner_id]` | **uuid** <br>The thing pictured in this photo. 
`data[attributes][owner_type]` | **enum** <br>The resource type of the owner.<br>One of: `product_groups`, `bundles`.
`data[attributes][photo]` | **carrierwave_file** <br>An object describing the photo. 
`data[attributes][photo_base64]` | **string** <br>Base64 encoded photo. 
`data[attributes][position]` | **integer** <br>Which position the photo has in the album. 
`data[attributes][remote_photo_url]` | **string** <br>URL to an image on the web. 


### Includes

This request accepts the following includes:

<ul>
  <li><code>owner</code></li>
</ul>


## Delete a photo


> How to delete a photo:

```shell
  curl --request DELETE
       --url 'https://example.booqable.com/api/4/photos/d9aa6a55-20cb-4b4e-8dc1-b546e4d3abf0'
       --header 'content-type: application/json'
```

> A 200 status response looks like this:

```json
  {
    "data": {
      "id": "d9aa6a55-20cb-4b4e-8dc1-b546e4d3abf0",
      "type": "photos",
      "attributes": {
        "created_at": "2025-11-22T09:49:03.000000+00:00",
        "updated_at": "2025-11-22T09:49:03.000000+00:00",
        "original_url": "/uploads/5e3caf7997ce0b0563ffc6e824afbe2a/photo/photo/d9aa6a55-20cb-4b4e-8dc1-b546e4d3abf0/upload.png",
        "large_url": "/uploads/5e3caf7997ce0b0563ffc6e824afbe2a/photo/photo/d9aa6a55-20cb-4b4e-8dc1-b546e4d3abf0/large_upload.jpg",
        "xlarge_url": "/uploads/5e3caf7997ce0b0563ffc6e824afbe2a/photo/photo/d9aa6a55-20cb-4b4e-8dc1-b546e4d3abf0/xlarge_upload.jpg",
        "coordinates": {
          "x": "0.00",
          "y": "0.00"
        },
        "alt_text": null,
        "preview": "iVBORw0KGgoAAAANSUhEUgAAABkAAAAZCAMAAADzN3VRAAAAIGNIUk0AAHomAACAhAAA+gAAAIDoAAB1MAAA6mAAADqYAAAXcJy6UTwAAAFWUExURf////7///j+/9ry/4fc/mHY/nzj/tD2//n8/7Ta/1e5/Ta2/S++/SnG/TzS/Zzq/vT9/+7y/5m8/lWd/kmh/kSq/T6x/Te5/S/B/S3J/XHf/uP5/+Xm/4+d/2KF/1yN/1aV/1Cd/0mk/kKs/Tyz/TW7/S3D/VnV/dP0/+Td/45/8mVi3FxlzVZpyVBvzFSB3F+b9lGh/kal/kGu/Tu2/TG9/VDN/c3y/+rh+o1p1GBEsFlHo1NKoVFQonZ8t7zE3uHo+MTb/3y0/k2h/kWn/T+w/Ta3/VXJ/dr0//r4/KB6yWUzpGI6ol08ompVrK2o0/Hx+PL3/63O/2Cl/kih/jqx/XjO/vb8/+nd8X06q2ooomw1ppFxvtrT6tfm/4O1/lGe/kWi/k6w/dvw//bx+q5/yp1nv8mw3ffz+vX4/73W/4O2/o7E/u/4//37/vz6/fr8//v8/yD7uT4AAAABYktHRACIBR1IAAAAB3RJTUUH6gIMDjEWcwrhdQAAACV0RVh0ZGF0ZTpjcmVhdGUAMjAyNi0wMi0xMlQxNDo0OToyMiswMDowMM4fEV8AAAAldEVYdGRhdGU6bW9kaWZ5ADIwMjYtMDItMTJUMTQ6NDk6MjIrMDA6MDC/QqnjAAAAKHRFWHRkYXRlOnRpbWVzdGFtcAAyMDI2LTAyLTEyVDE0OjQ5OjIyKzAwOjAw6FeIPAAAAJ9JREFUKM9jYBjqgJGJEbsEMwsrGzsWcQ5OLm4eXj5+AXQJQSFhEVExcQlJKWlUCRlZOXkFRSVlFVU1dQ1kCU0tbR1dPX0DQyNjE1Mzc4SEhaWVtY2tnb2Do5Ozi6ubuwdMwtPL28fXzz8AyAwMCg4RDQ0Lh8pEREZFx8RCOXHxCYlJyVBOSmpaegbc6Mys7JxcGCcvH8WhBYUDHRvkAwBOtRlAVFW3EgAAAABJRU5ErkJggg==",
        "position": 1,
        "width": null,
        "height": null,
        "photo": {
          "url": "/uploads/5e3caf7997ce0b0563ffc6e824afbe2a/photo/photo/d9aa6a55-20cb-4b4e-8dc1-b546e4d3abf0/upload.png"
        },
        "owner_id": "98ee3afa-9bdc-4ccd-850a-61157c8e2a39",
        "owner_type": "product_groups"
      },
      "relationships": {}
    },
    "meta": {}
  }
```

### HTTP Request

`DELETE /api/4/photos/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[photos]=created_at,updated_at,original_url`


### Includes

This request does not accept any includes