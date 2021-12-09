// This #include statement was automatically added by the Particle IDE.

Servo servoI;
Servo servoD;

// Temperatura
double lectura = 0;
double gradosC = 0;
double voltaje = 0;
double mvolts = 0;

// Proximidad techo - puerta
int trigPin = D4;
int echoPin = D5;

int maxDist = 200;
int minDist = 0;

double distCm = 0.0;
double distIn = 0.0;


bool flag = 0;
int pos = 0;

//int trigPinD = D5;
//int echoPinD = D6;
bool abierta = false;


void setup() {
    

    pinMode(D0, OUTPUT);
    pinMode(D1, OUTPUT);
    pinMode(D2, INPUT_PULLUP); 
    
    pinMode(echoPin, INPUT);
    pinMode(trigPin, OUTPUT);
    
    Particle.variable("gradosC", &gradosC, DOUBLE);
    
    // Puertas
    servoI.attach(D0);
    servoD.attach(D1);
    
    // Cerradas por defecto
    servoI.write(0);
    servoD.write(135);
    delay(1000);
    servoI.detach();
    servoD.detach();
    
    Serial.begin(9600);
    
}

void loop() {
    
    // Temperatura
    lectura = analogRead(A0);
    
    voltaje = (lectura * 3.3) / 4095;
    
    mvolts = (voltaje * 1000.0); //0 - 3300mv
    
    gradosC = (mvolts * 1.0) / 10.0;
    
    if (digitalRead(D2) == LOW) {
        if (abierta == false) {
            abierta = true;
            abrirPuerta();
            delay(5000);
        }
        if (abierta == true) {
            abierta = false;
            cerrarPuerta();
            delay(1000);
        }
        {
            pos = 180;
        }
        servoI.attach(D0);
        servoD.attach(D1);
        servoI.write(pos);
        servoD.write(pos);
        delay(1000);
        servoI.detach();
        servoD.detach();
        
        flag =! flag;
    }

    
    // Proximidad puerta
    distCm = getDistanceCM();
    Particle.publish("Distance-CM", String(distCm));
    
    if (distCm < 20) {
        if (abierta = false) {
            abierta = true;
            abrirPuerta();
            delay(5000);
            abierta = false;
            cerrarPuerta();
        }
    }
    
    Particle.function("casita", acceso);
}

// HTML
int acceso(String parametro) {
    if(parametro == "on" ) {
        abrirPuerta();
        delay(5000);
        return 1;
    } else if(parametro == "off") {
        cerrarPuerta();
        return 0;
    } else {
        return -1;
    }
}

void abrirPuerta() {
    servoI.attach(D0);
    servoD.attach(D1);
    servoI.write(135);
    servoD.write(0);
    delay(1000);
    servoI.detach();
    servoD.detach();
}

void cerrarPuerta() {
    servoI.attach(D0);
    servoD.attach(D1);
    servoI.write(0);
    servoD.write(135);
    delay(1000);
    servoI.detach();
    servoD.detach();
}



double getDistanceCM()
{
    sendTriggerPulse(trigPin);
    waitForEcho(echoPin, HIGH, 100);
    long startTime = micros();
    waitForEcho(echoPin, LOW, 100);
    long endTime = micros();
    long duration = endTime - startTime;
    double distance = duration / 29.0 / 2.0;
    if (distance < minDist || distance > maxDist)
    {
        return -1;
    }
    return distance;
}

void sendTriggerPulse(int pin)
{
    digitalWrite(pin, HIGH);
    delayMicroseconds(10);
    digitalWrite(pin, LOW);
}

void waitForEcho(int pin, int value, long timeout)
{
    long giveupTime = millis() + timeout;
    while (digitalRead(pin) != value && millis() < giveupTime)
    {
    }
}








