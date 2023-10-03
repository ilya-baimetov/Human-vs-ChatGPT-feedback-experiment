import unittest
from player import Player
from board import Board


class TestPlayer(unittest.TestCase):
    def setUp(self):
        self.player = Player("Player1")
        self.board = Board()

    def test_get_name(self):
        self.assertEqual(self.player.get_name(), "Player1")

    def test_get_square(self):
        self.assertEqual(self.player.get_square(), 0)

    def test_get_score(self):
        self.assertEqual(self.player.get_score(), 15)

    def test_update_square(self):
        # Checking that you cannot accumulate more than 15 points.
        self.player.update_square(5, self.board)
        self.assertEqual(self.player.get_square(), 5)
        self.assertEqual(self.player.is_active(), True)
        self.assertEqual(self.player.has_finished(), False)
        self.assertEqual(self.player.get_score(), 15)

        # Checking that it deducts 5 points on square 10.
        self.player.update_square(5, self.board)
        self.assertEqual(self.player.get_square(), 10)
        self.assertEqual(self.player.is_active(), True)
        self.assertEqual(self.player.has_finished(), False)
        self.assertEqual(self.player.get_score(), 10)

        # Checking that when landing on a regular square, the points remain unchanged.
        self.player.update_square(2, self.board)
        self.assertEqual(self.player.get_square(), 12)
        self.assertEqual(self.player.is_active(), True)
        self.assertEqual(self.player.has_finished(), False)
        self.assertEqual(self.player.get_score(), 10)

        # Checking that 5 points are added on square 15.
        self.player.update_square(3, self.board)
        self.assertEqual(self.player.get_square(), 15)
        self.assertEqual(self.player.is_active(), True)
        self.assertEqual(self.player.has_finished(), False)
        self.assertEqual(self.player.get_score(), 15)

        # Checking that when a player has 0 points, they become inactive.
        self.player.update_square(5, self.board)
        self.player.update_square(10, self.board)
        self.player.update_square(10, self.board)
        self.assertEqual(self.player.get_square(), 40)
        self.assertEqual(self.player.is_active(), False)
        self.assertEqual(self.player.has_finished(), False)
        self.assertEqual(self.player.get_score(), 0)

        # Checking that when an inactive player attempts to take a turn, nothing changes.
        self.player.update_square(2, self.board)
        self.assertEqual(self.player.get_square(), 40)
        self.assertEqual(self.player.is_active(), False)
        self.assertEqual(self.player.has_finished(), False)
        self.assertEqual(self.player.get_score(), 0)

    def test_is_active(self):
        self.assertEqual(self.player.is_active(), True)

    def test_has_finished(self):
        self.assertEqual(self.player.has_finished(), False)


if __name__ == "__main__":
    unittest.main()
