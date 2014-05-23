$(document).ready(function() {

  var background_required_words = 50;
  var instruction_required_words = 50;
  var overall_required_words = 200;

  var wordCount = function(text) {
    text = text.replace(/(^\s*)|(\s*$)/gi,"");
    text = text.replace(/[ ]{2,}/gi," ");
    text = text.replace(/\n /,"\n");
    var word_count = text.split(" ").length.toString();
    return word_count;
  }//end of function

  var getText = function(textbox) {
    var text = $(textbox).val();
    return text;
  }

  var displayWordCount = function(text_area_id, word_count_id) {
    var text = getText(text_area_id);
    var word_count = wordCount(text);
    $(word_count_id).text("Word Count: " + word_count);
  }

  var hasRequiredWords = function(text_area_id, required_words) {
    var text = getText(text_area_id)
    if (wordCount(text) >= required_words) {
      return true
    } else {
      return false
    }
  }

  var changeFontColor = function(text_area_id, word_count_id, required_words) {
    if (hasRequiredWords(text_area_id, required_words)) {
      $(word_count_id).css("color", "black")
    } else {
      $(word_count_id).css("color", "red")
    }
  }

  var wordCounter = function(text_area_id, word_count_id, required_words) {
    $(text_area_id).keyup(function() {
      displayWordCount(text_area_id, word_count_id)
      changeFontColor(text_area_id, word_count_id, required_words)
    });
  }

  var displayErrors = function(text_area_id, error_id, word_count) {
    if (!hasRequiredWords(text_area_id, word_count)) {
      $(error_id).css("color", "red").text("You must have the required words.")
      return 0
    }
    else {
      $(error_id).text("")
      return 1
    }
  }
  
  wordCounter("#background", "#background-wordcount", background_required_words);
  wordCounter("#instruction", "#instruction-wordcount", instruction_required_words);
  wordCounter("#overall", "#overall-wordcount", overall_required_words);


  $("#review_form").submit(
    function(event) {
      errors = 0;
      errors = errors + displayErrors("#background", "#background-error", background_required_words);
      errors = errors + displayErrors("#instruction", "#instruction-error", instruction_required_words);
      errors = errors + displayErrors("#overall", "#overall-error", overall_required_words);
      
      if (errors < 3) {
        event.preventDefault();
      }
    }

  ); //end of submit 

}); //end document.ready