$ ->
  class Car extends Backbone.Model

  class CarView extends Backbone.View
    template: Handlebars.compile($('#car-template').html())

    render: ->
      @el.innerHTML = @template(@model.toJSON())
      @

  class Cars extends Backbone.Collection
    model: Car

  class AppView extends Backbone.View
    el: '#result'

    initialize: ->
      @collection = new Cars()
      @collection.on('sync', @render, this)

    events: ->
      $('#getDataButton').on 'click', @, (event) => @getData(event)

    render: ->
      @

    getData: (event) ->
      event?.preventDefault()
      $.ajax
        url: 'index.php'
        dataType: 'json'
        success: (data) =>
          @renderWithData(data)

    renderWithData: (data) ->
      @el.innerHTML = "#{data.name} has #{data.cars.length} cars:"
      for car in data.cars
        view = new CarView(model: new Car(car))
        @el.appendChild(view.render().el)

  class AppRouter extends Backbone.Router
    initialize: ->
      @collection = new Cars()
      @view = new AppView(collection: @collection)
      @fetchData()

    routes:
      '': 'home'

    events: ->
      $('#getDataButton').on 'click', @, (event) => @getData(event)

    fetchData: ->
      @collection.url = 'index.php'
      @collection.fetch()

  router = new AppRouter()
  Backbone.history.start()
