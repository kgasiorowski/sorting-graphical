import java.util.Stack; //<>//

class QuickSort extends SortingAlgorithm{

    Stack<StackFrame> callStack;
    
    QuickSort(){
    
        callStack = new Stack();
        callStack.push(new StackFrame(0, arr.length-1));
        name = "Quick Sort";
    
        i = j = 0;
    
    }
    
    
    // This function should take a sub-array from index _low to _high and
    // pick some pivot and guarantee that:
    // Anything in that sub-array that's less than the pivot is below it, anything larger is above it
    // The function returns the new location of the pivot
    // In other words, the returned index is guaranteed to be correct
    void partition(int low, int high){
        
        
        
    }
    
    private void printarr(){
    
        for(int i = 0; i < arr.length; i++){
            
            print(String.format("%-3d", i));
        
        }
        
        println();
        
        for(int i : arr){
        
            print(String.format("%-3d", i));
        
        }
    
        println();
    
    }
    
    void step(){
    
        if(sorted)
            return;
        
        while(!callStack.empty()){
        
            StackFrame current = callStack.pop();
        
            int low = current.low;
            int high = current.high;
            
            // pick the pivot
            int middle = low + (high - low) / 2;
            int pivot = arr[middle];
     
            // make left < pivot and right > pivot
            i = low; 
            j = high;
            while (i <= j) {
                while (arr[i] < pivot) {
                    i++;
                }
     
                while (arr[j] > pivot) {
                    j--;
                }
     
                if (i <= j) {
                    swap(i,j);
                    i++;
                    j--;
                }
            }
            
            if (low < j)
                callStack.push(new StackFrame(low, j));
     
            if (high > i)
                callStack.push(new StackFrame(i, high)); 
        
        }
        
        sorted = true;
    
    }

    void reset(){
    
        super.reset();
        callStack = new Stack();
        callStack.push(new StackFrame(0, arr.length-1));
        i = j = 0;
        
    
    }

}
