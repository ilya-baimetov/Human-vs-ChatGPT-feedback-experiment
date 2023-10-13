mod board;
mod die;
mod player;
use board::Board;
use player::Player;

#[derive(Debug)]
pub struct Game {
    board: Board,
}

impl<'a> Game {
    pub fn new() -> Game {
        let board = Board::new();
        Game { board }
    }
    pub fn init_board(&mut self) {
        let players = vec![
            Player::new("Player-1".to_string()),
            Player::new("Player-2".to_string()),
        ];
        self.board.init_placement(players);
        self.board.init_dice();
    }
}

impl Game {
    pub fn run(&mut self) {
        while self
            .board
            .placement
            .iter()
            .all(|(_, position)| position.is_some())
            && self
                .board
                .placement
                .iter()
                .any(|(player, _)| player.is_alive())
        {
            self.execute_round();
        }
        println!("{}", self.board);
    }
    fn execute_round(&mut self) {
        self.board.move_players();
        self.board.execute_effect_squares();
    }
}
