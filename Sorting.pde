import controlP5.*;

int arr[];
float rect_pixel_width;
float startTime;
float pauseTime;
SortingAlgorithm[] algos;
int currentAlgorithm;

float fontSize = 14;

ControlP5 cp5;
Textlabel swapsLabel;
Textlabel compsLabel;
Textlabel timeLabel;
Textlabel nameLabel;
Textlabel sizeLabel;
Textlabel stackLabel;

void setup(){
    
    size(1200, 800);
    
    rectMode(CORNER);
    background(0);

    algos = new SortingAlgorithm[7];

    algos[0] = new BubbleSort();
    algos[1] = new FastBubbleSort();
    algos[2] = new SelectionSort();
    algos[3] = new FastSelectionSort();
    algos[4] = new InsertionSort();
    algos[5] = new FastInsertionSort();
    algos[6] = new QuickSort();

    currentAlgorithm = 0;

    shuffle(algos[currentAlgorithm].arrSize);

    rect_pixel_width = (float)width/(float)(algos[currentAlgorithm].arrSize);

    cp5 = new ControlP5(this);
    
    nameLabel = cp5.addTextlabel("meh lol")
        .setPosition(10, 10)
        .setColorValue(color(255))
        .setFont(createFont("",fontSize))
        .setText(algos[currentAlgorithm].name);
        
    swapsLabel = cp5.addTextlabel("label")
        .setPosition(10, 30)
        .setColorValue(color(255))
        .setFont(createFont("",fontSize));

    compsLabel = cp5.addTextlabel("label2")
        .setPosition(10, 50)
        .setColorValue(color(255))
        .setFont(createFont("",fontSize));

    timeLabel = cp5.addTextlabel("label3")
        .setPosition(10, 70)
        .setColorValue(color(255))
        .setFont(createFont("",fontSize));

    sizeLabel = cp5.addTextlabel("label4")
        .setPosition(10, 90)
        .setColorValue(color(255))
        .setFont(createFont("", fontSize));

    stackLabel = cp5.addTextlabel("label5")
        .setPosition(10, 110)
        .setColorValue(color(255))
        .setFont(createFont("", fontSize))
        .setText("");

    startTime = millis();
    pauseTime = 0;

}

boolean drawLines = false;
void keyPressed(){
    
    if(keyCode == 32){
    
        reset();
        
    }else if(keyCode == 38){
    
        currentAlgorithm = (currentAlgorithm + 1) % algos.length;
        reset();
    
    }else if(keyCode == 40){
    
        currentAlgorithm = currentAlgorithm - 1 < 0 ? algos.length-1 : currentAlgorithm - 1;
        reset();
    
    }else if(keyCode == 81){
    
        drawLines = !drawLines;
    
    }

}

void reset(){

    // Stop the program from looping
    noLoop();
    
    // Shuffle the array
    shuffle(algos[currentAlgorithm].arrSize);
    rect_pixel_width = (float)width/(float)(algos[currentAlgorithm].arrSize);
    
    // Let the algorithm reset
    algos[currentAlgorithm].reset();
    // Record the new starting time
    startTime = millis();
    pauseTime = 0;
    // Reset the time label's color
    timeLabel.setColorValue(color(255));
    timeLabel.setText(getTimeString(0));
    nameLabel.setText(algos[currentAlgorithm].name);
    
    // Now re-start everything
    redraw();
    loop();

}

boolean shuffling;
void draw(){
    
    background(0);
    
    SortingAlgorithm algo = algos[currentAlgorithm];
    
    if(algo.sorted){
    
        //noLoop();
        delay(3000);
        currentAlgorithm = (currentAlgorithm + 1) % algos.length;
        reset();
        return;
    
    }
    
    algo.step();
    
    for(int i = 0; i < arr.length; i++){
    
        color clr = mapColor(arr[i]);
        
        stroke(clr);
        fill(clr);
        rect(i * rect_pixel_width, getRectHeight(arr[i]), rect_pixel_width, height);
        stroke(255);
    
        stackLabel.setText("");
    
        if(!algo.sorted){
            
            if(algo instanceof QuickSort){
                
                QuickSort q = (QuickSort)algo;
                
                if(i == ((QuickSort)algo).pivotIndex)
                    horizLine(i);
            
                if(drawLines){
            
                    if(q.lastPopped != null)
                        if(i == q.lastPopped.low+1)
                            horizLine(i, color(0, 0, 255));
                        else if(i == q.lastPopped.high)
                            horizLine(i, color(255, 0, 0));
                
                    for(StackFrame s : q.callStack)
                        if(i == s.low+1)
                            horizLine(i, color(0, 0, 255));
                        else if(i == s.high)
                            horizLine(i, color(255, 0, 0));
                
                    stackLabel.setText("Stack size: "+q.callStack.size());
            
                }
            
            }else if (algo instanceof BubbleSort){
    
                if(i == algo.i || i == arr.length-algo.j+1)
                    horizLine(i);
            
            }else if(algo instanceof FastBubbleSort){
            
                if(i == arr.length-algo.j+1)
                    horizLine(i);
                
            }else if(algo instanceof SelectionSort){
            
                if(i == ((SelectionSort)algo).biggest+1 || i == algo.i)
                    horizLine(i);
            
            }else if(algo instanceof InsertionSort){
            
                if(i == algo.j)
                    horizLine(i);
            
            }
    
        }
    
    }

    String timeString = getTimeString(millis());
    
    if(algo.sorted)
        timeLabel.setColorValue(color(0,255,0));
    
    swapsLabel.setText("Swaps: " + algo.numSwaps);
    compsLabel.setText("Comparisons: " + algo.numComps);
    timeLabel.setText("Time elapsed: " + timeString);
    sizeLabel.setText("Array size: " + algo.arrSize);
    
}

String getTimeString(int time){

    float timeSeconds = round((time - startTime - pauseTime)/100.0)/10.0;
    int timeMinutes = ((int)timeSeconds / 60);
    int timeHours = timeMinutes / 60;
    
    return String.format("%d:%d:%.1f", timeHours, timeMinutes%60, timeSeconds%60);

}

void horizLine(int i){

    line(i*rect_pixel_width - (0.5 * rect_pixel_width), 0, i*rect_pixel_width - (0.5 * rect_pixel_width), height);

}

void horizLine(int i, color clr){

    stroke(clr);
    horizLine(i);

}

void shuffle(int numVals){

    arr = new int[numVals];
    
    int i = 1;
    while((arr[i-1] = i++) < arr.length);
    
    for(i = 0; i < arr.length; i++){
    
        int swap = 0;
        
        swap = int(random(arr.length));
        
        int temp = arr[i];
        arr[i] = arr[swap];
        arr[swap] = temp;
        
    }

}

float getRectHeight(int val){

    return map(val, 0, arr.length, height, 0);

}

color mapColor(int val){

    int red = 0;
    int green = 0;
    int blue = 0;
    
    int maxMap = 100000;
    
    int mappedVal = int(map(val, 0, arr.length, 0, maxMap));
    
    if(mappedVal <= maxMap*.25){
    
        // Lowest level, blue -> cyan
        red = 0;
        green = int(map(mappedVal, 0, maxMap*.25, 0, 255));
        blue = 255;
    
    }else if(mappedVal > maxMap*.25 && mappedVal <= maxMap*.50){
    
        // 2nd level, teal -> green
        red = 0;
        green = 255;
        blue = int(map(mappedVal, maxMap*.25, maxMap*.50, 255, 0));

    }else if(mappedVal > maxMap*.50 && mappedVal <= maxMap*.75){
        
        // 3rd level, green -> yellow
        red = int(map(mappedVal, maxMap*.50, maxMap*.75, 0, 255));
        green = 255;
        blue = 0;
    
    }else{
    
        // Top level, yellow -> red
        red = 255;
        green = int(map(mappedVal, maxMap*.75, maxMap, 255, 0));
        blue = 0;
    
    }

    return color(red, green, blue);

}
