# renderer

Backbone.Marionette.Renderer.render = (template, data) ->
	return HandlebarsTemplates[template](data)