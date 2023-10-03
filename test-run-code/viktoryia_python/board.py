class Board:

    def __init__(self):
        self.__squares = [0] * 51

        for index in [10, 20, 30, 40, 50]:
            self.__squares[index] = -5

        for index in [5, 15, 25, 35,  45]:
            self.__squares[index] = 5

    def get_square_value(self, index):
        if index > 50:
            return 0
        else:
            return self.__squares[index]
