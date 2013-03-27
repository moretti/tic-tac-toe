#<< tictactoe/ai
#<< tictactoe/board
#<< tictactoe/event
#<< tictactoe/mark
#<< tictactoe/player

namespace 'tictactoe', (exports) ->
    exports.Game = class Game
        constructor: (player1, player2) ->
            @gameStarted = new tictactoe.Event()
            @playerChanged = new tictactoe.Event()
            @boardChanged = new tictactoe.Event()
            @gameOver = new tictactoe.Event()

            @isAIMoving = false

            @restart player1, player2

        restart: (player1, player2) ->
            throw new Error "Invalid player1" if not (player1 in tictactoe.Player.VALID_PLAYERS)
            throw new Error "Invalid player2" if not (player2 in tictactoe.Player.VALID_PLAYERS)

            @_board = new tictactoe.Board()
            @_players = [player1, player2]
            @_board = new tictactoe.Board()
            @_turn = 0

            # raise changes
            @gameStarted.raise this
            @boardChanged.raise this, [@_board]
            @playerChanged.raise this, [@_getCurrentMark()]

            if @_getCurrentPlayer() is tictactoe.Player.COMPUTER
                @_autoMove()

        move: (index) ->
            if @_board.isGameOver() or @_board.getSquare index isnt tictactoe.Mark.EMPTY
                return

            @_board.move index, @_getCurrentMark()
            @boardChanged.raise this, [@_board]

            # update the game state
            [winnerMark, winPosition] = @_board.getWinnerMarkAndWinPosition()

            if @_board.isGameOver()
                @gameOver.raise this, [winnerMark, winPosition]
            else # switch players
                @_turn += 1
                @playerChanged.raise this, [@_getCurrentMark()]

                if @_getCurrentPlayer() is tictactoe.Player.COMPUTER
                    @_autoMove()

        _autoMove: ->
            @isAIMoving = true

            # add a short pause
            setTimeout (=>
                currentMark = tictactoe.Mark.VALID_MARKS[@_turn % 2]
                bestMove = tictactoe.AI.getBestMove currentMark, @_board
                @move bestMove

                @isAIMoving = false
            ), 1000

        _getCurrentPlayer: () ->
            @_players[@_turn % 2]

        _getCurrentMark: () ->
            tictactoe.Mark.VALID_MARKS[@_turn % 2]