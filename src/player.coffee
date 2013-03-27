namespace 'tictactoe', (exports) ->
    exports.Player = class Player
        @HUMAN: 0
        @COMPUTER: 1

        @VALID_PLAYERS: [Player.HUMAN, Player.COMPUTER]