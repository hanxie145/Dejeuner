(function() {
  var myFunct;

  myFunct = function() {
    $('.dash-quick-link').on('mouseenter', function() {
      return $('img', this).stop().animate({
        "margin-left": "60px"
      }, 200, 'linear');
    });
    $('.dash-quick-link').on('mouseleave', function() {
      return $('img', this).stop().animate({
        "margin-left": "0px"
      }, 200, 'linear');
    });
    $('.restaurant-quick-link').click(function(e) {
      e.preventDefault();
      return window.location.href = "/profile";
    });
    $('.reviews-quick-link').click(function(e) {
      e.preventDefault();
      return window.location.href = "/reviews";
    });
    return $('marketing-quick-link').click(function(e) {
      e.preventDefault();
      return window.location.href = '/market';
    });
  };

  $(document).ready(function() {
    return myFunct();
  });

  $(document).on("page:change", function() {
    return myFunct();
  });

}).call(this);
