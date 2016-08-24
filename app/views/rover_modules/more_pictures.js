
alert('javascript is working')
if data.module_data is 'no data found'
  $(".picture-area").append '<p>No more pictures</p>'
else
  for picture in data.module_data
    $(".picture-area").append '<div class="col s3 offset-s1"><img src="' + picture + '" style="width:100%;height:100%;"/></div>'
