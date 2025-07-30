## App Store

The Booqable App Store is the first place where users will meet your app. App authors can provide an app title, description and images to control how the app is displayed in the store.

<figure>
  <img src="/images/apps/app-store-listings.png" alt="App store listings" style="max-width: 100%;">
  <figcaption>
    How apps are displayed in the app store listings page.
  </figcaption>
</figure>

If a user clicks on your app listing, they will be taken to the app store detail page.

<figure>
  <img src="/images/apps/app-store-detail-page.png" alt="Example of an app detail page in the Booqable App Store" style="max-width: 100%;">
  <figcaption>
    Example of how your app might look in the app store detail page.
  </figcaption>
</figure>

And when users choose to install your app, they are guided through the installation process.

<figure>
  <img src="/images/apps/app-install-step-1.png" alt="Step 1: Choose app plan" style="max-width: 100%;">
  <figcaption>
    <strong>Step 1:</strong> The user chooses the app plan they want to install.
  </figcaption>
</figure>

<figure>
  <img src="/images/apps/app-install-step-2.png" alt="Step 2: Review and confirm" style="max-width: 100%;">
  <figcaption>
    <strong>Step 2:</strong> The user reviews the app plan and confirms the installation.
  </figcaption>
</figure>

The full list of customizable app store elements is:

* **Title:** The title of your app and it is displayed in several spots throughout the app store and the Booqable UI. Configured in [locale files](#TODO).
* **Author:** A byline for the app. It's displayed mainly in the app store. Configured in [`meta.json`](#TODO).
* **Banner:** A banner image to make your app stand out in the app store listings. Configured in [`meta.json`](#TODO).
* **Icon:** A small icon to represent your app in the app store and few other places in the Booqable UI. Configured in [`meta.json`](#TODO).
* **Synopsis:** A short summary of your app, mainly for users to quickly understand what the app does when browsing the app store. Configured in [locale files](#TODO).
* **Description:** Your app's description is displayed in the app store detail page, after users clicked through from the app store listings. Configured in [locale files](#TODO).

Additionally, each app plan has its own set of customizable elements:

* **Title:** The title of the plan. Configured in [locale files](#TODO).
* **Description:** The description of the plan. Configured in [locale files](#TODO).
* **Features:** A list of the plan's key features. Configured in [locale files](#TODO).

TODO some apps have an extra step right after installation for asking permissions.
