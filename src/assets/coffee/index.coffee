$ ->
  $(document).on "click", ".btn", (event) ->
    target = $(this)
    if(target.hasClass "checked")
      console.log "already"
    else
      previous_column = target.siblings ".checked"
      previous_column.removeClass "checked"
      target.addClass "checked"
      current_layer = target.closest("ul")
      radio = target.find ".position"
      name = radio.attr "name"
      value = radio.attr "value"
      selector = ".position[name='" + name + "']"
      current_layer.find(selector).val [value]

      # TODO: fire ajax post

  $(document).on "click", ".add-btn", (event) ->
    scene_template = $(".template").find ".scene"
    new_scene = scene_template.clone()
    $(".scenes").append new_scene
