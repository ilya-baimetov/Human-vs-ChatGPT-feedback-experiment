import random
from game import Game

if __name__ == '__main__':
    # Creating a game with a player count ranging from 2 to 6.
    num_players = random.randint(2, 6)
    game = Game(num_players)

    # Starting the game.
    game.run_game()

    # Displaying the game results.
    game.print_game_board()
