# Bundle duplications

Creates a new Bundle using an active [Bundle](#bundles) as a starting point.

The copy requires a new, unique name and receives its own ID and slug. Archived Bundles cannot be duplicated.
Other scalar settings, including the online-store excerpt, SEO title, SEO description, and extra information,
are retained regardless of the copy options. Review these settings after renaming the copy.

Contents, collection memberships, discount eligibility, tags, and tax settings are controlled by the options below.
Automatic collection membership is maintained even when `collections` is `false`.
The original Bundle's photos are not copied; provide an image using one of the write-only upload attributes.

## Relationships
Name | Description
-- | --
`new_bundle` | **[Bundle](#bundles)** `required`<br>The newly created [Bundle](#bundles).
`original_bundle` | **[Bundle](#bundles)** `required`<br>The [Bundle](#bundles) to be duplicated.


Check matching attributes under [Fields](#bundle-duplications-fields) to see which relations can be written.
<br/ >
Check each individual operation to see which relations can be included as a sideload.
## Fields

 Name | Description
-- | --
`bundle_items` | **boolean** <br>Indicates if [BundleItems](#bundle-items) should be copied from the original Bundle.
`collections` | **boolean** <br>Indicates if collections should be copied from the original Bundle.
`description` | **string** <br>Description used in the online store. Omit this attribute to retain the original description, or supply an empty string to clear it.
`discount_settings` | **boolean** <br>Copies the original Bundle's discount eligibility when `true`. When `false`, the copy is eligible for discounts. Per-content discount percentages are copied with `bundle_items` independently of this option.
`id` | **uuid** `readonly`<br>Primary key.
`name` | **string** <br>Name of the newly created [Bundle](#bundles).
`new_bundle_id` | **uuid** `readonly`<br>The newly created [Bundle](#bundles).
`original_bundle_id` | **uuid** <br>The [Bundle](#bundles) to be duplicated.
`photo_base64` | **string** `writeonly`<br>Write-only Base64 encoded image used to upload a new main photo. The submitted image data is not returned in the response.
`remote_photo_url` | **string** `writeonly`<br>Write-only image URL used to enqueue a new photo download. The submitted URL is not returned in the response.
`show_in_store` | **boolean** <br>Indicates if the copied bundle should be visible in the online store.
`tags` | **boolean** <br>Indicates if tags should be copied from the original Bundle.
`tax_settings` | **boolean** <br>Copies the original Bundle's tax category and taxable status when `true`. When `false`, the copy has no tax category and is not taxable, rather than using the taxable default for new Bundles.


## Duplicate


> Duplicate a Bundle:

```shell
  curl --request POST
       --url 'https://example.booqable.com/api/4/bundle_duplications'
       --header 'content-type: application/json'
       --data '{
         "data": {
           "type": "bundle_duplications",
           "attributes": {
             "original_bundle_id": "5fb6fe2a-c233-46af-8f75-45390aad71c7",
             "name": "New name",
             "description": "New description",
             "bundle_items": true,
             "collections": true,
             "discount_settings": true,
             "tags": true,
             "tax_settings": true,
             "show_in_store": true
           }
         }
       }'
```

> A 201 status response looks like this:

```json
  {
    "data": {
      "id": "28c55e21-e84c-4570-8224-45e32c635b92",
      "type": "bundle_duplications",
      "attributes": {
        "name": "New name",
        "description": "New description",
        "bundle_items": true,
        "collections": true,
        "discount_settings": true,
        "tags": true,
        "tax_settings": true,
        "show_in_store": true,
        "original_bundle_id": "5fb6fe2a-c233-46af-8f75-45390aad71c7",
        "new_bundle_id": "f8c07288-4568-4f7c-8d61-1c9e1c337f4b"
      },
      "relationships": {}
    },
    "meta": {}
  }
```

### HTTP Request

`POST /api/4/bundle_duplications`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **array** <br>List of comma separated fields to include instead of the default fields. `?fields[bundle_duplications]=name,description,bundle_items`
`include` | **string** <br>List of comma seperated relationships to sideload. `?include=original_bundle,new_bundle`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][bundle_items]` | **boolean** <br>Indicates if [BundleItems](#bundle-items) should be copied from the original Bundle.
`data[attributes][collections]` | **boolean** <br>Indicates if collections should be copied from the original Bundle.
`data[attributes][discount_settings]` | **boolean** <br>Copies the original Bundle's discount eligibility when `true`. When `false`, the copy is eligible for discounts. Per-content discount percentages are copied with `bundle_items` independently of this option.
`data[attributes][name]` | **string** <br>Name of the newly created [Bundle](#bundles).
`data[attributes][original_bundle_id]` | **uuid** <br>The [Bundle](#bundles) to be duplicated.
`data[attributes][photo_base64]` | **string** <br>Write-only Base64 encoded image used to upload a new main photo. The submitted image data is not returned in the response.
`data[attributes][remote_photo_url]` | **string** <br>Write-only image URL used to enqueue a new photo download. The submitted URL is not returned in the response.
`data[attributes][show_in_store]` | **boolean** <br>Indicates if the copied bundle should be visible in the online store.
`data[attributes][tags]` | **boolean** <br>Indicates if tags should be copied from the original Bundle.
`data[attributes][tax_settings]` | **boolean** <br>Copies the original Bundle's tax category and taxable status when `true`. When `false`, the copy has no tax category and is not taxable, rather than using the taxable default for new Bundles.


### Includes

This request accepts the following includes:

<ul>
  <li>
    <code>new_bundle</code>
    <ul>
      <li>
          <code>bundle_items</code>
          <ul>
            <li>
                  <code>product</code>
                  <ul>
                    <li><code>photo</code></li>
                  </ul>
            </li>
            <li>
                  <code>product_group</code>
                  <ul>
                    <li><code>photo</code></li>
                  </ul>
            </li>
          </ul>
      </li>
      <li><code>photo</code></li>
      <li><code>tax_category</code></li>
    </ul>
  </li>
  <li>
    <code>original_bundle</code>
    <ul>
      <li>
          <code>bundle_items</code>
          <ul>
            <li>
                  <code>product</code>
                  <ul>
                    <li><code>photo</code></li>
                  </ul>
            </li>
            <li>
                  <code>product_group</code>
                  <ul>
                    <li><code>photo</code></li>
                  </ul>
            </li>
          </ul>
      </li>
      <li><code>photo</code></li>
      <li><code>tax_category</code></li>
    </ul>
  </li>
</ul>

