import controlP5.*;

int arr[];
float rect_pixel_width;
    


void setup(){

    size(500,300);
    
    arr = new int[100];
    
    int i = 1;
    while((arr[i-1] = i++) < arr.length);

    println(width, height);

    rect_pixel_width = (float)width/(float)(arr.length);

    rectMode(CORNER);

    frameRate(60);

    background(0);

    shuffle();

}

void keyPressed(){

    shuffle();
    i = 0;
    j = 0;
    redraw();
    loop();

}

int i = 0, j = 0;

void draw(){
    
    background(0);
    
    //for(int j = 0; j < arr.length-1; j++){
    
    //    for(int i = 0; i < arr.length-1-j; i++){
        
    //        if(arr[i] > arr[i+1]){
            
    //            swap(i, i+1);
            
    //        }
        
    //    }
    
    //}
    
    if(arr[i] > arr[i+1])
        swap(i, i+1);
    
    i++;
    
    if(i >= arr.length-1-j)
    {
    
        i = 0;
        j++;
    
    }
    
    for(int i = 0; i < arr.length; i++){
    
        noStroke();
        fill(mapColor(arr[i]));
        rect(i * rect_pixel_width, getRectHeight(arr[i]), rect_pixel_width, height);
    
    }

    if(j >= arr.length-1){
    
        println("Done!");    
        noLoop();
    
    }
    
}

void swap(int swap1, int swap2){

    int temp = arr[swap1];
    arr[swap1] = arr[swap2];
    arr[swap2] = temp;

}

void shuffle(){

    for(int i = 0; i < 1000; i++){
    
        int swap1, swap2;
        swap1 = swap2 = 0;
        
        do{
            
            swap1 = int(random(arr.length));
            swap2 = int(random(arr.length));
        
        }while(swap1 == swap2);
        
        swap(swap1, swap2);
        
    }

}

float getRectHeight(int val){

    return map(val, 0, arr.length, height, height*.05);

}

color mapColor(int val){

    int red = 0;
    int green = 0;
    int blue = 0;
    
    int mappedVal = int(map(val, 0, arr.length, 0, 100));
    
    if(mappedVal <= 25){
    
        // Lowest level, blue -> cyan
        red = 0;
        green = int(map(mappedVal, 0, 25, 0, 255));
        blue = 255;
    
    }else if(mappedVal > 25 && mappedVal <= 50){
    
        // 2nd level, teal -> green
        red = 0;
        green = 255;
        blue = int(map(mappedVal, 25, 50, 255, 0));

    }else if(mappedVal > 50 && mappedVal <= 75){
        
        // 3rd level, green -> yellow
        red = int(map(mappedVal, 50, 75, 0, 255));
        green = 255;
        blue = 0;
    
    }else{
    
        // Top level, yellow -> red
        red = 255;
        green = int(map(mappedVal, 75, 100, 255, 0));
        blue = 0;
    
    }

    return color(red, green, blue);

}
