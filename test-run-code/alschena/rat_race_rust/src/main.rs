mod game;
use game::Game;
fn main() {
    let mut game = Game::new();
    game.init_board();
    game.run();
}
