
function geocode() {
  var geocoder = new google.maps.Geocoder();
  $(search).bind("ajax:before", function(){
    if (coordinatesField.val() == "" && geocoder){
      geocoder.geocode({'address':search.val()}, (results, status) =>
        if (status == google.maps.GeocoderStatus.OK){
          coordinates.val(results[0].geometry.location);
          alert "coordinates: #{coordinatesField.val()}";
          searchForm.trigger("submit.rails");
        };
      );
        
      return false;
    };
    else{
      return true;
    }
  });
};