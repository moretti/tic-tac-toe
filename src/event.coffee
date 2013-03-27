namespace 'tictactoe', (exports) ->
    # A simple event implementation, inspired by C# events:
    # http://msdn.microsoft.com/en-us/library/aa645739%28v=vs.71%29.aspx
    exports.Event = class Event
        constructor: () ->
            @callbacks = []

        add: (callback) ->
            @callbacks.push(callback)

        remove: (callback) ->
            i = @callbacks.indexOf callback
            @callbacks.splice(i, 1) if i > -1

        raise: (sender, args) ->
            callback(sender, args) for callback in @callbacks