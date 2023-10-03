import unittest
from game import Game  # Импортируйте ваш класс Game и соответствующие зависимости (Player, Board, Dice)

class TestGame(unittest.TestCase):
    def test_initialization(self):
        game = Game(4)
        self.assertEqual(len(game._Game__players), 4)
        self.assertIsNotNone(game._Game__board)
        self.assertIsNotNone(game._Game__dice1)
        self.assertIsNotNone(game._Game__dice2)

    def test_run_and_print_game_board(self):
        game = Game(3)
        game.run_game()
        game.print_game_board()

if __name__ == "__main__":
    unittest.main()

