// Extra settings to add on top of Arkenfox

// Enable userContent.css:
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);

// Diable Firefox accounts:
user_pref("identity.fxaccounts.enabled", false);

// Disable Pocket:
user_pref("extensions.pocket.enabled", false);

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
