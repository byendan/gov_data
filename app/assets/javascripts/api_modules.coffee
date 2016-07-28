# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
add_options = ->
  $new_options = $("<div class='row'></div>")
  key = $("#options-key").val()
  value = $("#options-value").val()
  
  $new_options.html '<div class="col s4"><input value="' + key + '" /></div><div class="col s4"><input name="api_module[options][' + key + ']" value="' + value + '" /></div>'
  $("#added-options").append($new_options)

  $("#options-key").val('')
  $("#options-value").val('')
  return


$(document).ready ->
  $('select').material_select()
  $('#add-options-button').click add_options
  return
