base_url =　"http://www.example.com/patterns/0/scenes/"
timers = []

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
      # post
      # submit_btn.click()

  $(document).on "click touch", ".duration", (event) ->
    target = $(this)
    if(target.hasClass "checked")
      console.log "already"
    else
      previous_column = target.siblings ".checked"
      previous_column.removeClass "checked"
      previous_time = previous_column.find ".time"
      previous_time.removeAttr "checked"
      target.addClass "checked"
      radio = target.find ".time"
      name = radio.attr "name"
      value = radio.attr "value"
      selector = ".time[name='" + name + "']"
      console.log selector
      current_durations = target.closest ".durations"
      current_durations.find(selector).val [value]
      target_radio = current_durations.find(selector)[value]
      $(target_radio).attr "checked", "checked"
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
    target = $(event.target)
    class_name = "is-playing"
    if target.hasClass class_name
      target.removeClass class_name
      clearTimeout timer for timer in timers
    else
      target.addClass class_name
      post_positions 0

post_positions = (i) ->
  scenes = $(".scenes .scene")
  scene = $ scenes[i]
  post_url = scene.find(".scene-form").attr "action"
  checked_duration = scene.find ".duration.checked"
  duration = checked_duration.find(".val")[0].innerHTML

  checked_positions = scene.find ".layer .checked .position"
  val = [duration * 1]
  append_value(val, c_p) for c_p in checked_positions

  console.log "duration:" + val[0] + ", l_0:" + val[1] + ", l_1:" + val[2] + ", l_2:" + val[3] + ", l_3:" + val[4] + ", l_4:" + val[5]
  # POST
  # $.post post_url, {duration: val[0], l_0: val[1], l_1: val[2], l_2: val[3], l_3: val[4], l_4: val[5] }
  #   .done ->
  #     console.log "post done"
  #   .fail ->
  #     console.log "post failed"
  #     alert "post failed"
  #     return false
  #   .always ->
  #     console.log "finished"

  if(i > scenes.length - 2)
    i = 0
  else
    i++
  console.log duration * 33
  timers.push setTimeout ->
    post_positions(i)
  , duration * 33

append_value = (array, position) ->
  array.push $(position).attr("value")
