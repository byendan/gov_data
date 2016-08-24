# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'page:load ready', ->
  $('.datepicker').pickadate
    selectMonths: true
    selectYears: 4
  $('select').material_select()
  return

$(document).on 'ajax:success', (status,data,xhr)->
  if data.module_data is 'no data found'
    $(".picture-area").append '<p>No more pictures</p>'
  else
    for picture in data.module_data
      $(".picture-area").append '<div class="col s3 offset-s1"><img src="' + picture + '" style="width:100%;height:100%;"/></div>'
  return
