import ddf.minim.*;

Minim minim;
AudioPlayer bgMusica;
AudioPlayer somAcerto;
AudioPlayer somErro;
AudioPlayer somMenu;

int respostaUsuario = 0;
String mensagemInicial = "Selecione a opção que se encaixa na frase:";

// Perguntas e opções
String[] perguntasPQs = {
  "________ você não vai sair hoje?",
  "Quero que você me conte o ________ dessa sua atitude.",
  "Eu vou comprar o hambúrguer hoje ________ estou com muita vontade.",
  "Você está bravo ________?",
  "Eu quero ir _____ eu não posso... ",
  "Você precisa de _____ tempo para terminar a prova? ",
  "Ele não é igual a ____! ",
  "Me empresta o lápis pra ____ escrever? ",
};
String[][] opcoesPQs = {
  {"Por que", "Por quê", "Porque", "Porquê"},
  {"Por que", "Por quê", "Porque", "Porquê"},
  {"Por que", "Por quê", "Porque", "Porquê"},
  {"Por que", "Por quê", "Porque", "Porquê"},
  {"Mas", "Mais"},
  {"Mas", "Mais"},
  {"Mim", "Eu"},
  {"Mim", "Eu"}
};
int[] respostasPQs = {0, 3, 0, 1, 0, 1, 0, 1};

String mensagemBotao = "";
boolean iniciarJogo = false;
boolean telaTeoria = false;
boolean perguntas = false;
boolean mostrarImagemFinal = false;
int perguntaAtual = 0;

PImage menu;
PImage teoria;
PImage imagemFinal;

void setup() {
  size(1000, 800);
  menu = loadImage("erreaquimenu.jpg");
  teoria = loadImage("erreaquiteoria.jpg");
  imagemFinal = loadImage("erreaquifinal.jpg");
  minim = new Minim(this);
  bgMusica = minim.loadFile("sakuragirldaisy.mp3", 2048);
  somAcerto = minim.loadFile("acerto.mp3", 2048);
  somErro = minim.loadFile("erro.mp3", 2048);
  somMenu = minim.loadFile("menuteoria.mp3", 2048);
  bgMusica.loop();
  bgMusica.setGain(-30);
}

void draw() {
  background(220);
  if (!iniciarJogo) {
    image(menu, 0, 0, width, height);
  } else if (telaTeoria) {
    image(teoria, 0, 0, width, height);
  } else if (perguntas) {
    jogo();
  } else if (mostrarImagemFinal) {
    image(imagemFinal, 0, 0, width, height);
  }
}

int tempoExibicaoMensagem = 0;
final int DURACAO_EXIBICAO_MENSAGEM = 150;

void jogo() {
  botoes();

  fill(0);
  textSize(30);
  textAlign(CENTER, CENTER);
  text(mensagemInicial, width / 2, 50);
  text(perguntasPQs[perguntaAtual], width / 2, 100);

  textSize(30);
  textAlign(CENTER, CENTER);
  if (respostaUsuario != 0) {
    if (respostaUsuario - 1 == respostasPQs[perguntaAtual]) {
      mensagemBotao = "Parabéns, você acertou!";
      somAcerto.rewind();
      somAcerto.play();
    } else {
      mensagemBotao = "Resposta errada! A resposta correta é: " + opcoesPQs[perguntaAtual][respostasPQs[perguntaAtual]];
      somErro.rewind();
      somErro.play();
    }
    respostaUsuario = 0;
    tempoExibicaoMensagem = DURACAO_EXIBICAO_MENSAGEM;
  }

  if (mensagemBotao != "") {
    if (mensagemBotao.equals("Parabéns, você acertou!")) {
      fill(0, 220, 0);
    } else {
      fill(255, 0, 0);
    }
    text(mensagemBotao, width / 2, 700);
    if (tempoExibicaoMensagem > 0) {
      tempoExibicaoMensagem--;
    } else {
      perguntaAtual++;
      mensagemBotao = "";
      if (perguntaAtual >= perguntasPQs.length) {
        mostrarImagemFinal = true;
        perguntas = false;
      }
    }
  }
}

void botoes() {
  for (int i = 0; i < opcoesPQs[perguntaAtual].length; i++) {
    fill(255, 255, 255);
    rect(0, 200 + i * 100, 250, 80);
    fill(0);
    text(opcoesPQs[perguntaAtual][i], 125, 240 + i * 100);
  }
}

void mousePressed() {
  if (!iniciarJogo) {
    if (mouseX > 325 && mouseX < 675 && mouseY > 475 && mouseY < 575) {
      iniciarJogo = true;
      telaTeoria = true;
      somMenu.rewind();
      somMenu.play();
    }
  } else if (telaTeoria) {
    if (mouseX > 720 && mouseX < 930 && mouseY > 675 && mouseY < 775) {
      perguntas = true;
      telaTeoria = false;
      somMenu.rewind();
      somMenu.play();
    }
  }

  if (perguntas) {
    for (int i = 0; i < opcoesPQs[perguntaAtual].length; i++) {
      if (mouseX > 0 && mouseX < 250 && mouseY > 200 + i * 100 && mouseY < 280 + i * 100) {
        respostaUsuario = i + 1;
      }
    }
   }
 }
