// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import './custom/googlemap'

const KEY = gon.google_maps_api_key;
