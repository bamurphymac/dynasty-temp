# capitalize method for String
String::capitalize = () ->
    (this.split(/\s+/).map (word) -> word[0].toUpperCase() + word[1..-1].toLowerCase()).join ' '

String::lpad = (length, padString) ->
    str = @
    str = (padString + str) while (str.length < length)
    str

# default options for Ajax requests through JQuery
$.ajaxSetup
    dataType: 'json'
    timeout: 10000

# global Rails API error handling
$(document).ajaxError (e, transport, status, exception) ->
    response = $.parseJSON(transport.responseText)
    if response? and errorBucket = $('#global-errors')
        for own attr, messages of response.errors
            for msg in messages
                errorBucket.append("<div class=\"alert-box error\">#{msg}</div>")

$(document).ajaxSuccess (e, transport) ->
    # If a redirect header is found, redirect!
    location = transport.getResponseHeader('location')
    #window.location.reload() if location?

    response = $.parseJSON(transport.responseText)
    if response? and errorBucket = $('#global-errors')
        for own attr, messages of response.errors
            for msg in messages
                errorBucket.append("<div class=\"alert-box error\">#{msg}</div>")

# clear out all the error boxes prior to doing an Ajax call
$(document).ajaxSend () ->
    errorBucket = $('#global-errors')
    errorBucket.children().remove() if errorBucket?
