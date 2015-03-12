$ ->
  # instantiate FastClick on the body
  FastClick.attach document.body

  # toggle menu open/close
  $('#menu').click ->
    $('.menu').toggleClass('open')

# Mailchimp form
# http://marketfurther.us10.list-manage.com/subscribe/post-json?u=aa52d5e1b14f1c50429ce9c39&id=07d877879d&c=?
