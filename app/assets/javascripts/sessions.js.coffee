# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


do ($ = jQuery) ->
  $(->
    do ->
      quantity = 140 - $('#micropost_content').val().length
      $('#quantity').text(quantity)
      return

    $(document).on('blur keydown','#micropost_content',->
      quantity = 140 - $(this).val().length
      $('#quantity').text(quantity)
    )
  )
  return
