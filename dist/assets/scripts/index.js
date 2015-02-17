$(function() {
  $(document).on("click", ".btn", function(event) {
    var current_layer, name, previous_column, radio, selector, target, value;
    target = $(this);
    if (target.hasClass("checked")) {
      return console.log("already");
    } else {
      previous_column = target.siblings(".checked");
      previous_column.removeClass("checked");
      target.addClass("checked");
      current_layer = target.closest("ul");
      radio = target.find(".position");
      name = radio.attr("name");
      value = radio.attr("value");
      selector = ".position[name='" + name + "']";
      return current_layer.find(selector).val([value]);
    }
  });
  return $(document).on("click", ".add-btn", function(event) {
    var new_scene, scene_template;
    scene_template = $(".template").find(".scene");
    new_scene = scene_template.clone();
    return $(".scenes").append(new_scene);
  });
});
