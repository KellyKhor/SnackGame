require 'ruby2d'
require 'gosu'

#set game window size
set width: 640
set height: 480
set background: 'black'
set fps_cap: 25

# Grid size is 20 pixels
SQUARE_SIZE = 20

#This is to ensure all the block sizes are of equal size in the game  
GRID_WIDTH = Window.width / SQUARE_SIZE
GRID_HEIGHT = Window.height / SQUARE_SIZE

# Creating logic for the snake within a class
class Snake
  attr_writer :direction
  attr_accessor :color

  def initialize
    @positions = [[2, 10], [2, 11], [2, 12], [2, 13]] 
    @direction = 'down'
    @growing = false
    @color = 'olive' # Default color
  end

  def draw
    @positions.each do |position|
      Square.new(x: position[0] * SQUARE_SIZE, y: position[1] * SQUARE_SIZE, size: SQUARE_SIZE - 1, color: @color)
    end
  end

  def grow
    @growing = true
  end

  def move
    if !@growing
      @positions.shift
    end

    @positions.push(next_position)
    @growing = false
  end

  def can_change_direction_to?(new_direction) #returns true if case is true, allowing it to change direction
    case @direction
    when 'up' then new_direction != 'down' #If snake is moving up, user cannot change its direction to down, only left or right
    when 'down' then new_direction != 'up'
    when 'left' then new_direction != 'right'
    when 'right' then new_direction != 'left'
    end
  end

  def x
    head[0]
  end

  def y
    head[1]
  end

  def next_position
    if @direction == 'down'
      new_coords(head[0], head[1] + 1)
    elsif @direction == 'up'
      new_coords(head[0], head[1] - 1)
    elsif @direction == 'left'
      new_coords(head[0] - 1, head[1])
    elsif @direction == 'right'
      new_coords(head[0] + 1, head[1])
    end
  end

  def hit_itself?
    @positions.uniq.length != @positions.length #uniqreturns an array with unique elements, removing any duplicate positions
  end

  private #ensures new_coords function can only be accessed within snake class

  def new_coords(x, y) #Handles wrapping around the game window
    [x % GRID_WIDTH, y % GRID_HEIGHT] #Takes remainder if the coordinate exceeds game window, to wrap new coordinates from opposite end
  end

  def head
    @positions.last
  end
end

# Creating basic game mechanics
class Game
  def initialize
    @ball_x = 10
    @ball_y = 10
    @score = 0
    @finished = false
  end

  def draw
    Square.new(x: @ball_x * SQUARE_SIZE, y: @ball_y * SQUARE_SIZE, size: SQUARE_SIZE, color: 'red')
    Text.new(text_message, color: 'white', x: 20, y: 20, size: 25, z: 1)
  end

  def snake_hit_ball?(x, y) #compares ball and snake head coordinates, returns true or false
    @ball_x == x && @ball_y == y 
  end

  def record_hit
    @score += 1
    @ball_x = rand(Window.width / SQUARE_SIZE)
    @ball_y = rand(Window.height / SQUARE_SIZE)
  end

  def finish #used to mark the game as finished
    @finished = true
  end

  def finished? #Used to check game state
    @finished
  end

  private

  def text_message
    if finished?
      "Game over! Your Score: #{@score}. Press 'Space' to restart. "
    else
      "Score: #{@score}"
    end
  end
end

# Color selection class to manage snake colour
class ColorSelection 
  COLORS = ['maroon', 'teal', 'olive', 'silver', 'orange'].freeze #Default colour choices cannot be modified
  BOX_SIZE = 60
  BOX_PADDING = 20

  def initialize
    @selected_color = nil
    @color_boxes = []
    create_color_boxes
  end

  def draw
    @color_boxes.each(&:draw)
  end

  def handle_click(x, y)
    @color_boxes.each do |box|
      if box.contains_point?(x, y) #If clicked, assign that colour to @selected colour
        @selected_color = box.color
        box.highlighted = true
      else
        box.highlighted = false
      end
    end
  end

  def selected_color
    @selected_color
  end

  private

  def create_color_boxes
    x = (Window.width - (COLORS.length * (BOX_SIZE + BOX_PADDING))) / 2
    y = (Window.height - BOX_SIZE) / 2

    COLORS.each do |color|
      @color_boxes << ColorBox.new(x: x, y: y, size: BOX_SIZE, color: color) #Add to array, array called in draw function
      x += BOX_SIZE + BOX_PADDING
    end
  end
end

# Individual Color box class for selection
class ColorBox
  attr_reader :x, :y, :size, :color
  attr_accessor :highlighted

  def initialize(x:, y:, size:, color:)
    @x = x
    @y = y
    @size = size
    @color = color
    @highlighted = false
  end

  def draw
    @y = 50
    if highlighted
      Square.new(x: x, y: y, size: size, color: 'white', z: 1)
    end
    Square.new(x: x + 10, y: y + 10, size: size - 20, color: color, z: 2)
  end

  def contains_point?(x, y)
    x >= @x && x <= (@x + @size) && y >= @y && y <= (@y + @size)
  end
end

snake = Snake.new
game = Game.new
color_selection = ColorSelection.new
color_selected = false

update do
  clear

  #invoke functions on the created objects
  
  unless game.finished?
    snake.move
  end

  snake.draw
  game.draw

  if game.snake_hit_ball?(snake.x, snake.y)
    game.record_hit
    snake.grow
  end

  if snake.hit_itself?
    game.finish
  end

  # If color selection screen is displayed
  if !color_selected
    color_selection.draw
  end
end

on :mouse_down do |event|
  # If color selection screen is displayed
  if !color_selected
    color_selection.handle_click(event.x, event.y)
    snake.color = color_selection.selected_color
    color_selected = true
  end
end

on :key_down do |event|
  if ['up', 'down', 'left', 'right'].include?(event.key)
    if snake.can_change_direction_to?(event.key)
      snake.direction = event.key
    end
  end

  if game.finished? && event.key == 'space'

    snake = Snake.new
    game = Game.new
    color_selected = false

  end
  end

show
