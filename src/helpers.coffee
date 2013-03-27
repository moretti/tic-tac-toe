namespace 'tictactoe.helpers', (exports) ->
    # Return a random element from the sequence
    exports.randomChoice = (sequence) ->
        index = Math.floor Math.random() * sequence.length
        sequence[index]