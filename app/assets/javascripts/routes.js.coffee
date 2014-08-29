# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

map = L.map('map').setView [18.769, 98.9569], 13
gpx = $('#track').data('url')

L.tileLayer("http://{s}.tiles.mapbox.com/v3/paul-ylz.jc2nmmhf/{z}/{x}/{y}.png",
  attribution: "Map data &copy; <a href=\"http://openstreetmap.org\">OpenStreetMap</a> contributors, <a href=\"http://creativecommons.org/licenses/by-sa/2.0/\">CC-BY-SA</a>, Imagery © <a href=\"http://mapbox.com\">Mapbox</a>"
  maxZoom: 18
).addTo map

new L.GPX(gpx,
  async: true
).on("loaded", (e) ->
  map.fitBounds e.target.getBounds()
  return
).addTo map
