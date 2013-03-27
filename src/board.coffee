#<< tictactoe/mark

namespace 'tictactoe', (exports) ->
    exports.Board = class Board
        @WIN_POSITIONS: [ 
            [0, 1, 2], [3, 4, 5], [6, 7, 8] # horizontals
            [0, 3, 6], [1, 4, 7], [2, 5, 8] # verticals
            [0, 4, 8], [2, 4, 6]            # diagonals
        ]

        constructor: (board) ->
            @_board = board ? (tictactoe.Mark.EMPTY for _ in [0..8])

        isEmpty: ->
            @_board.every (s) -> s is tictactoe.Mark.EMPTY

        isFull: ->
             @_board.every (s) -> s in tictactoe.Mark.VALID_MARKS

        getSquare: (index) ->
            throw new RangeError if not (0 <= index <= 8)
            @_board[index]

        move: (index, mark) ->
            throw new RangeError if not (0 <= index <= 8)
            throw new Error "Invalid mark" if not (mark in tictactoe.Mark.VALID_MARKS)
            @_board[index] = mark

        getPossibleMoves: ->
            (i for mark, i in @_board when mark is tictactoe.Mark.EMPTY)

        getWinnerMarkAndWinPosition: ->
            for [i, j, k], winPosition in Board.WIN_POSITIONS
                return [@_board[i], winPosition] if @_board[i] == @_board[j] == @_board[k] != tictactoe.Mark.EMPTY
            return [tictactoe.Mark.EMPTY, -1]

        isGameOver: () ->
            [winnerMark, _] = @getWinnerMarkAndWinPosition()
            winnerMark isnt tictactoe.Mark.EMPTY or # a player has won
            (winnerMark is tictactoe.Mark.EMPTY and @isFull()) # tied game

        clone: -> 
            new Board(@_board[..])