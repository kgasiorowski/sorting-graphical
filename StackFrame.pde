class StackFrame{

    int low, high, pivot;
    
    StackFrame(int _low, int _high){
    
        this(_low, _high, 0);
    
    }
    
    StackFrame(int _low, int _high, int _pivot){
    
        low = _low;
        high = _high;
        pivot = _pivot;
    
    }

}
