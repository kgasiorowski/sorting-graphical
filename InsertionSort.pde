class InsertionSort extends SortingAlgorithm{

    // j -> sorted array index
    // i -> searching for correct array index/swap index
    
    InsertionSort(){
    
        arrSize = 50;
        j = arrSize-1;
        i = j-1;
        name = "Insertion Sort";
    
    }

    void step(){
    
        if(sorted)
            return;
        
        if(i < arr.length-1 && arr[i] > arr[i+1]){
            
            swap(i, i+1);
            i++;
            
        }else{
            
            j--;
            i = j-1;
            
        }
    
        numComps++;
    
        if(j == 0)
            sorted = true;
    
    }

    void reset(){
    
        super.reset();
        j = arr.length-1;
        i = j-1;
    
    }

}
