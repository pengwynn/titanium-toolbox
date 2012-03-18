# Usage:
#   Parse.Data.app_id = 'blah'
#   Parse.Data.rest_key = 'foo'
class Data

  @ENDPOINT: 'https://api.parse.com/1/classes/'

  @request: (args) ->
    args.success ?= Ti.API.info
    args.error ?= Ti.API.error
    args.query ?= {}
    xhr = Ti.Network.createHTTPClient()

    xhr.onload = () ->
      response = JSON.parse(@responseText)
      args.success response

    xhr.onerror = () ->
      response = JSON.parse(@responseText)
      args.error response

    url = "#{ @ENDPOINT }#{ args.path }?"


    for own key, value of args.query
      url += "#{ key }=#{ encodeURIComponent(JSON.stringify(value)) }"


    xhr.open args.method, url

    xhr.setRequestHeader 'X-Parse-Application-Id', @app_id
    xhr.setRequestHeader 'X-Parse-REST-API-Key', @rest_key
    xhr.setRequestHeader 'Content-Type','application/json'

    if args.method is 'PUT' or args.method is 'POST'
      xhr.send JSON.stringify(args.payload)
    else
      xhr.send ''

  @create: (args) ->
    @request
      path: args.className
      method: 'POST'
      payload: args.object
      success: args.success
      error: args.error

  @get: (args) ->
    path = "#{args.className}"
    path += "/#{args.objectId}" if args.objectId?
    @request
      path: path
      method: 'GET'
      success: args.success
      error: args.error
      query: args.query

  @update: (args) ->
    id = args.object?.objectId or= args.object?.id
    #delete args.object.objectId
    @request
      path: "#{args.className}/#{id}"
      method: 'PUT'
      payload: args.object
      success: args.success
      error: args.error

  @delete: (args) ->
    @request
      path: "#{args.className}/#{args.objectId}"
      method: 'DELETE'
      success: args.success
      error: args.error

module.exports = Data
