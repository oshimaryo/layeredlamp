base_url =　"http://www.example.com/patterns/0/scenes/"
timers = []
json_data = []
# data/data.json以下の servoのparameter設定のための定数
# layer毎に下のほうから 5つ
# 0,1,2,3,4 の 5種類
servo_ids = [0, 0, 0, 1, 1]
#サーボが遅れた時用のdeplay定数
YOSHINA = 500

$.getJSON "data/data.json", (data) ->
  json_data.push datum for datum in data
  # console.log json_data[0].positions[1][0]

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
      # submit_btn = target.closest(".scene-form").find ".submit"
      # post
      # submit_btn.click()

      scene = target.closest ".scene"
      checked_duration = scene.find ".duration.checked"
      duration = checked_duration.find(".val")[0].innerHTML
      checked_wait = scene.find ".wait.checked"
      wait = checked_wait.find(".val")[0].innerHTML

      checked_positions = scene.find ".layer .checked .position"
      val = [duration / 200 - 1]
      append_value(val, c_p) for c_p in checked_positions

      # console.log "duration:" + val[0] + ", l_0:" + val[1] + ", l_1:" + val[2] + ", l_2:" + val[3] + ", l_3:" + val[4] + ", l_4:" + val[5]
      post_url = make_url("/transform?data=", val)
      $.post post_url


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

  $(document).on "click touch", ".wait", (event) ->
    target = $(this)
    if(target.hasClass "checked")
      console.log "already"
    else
      previous_column = target.siblings ".checked"
      previous_column.removeClass "checked"
      target.addClass "checked"
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
  # post_url = scene.find(".scene-form").attr "action"
  checked_duration = scene.find ".duration.checked"
  duration = checked_duration.find(".val")[0].innerHTML
  checked_wait = scene.find ".wait.checked"
  wait = checked_wait.find(".val")[0].innerHTML

  checked_positions = scene.find ".layer .checked .position"
  val = [duration / 200 - 1]
  append_value(val, c_p) for c_p in checked_positions

  # console.log "duration:" + val[0] + ", l_0:" + val[1] + ", l_1:" + val[2] + ", l_2:" + val[3] + ", l_3:" + val[4] + ", l_4:" + val[5]
  post_url = make_url("/transform?data=", val)
  $.post post_url

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
  console.log (wait * 1 + duration * 1 + YOSHINA)
  timers.push setTimeout ->
    post_positions(i)
  , (wait * 1 + duration * 1 + YOSHINA)

append_value = (array, position) ->
  array.push $(position).attr("value")

make_url = (base_url, vals)->
  url = base_url + vals[0] + ":"
  url_0 = "0-0a" + calc_id(0, vals[1], 0) + "," + "0-1a" + calc_id(0, vals[1], 1) + "," + "0-2a" + calc_id(0, vals[1], 2) + ","
  url_1 = "1-0a" + calc_id(1, vals[2], 0) + "," + "1-1a" + calc_id(1, vals[2], 1) + "," + "1-2a" + calc_id(1, vals[2], 2) + ","
  url_2 = "2-0a" + calc_id(2, vals[3], 0) + "," + "2-1a" + calc_id(2, vals[3], 1) + "," + "2-2a" + calc_id(2, vals[3], 2) + ","
  url_3 = "3-0a" + calc_id(3, vals[4], 0) + "," + "3-1a" + calc_id(3, vals[4], 1) + "," + "3-2a" + calc_id(3, vals[4], 2) + ","
  url_4 = "4-0a" + calc_id(4, vals[5], 0) + "," + "4-1a" + calc_id(4, vals[5], 1) + "," + "4-2a" + calc_id(4, vals[5], 2)
  url = url + url_0 + url_1 + url_2 + url_3 + url_4
  console.log url
  return url

calc_id = (servo_index, val, servo_number) ->
  console.log (json_data[servo_ids[servo_index]].positions[val][servo_number] / 10) + ""
  return (json_data[servo_ids[servo_index]].positions[val][servo_number] / 10) + ""
