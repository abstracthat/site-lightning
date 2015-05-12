submitForm = require './submit-form'

$ ->
  # Instantiate FastClick on the body
  FastClick.attach document.body

  # Toggle menu open
  $('#menu-toggle').on 'click', ->
    $('.menu').toggleClass 'open'
    $('.menu-toggle .icon').toggleClass 'close'
  
  # Close menu if click outside of menu/header
  $(document).on 'click', (event) ->
    unless $(event.target).closest('.site-header').length
      $('.menu').removeClass 'open'
      $('.menu-toggle .icon').removeClass 'close'

  # Mailchimp Signup Form
  submitForm '.signup', '#signup'
