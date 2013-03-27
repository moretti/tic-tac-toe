test("board tests", function() {
    var board = new tictactoe.Board();
    
    ok(board.isEmpty(), "new board should be empty" );

    throws(
        function() {
            board.getSquare(-1);
        },
        RangeError,
        "getSquare index has to be between 0 and 8"
    );

    throws(
        function() {
            board.move(20, tictactoe.Mark.O);
        },
        RangeError,
        "move index has to be between 0 and 8"
    );

    throws(
        function() {
            board.move(0, 'foo');
        },
        Error,
        "move player has to be 'O' or 'X'"
    );

    board.move(0, tictactoe.Mark.X);
    equal(board.getSquare(0), tictactoe.Mark.X, "move and getSquare succeded");

    equal(board.isGameOver(), false, "it's not game over yet");

    board.move(1, tictactoe.Mark.X);
    board.move(2, tictactoe.Mark.X);

    equal(board.isGameOver(), true, "it's game over");

    var r = board.getWinnerMarkAndWinPosition();
    var winnerMark = r[0];
    var winPosition = r[1];

    equal(winnerMark, tictactoe.Mark.X, "winner mark is correct");
    equal(winPosition, 0, "win position is correct");
});

// TODO: We ned moar tests!!! Nao, I can has cheezburger?