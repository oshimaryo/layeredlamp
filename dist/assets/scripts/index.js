var append_value, base_url, post_positions, timers;

base_url = "http://www.example.com/patterns/0/scenes/";

timers = [];

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
  return $(document).on("click touch", ".play-btn", function(event) {
    var class_name, target, timer, _i, _len, _results;
    target = $(event.target);
    class_name = "is-playing";
    if (target.hasClass(class_name)) {
      target.removeClass(class_name);
      _results = [];
      for (_i = 0, _len = timers.length; _i < _len; _i++) {
        timer = timers[_i];
        _results.push(clearTimeout(timer));
      }
      return _results;
    } else {
      target.addClass(class_name);
      return post_positions(0);
    }
  });
});

post_positions = function(i) {
  var c_p, checked_duration, checked_positions, duration, post_url, scene, scenes, val, _i, _len;
  scenes = $(".scenes .scene");
  scene = $(scenes[i]);
  post_url = scene.find(".scene-form").attr("action");
  checked_duration = scene.find(".duration.checked");
  duration = checked_duration.find(".val")[0].innerText;
  checked_positions = scene.find(".layer .checked .position");
  val = [];
  for (_i = 0, _len = checked_positions.length; _i < _len; _i++) {
    c_p = checked_positions[_i];
    append_value(val, c_p);
  }
  console.log("l_0:" + val[0] + ", l_1:" + val[1] + ", l_2:" + val[2] + ", l_3:" + val[3] + ", l_4:" + val[4]);
  if (i > scenes.length - 2) {
    i = 0;
  } else {
    i++;
  }
  console.log(duration * 33);
  return timers.push(setTimeout(function() {
    return post_positions(i);
  }, duration * 33));
};

append_value = function(array, position) {
  return array.push($(position).attr("value"));
};
