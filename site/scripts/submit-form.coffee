###
Submit Form
Used to validate and then submit a form. Pass the sectionClass and the formID. The form should be contained in div.form which is contained in the sectionClass. Requires an h2 and a p in the section to insert the error message.

TODO: use parsley.js for validation and insert error more generic / modular

example:
submitForm('.signup', '#signup')
###

module.exports = (sectionClass, formID) ->
  if $(formID).length
    $(formID).submit (event) ->
      validateForm sectionClass, formID, (valid, name, email) ->
        unless valid
          event.preventDefault()

insertErrorMessage = (sectionClass, title, message) ->
  $('.form').addClass 'error'
  $("#{sectionClass} p").remove()
  $("#{sectionClass} h2").text title
  $("#{sectionClass} h2").after "<p>#{message}</p>"

validateForm = (sectionClass, formID, done) ->
  nameInput = $("#{formID} #name")
  name = nameInput.val()
  emailInput = $("#{formID} #email")
  email = emailInput.val()

  unless name.length
    insertErrorMessage sectionClass, 'There is a Problem', 'Please enter your first name'
    nameInput.addClass('error').focus()
    done false

  else unless email.length
    insertErrorMessage sectionClass, 'There is a Problem', 'You did not enter an email address'
    emailInput.addClass('error').focus()
    done false

  else if email.match /^([\w\.\-_]+)?\w+@[\w-_]+(\.\w+){1,}$/igm
    done true, name, email

  else
    insertErrorMessage sectionClass, 'There is a Problem', 'Please check your email address for typos'
    emailInput.addClass('error').focus()
    done false