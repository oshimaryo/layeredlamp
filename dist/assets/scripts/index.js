var base_url;

base_url = "http://www.example.com/patterns/0/scenes/";

$(function() {
  $(document).on("click touch", ".btn", function(event) {
    var current_layer, name, previous_column, previous_position, radio, selector, submit_btn, target, target_radio, value;
    target = $(this);
    if (target.hasClass("checked")) {
      return console.log("already");
    } else {
      previous_column = target.siblings(".checked");
      previous_column.removeClass("checked");
      previous_position = previous_column.find(".position");
      previous_position.removeAttr("checked");
      target.addClass("checked");
      current_layer = target.closest(".layer");
      radio = target.find(".position");
      name = radio.attr("name");
      value = radio.attr("value");
      selector = ".position[name='" + name + "']";
      current_layer.find(selector).val([value]);
      target_radio = current_layer.find(selector)[value];
      $(target_radio).attr("checked", "checked");
      event.preventDefault();
      return submit_btn = target.closest(".scene-form").find(".submit");
    }
  });
  $(document).on("click touch", ".duration", function(event) {
    var current_durations, previous_column, target;
    target = $(this);
    if (target.hasClass("checked")) {
      return console.log("already");
    } else {
      previous_column = target.siblings(".checked");
      previous_column.removeClass("checked");
      target.addClass("checked");
      current_durations = target.closest(".durations");
      return event.preventDefault();
    }
  });
  $(document).on("click touch", ".add-btn", function(event) {
    var new_form, new_scene, new_url, scene_template, scenes_length;
    scene_template = $(".template").find(".scene");
    new_scene = scene_template.clone();
    new_form = new_scene.find("form");
    scenes_length = $(".scenes .scene").length;
    new_url = base_url + scenes_length;
    new_form.attr("action", new_url);
    return $(".scenes").append(new_scene);
  });
  $(document).on("ajax:error", ".scene-form", function(event, xhr, status, error) {
    alert(error.message);
    return event.preventDefault();
  });
  return $(document).on("click touch", ".play-btn", function(event) {});
});
