class SelectionSort extends SortingAlgorithm{

    int biggest;
    
    SelectionSort(){
        
        arrSize = 50;
        i = 0; 
        j = arrSize-1; 
        biggest = j;
        name = "Selection Sort";
    
    }
    
    void step(){
    
        if(sorted)
            return;
        
        if(arr[i] > arr[biggest]){
        
            biggest = i;
        
        }
        
        numComps++;
        
        if(++i > j){
        
            swap(biggest, j);
            
            i = 0;
            j--;
            
            biggest = j;
        
            if(j < 0){
            
                sorted = true;
            
            }
        
        
        }
        
        
    }
    
    void reset(){
        
        super.reset();
        i = 0;
        j = arr.length - 1;
        biggest = j;
    
    }

}
