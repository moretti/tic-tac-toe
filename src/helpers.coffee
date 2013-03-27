namespace 'tictactoe.helpers', (exports) ->
    exports.randomChoice = (sequence) ->
        index = Math.floor Math.random() * sequence.length
        sequence[index]