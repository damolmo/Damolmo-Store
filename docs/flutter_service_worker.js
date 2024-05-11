'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"index.html": "369d32c36414547c534f810004031995",
"/": "369d32c36414547c534f810004031995",
"main.dart.js": "79a8fa5b83e7d3df6f13330ae4e982b1",
"version.json": "33b8dbd2fcbd32d53e1ea90709d382ec",
"sqlite3.wasm": "f08450f1d5a088a01cec0eb541c3aeca",
"icons/Icon-maskable-512.png": "b449724c6dfb0bb339c9358ef8be8121",
"icons/Icon-192.png": "64419e369cd9260c49992e6bed661657",
"icons/Icon-512.png": "b449724c6dfb0bb339c9358ef8be8121",
"icons/Icon-maskable-192.png": "64419e369cd9260c49992e6bed661657",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03",
"canvaskit/skwasm.js.symbols": "741d50ffba71f89345996b0aa8426af8",
"canvaskit/skwasm.js": "445e9e400085faead4493be2224d95aa",
"canvaskit/chromium/canvaskit.js.symbols": "4525682ef039faeb11f24f37436dca06",
"canvaskit/chromium/canvaskit.wasm": "f5934e694f12929ed56a671617acd254",
"canvaskit/chromium/canvaskit.js": "43787ac5098c648979c27c13c6f804c3",
"canvaskit/canvaskit.js.symbols": "38cba9233b92472a36ff011dc21c2c9f",
"canvaskit/canvaskit.wasm": "3d2a2d663e8c5111ac61a46367f751ac",
"canvaskit/canvaskit.js": "c86fbd9e7b17accae76e5ad116583dc4",
"canvaskit/skwasm.wasm": "e42815763c5d05bba43f9d0337fa7d84",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "b93248a553f9e8bc17f1065929d5934b",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin.json": "770dd9181e5048741c711395ecd0e9c2",
"assets/NOTICES": "7cbc0db43713329da9dd505257c5af78",
"assets/AssetManifest.bin": "b4d9da0301dfe8310368c28b3d9deed4",
"assets/assets/sounds/theme.mp3": "afa090afd7ca27921745326db9f84c86",
"assets/assets/logo/logo.png": "921e0a2daedf83e836c2c9239eb684a7",
"assets/assets/apps/message_direct/screens/screen_0.png": "0a643a872c0e2c5302b414bf21ce2692",
"assets/assets/apps/message_direct/screens/screen_4.png": "e98b1cdd07db2cf5c9b8e793da6726ea",
"assets/assets/apps/message_direct/screens/screen_2.png": "43f994b91278cab20a5f1cc1c437a0d8",
"assets/assets/apps/message_direct/screens/screen_1.png": "2e5ea3882f49e98e538a6bddfd9867ae",
"assets/assets/apps/message_direct/screens/screen_3.png": "2b0f81ebb2f09504f7087094909d27dd",
"assets/assets/apps/message_direct/banner.png": "fba39006270d35703c9a05c6cdcfd7cc",
"assets/assets/apps/message_direct/logo.png": "5ffa02f3494c833d581f1f2dffe952b7",
"assets/assets/apps/damolmo_store/screens/screen_0.png": "a02082169a84ef9d14ec0bda9e2cd830",
"assets/assets/apps/damolmo_store/screens/screen_4.png": "fbf6e313d4cbe2cbb320d04a08f70c90",
"assets/assets/apps/damolmo_store/screens/screen_2.png": "2986d1f9d09f4b1513dc8c1faf972ee9",
"assets/assets/apps/damolmo_store/screens/screen_1.png": "3b60fa2abbe78cf81f449fea68f0e474",
"assets/assets/apps/damolmo_store/screens/screen_5.png": "8d8cb23c3fa88aa599c448de442d467c",
"assets/assets/apps/damolmo_store/screens/screen_3.png": "d95ccb1910a5f083a94afc3cd78fd0f9",
"assets/assets/apps/damolmo_store/banner.png": "29229f8ba68effd31b1cb65310e3bec9",
"assets/assets/apps/damolmo_store/logo.png": "921e0a2daedf83e836c2c9239eb684a7",
"assets/assets/apps/animal_crossing_clock/screens/screen_0.png": "8a47517cf47ee51b14afaeceda951167",
"assets/assets/apps/animal_crossing_clock/screens/screen_6.png": "6c7a783c1b286f4deffba6fe6148d5ce",
"assets/assets/apps/animal_crossing_clock/screens/screen_4.png": "2ef33316721c15c412c597fdcacd58bd",
"assets/assets/apps/animal_crossing_clock/screens/screen_2.png": "39d29547669cf9a4a301dd3a3407ad4b",
"assets/assets/apps/animal_crossing_clock/screens/screen_7.png": "7cee7d89616105276d621860a948e421",
"assets/assets/apps/animal_crossing_clock/screens/screen_1.png": "af4fef86e3de89de318e588395f73a19",
"assets/assets/apps/animal_crossing_clock/screens/screen_5.png": "4cb0c6e29e73a87e261b13d569140b6e",
"assets/assets/apps/animal_crossing_clock/screens/screen_3.png": "d4d45c9e12137a34ec3c306e3c5c68e3",
"assets/assets/apps/animal_crossing_clock/banner.png": "dae34118fd0f25ab27360b53e863695c",
"assets/assets/apps/animal_crossing_clock/logo.png": "b78d2c1dbd54b4487818213455c68a1c",
"assets/assets/apps/horizon/screens/screen_6.png": "a220b3873a4206a34f96cd4a95567248",
"assets/assets/apps/horizon/screens/screen_4.png": "f3e721bd053d6843fe5f9e9c53b733cd",
"assets/assets/apps/horizon/screens/screen_2.png": "6dd02f506a4cf057a93590eb789fdce2",
"assets/assets/apps/horizon/screens/screen_1.png": "ec87389c00b008d25411e89388cf9344",
"assets/assets/apps/horizon/screens/screen_5.png": "4c627dd42cea1512200b9e88a8043945",
"assets/assets/apps/horizon/screens/screen_3.png": "6d1518f9a8aa55db05ed9113c33fb8fa",
"assets/assets/apps/horizon/banner.png": "0f175b8b02d5e36d5cba30b2999859f1",
"assets/assets/apps/horizon/logo.png": "bcfb6bdff11b928619016f3876decbc7",
"assets/assets/apps/fast_notes/banner.png": "5d21ea0853a5b267e59fce80f6ae5596",
"assets/assets/apps/fast_notes/logo.png": "b5abbce975157f0c733548521f927c82",
"assets/assets/apps/cards_pocket/screens/screen_11.png": "f12f43e9bea4df83a4dbcffb62861514",
"assets/assets/apps/cards_pocket/screens/screen_0.png": "f90812f5add104dfc960a15ade522db7",
"assets/assets/apps/cards_pocket/screens/screen_6.png": "57ae24b19d53cf37bf57a5fbedd9fd62",
"assets/assets/apps/cards_pocket/screens/screen_4.png": "72b7f56d9c47d8e4f3a091eaa5252f97",
"assets/assets/apps/cards_pocket/screens/screen_2.png": "8a05f58523002ae073452794d924756a",
"assets/assets/apps/cards_pocket/screens/screen_7.png": "5f671e6e5a93d64ebb0a2ef787fb26b0",
"assets/assets/apps/cards_pocket/screens/screen_8.png": "0f060ef444e752ac5ea03d22990e4e83",
"assets/assets/apps/cards_pocket/screens/screen_1.png": "3ae26f484d57cff3860d07744b085dc1",
"assets/assets/apps/cards_pocket/screens/screen_9.png": "52d54f8725ef3d25b194a012a910ff2b",
"assets/assets/apps/cards_pocket/screens/screen_10.png": "fec9cd0271b60986be1fd9623b1f9bbd",
"assets/assets/apps/cards_pocket/screens/screen_5.png": "a35c29cc240fadc14860126ac3dcf796",
"assets/assets/apps/cards_pocket/screens/screen_3.png": "28d84c4642baeb182566c9a9ef1bad3a",
"assets/assets/apps/cards_pocket/banner.png": "4c2c7879e5c1f80382011ccb44dccab1",
"assets/assets/apps/cards_pocket/logo.png": "43ff4347809f57ca20de20030eedf4fe",
"assets/assets/apps/material_downloader/screens/screen_0.png": "37f40018b282d0ca95c29ea33df56f83",
"assets/assets/apps/material_downloader/screens/screen_2.png": "25e414d1419272423719aa051bdf97c6",
"assets/assets/apps/material_downloader/screens/screen_1.png": "b79a6e175f3b3706624ac5793ed081bc",
"assets/assets/apps/material_downloader/banner.png": "d28f12d5d13878551878303154ed2d90",
"assets/assets/apps/material_downloader/logo.png": "1b011bd289af734a1eba38160a090e1f",
"assets/assets/apps/animal_crossing_radio/screens/screen_12.png": "d67b6ab69a35a535ebd8fbeeb3f9de04",
"assets/assets/apps/animal_crossing_radio/screens/screen_16.png": "56ed51ab6a1b22e530beac1ee737d94f",
"assets/assets/apps/animal_crossing_radio/screens/screen_11.png": "d6352d96ed443d13ad7803c94a8a991a",
"assets/assets/apps/animal_crossing_radio/screens/screen_0.png": "f2db00617493d48b76551b3c7c8c8064",
"assets/assets/apps/animal_crossing_radio/screens/screen_13.png": "1717d55874ceb275a1eb4e88fd97d5fa",
"assets/assets/apps/animal_crossing_radio/screens/screen_6.png": "3739ec2435c55234c85b75cd58d99cfd",
"assets/assets/apps/animal_crossing_radio/screens/screen_4.png": "3e51d46ed7335323ee54d07f186ed122",
"assets/assets/apps/animal_crossing_radio/screens/screen_14.png": "bc2cc5259b5548ee8da2bb194c7a27a3",
"assets/assets/apps/animal_crossing_radio/screens/screen_2.png": "d6d8f0df63e5e4cb1c007717b414e8aa",
"assets/assets/apps/animal_crossing_radio/screens/screen_15.png": "da67f9343e8dea12a3fd0f43a797cce8",
"assets/assets/apps/animal_crossing_radio/screens/screen_7.png": "6483aff99e7d67efdca0a264b9cfc3a7",
"assets/assets/apps/animal_crossing_radio/screens/screen_8.png": "bfc3b052715c4f6b526cfda3e5a4b0ee",
"assets/assets/apps/animal_crossing_radio/screens/screen_1.png": "33124197dec8e5c3483f57e5a5f63efc",
"assets/assets/apps/animal_crossing_radio/screens/screen_9.png": "9c7c79742ec4f5239521f1e488213ab4",
"assets/assets/apps/animal_crossing_radio/screens/screen_10.png": "69047e0bc729b38eb43e1f14cf26aa39",
"assets/assets/apps/animal_crossing_radio/screens/screen_5.png": "3a330a1c3bca53ece7f643b16a59b9dd",
"assets/assets/apps/animal_crossing_radio/screens/screen_3.png": "a9428294411daf123616e9338a720234",
"assets/assets/apps/animal_crossing_radio/banner.png": "00efb30116c4f6c7e4067e770e612d7f",
"assets/assets/apps/animal_crossing_radio/logo.png": "641c41699d1fea2e2c9bfd89b5b5a59b",
"assets/assets/apps/whatsapp_direct/screens/screen_0.png": "a3977d55c8748f3b4b5cb6f533f1935f",
"assets/assets/apps/whatsapp_direct/screens/screen_2.png": "eea2cb36331533051cec878ea4f259f4",
"assets/assets/apps/whatsapp_direct/screens/screen_1.png": "e205a74721f5d515576ea92e52b36797",
"assets/assets/apps/whatsapp_direct/banner.png": "3015ef0d0d4dc8e53ada2921d2b65211",
"assets/assets/apps/whatsapp_direct/logo.png": "aa1e36508a60131c05cc3b9f19524c14",
"assets/assets/apps/material_dialer/screens/screen_6.png": "2721b7244931d7acd4c2c1572ecbe950",
"assets/assets/apps/material_dialer/screens/screen_4.png": "b5352e71d921979404431e4394fafa42",
"assets/assets/apps/material_dialer/screens/screen_2.png": "cdd6c4a91cf9edbf3004610eeea53803",
"assets/assets/apps/material_dialer/screens/screen_7.png": "fda5a707dda3683d3a6839dd1b3273ce",
"assets/assets/apps/material_dialer/screens/screen_8.png": "99bf8ca83277e353df3d1a717732cacc",
"assets/assets/apps/material_dialer/screens/screen_1.png": "1ce9ef0de608279cc3d7bba89b4aef03",
"assets/assets/apps/material_dialer/screens/screen_5.png": "dba8036ef5086e5cfbb5ae350418ecb0",
"assets/assets/apps/material_dialer/screens/screen_3.png": "ca4e28353b15f2665384f2132c51870e",
"assets/assets/apps/material_dialer/banner.png": "e6999d6246c9e99d2ba1bdce0ddba6be",
"assets/assets/apps/material_dialer/logo.png": "d28f6015c006a06cb010fedcbf66a054",
"assets/assets/apps/shoppy_go/screens/screen_6.png": "360b0df6913c0cf5a5624530fbb9f2c2",
"assets/assets/apps/shoppy_go/screens/screen_4.png": "f18a202b64df81f6578151d5ee6887ae",
"assets/assets/apps/shoppy_go/screens/screen_2.png": "0583c344999a28a24c81812b202f2c06",
"assets/assets/apps/shoppy_go/screens/screen_7.png": "faa0b6ad1c373f6dbb221a20fef57597",
"assets/assets/apps/shoppy_go/screens/screen_8.png": "3ce2cb44315bd630c9cccb5a71572533",
"assets/assets/apps/shoppy_go/screens/screen_1.png": "5e0037c5a53d8ca60a489771be7b2e5c",
"assets/assets/apps/shoppy_go/screens/screen_5.png": "a1a6c7827ccb7f00ae53f14f18970bd8",
"assets/assets/apps/shoppy_go/screens/screen_3.png": "268759d0a027e88b757ba0386105fc9f",
"assets/assets/apps/shoppy_go/banner.png": "dbabb12963532f3049e1560e849f72ef",
"assets/assets/apps/shoppy_go/logo.png": "724e3b4764dfa5218b9713a9c560809a",
"assets/fonts/MaterialIcons-Regular.otf": "e7069dfd19b331be16bed984668fe080",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/AssetManifest.json": "3fac9fa54a5a458c00a428261409d466",
"sqflite_sw.js": "8d894780f6ae7c7da7ae1e259e6d240d",
"favicon.png": "2c9a822751007e58c7ffeb870abfb3b6",
"manifest.json": "fece5dc15ad360f26c44191ad2b7e056",
"flutter.js": "c71a09214cb6f5f8996a531350400a9a"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"assets/AssetManifest.bin.json",
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
        // Claim client to enable caching on first launch
        self.clients.claim();
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
      // Claim client to enable caching on first launch
      self.clients.claim();
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
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
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
