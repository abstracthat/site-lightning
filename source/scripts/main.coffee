$ ->
  # instantiate FastClick on the body
  FastClick.attach document.body

  # toggle menu open/close
  $('#menu').click ->
    $('.page').toggleClass('open')
