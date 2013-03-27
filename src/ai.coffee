#<< tictactoe/helpers
#<< tictactoe/player

namespace 'tictactoe', (exports) ->
    exports.AI = class AI
        @MAX_DEPTH = 999

        @getBestMove: (playerMark, board) ->
            if board.isEmpty()
                # random move
                return tictactoe.helpers.randomChoice [0..8]
            else
                [score, bestMove] = @_negamax board, @MAX_DEPTH, -Infinity, Infinity, playerMark
                return bestMove
            #tictactoe.helpers.randomChoice board.getPossibleMoves()

        # http://en.wikipedia.org/wiki/Negamax
        # http://www.cs.colostate.edu/~anderson/cs440/index.html/lib/exe/fetch.php?media=notes:negamax.pdf
        @_negamax: (board, depth, alpha, beta, playerMark) ->
            if board.isGameOver() or depth == 0
                return [@_getScore(playerMark, board), null]

            bestMove = null

            for move in board.getPossibleMoves()
                newBoard = board.clone()
                newBoard.move move, playerMark

                opponentMark = tictactoe.Mark.getOpponent playerMark
                
                score = -(@_negamax(newBoard, depth-1, -beta, -alpha, opponentMark)[0])

                if score >= beta
                    return [score, move]

                if score > alpha
                    alpha = score 
                    bestMove = move

            return [alpha, bestMove]

        @_getScore: (mark, board) ->
            opponentMark = tictactoe.Mark.getOpponent mark
            [winnerMark, _] = board.getWinnerMarkAndWinPosition()

            if winnerMark is mark
                return Infinity
            if winnerMark is opponentMark
                return -Infinity
            if board.isFull()
                return 0