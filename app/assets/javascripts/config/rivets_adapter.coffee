# rivets adapter for backbone

rivets.configure adapter:
  subscribe: (obj, keypath, callback) ->
    if obj instanceof Backbone.Collection
      obj.on "add remove reset", ->
        callback obj[keypath]

    else
      obj.on "change:" + keypath, (m, v) ->
        callback v


  unsubscribe: (obj, keypath, callback) ->
    if obj instanceof Backbone.Collection
      obj.off "add remove reset", ->
        callback obj[keypath]

    else
      obj.off "change:" + keypath, (m, v) ->
        callback v


  read: (obj, keypath) ->
    if obj instanceof Backbone.Collection
      return obj[keypath]
    else
      return obj.get(keypath)

  publish: (obj, keypath, value) ->
    if obj instanceof Backbone.Collection
      obj[keypath] = value
    else
      obj.set keypath, value

