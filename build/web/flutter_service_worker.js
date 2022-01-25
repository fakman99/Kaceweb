'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "icons/Icon-512.png": "dbc06ae031ed607772c21020013a1329",
"icons/Icon-192.png": "58eaabe58d5bf71fc13314bed131fc13",
"manifest.json": "f694b3b6526fcf603461c22e62779db7",
"favicon.png": "8fa786b3deaae6134e90698e45c53212",
"favicon.ico": "b9fd6528743eb2f8412206eb16321e8e",
"assets/fonts/MaterialIcons-Regular.otf": "4e6447691c9509f7acdbf8a931a85ca1",
"assets/AssetManifest.json": "2218f7e01f213b9bc5f77f17229a43f4",
"assets/NOTICES": "ae1c355b99edc717f1719a13c824f6ad",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"assets/packages/share_everywhere/icons/linkedin.png": "30c453b7f5fbdb09ea0cb42a5dc7a6e5",
"assets/packages/share_everywhere/icons/facebook.png": "c22a4ee32b54d42a6f5599a866b84ba8",
"assets/packages/share_everywhere/icons/twitter.png": "a4dfaf020789cbf745fa5c916e3a107e",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/assets/commun_toutes_pages/logo_g%25C3%25A9n%25C3%25A9ral/logo_lettre_K.png": "a74064ac465fcddffc1614988c187001",
"assets/assets/commun_toutes_pages/logo_g%25C3%25A9n%25C3%25A9ral/logo_lettre_K.svg": "481ac1321310cd7addb812ecc4e02200",
"assets/assets/commun_toutes_pages/logo_g%25C3%25A9n%25C3%25A9ral/logo_nom_kac%25C3%25A9.svg": "9b54b70543de7d246f05cb91cf13465f",
"assets/assets/commun_toutes_pages/logos_contact/logo_insta_rose.png": "2c295bbf26a4ee20459afc11079a81ea",
"assets/assets/commun_toutes_pages/logos_contact/logo_mail_noir.png": "ae879d0c55b1396edbc81978683c0549",
"assets/assets/commun_toutes_pages/logos_contact/logo_mail_rose.png": "ed31d994514bcb8e7965d8f93fb71923",
"assets/assets/commun_toutes_pages/logos_contact/logo_insta_noir.png": "fbf60a58c6b634624aa820ef8ceaf44c",
"assets/assets/homepage/design_T-shirt_final.png": "b77772d1096a227be669d6aba0fdf68a",
"assets/assets/homepage/mockup.png": "6cb19f1024dc6eef9036079bb88c0f96",
"assets/assets/homepage/mock_up_T-shirt.svg": "1b1e0e6197ed6142e7d890e9d0a2552e",
"assets/assets/homepage/design_T-shirt_front.png": "c5954e73ccea44440b66081519953664",
"main.dart.js": "422a111b304de8f57dcbae1b7ce07325",
"index.html": "8529f68c8403a5bf231449a9c235ee92",
"/": "8529f68c8403a5bf231449a9c235ee92",
"version.json": "8a6e79b3e1398aa369fa8850e8439148"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "/",
"main.dart.js",
"index.html",
"assets/NOTICES",
"assets/AssetManifest.json",
"assets/FontManifest.json"];
// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});

// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});

// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache.
        return response || fetch(event.request).then((response) => {
          cache.put(event.request, response.clone());
          return response;
        });
      })
    })
  );
});

self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});

// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}

// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
