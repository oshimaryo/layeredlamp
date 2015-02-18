base_url =　"http://www.example.com/patterns/0/scenes/"

$ ->
  $(document).on "click touch", ".btn", (event) ->
    target = $(this)
    if(target.hasClass "checked")
      console.log "already"
    else
      previous_column = target.siblings ".checked"
      previous_column.removeClass "checked"
      previous_position = previous_column.find ".position"
      previous_position.removeAttr "checked"
      target.addClass "checked"
      current_layer = target.closest(".layer")
      radio = target.find ".position"
      name = radio.attr "name"
      value = radio.attr "value"
      selector = ".position[name='" + name + "']"
      current_layer.find(selector).val [value]
      target_radio = current_layer.find(selector)[value]
      $(target_radio).attr "checked", "checked"
      event.preventDefault()
      submit_btn = target.closest(".scene-form").find ".submit"
      # submit_btn.click()

  $(document).on "click touch", ".duration", (event) ->
    target = $(this)
    if(target.hasClass "checked")
      console.log "already"
    else
      previous_column = target.siblings ".checked"
      previous_column.removeClass "checked"
      target.addClass "checked"
      current_durations = target.closest(".durations")
      event.preventDefault()

  $(document).on "click touch", ".add-btn", (event) ->
    scene_template = $(".template").find ".scene"
    new_scene = scene_template.clone()
    new_form = new_scene.find "form"
    scenes_length = $(".scenes .scene").length
    new_url = base_url + scenes_length
    new_form.attr "action", new_url
    $(".scenes").append new_scene

  $(document).on "ajax:error", ".scene-form", (event, xhr, status, error) ->
    alert error.message
    event.preventDefault()

  $(document).on "click touch", ".play-btn", (event) ->
    #TODO
