$(function() {
  
  function setDevice(device) {
    deviceNs = device ? "device--" + device : "";
    containerNs = device ? "container--" + device : "";
    $(".device").removeClass().addClass("device " + deviceNs);
    $(".container").removeClass().addClass("container " + containerNs);
  };
  
  $(".nav").on("click", "a", function(e) {
    e.preventDefault();
    setDevice($(e.target).data("device"));
  });
  
  $(window).on("keyup", function(e) {
    switch(e.keyCode) {
      case 49 :
        setDevice();
        break;
      case 51 :
        setDevice("ipad");
        break;
    }
  });
  
});
