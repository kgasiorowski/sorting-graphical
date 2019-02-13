import java.util.Stack; //<>//

class QuickSort extends SortingAlgorithm{

    Stack<StackFrame> callStack;

    int low, high;
    int pivot;
    
    QuickSort(){
    
        callStack = new Stack();
        callStack.push(new StackFrame(0, arr.length-1));
        initCall(callStack.peek());
        name = "Quick Sort";
    
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
    
    void initCall(StackFrame current){
    
        low = current.low;
        high = current.high;
        
        // pick the pivot
        //int middle = low + (high - low) / 2;
        int middle = (low + high) / 2;
        pivot = arr[middle];
 
        // make left < pivot and right > pivot
        i = low; 
        j = high;
    
    }
    
    void step(){
    
        if(sorted)
            return;
        
        if(!callStack.empty()){
        
            if(i <= j) {
                
                while (arr[i] < pivot){
                    i++;
                    numComps++;
                }
                
                numComps++;
                
                while (arr[j] > pivot){
                    j--;
                    numComps++;
                }
     
                numComps++;
     
                if (i <= j) {
                    swap(i,j);
                    i++;
                    j--;
                }
            
            }else{
             
                // Push the recursive calls to the stack
                if (high > i)
                    callStack.push(new StackFrame(i, high));
                
                if (low < j)
                    callStack.push(new StackFrame(low, j));
                
                // Initialize the new stack frame we have after the last one ended
                initCall(callStack.pop());
                
            }
        
        }else{
        
            sorted = true;
    
        }
    
    }

    void reset(){
    
        super.reset();
        callStack = new Stack();
        callStack.push(new StackFrame(0, arr.length-1));
        initCall(callStack.peek());
    
    }

}
