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

## Prerequisites to Run
Before running the game, make sure you have:
- **Ruby** installed → [Download Ruby](https://rubyinstaller.org/) (for Windows) or install via package manager (macOS/Linux).  
- **Gosu gem** installed →  
  ```bash
  gem install gosu
  ```
- A terminal/command prompt that can run Ruby commands.  

## How to Run
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
