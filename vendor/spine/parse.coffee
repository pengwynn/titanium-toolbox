Spine ?= require('vendor/spine')
Parse ?= require('vendor/parse')

Spine.Model.Parse =


  extended: ->
    @fetch @loadParse

    @bind 'create', @createParse
    @bind 'update', @updateParse
    @bind 'destroy', @destroyParse

  createParse: (record) ->
    Parse.Data.create
      className: @className
      object: record.toJSON()

  updateParse: (record) ->
    Parse.Data.update
      className: @className
      object: record.toJSON()

  destroyParse: (record) ->
    id = record.objectId or= record.id
    Parse.Data.delete
      className: @className
      objectId: id

  loadParse: ->
    result = Parse.Data.get
      className: @className
      success: (response) =>
        results = response.results
        for record, i in results
          record.id = record.objectId
          delete record.objectId
          results[i] = record

        @refresh(results, clear: true)

module?.exports = Spine.Model.Parse
