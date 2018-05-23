import java.awt.event.KeyEvent;
import javax.swing.JOptionPane;
import processing.serial.*;

/*
 * Mini CNC machine user interface code
 */

/*****************************************************************
               GLOBAL VARIABLES
  ****************************************************************/

Serial port = null;

// select and modify the appropriate line for your operating system
// leave as null to use interactive port (press 'p' in the program)
String portname = null;
//String portname = Serial.list()[0]; // Mac OS X
//String portname = "/dev/ttyUSB0"; // Linux
//String portname = "COM7"; // Windows

boolean streaming = false;
float speed = 1;
String[] gcode;
int i = 0;

/*****************************************************************
               FUNCTIONS TO WORK WITH THE SERIAL PORT
  ****************************************************************/
void openSerialPort()
{
  if (portname == null) 
    return;

  if (port != null) 
    port.stop();
  
  port = new Serial(this, portname, 9600);
  
  port.bufferUntil('\n');
}

void selectSerialPort()
{
  String result = (String) JOptionPane.showInputDialog(frame,
    "Select the serial port that corresponds to your Arduino board.",
    "Select serial port",
    JOptionPane.QUESTION_MESSAGE,
    null,
    Serial.list(),
    0);
    
  if (result != null) {
    portname = result;
    openSerialPort();
  }
}

/*****************************************************************
                       MAIN FUNCTIONS
  ****************************************************************/

void setup()
{
  size(600, 400);
  openSerialPort();
}

void draw()
{
  background(255);  
  fill(0);
  textSize(20);
  int y = 24, dy = 20;
  text("INSTRUCTIONS", 20, y); y += dy;
  text("p: select serial port", 20, y); y += dy;
  text("arrow keys: move in x-y plane", 20, y); y += dy;
  text("u & d: move in z axis", 20, y); y += dy;
  text("h: go home", 20, y); y += dy;
  text("m: report position", 20, y); y += dy;
  text("0: zero machine (set home to the current location)", 20, y); y += dy;
  text("g: select and stream a g-code file", 20, y); y += dy;
  text("x: stop streaming g-code (this is not immediate)", 20, y); y += dy;
  y = height - dy;
  text("current serial port: " + portname, 20, y); y -= dy;
}

void keyPressed()
{
  
  if (!streaming) {
    if (keyCode == LEFT) port.write("G91\nG00 X-" + speed + " Y0.00\n");
    if (keyCode == RIGHT) port.write("G91\nG00 X+" + speed + " Y0.00\n");
    if (keyCode == UP) port.write("G91\nG00 X0.00 Y+" + speed + "\n");
    if (keyCode == DOWN) port.write("G91\nG00 X0.00 Y-" + speed + "\n");
    if (key == 'u') {println("Key U was hit"); port.write("UUUUUU\n");}
    if (key == 'd') {println("Key D was hit"); port.write("DDDDDD\n");}
    if (key == 'h') port.write("G90\nG00 X0.00 Y0.00 Z0.00\n");
    if (key == 'm') port.write("M114\n");
    if (key == '0') openSerialPort();
    if (key == 'p') selectSerialPort();
  }
  
  if (!streaming && key == 'g') {
    gcode = null; i = 0;
    File file = null; 
    println("Loading file...");
    selectInput("Select a file to process:", "fileSelected", file);
  }
  
  if (key == 'x') streaming = false;
}

/*****************************************************************
                   HELPER FUNCTIONS
  ****************************************************************/

void fileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("User selected " + selection.getAbsolutePath());
    gcode = loadStrings(selection.getAbsolutePath());
    if (gcode == null) return;
    streaming = true;
    stream();
  }
}

void stream()
{
  if (!streaming) return;
  
  while (true) {
    if (i == gcode.length) {
      streaming = false;
      return;
    }
    
    if (gcode[i].trim().length() == 0) i++;
    else break;
  }
  
  println(gcode[i]);
  port.write(gcode[i] + '\n');
  i++;
}

void serialEvent(Serial p)
{
  String s = p.readStringUntil('\n');
  println(s.trim());
  
  if (s.trim().startsWith("ok")) stream();
  if (s.trim().startsWith("error")) stream(); 
}