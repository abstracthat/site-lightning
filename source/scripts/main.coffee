submitForm = require './submit-form'

$ ->
  # Instantiate FastClick on the body
  FastClick.attach document.body

  # Toggle menu open
  $('#menuToggle').on 'click', ->
    $('.menu').toggleClass 'open'
    $('.toggle .icon').toggleClass 'close'
  
  # Close menu if click outside of menu/header
  $(document).on 'click', (event) ->
    unless $(event.target).closest('#menuToggle').length
      $('.menu').removeClass 'open'
      $('.toggle .icon').removeClass 'close'

  # Mailchimp Signup Form
  submitForm '.signup', '#signup'
