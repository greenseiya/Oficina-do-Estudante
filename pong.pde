// 9 Ano - Oficina do Estudante 
//PONG GAME

//Variaveis
//BOLA
int pos_bola_x, pos_bola_y;
int raio_bola, diam_bola;
int v_bola_x, v_bola_y; 

//RAQUETE
int paddle_altura, paddle_largura;
int v_paddle;

//PADDLE ESQUERDA
int paddle_esq_x, paddle_esq_y;
boolean cima_esq, baixo_esq;
color cor_esq = color(0,255,0);
int pontos_esq = 0;

//PADDLE DIREITA
int paddle_dir_x, paddle_dir_y;
boolean cima_dir, baixo_dir;
color cor_dir = color(0,0,255);
int pontos_dir = 0;

int winScore = 2;

void setup() {
  size(800,800);
  pos_bola_x = width/2;
  pos_bola_y = height/2;
  diam_bola = 50;
  raio_bola = 25;
  v_bola_x = 3;
  v_bola_y = 4;
  
  textSize(30);
  textAlign(CENTER,CENTER);
  rectMode(CENTER);
  
  //PADDLE ESQUERDA
  paddle_esq_x = 30;
  paddle_esq_y = height/2;
  
  //PADDLE DIREITA
  paddle_dir_x = width - 30;
  paddle_dir_y = paddle_esq_y;
  
  paddle_altura = 100;
  paddle_largura = 30;
  v_paddle = 5;
}

void draw() {
  background(255);
  desenho_bola();
  mover_bola();
  fora_limite();
  desenho_paddle(); 
  mover_paddle();
  dentro_tela();
  contato_paddle();
  pontos();
  gameOver();
}

void desenho_bola() {
  fill(255, 0, 0);
  ellipse(pos_bola_x,pos_bola_y, diam_bola, diam_bola);
}

void mover_paddle() {
  //PADDLE ESQUERDA
  if(cima_esq == true) {
    paddle_esq_y = paddle_esq_y - v_paddle;
  }
  if(baixo_esq == true) {
    paddle_esq_y = paddle_esq_y + v_paddle;
  }
  
  //PADDLE DIREITA
  if(cima_dir == true) {
    paddle_dir_y = paddle_dir_y - v_paddle;
  }
  if(baixo_dir == true) {
    paddle_dir_y = paddle_dir_y + v_paddle;
  }
}

void desenho_paddle() {
  //PADDLE ESQUERDA
  fill(cor_esq);
  rect(paddle_esq_x, paddle_esq_y, paddle_largura, paddle_altura);
  
  //PADDLE DIREITA
  fill(cor_dir);
  rect(paddle_dir_x, paddle_dir_y, paddle_largura, paddle_altura);
}

void contato_paddle(){ 
  if( (pos_bola_x - raio_bola) <= (paddle_esq_x + (paddle_largura/2)) && (pos_bola_y - raio_bola) >= (paddle_esq_y - (paddle_altura/2)) && (pos_bola_y + raio_bola) <= (paddle_esq_y + (paddle_altura/2)) ){
    if(v_bola_x < 0){
      v_bola_x = -v_bola_x;
    }
  }
  if((pos_bola_x + raio_bola) >= (paddle_dir_x - (paddle_largura/2)) && (pos_bola_y - raio_bola) >= (paddle_dir_y - (paddle_altura/2)) && (pos_bola_y + raio_bola) <= (paddle_dir_y + (paddle_altura/2))){
    if(v_bola_x > 0){
      v_bola_x = -v_bola_x;
    }
  }
}

void dentro_tela() {
  if( (paddle_esq_y - (paddle_altura/2)) < 0) paddle_esq_y = paddle_esq_y + v_paddle;
  if( (paddle_esq_y + (paddle_altura/2)) > height) paddle_esq_y = paddle_esq_y - v_paddle;
  
  if( (paddle_dir_y - (paddle_altura/2)) < 0) paddle_dir_y = paddle_dir_y + v_paddle;
  if( (paddle_dir_y + (paddle_altura/2)) > height) paddle_dir_y = paddle_dir_y - v_paddle;
}

void mover_bola() {
  pos_bola_x = pos_bola_x + v_bola_x;
  pos_bola_y = pos_bola_y + v_bola_y;
}

void fora_limite() {
  if( pos_bola_x > (width - raio_bola) ) {
    setup();
    v_bola_x = -v_bola_x;
    pontos_esq = pontos_esq + 1;
  }
  else if( pos_bola_x < raio_bola ) {
    setup();
    v_bola_x = -v_bola_x;
    pontos_dir = pontos_dir + 1;
  }
  
  if( pos_bola_y > (height - raio_bola) ) v_bola_y = -v_bola_y;
  if( pos_bola_y < raio_bola ) v_bola_y = -v_bola_y;
}

void pontos(){
  fill(0);
  text(pontos_esq, 100, 50);
  text(pontos_dir, width-100, 50);
}

void gameOver(){
  if(pontos_esq == winScore) gameOverPage("Esquerdo Ganhou!", cor_esq);
  if(pontos_dir == winScore) gameOverPage("Direito Ganhou!", cor_dir);
}

void gameOverPage (String ganhador, color cor){
  v_bola_x = 0;
  v_bola_y = 0;
  
  fill(0);
  text("Game Over", width/2, height/3-40);
  fill(cor);
  text(ganhador, width/2, height/3);
  fill(0);
  text("Clique para jogar novamente", width/2, height/3+40);
  
  if(mousePressed){
    pontos_dir = 0;
    pontos_esq = 0;
    v_bola_x = 3;
    v_bola_y = 4;
  }
}

void keyPressed() {
  if(key == 'w' || key == 'W') {
    cima_esq = true;
  }
    if(key == 's' || key == 'S') {
    baixo_esq = true;
  }
  
   if(keyCode == UP) {
    cima_dir = true;
  }
    if(keyCode == DOWN) {
    baixo_dir = true;
  }
}

void keyReleased() {
   if(key == 'w' || key == 'W') {
    cima_esq = false;
  }
    if(key == 's' || key == 'S') {
    baixo_esq = false;
  }
  
   if(keyCode == UP) {
    cima_dir = false;
  }
    if(keyCode == DOWN) {
    baixo_dir = false;
  }
}
