from player import Player
from board import Board
from dice import Dice


class Game:

    def __init__(self, num_players):
        self.__players = [Player(f"player{i}") for i in range(1, num_players + 1)]
        self.__board = Board()
        self.__dice1 = Dice()
        self.__dice2 = Dice()

    def run_game(self):

        game_active = True
        while game_active:
            active_players_count = 0

            # Iterating through all players in the current round.
            for player in self.__players:
                player.update_square(self.__dice1.roll() + self.__dice2.roll(), self.__board)
                if player.is_active():
                    active_players_count += 1

                if player.has_finished():
                    game_active = False

            # Checking that not all players have been eliminated; otherwise, end the game.
            if active_players_count == 0:
                game_active = False

    def print_game_board(self):
        for player in self.__players:
            print("{} {}".format(player.get_name(), player.get_square()))




