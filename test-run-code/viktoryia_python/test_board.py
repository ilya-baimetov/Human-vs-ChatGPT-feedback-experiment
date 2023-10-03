import unittest
from board import Board

class TestBoard(unittest.TestCase):
    def setUp(self):
        self.board = Board()

    def test_get_square_value_positive(self):
        self.assertEqual(self.board.get_square_value(5), 5)

    def test_get_square_value_negative(self):
        self.assertEqual(self.board.get_square_value(10), -5)

    def test_get_square_value_zero(self):
        self.assertEqual(self.board.get_square_value(43), 0)

    def test_get_square_out_of_range(self):
        self.assertEqual(self.board.get_square_value(63), 0)

if __name__ == "__main__":
    unittest.main()

