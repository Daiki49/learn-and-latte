/**
 * @license
 * Copyright 2019 Google LLC. All Rights Reserved.
 * SPDX-License-Identifier: Apache-2.0
 */
// [START maps_add_map]
// Initialize and add the map
let map;

async function initMap() {
  // [START maps_add_map_instantiate_map]
  // The location of Shinjuku Station
  const position = { lat: 35.68978920591743, lng: 139.70055989948156 };
  // Request needed libraries.
  //@ts-ignore
  const { Map } = await google.maps.importLibrary("maps");
  const { AdvancedMarkerElement, PinElement } = await google.maps.importLibrary("marker");

  // The map, centered at Shinjuku Station
  map = new Map(document.getElementById("map"), {
    zoom: 16,
    center: position,
    mapId: "DEMO_MAP_ID",
  });

  // [END maps_add_map_instantiate_map]
  // [START maps_add_map_instantiate_marker]
  // The marker, positioned at Shinjuku Station
  const marker = new google.maps.marker.AdvancedMarkerElement({
    map: map,
    position: position,
    title: "Shinjuku Station",
  });
  // [END maps_add_map_instantiate_marker]
}

initMap();
// [END maps_add_map]
