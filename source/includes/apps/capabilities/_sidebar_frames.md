## Sidebar Frames

Sidebar frames let your app show a panel in the sidebar of an order, a customer or a product in the Booqable back office, about the record being viewed. For example, a delivery app can show the delivery status of the order the employee is looking at.

### Adding a panel

```jsonc
// booqable.json
{
  "order_page": {
    "sidebar_frame": { "url": { "relative": "/panels/order" } }
  }
}
```

Each of `order_page`, `customer_page` and `product_page` takes one `sidebar_frame`, a [`Frame`](#reference-frame) like any other app page, so an app has at most one panel per sidebar. The panel runs under the [Frames](#booqable-interop-frames) rules, can ask for `permissions` like any frame, and needs the same [response headers](#booqable-interop-frames-response-headers).

Panels sit below Booqable's own panels, in alphabetical order by app name. Employees can reorder and collapse panels, so don't rely on your panel's position.

### What the panel receives

```
GET https://my-app.com/panels/order?company_id=…&employee_id=…&locale=en&order_id=…&ts=1798761600&v=1&signature=…
```

Booqable [signs](#booqable-interop-signed-requests) the panel URL each time it loads it, adding:

- **`company_id`**: the company the record belongs to.
- **`employee_id`**: the employee viewing the record.
- **`locale`**: the employee's language.
- **`order_id`**, **`customer_id`** or **`product_group_id`**: the record being viewed, depending on the sidebar.

Verify the signature before showing anything. Booqable only loads the panel once the merchant has authorized and configured your app. Until then the panel says "This app is not set up yet." and links to your app's page in Booqable. If the URL breaks the [frame URL rules](#booqable-interop-frames-frame-urls), it says "This app is unavailable."

### Sizing the panel

```javascript
// in your panel
new ResizeObserver(() => {
  window.parent.postMessage({
    eventName: "SET_IFRAME_HEIGHT",
    payload: { height: Math.ceil(document.documentElement.getBoundingClientRect().height) }
  }, "*")
}).observe(document.documentElement)
```

The panel stays hidden until your page reports its height, so post `SET_IFRAME_HEIGHT` once it loads and again whenever its height changes. Booqable caps the height at 1000 pixels. It's the only message a panel can send.

If no height arrives within 10 seconds, the panel says "This app did not respond." until one does. Panels load even when an employee has collapsed them, and reload with a freshly signed URL when an employee reorders them.

### Staying signed in

A signature is only valid for 5 minutes, so anything that loads your panel's URL again later, such as a link, a form or a reload, needs a session of your own. Verify the signature on the first load, then carry a short-lived token in your URLs: browsers often block cookies in iframes.

Only the signed first load proves `locale` and the record id. Once you've moved on to your own session, treat them as ordinary params.

Panels are shown to every employee who can view the record, but a session started from a panel reaches the rest of your app too. Before showing or changing anything sensitive, check the employee's permissions through the [API](/v4.html#employees). Keep the session token out of URLs you hand to other services, such as a callback URL a merchant pastes into a third-party dashboard.
