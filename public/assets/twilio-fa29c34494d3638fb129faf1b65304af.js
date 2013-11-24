(function() {
  var characterCount, historyTab, messageTab;

  messageTab = function() {
    return $('.message-tab').click(function(e) {
      e.preventDefault();
      $('.market-history').fadeOut(200, function() {
        return $('.market-message').fadeIn();
      });
      $(this).addClass('active');
      return $('.history-tab').removeClass('active');
    });
  };

  historyTab = function() {
    return $('.history-tab').click(function(e) {
      e.preventDefault();
      $('.market-message').fadeOut(200, function() {
        return $('.market-history').fadeIn();
      });
      $(this).addClass('active');
      return $('.message-tab').removeClass('active');
    });
  };

  characterCount = function() {
    $('.text-message-area').keyup(function() {
      var chars;
      chars = $(this).val().length;
      console.log(chars);
      if (chars > 160) {
        return $('.chars-left').text("Character limit exceeded! Message will be cut off after 160 letters.");
      } else {
        return $('.chars-left').text("Characters: " + chars + "/160");
      }
    });
    return $('.text-message-area').keydown(function() {
      var chars;
      chars = $(this).val().length;
      console.log(chars);
      if (chars > 160) {
        return $('.chars-left').text("Character limit exceeded! Message will be cut off after 160 letters.");
      } else {
        return $('.chars-left').text("Characters: " + chars + "/160");
      }
    });
  };

  $(document).ready(function() {
    messageTab();
    historyTab();
    return characterCount();
  });

  $(document).on('page:change', function() {
    messageTab();
    historyTab();
    return characterCount();
  });

}).call(this);
