#define N_CUPS 5
//For test, to set the threshold ratios.
//#define TEST_CUPS
//#define PROCESS

static int cups[N_CUPS] = {A0, A1, A2, A3, A4};
static int init_state[N_CUPS];
const int init_samples = 10000;
const float open_threshold_ratio = 1.08;
const float shad_threshold_ratio = 0.85;

int detect_cup(int cup);

void setup() {  
  Serial.begin(9600);
#ifdef PROCESS
  delay(200);
  for(int i = 0; i < init_samples; i++)
  {
    for(int j = 0; j < N_CUPS; j++)
    {
      if(i == 0)
      {
        init_state[j] = analogRead(cups[j]);
      }
      else
      {
        init_state[j] = (init_state[j] + analogRead(cups[j]))/2;
      }
    }
  }
#endif
}

#ifndef PROCESS
#ifndef TEST_CUPS
void loop() {
  byte data[6] = {};
  for(int i = 0; i < N_CUPS; i++)
  {
    data[i] = analogRead(cups[i])/4;
  }
  for(int i = 0; i < 6; i++)
  {
    Serial.write(data[i]);
  }
  delay(10);
  Serial.flush();
}
#endif
#endif

#ifdef PROCESS
void loop() {
  int val = 0;
  for(int i = 0; i < N_CUPS; i++)
  {
    val = val * 4 + detect_cup(i);
  }
  Serial.write(val);
  delay(10);
  Serial.flush();
}
#endif

#ifdef TEST_CUPS
void loop() {
  Serial.print(analogRead(A0));
  Serial.print(" ");
  Serial.print(analogRead(A1));
  Serial.print(" ");
  Serial.print(analogRead(A2));
  Serial.print(" ");
  Serial.print(analogRead(A3));
  Serial.print(" ");
  Serial.println(analogRead(A4));
  delay(1000);
}
#endif

int detect_cup(int cup)
{
  if(analogRead(cups[cup]) >
      (int)(open_threshold_ratio * (float)init_state[cup]))
  {
    return 1;
  }
  if(analogRead(cups[cup]) <
      (int)(shad_threshold_ratio * (float)init_state[cup]))
  {
    return 3;
  }
  return 2;
}

