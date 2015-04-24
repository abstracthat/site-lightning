$ ->
  # instantiate FastClick on the body
  FastClick.attach document.body

  ###
  Mobile Menu
  ###

  # Set the menu max-height to 0 to hide for mobile
  menuHeight = $('.menu').height()
  $('.menu').css
    'max-height': 0

  # toggle menu open/close
  $('#menu-toggle').click ->
    $('.menu').toggleClass('open')
    $('.menu-toggle .icon').toggleClass('close')

    # Set the max-height of the open menu to the real height of the menu
    # The max-height is animated by a CSS transition
    if $('.menu').hasClass 'open'
      $('.menu').css
        'max-height': "#{menuHeight}px"
    else
      $('.menu').css
        'max-height': 0

  ###
  AJAX Mailchimp Opt-In Form
  ###
  
  form = $ '#signup'

  if form.length
    ($ '#signup button').bind 'click', (event) ->
      event.preventDefault()
      validate (response, name, email) ->
        if response
          clearMessage ->
            form.toggleClass 'submitted'
            register form, name, email

  clearMessage = (done) ->
    $('.form').removeClass 'error'
    $('.form h3').text 'Submitting...'
    $('.form p').remove()
    done true

  insertMessage = (type, title, message) ->
    $('.form').addClass type
    $('.form h3').text title
    $('.form h3').after "<p>#{message}</p>"

  validate = (done) ->
    name = $('input:text').val()
    email = $('input[type=email]').val()
    unless name.length
      insertMessage 'error', 'There is a Problem', 'Please enter your first name'
      ($ 'input:text').focus()
      done false
    else if email.match /^([\w\.\-_]+)?\w+@[\w-_]+(\.\w+){1,}$/igm
      done true, name, email
    else
      insertMessage 'error', 'There is a Problem', 'Please check your email address for typos'
      ($ 'input[type=email]').addClass('error').focus()
      done false

  register = (form, name, email) ->
    $.ajax
      type: 'GET'
      url: 'http://marketfurther.us10.list-manage.com/subscribe/post-json?u=aa52d5e1b14f1c50429ce9c39&id=07d877879d&c=?'
      data: form.serialize()
      cache: false
      dataType: 'jsonp'
      contentType: 'application/json; charset=utf-8'
      error: (err) ->
        insertMessage 'error', 'Something is Wrong', 'Could not connect to the registration server. Please try again later.'
      success: (data) ->
        if data.result isnt 'success'
          insertMessage 'error', 'Ooops!', data.msg
          form.show()
        else
          insertMessage 'success', "One More Step #{name}...", "Please confirm your email address by clicking the link in the email we just sent to #{email}."
