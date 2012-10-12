class @App.Views.ChatWindow extends Backbone.Marionette.ItemView
	template: 'rooms/chat'

	events:
		'submit form#new-message'		:		'postMessage'

	ui:
		messageBox: '#message-content'
		messageList: '#messages'

	onRender: ->
		# subscribe to the chat channel or if already subscribed,
		# grab the channel from existing channels array
		@model.connectChat() 
		@chat = @model.chat

		@chat.bind 'new_message', (data) => @appendMsg(data) # bind to chat socket channel for new msgs

		@$('#messages').height(window.innerHeight / 2) # set the chat window height

	postMessage: (e) ->
		e.preventDefault()
		sender = App.currentUser.get('name')
		message = @ui.messageBox.val()
		@ui.messageBox.val('') # empty the msg box
		@appendMsg({sender: sender, message: message}) # add msg to list

		# post msg to server
		$.ajax
			url: "/rooms/#{@model.get('token')}/add_message"
			dataType: 'json'
			type: 'post'
			data:
				sender: sender
				message: message
				socket_id: App.pusher.connection.socket_id # pass the socket_id to exclude it from recipients

	appendMsg: (data) ->
		@ui.messageList.append """<li><strong>#{data.sender}</strong>  #{data.message}</li>"""