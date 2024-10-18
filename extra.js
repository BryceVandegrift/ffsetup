// Extra settings to add on top of Arkenfox

// Disable Firefox updates
user_pref("app.update.auto", false);

// Enable userContent.css:
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);

// Disable Firefox accounts:
user_pref("identity.fxaccounts.enabled", false);

// Disable Pocket:
user_pref("extensions.pocket.enabled", false);

// Disable screenshot extension
user_pref("extensions.screenshots.disabled", true);

// Disable advertisements in the search bar:
user_pref("browser.urlbar.quicksuggest.enabled", false);
user_pref("browser.urlbar.suggest.topsites", false);

// Disable preloading new tabs:
user_pref("browser.newtab.preload", false);

// Disable access to sensors:
user_pref("device.sensors.enabled", false);

// Do not suggest web history in the URL bar:
user_pref("browser.urlbar.suggest.history", false);

// Keep cookies until expiration or user deletion:
user_pref("network.cookie.lifetimePolicy", 0);

// Disable notifications:
user_pref("dom.push.enabled", false);
user_pref("dom.webnotifications.serviceworker.enabled", false);

// Don't autodelete cookies on shutdown:
user_pref("privacy.clearOnShutdown.cookies", false);
user_pref("privacy.clearOnShutdown_v2.cookiesAndStorage", false);

// Disable beacon studies:
user_pref("beacon.enabled", false);

// Enable "Do Not Track":
user_pref("privacy.donottrackheader.enabled", true);
user_pref("privacy.donottrackheader.value", 1);

// Disable signin and autofill info
user_pref("signon.rememberSignons", false);
user_pref("browser.formfill.enable", false);
user_pref("extensions.formautofill.addresses.enabled", false);
user_pref("extensions.formautofill.creditCards.enabled", false);

// Disable Google safebrowsing
user_pref("browser.safebrowsing.malware.enabled", false);
user_pref("browser.safebrowsing.phishing.enabled", false);
user_pref("browser.safebrowsing.blockedURIs.enabled", false);
user_pref("browser.safebrowsing.provider.google4.gethashURL", "");
user_pref("browser.safebrowsing.provider.google4.updateURL", "");
user_pref("browser.safebrowsing.provider.google.gethashURL", "");
user_pref("browser.safebrowsing.provider.google.updateURL", "");
user_pref("browser.safebrowsing.provider.google4.dataSharingURL", "");
user_pref("browser.safebrowsing.downloads.enabled", false);
user_pref("browser.safebrowsing.downloads.remote.url", "");
user_pref("browser.safebrowsing.downloads.remote.block_potentially_unwanted", false);
user_pref("browser.safebrowsing.downloads.remote.block_uncommon", false);
user_pref("browser.safebrowsing.allowOverride", false);

// Disable checking for updates
user_pref("app.update.auto", false);

// Disable feedback reporting
user_pref("browser.chrome.toolbar_tips", false);
user_pref("extensions.abuseReport.enabled", false);

// Disable DNS over HTTPS
user_pref("network.trr.mode", 5);
