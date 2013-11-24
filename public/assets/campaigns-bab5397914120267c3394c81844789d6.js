(function() {
  var campaignTab, feedbackTab, pastCampaignsTab;

  feedbackTab = function() {
    return $('.feedback-tab').click(function(e) {
      var prev;
      e.preventDefault();
      $('.campaigns').fadeOut();
      $('.campaigns-history').fadeOut();
      $('.reviews').fadeIn();
      prev = $('.active');
      $(this).addClass('active');
      return prev.removeClass('active');
    });
  };

  campaignTab = function(e) {
    return $('.campaign-tab').click(function(e) {
      var prev;
      e.preventDefault();
      $('.reviews').fadeOut();
      $('.campaigns-history').fadeOut();
      $('.campaigns').fadeIn();
      prev = $('.active');
      $(this).addClass('active');
      return prev.removeClass('active');
    });
  };

  pastCampaignsTab = function(e) {
    return $('.campaigns-history-tab').click(function(e) {
      var prev;
      e.preventDefault();
      $('.campaigns').fadeOut();
      $('.reviews').fadeOut();
      $('.campaigns-history').fadeIn();
      prev = $('.active');
      $(this).addClass('active');
      return prev.removeClass('active');
    });
  };

  $(document).ready(function() {
    feedbackTab();
    campaignTab();
    return pastCampaignsTab();
  });

  $(document).on("page:change", function() {
    feedbackTab();
    campaignTab();
    return pastCampaignsTab();
  });

}).call(this);
