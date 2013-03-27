namespace 'tictactoe', (exports) ->
    exports.Mark = class Mark
        @X: -1
        @EMPTY: 0
        @O: 1

        @VALID_MARKS: [Mark.X, Mark.O]

        @getOpponent: (mark) ->
            throw new Error "Invalid mark" if not (mark in Mark.VALID_MARKS)
            -mark

        @toString: (mark) ->
            throw new Error "Invalid mark" if not (mark in Mark.VALID_MARKS)
            if mark is Mark.X then 'X' else 'O'