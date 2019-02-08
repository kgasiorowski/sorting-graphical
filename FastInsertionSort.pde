class FastInsertionSort extends SortingAlgorithm{

    // j -> sorted array index
    // i -> searching for correct array index/swap index
    
    FastInsertionSort(){
    
        j = arr.length-1;
        i = j-1;
        name = "Fast Insertion Sort";
    
    }

    void step(){
    
        if(sorted)
            return;
        
        while(i < arr.length-1 && arr[i] > arr[i+1]){
            
            numComps++;
            swap(i, i+1);
            i++;
        
        }
        
        numComps++;
        
        j--;
        i = j-1;
    
        if(j == 0)
            sorted = true;
    
    }

    void reset(){
    
        super.reset();
        j = arr.length-1;
        i = j-1;
    
    }

}
