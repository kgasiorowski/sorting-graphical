class FastSelectionSort extends SortingAlgorithm{

    int biggest;
    
    FastSelectionSort(){
        
        arrSize = 300;
        j = arrSize-1; 
        biggest = j;
        name = "Fast Selection Sort";
    
    }
    
    void step(){
    
        if(sorted)
            return;
        
        for(int i = 0; i <= j; i++){
        
            if(arr[i] > arr[biggest]){
            
                biggest = i;
            
            }
            
            numComps++;
        }
        
        swap(biggest, j);
        j--;
        biggest = j;
    
        if(j < 0){
        
            sorted = true;
        
        }
        
    }
    
    void reset(){
        
        super.reset();
        i = 0;
        j = arr.length - 1;
        biggest = j;
    
    }

}
