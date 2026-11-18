## Frames

Booqable shows your app's pages in iframes: [embedded pages](#capabilities-embedded-pages) (including a `configuration_page.iframe`), [sidebar frames](#capabilities-sidebar-frames), and [theme block settings](#capabilities-theme-blocks-settings-frame). Every one of them runs under the rules below.

### Sandbox

Every frame is sandboxed. Scripts, forms and popups work, and the page keeps its own origin. The main things that don't:

- **Native dialogs.** `alert()`, `confirm()` and `prompt()` are blocked, and `confirm()` always returns `false`. Show your own dialog inside the page instead, such as a `<dialog>` element.
- **Navigating Booqable's tab.** A link or form with `target="_top"` is blocked. An embedded page can send Booqable to one of its own pages with the `NAVIGATE` message.

Popups aren't sandboxed, so run flows that need a whole tab, such as connecting a third-party account with OAuth, in a popup. When the flow ends, close the popup and refresh your frame.

### Browser features

```jsonc
// booqable.json
{
  "configuration_page": {
    "iframe": {
      "url": { "relative": "/settings" },
      "permissions": ["clipboard-write"]
    }
  }
}
```

Frames can't use the camera, microphone, geolocation, payments, screen capture, USB devices or fullscreen, and can't write to the clipboard. A frame that needs clipboard writes, for a copy button, asks for it with `permissions`, as in the example.

`clipboard-write` is the only feature a frame can ask for on any [`Frame`](#reference-frame) (for now). Theme block settings frames can't ask for it. Some browsers refuse clipboard writes in frames anyway, so fall back to `document.execCommand("copy")`, and only tell the user it was copied when a copy really happened.

### Referrer

Frames load without a referrer: your pages get no `Referer` header, and `document.referrer` is empty.

### Response headers

```
Content-Security-Policy: frame-ancestors https://*.booqable.com
Referrer-Policy: no-referrer
```

Send these headers with every page Booqable embeds, so only Booqable can embed it and a signed URL doesn't leak to the sites your page links to. Keep `signature` and any session token of yours out of your logs.

### Frame URLs

Booqable shows "This app is unavailable." instead of a frame it won't load. A frame URL must use `https`, have a plain ASCII host (use punycode for other characters), and have no credentials or fragment. It can't point at the merchant's own Booqable back office, and a [signed](#booqable-interop-signed-requests) frame URL can't already contain a param Booqable adds.

### Messages

```javascript
// in your frame
window.parent.postMessage({
  eventName: "SET_IFRAME_HEIGHT",
  payload: { height: 320 }
}, "*")
```

A frame talks to Booqable with `window.parent.postMessage`. Each kind of frame accepts its own messages:

- **Embedded pages**: `SET_IFRAME_HEIGHT`, `SET_FLASH_MESSAGE`, `REFRESH_SUBSCRIPTION`, `GET_AVATAR` and `NAVIGATE`, described in [Message protocol](#capabilities-embedded-pages-message-protocol).
- **Sidebar frames**: `SET_IFRAME_HEIGHT` only, described in [Sizing the panel](#capabilities-sidebar-frames-sizing-the-panel).
- **Theme block settings**: `SET_APP_BLOCK_SETTINGS` and `REFRESH_PAGE_PREVIEW`, described in [Settings frame](#capabilities-theme-blocks-settings-frame).

Booqable ignores, without an error:

- a message that isn't an object of the form `{ eventName, payload }`, such as a JSON string
- a message from any window other than the frame itself
- a message from an origin other than the origin of the frame's URL, for example after the frame redirected to another domain
