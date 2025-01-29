import processing.sound.*;

AudioIn input;
Amplitude loudness;

SoundFile degelo;

int lineX = 0; // Posição inicial da linha

void setup() {
  size(768, 1360);
  background(0);

  input = new AudioIn(this, 0);
  input.start();
  
  loudness = new Amplitude(this);

  loudness.input(input);

  // Carregar o arquivo de som
  degelo = new SoundFile(this, "degelo.wav");
  degelo.loop();
}

void draw() {

  input.amp(1);

  float volume = loudness.analyze(); // normalmente varia de 0 a 0,5, mas no nosso caso tem sido até 0.25 mais ou menos
  float vol = map(volume, 0, 0.25, 0.5, 1); // portanto mapeamos para valores para agradáveis e ao mesmo tempo não deixamos o amp ficar muito baixo

  degelo.amp(vol); // Volume controlado pelo áudio

  float blue = map(volume, 0, 0.5, 0, 255);
  stroke(0, 0, blue); // Tom de azul controlado pelo áudio
  line(lineX, 0, lineX, height);

  lineX++;
  if (lineX >= width) {
    lineX = 0;
  }

  //filter(BLUR, 0.1); // experimentamos o BLUR, mas decidimos por não usar
}
