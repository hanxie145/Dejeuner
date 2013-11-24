(function() {
  var alertFadeOut;

  alertFadeOut = function() {
    return $(".alert").fadeOut(3000);
  };

  $(document).ready(function() {
    return alertFadeOut();
  });

  $(document).on("page:change", function() {
    return alertFadeOut();
  });

}).call(this);
