# Snake Game (Ruby)

A modern take on the classic Snake Game, built in Ruby with the Gosu library.
The snake grows longer as it eats food, the player’s score increases, and the game ends when the snake collides with itself.

## Features
- Classic snake mechanics (growth + collision detection).
- Customisable snake colours (choose from multiple options).
- Snake changes colour dynamically on collisions.
- Random ball generation.
- Score and high score tracking.
- Smooth keyboard controls (arrow keys).

## Tech Stack
- Language: Ruby
- Graphics/Input Library: Gosu

## How to Run

### Prerequisites
- Install [Ruby](https://rubyinstaller.org/)  
- Install Gosu:
  ```bash
  gem install gosu
  ```

### Running the Game
```bash
# Navigate to project folder
cd "path/to/project"

# Run the game
ruby snake_game.rb
```

## What I Learned
- Building interactive 2D games with Ruby.
- Managing arrays for snake position and growth logic.
- Real-time keyboard input handling.
- Collision detection and state-based game logic.
- Enhancing user experience with customisation and visual feedback.
