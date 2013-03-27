#<< tictactoe/mark

namespace 'tictactoe', (exports) ->
    exports.UI = class UI
        constructor: (@_game, @_boardContext, @_statusContext) ->
            # event handlers
            @_boardSquare = @_boardContext.find('#board-square')
            @_boardContext.click @_onBoardClick
            @_game.gameStarted.add @_onGameStarted
            @_game.playerChanged.add @_onPlayerChanged
            @_game.boardChanged.add @_onBoardChanged
            @_game.gameOver.add @_onGameOver

        _onBoardClick: (e) =>
            x = e.pageX - @_boardSquare.offset().left;
            y = e.pageY - @_boardSquare.offset().top;

            if x > 0 and y > 0 and not @_game.isAIMoving
                index = @_getIndex x, y
                @_game.move(index)

         _getIndex: (x, y) ->
            width = @_boardContext.width()
            height = @_boardContext.height()

            boardColumns = 3
            squareLength = Math.min width, height / boardColumns

            iX = Math.floor x / squareLength
            iY = Math.floor y / squareLength

            # convert a two-dimensional array index into a one-dimensional array index
            i = iX + iY * boardColumns;

        _onGameStarted: () =>
            @_updateStatusBar('')

        _onPlayerChanged: (sender, [mark]) =>
             @_updateStatusBar("It's #{tictactoe.Mark.toString(mark)}'s turn")

        _onBoardChanged: (sender, [board]) =>
            @_drawBoard board

        _onGameOver: (sender, [winnerMark, winPosition]) =>
            if winnerMark isnt tictactoe.Mark.EMPTY
                @_drawStrike winPosition
                @_updateStatusBar("#{tictactoe.Mark.toString(winnerMark)} wins!")
            else
                @_updateStatusBar("Tied game")

        _drawBoard: (board) =>
            # clear the board
            @_boardContext.find('use[id^="O"], use[id^="X"], use[id^="strike"]').hide()

            for i in [0..8]
                mark = board.getSquare(i)
                if mark isnt tictactoe.Mark.EMPTY
                    @_boardContext.find("##{tictactoe.Mark.toString(mark) + i}").show()

        _drawStrike: (winPosition) ->
            @_boardContext.find("#strike#{winPosition}").show()

        _updateStatusBar: (text) ->
            @_statusContext.text text
