import java.util.Random;

class Main {
    static class Player {
        private int hp;
        // A player cannot heal further once reached this much HP.
        private int healingBlockHpThreshold;


        // Is not blocked from healing?
        private boolean canBeHealed;

        public Player(int hp, int healingBlockHpThreshold) {
            this.hp = hp;
            this.healingBlockHpThreshold = healingBlockHpThreshold;

            checkHealingBlock();
        }

        // Decrease hp for given non-negative `amount`.
        public void damage(int amount) {
            hp -= amount;
        }

        // If healing not blocked, increase hp for given non-negative `amount`.
        // If healing blocked, do nothing.
        public void heal(int amount) {
            if (canBeHealed) {
                hp += amount;
                checkHealingBlock();
            }
        }

        private void checkHealingBlock() {
            if (hp >= healingBlockHpThreshold) {
                canBeHealed = false;
            }
        }
    }

    // A 6-sided die
    static class Die {
        private Random random;

        Die() {
            this.random = new Random();
        }

        // Rolls die and returns the resulting face-up value in [1, 6]
        int nextValue() {
            return random.nextInt(5) + 1;
        }
    }

    static class Game {
        private Die die1, die2;
        private Player[] players;
        private int[] positions;

        static final int PLAYERS_N = 6;
        static final int INITIAL_CELL = 16;
        static final int LAST_CELL = 50;
        static final int HEAL_CELL_HEALING = 5;
        static final int DAMAGE_CELL_DAMAGE = 5;
        static final int INITIAL_HP = 15;
        static final int HEALING_BLOCK_HP_THRESHOLD = 15;

        Game() {
            die1 = new Die();
            die2 = new Die();
            players = new Player[PLAYERS_N];
            positions = new int[players.length];
            for (int i = 0; i < players.length; i++) {
                players[i] = new Player(INITIAL_HP, HEALING_BLOCK_HP_THRESHOLD);
                positions[i] = INITIAL_CELL;
            }
        }

        public int[] play() {
            while (!isGameEnded()) {
                playRound();
            }

            int playersLeft = 0;
            for (int i = 0; i < players.length; i++) {
                if (players[i] != null) {
                    playersLeft++;
                }
            }

            int j = 0;
            int[] result = new int[playersLeft];

            for (int i = 0; i < players.length; i++) {
                if (players[i] != null) {
                    result[j++] = positions[i];
                }
            }

            return result;
        }

        private void playRound() {
            for (int i = 0; i < players.length; i++) {
                Player p = players[i];
                if (p == null) {
                    continue;
                }

                int progress = die1.nextValue() + die2.nextValue();

                positions[i] += progress;

                if (isHealCell(positions[i])) {
                    p.heal(HEAL_CELL_HEALING);
                }
                if (isDamageCell(positions[i])) {
                    p.damage(DAMAGE_CELL_DAMAGE);
                    if (p.hp < 0) {
                        players[i] = null;
                    }
                }
            }
        }

        // Is game ended?
        private boolean isGameEnded() {
            boolean hasPlayer = false;

            for (int i = 0; i < players.length; i++) {
                if (players[i] == null) {
                    continue;
                }

                hasPlayer = true;
                if (positions[i] > LAST_CELL) {
                    return true;
                }
            }

            return !hasPlayer;
        }

        // Is position `i` a healing cell's position (5, 15, 25, 35, 45)?
        private boolean isHealCell(int i) {
            return i >= 5 && i <= 45 && (i % 10) == 5;
        }

        // Is position `i` a trap cell's position (10, 20, 30, 40, 50)?
        private boolean isDamageCell(int i) {
            return i >= 10 && i <= 50 && (i % 10) == 0;
        }
    }

    public static void main(String[] args) {
        if (args.length > 0 && args[0].equals("-test")) {
            runTests();
            return;
        }

        Game game = new Game();
        int[] standing = game.play();

        for (int s : standing) {
            System.out.println(s);
        }
    }

    static void runTests() {
        // Game has 2 to 6 players
        Game g = new Game();
        assert g.players.length >= 2 && g.players.length <= 6;

        // Game has 2 dice
        assert g.die1 != g.die2;

        // Position increases by the sum of 2 dice [2, 12]
        int p1 = g.positions[0];
        g.playRound();
        int delta = g.positions[0] - p1;
        assert 2 <= delta && delta <= 12;

        // Game ends after player reaches beyond square 50
        for (int i = 0; i < g.positions.length; i++) {
            g.positions[i] = 50;
        }
        g.playRound();
        assert g.isGameEnded();

        // 10 is damage cell
        assert g.isDamageCell(10);
        // 11 is not damage cell
        assert !g.isDamageCell(11);

        // 15 is heal cell
        assert g.isHealCell(15);
        // 16 is not heal cell
        assert !g.isHealCell(16);
    }
}
