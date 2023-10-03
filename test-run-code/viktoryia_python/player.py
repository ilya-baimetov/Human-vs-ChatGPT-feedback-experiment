class Player:
    def __init__(self, name):
        self.__name = name
        self.__square = 0
        self.__score = 15
        self.__active = True
        self.__finish = False

    def get_name(self):
        return self.__name

    def get_square(self):
        return self.__square

    def get_score(self):
        return self.__score

    def update_square(self, step, board):
        if self.__active:
            # Moving to a new cell after rolling the dice.
            assert 2 <= step <= 12, "The sum of two 6-sided dice should be in the range from 2 to 12."
            self.__square += step

            # Checking if the player has finished the game in this round.
            if self.__square > 50:
                self.__finish = True

            #Updating the player's score based on the game board square they landed on.
            self.__score += board.get_square_value(self.__square)
            if self.__score == 0:
                self.__active = False
            if self.__score > 15:
                self.__score = 15

    def has_finished(self):
        return self.__finish

    def is_active(self):
        return self.__active





