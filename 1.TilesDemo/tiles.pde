import java.io.*;

int[][] tileMap;
int tileSize = 20;
int mapWidth = 32;
int mapHeight = 32;

void setup() {
  size(640, 640);
  tileMap = new int[mapWidth][mapHeight];
  for (int i = 0; i < mapWidth; i++) {
    for (int j = 0; j < mapHeight; j++) {
      tileMap[i][j] = 0;  // Initialize all tiles to state 0
    }
  }
}

void draw() {
  background(255);
  for (int i = 0; i < mapWidth; i++) {
    for (int j = 0; j < mapHeight; j++) {
      int x = i * tileSize;
      int y = j * tileSize;
      int state = tileMap[i][j];
      fill(state == 0 ? 255 : color(state * 63, state * 63, state * 63));
      rect(x, y, tileSize, tileSize);
    }
  }
}

// Handle mouse clicks
void mouseClicked() {
  int x = mouseX / tileSize;
  int y = mouseY / tileSize;
  if (mouseButton == LEFT) {
    tileMap[x][y] = (tileMap[x][y] + 1) % 4;  // Change state to one of four possible values
  } else if (mouseButton == RIGHT) {
    for (int i = 0; i < mapWidth; i++) {
      for (int j = 0; j < mapHeight; j++) {
        tileMap[i][j] = 0;  // Set all tiles back to default state (0)
      }
    }
  }
}

// Handle key presses
void keyPressed() {
  if (key == ' ') {  // If space is pressed
    // Create a .txt file that contains the coordinate system of the tiles and their state
    try (BufferedWriter writer = new BufferedWriter(new FileWriter("tile_map.txt"))) {
      for (int i = 0; i < mapWidth; i++) {
        for (int j = 0; j < mapHeight; j++) {
          int x = i * tileSize;
          int y = j * tileSize;
          int state = tileMap[i][j];
          writer.write(x + "\t" + y + "\t" + state + "\n");  // Write each tile's x, y, and state separated by tabs
        }
      }
      println("Tile map saved to tile_map.txt");
    } catch (IOException e) {
      println("Error saving tile map to file");
    }
  } else if (key == 'r') {  // If "r" is pressed
    // Read the .txt file and apply the states onto the tiles
    try (BufferedReader reader = new BufferedReader(new FileReader("tile_map.txt"))) {
      String line;
      while ((line = reader.readLine()) != null) {
        String[] parts = line.split("\t");  // Split the line by tabs
        int x = Integer.parseInt(parts[0]) / tileSize;
        int y = Integer.parseInt(parts[1]) / tileSize;
        int state = Integer.parseInt(parts[2]);
        tileMap[x][y] = state;
      }
      println("Tile map loaded from tile_map.txt");
    } catch (IOException e) {
      println("Error loading tile map from file");
    }
  }
}
